From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/7] rbd: do some header initialization earlier
Date: Fri, 07 Sep 2012 08:46:05 -0500
Message-ID: <5049FA9D.5050504@inktank.com>
References: <5049F951.2030706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39928 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab2IGNqI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:46:08 -0400
Received: by ieje11 with SMTP id e11so5016008iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:46:07 -0700 (PDT)
In-Reply-To: <5049F951.2030706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Move some of the code that initializes an rbd header out of
rbd_init_disk() and into its caller.

Move the code at the end of rbd_init_disk() that sets the device
capacity and activates the Linux device out of that function and
into the caller, ensuring we still have the disk size available
where we need it.

Update rbd_free_disk() so it still aligns well as an inverse of
rbd_init_disk(), moving the rbd_header_free() call out to its
caller.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   51
+++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 46b8f8e..6e735a7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1652,8 +1652,6 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 	if (!disk)
 		return;

-	rbd_header_free(&rbd_dev->header);
-
 	if (disk->flags & GENHD_FL_UP)
 		del_gendisk(disk);
 	if (disk->queue)
@@ -1875,20 +1873,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	int rc;
 	u64 segment_size;

-	/* contact OSD, request size info about the object being mapped */
-	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
-	if (rc)
-		return rc;
-
-	/* no need to lock here, as rbd_dev is not registered yet */
-	rc = rbd_dev_snap_devs_update(rbd_dev);
-	if (rc)
-		return rc;
-
-	rc = rbd_header_set_snap(rbd_dev, snap_name);
-	if (rc)
-		return rc;
-
 	/* create gendisk info */
 	rc = -ENOMEM;
 	disk = alloc_disk(RBD_MINORS_PER_MAJOR);
@@ -1925,12 +1909,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)

 	rbd_dev->disk = disk;

-	/* finally, announce the disk to the world */
-	set_capacity(disk, (sector_t) rbd_dev->mapping.size / SECTOR_SIZE);
-	add_disk(disk);
-
-	pr_info("%s: added with size 0x%llx\n",
-		disk->disk_name, (unsigned long long) rbd_dev->mapping.size);
 	return 0;

 out_disk:
@@ -2622,13 +2600,35 @@ static ssize_t rbd_add(struct bus_type *bus,
 	/*
 	 * At this point cleanup in the event of an error is the job
 	 * of the sysfs code (initiated by rbd_bus_del_dev()).
-	 *
-	 * Set up and announce blkdev mapping.
 	 */
+
+	/* contact OSD, request size info about the object being mapped */
+	rc = rbd_read_header(rbd_dev, &rbd_dev->header);
+	if (rc)
+		goto err_out_bus;
+
+	/* no need to lock here, as rbd_dev is not registered yet */
+	rc = rbd_dev_snap_devs_update(rbd_dev);
+	if (rc)
+		goto err_out_bus;
+
+	rc = rbd_header_set_snap(rbd_dev, snap_name);
+	if (rc)
+		goto err_out_bus;
+
+	/* Set up the blkdev mapping. */
+
 	rc = rbd_init_disk(rbd_dev);
 	if (rc)
 		goto err_out_bus;

+	/* Everything's ready.  Announce the disk to the world. */
+
+	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
+	add_disk(rbd_dev->disk);
+	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
+		(unsigned long long) rbd_dev->mapping.size);
+
 	rc = rbd_init_watch_dev(rbd_dev);
 	if (rc)
 		goto err_out_bus;
@@ -2700,6 +2700,9 @@ static void rbd_dev_release(struct device *dev)
 	rbd_free_disk(rbd_dev);
 	unregister_blkdev(rbd_dev->major, rbd_dev->name);

+	/* release allocated disk header fields */
+	rbd_header_free(&rbd_dev->header);
+
 	/* done with the id, and with the rbd_dev */
 	kfree(rbd_dev->mapping.snap_name);
 	kfree(rbd_dev->header_name);
-- 
1.7.9.5

