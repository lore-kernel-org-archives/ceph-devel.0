From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/5] libceph: use a flag to indicate a fault has occurred
Date: Tue, 19 Feb 2013 18:56:06 -0600
Message-ID: <51241F26.60902@inktank.com>
References: <51241E15.80903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:33827 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759033Ab3BTA4J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:56:09 -0500
Received: by mail-qc0-f182.google.com with SMTP id k19so2862025qcs.13
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:56:09 -0800 (PST)
In-Reply-To: <51241E15.80903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This just rearranges the logic in con_work() a little bit so that a
flag is used to indicate a fault has occurred.  This allows both the
fault and non-fault case to be handled the same way and avoids a
couple of nearly consecutive gotos.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 0fe9cbd..1cf0e53 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2338,13 +2338,15 @@ static void con_work(struct work_struct *work)
 {
 	struct ceph_connection *con = container_of(work, struct ceph_connection,
 						   work.work);
+	bool fault = false;
 	int ret;

 	mutex_lock(&con->mutex);
 restart:
 	if (con_sock_closed(con)) {
 		dout("con_work %p SOCK_CLOSED\n", con);
-		goto fault;
+		fault = true;
+		goto done;
 	}
 	if (con_backoff(con)) {
 		dout("con_work %p BACKOFF\n", con);
@@ -2369,7 +2371,8 @@ restart:
 		goto restart;
 	if (ret < 0) {
 		con->error_msg = "socket error on read";
-		goto fault;
+		fault = true;
+		goto done;
 	}

 	ret = try_write(con);
@@ -2377,20 +2380,17 @@ restart:
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

