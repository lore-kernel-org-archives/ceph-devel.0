From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5, v2] libceph: indent properly
Date: Fri, 22 Feb 2013 11:30:50 -0600
Message-ID: <5127AB4A.9080908@inktank.com>
References: <5127A85D.1070000@inktank.com> <5127A935.8020605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:35277 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757714Ab3BVRax (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:30:53 -0500
Received: by mail-ia0-f182.google.com with SMTP id k38so750456iah.27
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:30:53 -0800 (PST)
In-Reply-To: <5127A935.8020605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

This is just the second part of a two-part patch.  It simply
indents a block of code.  This patch is going to be merged into
its predecessor following review.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: rebased

 net/ceph/messenger.c |   80
+++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 223406f..2c0669f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2390,50 +2390,50 @@ static void con_work(struct work_struct *work)
 	bool fault;

 	mutex_lock(&con->mutex);
-while (true) {
-	int ret;
+	while (true) {
+		int ret;

-	if ((fault = con_sock_closed(con))) {
-		dout("%s: con %p SOCK_CLOSED\n", __func__, con);
-		break;
-	}
-	if (con_backoff(con)) {
-		dout("%s: con %p BACKOFF\n", __func__, con);
-		break;
-	}
-	if (con->state == CON_STATE_STANDBY) {
-		dout("%s: con %p STANDBY\n", __func__, con);
-		break;
-	}
-	if (con->state == CON_STATE_CLOSED) {
-		dout("%s: con %p CLOSED\n", __func__, con);
-		BUG_ON(con->sock);
-		break;
-	}
-	if (con->state == CON_STATE_PREOPEN) {
-		dout("%s: con %p PREOPEN\n", __func__, con);
-		BUG_ON(con->sock);
-	}
+		if ((fault = con_sock_closed(con))) {
+			dout("%s: con %p SOCK_CLOSED\n", __func__, con);
+			break;
+		}
+		if (con_backoff(con)) {
+			dout("%s: con %p BACKOFF\n", __func__, con);
+			break;
+		}
+		if (con->state == CON_STATE_STANDBY) {
+			dout("%s: con %p STANDBY\n", __func__, con);
+			break;
+		}
+		if (con->state == CON_STATE_CLOSED) {
+			dout("%s: con %p CLOSED\n", __func__, con);
+			BUG_ON(con->sock);
+			break;
+		}
+		if (con->state == CON_STATE_PREOPEN) {
+			dout("%s: con %p PREOPEN\n", __func__, con);
+			BUG_ON(con->sock);
+		}

-	ret = try_read(con);
-	if (ret < 0) {
-		if (ret == -EAGAIN)
-			continue;
-		con->error_msg = "socket error on read";
-		fault = true;
-		break;
-	}
+		ret = try_read(con);
+		if (ret < 0) {
+			if (ret == -EAGAIN)
+				continue;
+			con->error_msg = "socket error on read";
+			fault = true;
+			break;
+		}

-	ret = try_write(con);
-	if (ret < 0) {
-		if (ret == -EAGAIN)
-			continue;
-		con->error_msg = "socket error on write";
-		fault = true;
-	}
+		ret = try_write(con);
+		if (ret < 0) {
+			if (ret == -EAGAIN)
+				continue;
+			con->error_msg = "socket error on write";
+			fault = true;
+		}

-	break;	/* If we make it to here, we're done */
-}
+		break;	/* If we make it to here, we're done */
+	}
 	if (fault)
 		con_fault(con);
 	mutex_unlock(&con->mutex);
-- 
1.7.9.5

