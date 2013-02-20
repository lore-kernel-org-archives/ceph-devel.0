From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] libceph: indent properly
Date: Tue, 19 Feb 2013 18:57:09 -0600
Message-ID: <51241F65.7060109@inktank.com>
References: <51241E15.80903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:65340 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759047Ab3BTA5M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:57:12 -0500
Received: by mail-qe0-f49.google.com with SMTP id 5so3399771qea.36
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:57:11 -0800 (PST)
In-Reply-To: <51241E15.80903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This is just the second part of a two-part patch.  It simply
indents a block of code.  This patch is going to be merged into
its predecessor following review.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   80
+++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 609f2eb..8f1272d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2341,50 +2341,50 @@ static void con_work(struct work_struct *work)
 	bool fault;

 	mutex_lock(&con->mutex);
-while (true) {
-	int ret;
+	while (true) {
+		int ret;

-	if ((fault = con_sock_closed(con))) {
-		dout("con_work %p SOCK_CLOSED\n", con);
-		break;
-	}
-	if (con_backoff(con)) {
-		dout("con_work %p BACKOFF\n", con);
-		break;
-	}
-	if (con->state == CON_STATE_STANDBY) {
-		dout("con_work %p STANDBY\n", con);
-		break;
-	}
-	if (con->state == CON_STATE_CLOSED) {
-		dout("con_work %p CLOSED\n", con);
-		BUG_ON(con->sock);
-		break;
-	}
-	if (con->state == CON_STATE_PREOPEN) {
-		dout("con_work %p OPENING\n", con);
-		BUG_ON(con->sock);
-	}
+		if ((fault = con_sock_closed(con))) {
+			dout("con_work %p SOCK_CLOSED\n", con);
+			break;
+		}
+		if (con_backoff(con)) {
+			dout("con_work %p BACKOFF\n", con);
+			break;
+		}
+		if (con->state == CON_STATE_STANDBY) {
+			dout("con_work %p STANDBY\n", con);
+			break;
+		}
+		if (con->state == CON_STATE_CLOSED) {
+			dout("con_work %p CLOSED\n", con);
+			BUG_ON(con->sock);
+			break;
+		}
+		if (con->state == CON_STATE_PREOPEN) {
+			dout("con_work %p OPENING\n", con);
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

