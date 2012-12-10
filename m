From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] libceph: socket can close in any connection state
Date: Sun, 09 Dec 2012 18:36:11 -0600
Message-ID: <50C52E7B.5030204@inktank.com>
References: <50C52DE5.9070602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48269 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2LJAmB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 19:42:01 -0500
Received: by mail-ie0-f172.google.com with SMTP id c13so7314392ieb.17
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 16:42:00 -0800 (PST)
In-Reply-To: <50C52DE5.9070602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A connection's socket can close for any reason, independent of the
state of the connection (and without irrespective of the connection
mutex).  As a result, the connectino can be in pretty much any state
at the time its socket is closed.

Handle those other cases at the top of con_work().  Pull this whole
block of code into a separate function to reduce the clutter.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 1041114..4b04ccc 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2273,6 +2273,35 @@ static void queue_con(struct ceph_connection *con)
 	(void) queue_con_delay(con, 0);
 }

+static bool con_sock_closed(struct ceph_connection *con)
+{
+	if (!test_and_clear_bit(CON_FLAG_SOCK_CLOSED, &con->flags))
+		return false;
+
+#define CASE(x)								\
+	case CON_STATE_ ## x:						\
+		con->error_msg = "socket closed (con state " #x ")";	\
+		break;
+
+	switch (con->state) {
+	CASE(CLOSED);
+	CASE(PREOPEN);
+	CASE(CONNECTING);
+	CASE(NEGOTIATING);
+	CASE(OPEN);
+	CASE(STANDBY);
+	default:
+		pr_warning("%s con %p unrecognized state %lu\n",
+			__func__, con, con->state);
+		con->error_msg = "unrecognized con state";
+		BUG();
+		break;
+	}
+#undef CASE
+
+	return true;
+}
+
 /*
  * Do some work on a connection.  Drop a connection ref when we're done.
  */
@@ -2284,24 +2313,8 @@ static void con_work(struct work_struct *work)

 	mutex_lock(&con->mutex);
 restart:
-	if (test_and_clear_bit(CON_FLAG_SOCK_CLOSED, &con->flags)) {
-		switch (con->state) {
-		case CON_STATE_CONNECTING:
-			con->error_msg = "connection failed";
-			break;
-		case CON_STATE_NEGOTIATING:
-			con->error_msg = "negotiation failed";
-			break;
-		case CON_STATE_OPEN:
-			con->error_msg = "socket closed";
-			break;
-		default:
-			dout("unrecognized con state %d\n", (int)con->state);
-			con->error_msg = "unrecognized con state";
-			BUG();
-		}
+	if (con_sock_closed(con))
 		goto fault;
-	}

 	if (test_and_clear_bit(CON_FLAG_BACKOFF, &con->flags)) {
 		dout("con_work %p backing off\n", con);
-- 
1.7.9.5

