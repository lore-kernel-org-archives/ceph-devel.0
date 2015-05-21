From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 5/5] rbd: timeout watch teardown on unmap with mount_timeout
Date: Thu, 21 May 2015 15:35:06 +0300
Message-ID: <1432211706-10473-6-git-send-email-idryomov@gmail.com>
References: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38831 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbbEUMfg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 08:35:36 -0400
Received: by wichy4 with SMTP id hy4so12252775wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 05:35:35 -0700 (PDT)
In-Reply-To: <1432211706-10473-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Zheng Yan <zyan@redhat.com>

As part of unmap sequence, kernel client has to talk to the OSDs to
teardown watch on the header object.  If none of the OSDs are available
it would hang forever, until interrupted by a signal - when that
happens we follow through with the rest of unmap procedure (i.e.
unregister the device and put all the data structures) and the unmap is
still considired successful (rbd cli tool exits with 0).  The watch on
the userspace side should eventually timeout so that's fine.

This isn't very nice, because various userspace tools (pacemaker rbd
resource agent, for example) then have to worry about setting up their
own timeouts.  Timeout it with mount_timeout (60 seconds by default).

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
---
 drivers/block/rbd.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 992683b6b299..89fe8a4bc02e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1563,22 +1563,39 @@ static void rbd_obj_request_end(struct rbd_obj_request *obj_request)
 /*
  * Wait for an object request to complete.  If interrupted, cancel the
  * underlying osd request.
+ *
+ * @timeout: in jiffies, 0 means "wait forever"
  */
-static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
+static int __rbd_obj_request_wait(struct rbd_obj_request *obj_request,
+				  unsigned long timeout)
 {
-	int ret;
+	long ret;
 
 	dout("%s %p\n", __func__, obj_request);
-
-	ret = wait_for_completion_interruptible(&obj_request->completion);
-	if (ret < 0) {
-		dout("%s %p interrupted\n", __func__, obj_request);
+	ret = wait_for_completion_interruptible_timeout(
+					&obj_request->completion,
+					ceph_timeout_jiffies(timeout));
+	if (ret <= 0) {
+		if (ret == 0)
+			ret = -ETIMEDOUT;
 		rbd_obj_request_end(obj_request);
-		return ret;
+	} else {
+		ret = 0;
 	}
 
-	dout("%s %p done\n", __func__, obj_request);
-	return 0;
+	dout("%s %p ret %d\n", __func__, obj_request, (int)ret);
+	return ret;
+}
+
+static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
+{
+	return __rbd_obj_request_wait(obj_request, 0);
+}
+
+static int rbd_obj_request_wait_timeout(struct rbd_obj_request *obj_request,
+					unsigned long timeout)
+{
+	return __rbd_obj_request_wait(obj_request, timeout);
 }
 
 static void rbd_img_request_complete(struct rbd_img_request *img_request)
@@ -3122,6 +3139,7 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
 						bool watch)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_options *opts = osdc->client->options;
 	struct rbd_obj_request *obj_request;
 	int ret;
 
@@ -3148,7 +3166,7 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
 	if (ret)
 		goto out;
 
-	ret = rbd_obj_request_wait(obj_request);
+	ret = rbd_obj_request_wait_timeout(obj_request, opts->mount_timeout);
 	if (ret)
 		goto out;
 
-- 
1.9.3

