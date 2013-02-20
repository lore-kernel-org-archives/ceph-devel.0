From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] libceph: encapsulate connection backoff
Date: Tue, 19 Feb 2013 18:55:24 -0600
Message-ID: <51241EFC.2080104@inktank.com>
References: <51241E15.80903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:46041 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758948Ab3BTAz2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:55:28 -0500
Received: by mail-qa0-f47.google.com with SMTP id j8so2167015qah.20
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:55:27 -0800 (PST)
In-Reply-To: <51241E15.80903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Collect the code that tests for and implements a backoff delay for a
ceph connection into a new function, ceph_backoff().

Make the debug output messages in that part of the code report
things consistently by reporting a message in the socket closed
case, and by making the one for PREOPEN state report the connection
pointer like the rest.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ab702cd..686973c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2296,6 +2296,24 @@ static bool con_sock_closed(struct
ceph_connection *con)
 	return true;
 }

+static bool con_backoff(struct ceph_connection *con)
+{
+	int ret;
+
+	if (!test_and_clear_bit(CON_FLAG_BACKOFF, &con->flags))
+		return false;
+
+	ret = queue_con_delay(con, round_jiffies_relative(con->delay));
+	if (ret) {
+		dout("%s %p FAILED to back off %lu\n",
+			__func__, con, con->delay);
+		BUG_ON(ret == -ENOENT);
+		set_bit(CON_FLAG_BACKOFF, &con->flags);
+	}
+
+	return true;
+}
+
 /*
  * Do some work on a connection.  Drop a connection ref when we're done.
  */
@@ -2307,21 +2325,14 @@ static void con_work(struct work_struct *work)

 	mutex_lock(&con->mutex);
 restart:
-	if (con_sock_closed(con))
+	if (con_sock_closed(con)) {
+		dout("con_work %p SOCK_CLOSED\n", con);
 		goto fault;
-
-	if (test_and_clear_bit(CON_FLAG_BACKOFF, &con->flags)) {
-		dout("con_work %p backing off\n", con);
-		ret = queue_con_delay(con, round_jiffies_relative(con->delay));
-		if (ret) {
-			dout("con_work %p FAILED to back off %lu\n", con,
-			     con->delay);
-			BUG_ON(ret == -ENOENT);
-			set_bit(CON_FLAG_BACKOFF, &con->flags);
-		}
+	}
+	if (con_backoff(con)) {
+		dout("con_work %p BACKOFF\n", con);
 		goto done;
 	}
-
 	if (con->state == CON_STATE_STANDBY) {
 		dout("con_work %p STANDBY\n", con);
 		goto done;
@@ -2332,7 +2343,7 @@ restart:
 		goto done;
 	}
 	if (con->state == CON_STATE_PREOPEN) {
-		dout("con_work OPENING\n");
+		dout("con_work %p OPENING\n", con);
 		BUG_ON(con->sock);
 	}

-- 
1.7.9.5

