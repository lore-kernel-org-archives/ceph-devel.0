From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] libceph: encapsulate connection backoff
Date: Fri, 22 Feb 2013 11:23:17 -0600
Message-ID: <5127A985.3070305@inktank.com>
References: <5127A85D.1070000@inktank.com> <5127A935.8020605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:47920 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929Ab3BVRXU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:23:20 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so981351iea.26
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:23:20 -0800 (PST)
In-Reply-To: <5127A935.8020605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

Collect the code that tests for and implements a backoff delay for a
ceph connection into a new function, ceph_backoff().

Make the debug output messages in that part of the code report
things consistently by reporting a message in the socket closed
case, and by making the one for PREOPEN state report the connection
pointer like the rest.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: rebased

 net/ceph/messenger.c |   37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ed9e237..9a29d8a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2345,6 +2345,24 @@ static bool con_sock_closed(struct
ceph_connection *con)
 	return true;
 }

+static bool con_backoff(struct ceph_connection *con)
+{
+	int ret;
+
+	if (!con_flag_test_and_clear(con, CON_FLAG_BACKOFF))
+		return false;
+
+	ret = queue_con_delay(con, round_jiffies_relative(con->delay));
+	if (ret) {
+		dout("%s: con %p FAILED to back off %lu\n", __func__,
+			con, con->delay);
+		BUG_ON(ret == -ENOENT);
+		con_flag_set(con, CON_FLAG_BACKOFF);
+	}
+
+	return true;
+}
+
 /*
  * Do some work on a connection.  Drop a connection ref when we're done.
  */
@@ -2356,21 +2374,14 @@ static void con_work(struct work_struct *work)

 	mutex_lock(&con->mutex);
 restart:
-	if (con_sock_closed(con))
+	if (con_sock_closed(con)) {
+		dout("%s: con %p SOCK_CLOSED\n", __func__, con);
 		goto fault;
-
-	if (con_flag_test_and_clear(con, CON_FLAG_BACKOFF)) {
-		dout("con_work %p backing off\n", con);
-		ret = queue_con_delay(con, round_jiffies_relative(con->delay));
-		if (ret) {
-			dout("con_work %p FAILED to back off %lu\n", con,
-			     con->delay);
-			BUG_ON(ret == -ENOENT);
-			con_flag_set(con, CON_FLAG_BACKOFF);
-		}
+	}
+	if (con_backoff(con)) {
+		dout("%s: con %p BACKOFF\n", __func__, con);
 		goto done;
 	}
-
 	if (con->state == CON_STATE_STANDBY) {
 		dout("con_work %p STANDBY\n", con);
 		goto done;
@@ -2381,7 +2392,7 @@ restart:
 		goto done;
 	}
 	if (con->state == CON_STATE_PREOPEN) {
-		dout("con_work OPENING\n");
+		dout("%s: con %p OPENING\n", __func__, con);
 		BUG_ON(con->sock);
 	}

-- 
1.7.9.5

