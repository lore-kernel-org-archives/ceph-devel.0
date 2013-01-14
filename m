From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: prevent open for image being removed
Date: Mon, 14 Jan 2013 12:51:03 -0600
Message-ID: <50F45397.2030905@inktank.com>
References: <50F4535A.6030601@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:50605 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757289Ab3ANSvG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 13:51:06 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so5464704iea.7
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 10:51:05 -0800 (PST)
In-Reply-To: <50F4535A.6030601@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

An open request for a mapped rbd image can arrive while removal of
that mapping is underway.  The control mutex and an open count is
protect a mapped device that's in use from being removed.  But it
is possible for the removal of the mapping to reach the point of no
return *after* a racing open has concluded it is OK to proceed.  The
result of this is not good.

Define and use a flag to indicate a mapping is getting removed to
avoid this problem.

This addresses http://tracker.newdream.net/issues/3427

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9eb1631..760f7f7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -264,6 +264,7 @@ struct rbd_device {

 enum rbd_dev_flags {
 	rbd_dev_flag_exists,	/* mapped snapshot has not been deleted */
+	rbd_dev_flag_removing,	/* this mapping is being removed */
 };

 static DEFINE_MUTEX(ctl_mutex);	  /* Serialize open/close/setup/teardown */
@@ -351,17 +352,22 @@ static int rbd_dev_v2_refresh(struct rbd_device
*rbd_dev, u64 *hver);
 static int rbd_open(struct block_device *bdev, fmode_t mode)
 {
 	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
+	int ret = 0;

 	if ((mode & FMODE_WRITE) && rbd_dev->mapping.read_only)
 		return -EROFS;

 	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
-	(void) get_device(&rbd_dev->dev);
-	set_device_ro(bdev, rbd_dev->mapping.read_only);
-	rbd_dev->open_count++;
+	if (!test_bit(rbd_dev_flag_removing, &rbd_dev->flags)) {
+		(void) get_device(&rbd_dev->dev);
+		set_device_ro(bdev, rbd_dev->mapping.read_only);
+		rbd_dev->open_count++;
+	} else {
+		ret = -ENOENT;
+	}
 	mutex_unlock(&ctl_mutex);

-	return 0;
+	return ret;
 }

 static int rbd_release(struct gendisk *disk, fmode_t mode)
@@ -3796,6 +3802,7 @@ static ssize_t rbd_remove(struct bus_type *bus,
 		ret = -EBUSY;
 		goto done;
 	}
+	set_bit(rbd_dev_flag_removing, &rbd_dev->flags);

 	rbd_remove_all_snaps(rbd_dev);
 	rbd_bus_del_dev(rbd_dev);
-- 
1.7.9.5

