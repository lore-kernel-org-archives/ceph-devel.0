From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: timeout watch teardown on unmap with mount_timeout
Date: Thu, 14 May 2015 13:00:22 +0300
Message-ID: <1431597622-1573-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34507 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbbENKAi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 06:00:38 -0400
Received: by wguv19 with SMTP id v19so7638446wgu.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 03:00:37 -0700 (PDT)
Received: from localhost.localdomain ([109.110.66.238])
        by mx.google.com with ESMTPSA id yz3sm4888725wjc.19.2015.05.14.03.00.34
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 03:00:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

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

This also changes rbd_obj_request_wait() to return -EINTR instead of
-ERESTARTSYS if interrupted - I don't think we want to mess with
restarts for any of rbd map/unmap requests.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 349115ae3bc2..3fabdfdbc0b1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1564,21 +1564,37 @@ static void rbd_obj_request_end(struct rbd_obj_request *obj_request)
  * Wait for an object request to complete.  If interrupted, cancel the
  * underlying osd request.
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
+					&obj_request->completion, timeout);
+	if (ret <= 0) {
+		if (ret == 0)
+			ret = -ETIMEDOUT;
+		else
+			ret = -EINTR;
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
+	return __rbd_obj_request_wait(obj_request, MAX_SCHEDULE_TIMEOUT);
+}
+
+static int rbd_obj_request_wait_timeo(struct rbd_obj_request *obj_request,
+				      unsigned long timeout)
+{
+	return __rbd_obj_request_wait(obj_request, timeout);
 }
 
 static void rbd_img_request_complete(struct rbd_img_request *img_request)
@@ -3121,7 +3137,9 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
 						struct rbd_device *rbd_dev,
 						bool watch)
 {
-	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	struct ceph_client *client = rbd_dev->rbd_client->client;
+	struct ceph_osd_client *osdc = &client->osdc;
+	unsigned long timeout = client->options->mount_timeout * HZ;
 	struct rbd_obj_request *obj_request;
 	int ret;
 
@@ -3148,7 +3166,7 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
 	if (ret)
 		goto out;
 
-	ret = rbd_obj_request_wait(obj_request);
+	ret = rbd_obj_request_wait_timeo(obj_request, timeout);
 	if (ret)
 		goto out;
 
-- 
1.9.3

