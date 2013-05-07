From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: revalidate only for mapping size changes
Date: Mon, 06 May 2013 20:34:17 -0500
Message-ID: <51885A19.7030905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:35532 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670Ab3EGBeX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 21:34:23 -0400
Received: by mail-ia0-f180.google.com with SMTP id 21so39417iay.25
        for <ceph-devel@vger.kernel.org>; Mon, 06 May 2013 18:34:22 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id d4sm5147215igc.3.2013.05.06.18.34.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 May 2013 18:34:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This commit:
    d98df63e rbd: revalidate_disk upon rbd resize
instituted a call to revalidate_disk() to notify interested parties
that a mapped image has changed size.  This works well, as long as
the the rbd device doesn't map a snapshot.

A snapshot will never change size.  However, the base image the
snapshot is associated with can, and it can do so while the snapshot
is mapped.

The problem is that the test for the size is looking at the size of
the base image, not the size of the mapped snapshot.  This patch
corrects that.

Update the warning message shown in the event of error, and move
it into the callers.

This resolves:
    http://tracker.ceph.com/issues/4911

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4263743..5d5e3f0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2628,6 +2628,7 @@ out:
 static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
 {
 	struct rbd_device *rbd_dev = (struct rbd_device *)data;
+	int ret;

 	if (!rbd_dev)
 		return;
@@ -2635,7 +2636,9 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
 	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
 		rbd_dev->header_name, (unsigned long long)notify_id,
 		(unsigned int)opcode);
-	(void)rbd_dev_refresh(rbd_dev);
+	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		rbd_warn(rbd_dev, ": header refresh error (%d)\n", ret);

 	rbd_obj_notify_ack(rbd_dev, notify_id);
 }
@@ -3182,11 +3185,11 @@ static void rbd_exists_validate(struct
rbd_device *rbd_dev)

 static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 {
-	u64 image_size;
+	u64 mapping_size;
 	int ret;

 	rbd_assert(rbd_image_format_valid(rbd_dev->image_format));
-	image_size = rbd_dev->header.image_size;
+	mapping_size = rbd_dev->mapping.size;
 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_refresh(rbd_dev);
@@ -3197,10 +3200,7 @@ static int rbd_dev_refresh(struct rbd_device
*rbd_dev)

 	rbd_exists_validate(rbd_dev);
 	mutex_unlock(&ctl_mutex);
-	if (ret)
-		rbd_warn(rbd_dev, "got notification but failed to "
-			   " update snaps: %d\n", ret);
-	if (image_size != rbd_dev->header.image_size)
+	if (mapping_size != rbd_dev->mapping.size)
 		revalidate_disk(rbd_dev->disk);

 	return ret;
@@ -3405,6 +3405,8 @@ static ssize_t rbd_image_refresh(struct device *dev,
 	int ret;

 	ret = rbd_dev_refresh(rbd_dev);
+	if (ret)
+		rbd_warn(rbd_dev, ": manual header refresh error (%d)\n", ret);

 	return ret < 0 ? ret : size;
 }
-- 
1.7.9.5

