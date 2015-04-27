From: Alex Elder <elder@linaro.org>
Subject: [PATCH 7/7] messenger: con_work() is not really a loop
Date: Mon, 27 Apr 2015 12:13:15 -0500
Message-ID: <1430154795-17123-8-git-send-email-elder@linaro.org>
References: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35474 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964825AbbD0RNZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:25 -0400
Received: by pdbqd1 with SMTP id qd1so134963626pdb.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:25 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.24
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:24 -0700 (PDT)
In-Reply-To: <1430154795-17123-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In con_work(), a while(true) loop is used to contain a block of code.
The normal path through that code does *not* actually loop.  The only
time it loops is if a socket read or write operation returns -EAGAIN.
So the use of the loop control structure is a little misleading.

Restructure that block so it's *not* a loop, and use "goto" calls
rather than a loop to implement the control flow.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 net/ceph/messenger.c | 84 +++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ec60c23..053c5f3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2845,54 +2845,52 @@ static void con_work(struct work_struct *work)
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
 	bool fault;
+	int ret;
 
 	mutex_lock(&con->mutex);
-	while (true) {
-		int ret;
-
-		if ((fault = con_sock_closed(con))) {
-			dout("%s: con %p SOCK_CLOSED\n", __func__, con);
-			break;
-		}
-		if (con_backoff(con)) {
-			dout("%s: con %p BACKOFF\n", __func__, con);
-			break;
-		}
-		if (con->state == CON_STATE_STANDBY) {
-			dout("%s: con %p STANDBY\n", __func__, con);
-			break;
-		}
-		if (con->state == CON_STATE_CLOSED) {
-			dout("%s: con %p CLOSED\n", __func__, con);
-			BUG_ON(con->sock);
-			break;
-		}
-		if (con->state == CON_STATE_PREOPEN) {
-			dout("%s: con %p PREOPEN\n", __func__, con);
-			BUG_ON(con->sock);
-		}
-
-		ret = try_read(con);
-		if (ret < 0) {
-			if (ret == -EAGAIN)
-				continue;
-			if (!con->error_msg)
-				con->error_msg = "socket error on read";
-			fault = true;
-			break;
-		}
+again:
+	fault = con_sock_closed(con);
+	if (fault) {
+		dout("%s: con %p SOCK_CLOSED\n", __func__, con);
+		goto done;
+	}
+	if (con_backoff(con)) {
+		dout("%s: con %p BACKOFF\n", __func__, con);
+		goto done;
+	}
+	if (con->state == CON_STATE_STANDBY) {
+		dout("%s: con %p STANDBY\n", __func__, con);
+		goto done;
+	}
+	if (con->state == CON_STATE_CLOSED) {
+		dout("%s: con %p CLOSED\n", __func__, con);
+		BUG_ON(con->sock);
+		goto done;
+	}
+	if (con->state == CON_STATE_PREOPEN) {
+		dout("%s: con %p PREOPEN\n", __func__, con);
+		BUG_ON(con->sock);
+	}
 
-		ret = try_write(con);
-		if (ret < 0) {
-			if (ret == -EAGAIN)
-				continue;
-			if (!con->error_msg)
-				con->error_msg = "socket error on write";
-			fault = true;
-		}
+	ret = try_read(con);
+	if (ret < 0) {
+		if (ret == -EAGAIN)
+			goto again;
+		if (!con->error_msg)
+			con->error_msg = "socket error on read";
+		fault = true;
+		goto done;
+	}
 
-		break;	/* If we make it to here, we're done */
+	ret = try_write(con);
+	if (ret < 0) {
+		if (ret == -EAGAIN)
+			goto again;
+		if (!con->error_msg)
+			con->error_msg = "socket error on write";
+		fault = true;
 	}
+done:
 	if (fault)
 		con_fault(con);
 	mutex_unlock(&con->mutex);
-- 
2.1.0

