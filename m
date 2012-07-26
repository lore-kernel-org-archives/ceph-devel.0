From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/7] rbd: create rbd_refresh_header()
Date: Thu, 26 Jul 2012 14:09:27 -0500
Message-ID: <501195E7.2040104@inktank.com>
References: <50119421.1090702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:34949 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab2GZTJ2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 15:09:28 -0400
Received: by mail-gh0-f174.google.com with SMTP id r11so2366170ghr.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 12:09:28 -0700 (PDT)
In-Reply-To: <50119421.1090702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Create a simple helper that handles the common case of calling
__rbd_refresh_header() while holding the ctl_mutex.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 31be4ca..94d0745 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -240,7 +240,7 @@ static void rbd_put_dev(struct rbd_device *rbd_dev)
 	put_device(&rbd_dev->dev);
 }

-static int __rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver);
+static int rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver);

 static int rbd_open(struct block_device *bdev, fmode_t mode)
 {
@@ -1222,9 +1222,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)

 	dout("rbd_watch_cb %s notify_id=%lld opcode=%d\n",
 		rbd_dev->header_name, notify_id, (int) opcode);
-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-	rc = __rbd_refresh_header(rbd_dev, &hver);
-	mutex_unlock(&ctl_mutex);
+	rc = rbd_refresh_header(rbd_dev, &hver);
 	if (rc)
 		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
 			   " update snaps: %d\n", rbd_dev->major, rc);
@@ -1746,6 +1744,17 @@ static int __rbd_refresh_header(struct rbd_device
*rbd_dev, u64 *hver)
 	return ret;
 }

+static int rbd_refresh_header(struct rbd_device *rbd_dev, u64 *hver)
+{
+	int ret;
+
+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
+	ret = __rbd_refresh_header(rbd_dev, hver);
+	mutex_unlock(&ctl_mutex);
+
+	return ret;
+}
+
 static int rbd_init_disk(struct rbd_device *rbd_dev)
 {
 	struct gendisk *disk;
@@ -1899,9 +1908,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
 	int ret;

-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-	ret = __rbd_refresh_header(rbd_dev, NULL);
-	mutex_unlock(&ctl_mutex);
+	ret = rbd_refresh_header(rbd_dev, NULL);

 	return ret < 0 ? ret : size;
 }
@@ -2191,9 +2198,7 @@ static int rbd_init_watch_dev(struct rbd_device
*rbd_dev)
 	do {
 		ret = rbd_req_sync_watch(rbd_dev);
 		if (ret == -ERANGE) {
-			mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-			rc = __rbd_refresh_header(rbd_dev, NULL);
-			mutex_unlock(&ctl_mutex);
+			rc = rbd_refresh_header(rbd_dev, NULL);
 			if (rc < 0)
 				return rc;
 		}
-- 
1.7.9.5

