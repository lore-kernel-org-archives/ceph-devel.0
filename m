From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5, v2] libceph: use a do..while loop in con_work()
Date: Fri, 22 Feb 2013 11:30:23 -0600
Message-ID: <5127AB2F.7070204@inktank.com>
References: <5127A85D.1070000@inktank.com> <5127A935.8020605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:59841 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757971Ab3BVRa0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:30:26 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so739264iak.24
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:30:26 -0800 (PST)
In-Reply-To: <5127A935.8020605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

This just converts a manually-implemented loop into a do..while loop
in con_work().  It also moves handling of EAGAIN inside the blocks
where it's already been determined an error code was returned.

Also update a few dout() calls near the affected code for
consistency.

NOTE:
    This was done in two steps in order to facilitate review.  The
    This patch will be squashed into the next one before commit.
    next patch simply indents the loop properly.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: rebased

 net/ceph/messenger.c |   39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 18eb788..223406f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2387,51 +2387,53 @@ static void con_work(struct work_struct *work)
 {
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
-	bool fault = false;
-	int ret;
+	bool fault;

 	mutex_lock(&con->mutex);
-restart:
-	if (con_sock_closed(con)) {
+while (true) {
+	int ret;
+
+	if ((fault = con_sock_closed(con))) {
 		dout("%s: con %p SOCK_CLOSED\n", __func__, con);
-		fault = true;
-		goto done;
+		break;
 	}
 	if (con_backoff(con)) {
 		dout("%s: con %p BACKOFF\n", __func__, con);
-		goto done;
+		break;
 	}
 	if (con->state == CON_STATE_STANDBY) {
-		dout("con_work %p STANDBY\n", con);
-		goto done;
+		dout("%s: con %p STANDBY\n", __func__, con);
+		break;
 	}
 	if (con->state == CON_STATE_CLOSED) {
-		dout("con_work %p CLOSED\n", con);
+		dout("%s: con %p CLOSED\n", __func__, con);
 		BUG_ON(con->sock);
-		goto done;
+		break;
 	}
 	if (con->state == CON_STATE_PREOPEN) {
-		dout("%s: con %p OPENING\n", __func__, con);
+		dout("%s: con %p PREOPEN\n", __func__, con);
 		BUG_ON(con->sock);
 	}

 	ret = try_read(con);
-	if (ret == -EAGAIN)
-		goto restart;
 	if (ret < 0) {
+		if (ret == -EAGAIN)
+			continue;
 		con->error_msg = "socket error on read";
 		fault = true;
-		goto done;
+		break;
 	}

 	ret = try_write(con);
-	if (ret == -EAGAIN)
-		goto restart;
 	if (ret < 0) {
+		if (ret == -EAGAIN)
+			continue;
 		con->error_msg = "socket error on write";
 		fault = true;
 	}
-done:
+
+	break;	/* If we make it to here, we're done */
+}
 	if (fault)
 		con_fault(con);
 	mutex_unlock(&con->mutex);
@@ -2442,7 +2444,6 @@ done:
 	con->ops->put(con);
 }

-
 /*
  * Generic error/fault handler.  A retry mechanism is used with
  * exponential backoff
-- 
1.7.9.5

