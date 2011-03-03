From: Sage Weil <sage@newdream.net>
Subject: [PATCH 7/8] libceph: fix msgr keepalive flag
Date: Thu,  3 Mar 2011 12:40:09 -0800
Message-ID: <1299184810-19125-8-git-send-email-sage@newdream.net>
References: <1299184810-19125-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52169 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758722Ab1CCUj7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:39:59 -0500
In-Reply-To: <1299184810-19125-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

There was some broken keepalive code using a dead variable.  Shift to using
the proper bit flag.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 include/linux/ceph/messenger.h |    1 -
 net/ceph/messenger.c           |    9 ++++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index eb31e10..31d91a6 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -161,7 +161,6 @@ struct ceph_connection {
 	struct list_head out_queue;
 	struct list_head out_sent;   /* sending or sent but unacked */
 	u64 out_seq;		     /* last message queued for send */
-	bool out_keepalive_pending;
 
 	u64 in_seq, in_seq_acked;  /* last message received, acked */
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index af1ea93..961d937 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -336,7 +336,6 @@ static void reset_connection(struct ceph_connection *con)
 		ceph_msg_put(con->out_msg);
 		con->out_msg = NULL;
 	}
-	con->out_keepalive_pending = false;
 	con->in_seq = 0;
 	con->in_seq_acked = 0;
 }
@@ -2019,10 +2018,10 @@ static void ceph_fault(struct ceph_connection *con)
 	/* Requeue anything that hasn't been acked */
 	list_splice_init(&con->out_sent, &con->out_queue);
 
-	/* If there are no messages in the queue, place the connection
-	 * in a STANDBY state (i.e., don't try to reconnect just yet). */
-	if (list_empty(&con->out_queue) && !con->out_keepalive_pending) {
-		dout("fault setting STANDBY\n");
+	/* If there are no messages queued or keepalive pending, place
+	 * the connection in a STANDBY state */
+	if (list_empty(&con->out_queue) &&
+	    !test_bit(KEEPALIVE_PENDING, &con->state)) {
 		set_bit(STANDBY, &con->state);
 	} else {
 		/* retry after a delay. */
-- 
1.7.0

