From: Sage Weil <sage@newdream.net>
Subject: [PATCH 8/8] libceph: fix msgr standby handling
Date: Thu,  3 Mar 2011 12:40:10 -0800
Message-ID: <1299184810-19125-9-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52170 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758737Ab1CCUj7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:59 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

The standby logic used to be pretty dependent on the work requeueing
behavior that changed when we switched to WQ_NON_REENTRANT.  It was also
very fragile.

Restructure things so that:
 - We clear WRITE_PENDING when we set STANDBY.  This ensures we will
   requeue work when we wake up later.
 - con_work backs off if STANDBY is set.  There is nothing to do if we are
   in standby.
 - clear_standby() helper is called by both con_send() and con_keepalive(),
   the two actions that can wake us up again.  Move the connect_seq++
   logic here.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/messenger.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 961d937..502dd27 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1712,14 +1712,6 @@ more:
 
 	/* open the socket first? */
 	if (con->sock == NULL) {
-		/*
-		 * if we were STANDBY and are reconnecting _this_
-		 * connection, bump connect_seq now.  Always bump
-		 * global_seq.
-		 */
-		if (test_and_clear_bit(STANDBY, &con->state))
-			con->connect_seq++;
-
 		prepare_write_banner(msgr, con);
 		prepare_write_connect(msgr, con, 1);
 		prepare_read_banner(con);
@@ -1962,6 +1954,11 @@ static void con_work(struct work_struct *work)
 
 	mutex_lock(&con->mutex);
 
+	if (test_bit(STANDBY, &con->state)) {
+		dout("con_work %p STANDBY\n", con);
+		goto done;
+	}
+
 	if (test_bit(CLOSED, &con->state)) { /* e.g. if we are replaced */
 		dout("con_work CLOSED\n");
 		con_close_socket(con);
@@ -2022,6 +2019,8 @@ static void ceph_fault(struct ceph_connection *con)
 	 * the connection in a STANDBY state */
 	if (list_empty(&con->out_queue) &&
 	    !test_bit(KEEPALIVE_PENDING, &con->state)) {
+		dout("fault %p setting STANDBY clearing WRITE_PENDING\n", con);
+		clear_bit(WRITE_PENDING, &con->state);
 		set_bit(STANDBY, &con->state);
 	} else {
 		/* retry after a delay. */
@@ -2117,6 +2116,19 @@ void ceph_messenger_destroy(struct ceph_messenger *msgr)
 }
 EXPORT_SYMBOL(ceph_messenger_destroy);
 
+static void clear_standby(struct ceph_connection *con)
+{
+	/* come back from STANDBY? */
+	if (test_and_clear_bit(STANDBY, &con->state)) {
+		mutex_lock(&con->mutex);
+		dout("clear_standby %p and ++connect_seq\n", con);
+		con->connect_seq++;
+		WARN_ON(test_bit(WRITE_PENDING, &con->state));
+		WARN_ON(test_bit(KEEPALIVE_PENDING, &con->state));
+		mutex_unlock(&con->mutex);
+	}
+}
+
 /*
  * Queue up an outgoing message on the given connection.
  */
@@ -2149,6 +2161,7 @@ void ceph_con_send(struct ceph_connection *con, struct ceph_msg *msg)
 
 	/* if there wasn't anything waiting to send before, queue
 	 * new work */
+	clear_standby(con);
 	if (test_and_set_bit(WRITE_PENDING, &con->state) == 0)
 		queue_con(con);
 }
@@ -2214,6 +2227,8 @@ void ceph_con_revoke_message(struct ceph_connection *con, struct ceph_msg *msg)
  */
 void ceph_con_keepalive(struct ceph_connection *con)
 {
+	dout("con_keepalive %p\n", con);
+	clear_standby(con);
 	if (test_and_set_bit(KEEPALIVE_PENDING, &con->state) == 0 &&
 	    test_and_set_bit(WRITE_PENDING, &con->state) == 0)
 		queue_con(con);
-- 
1.7.0

