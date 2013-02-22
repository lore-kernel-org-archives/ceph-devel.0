From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5, v2] libceph: use a flag to indicate a fault has occurred
Date: Fri, 22 Feb 2013 11:26:37 -0600
Message-ID: <5127AA4D.0@inktank.com>
References: <5127A85D.1070000@inktank.com> <5127A935.8020605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60612 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929Ab3BVR0k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:26:40 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so1004611iea.14
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:26:40 -0800 (PST)
In-Reply-To: <5127A935.8020605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

This just rearranges the logic in con_work() a little bit so that a
flag is used to indicate a fault has occurred.  This allows both the
fault and non-fault case to be handled the same way and avoids a
couple of nearly consecutive gotos.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: rebased

 net/ceph/messenger.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c3b9060..18eb788 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2387,13 +2387,15 @@ static void con_work(struct work_struct *work)
 {
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
+	bool fault = false;
 	int ret;

 	mutex_lock(&con->mutex);
 restart:
 	if (con_sock_closed(con)) {
 		dout("%s: con %p SOCK_CLOSED\n", __func__, con);
-		goto fault;
+		fault = true;
+		goto done;
 	}
 	if (con_backoff(con)) {
 		dout("%s: con %p BACKOFF\n", __func__, con);
@@ -2418,7 +2420,8 @@ restart:
 		goto restart;
 	if (ret < 0) {
 		con->error_msg = "socket error on read";
-		goto fault;
+		fault = true;
+		goto done;
 	}

 	ret = try_write(con);
@@ -2426,20 +2429,17 @@ restart:
 		goto restart;
 	if (ret < 0) {
 		con->error_msg = "socket error on write";
-		goto fault;
+		fault = true;
 	}
-
 done:
+	if (fault)
+		con_fault(con);
 	mutex_unlock(&con->mutex);
-done_unlocked:
-	con->ops->put(con);
-	return;

-fault:
-	con_fault(con);
-	mutex_unlock(&con->mutex);
-	con_fault_finish(con);
-	goto done_unlocked;
+	if (fault)
+		con_fault_finish(con);
+
+	con->ops->put(con);
 }


-- 
1.7.9.5

