From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] rbd: move more stuff into mapping
Date: Thu, 11 Oct 2012 08:43:44 -0700
Message-ID: <5076E930.5090504@inktank.com>
References: <5076E8CF.1060108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48079 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474Ab2JKPnv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Oct 2012 11:43:51 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1872641pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 11 Oct 2012 08:43:51 -0700 (PDT)
In-Reply-To: <5076E8CF.1060108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This moves a bunch of other fields out of the rbd device structure
and into the mapping structure.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   57 
+++++++++++++++++++++++++++------------------------
  1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8189841..250446d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -172,23 +172,22 @@ struct rbd_mapping {

  	int			dev_id;		/* blkdev unique id */
  	struct list_head	id_list;
+	char			name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
+
+	int			major;		/* blkdev assigned major */
+	spinlock_t		lock;		/* queue lock */
+	struct gendisk		*disk;		/* blkdev's gendisk and rq */
+
+	struct rbd_options	rbd_opts;
  };

  /*
   * a single device
   */
  struct rbd_device {
-	int			major;		/* blkdev assigned major */
-	struct gendisk		*disk;		/* blkdev's gendisk and rq */
-
  	u32			image_format;	/* Either 1 or 2 */
-	struct rbd_options	rbd_opts;
  	struct rbd_client	*rbd_client;

-	char			name[DEV_NAME_LEN]; /* blkdev name, e.g. rbd3 */
-
-	spinlock_t		lock;		/* queue lock */
-
  	struct rbd_image_header	header;
  	char			*image_id;
  	size_t			image_id_len;
@@ -452,7 +451,7 @@ static int parse_rbd_opts_token(char *c, void *private)
  static int rbd_get_client(struct rbd_device *rbd_dev, const char 
*mon_addr,
  				size_t mon_addr_len, char *options)
  {
-	struct rbd_options *rbd_opts = &rbd_dev->rbd_opts;
+	struct rbd_options *rbd_opts = &rbd_dev->mapping.rbd_opts;
  	struct ceph_options *ceph_opts;
  	struct rbd_client *rbdc;

@@ -672,7 +671,8 @@ static int rbd_dev_set_mapping(struct rbd_device 
*rbd_dev, char *snap_name)
  		rbd_dev->mapping.size = rbd_dev->header.image_size;
  		rbd_dev->mapping.features = rbd_dev->header.features;
  		rbd_dev->mapping.snap_exists = false;
-		rbd_dev->mapping.read_only = rbd_dev->rbd_opts.read_only;
+		rbd_dev->mapping.read_only =
+			rbd_dev->mapping.rbd_opts.read_only;
  		ret = 0;
  	} else {
  		ret = snap_by_name(rbd_dev, snap_name);
@@ -1293,7 +1293,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, 
u8 opcode, void *data)
  	rc = rbd_dev_refresh(rbd_dev, &hver);
  	if (rc)
  		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
-			   " update snaps: %d\n", rbd_dev->major, rc);
+			   " update snaps: %d\n", rbd_dev->mapping.major, rc);

  	rbd_req_sync_notify_ack(rbd_dev, hver, notify_id);
  }
@@ -1573,7 +1573,7 @@ static int rbd_merge_bvec(struct request_queue *q, 
struct bvec_merge_data *bmd,

  static void rbd_free_disk(struct rbd_device *rbd_dev)
  {
-	struct gendisk *disk = rbd_dev->disk;
+	struct gendisk *disk = rbd_dev->mapping.disk;

  	if (!disk)
  		return;
@@ -1697,7 +1697,7 @@ static void rbd_update_mapping_size(struct 
rbd_device *rbd_dev)
  	size = (sector_t) rbd_dev->header.image_size / SECTOR_SIZE;
  	dout("setting size to %llu sectors", (unsigned long long) size);
  	rbd_dev->mapping.size = (u64) size;
-	set_capacity(rbd_dev->disk, size);
+	set_capacity(rbd_dev->mapping.disk, size);
  }

  /*
@@ -1772,13 +1772,14 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)

  	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
  		 rbd_dev->mapping.dev_id);
-	disk->major = rbd_dev->major;
+	disk->major = rbd_dev->mapping.major;
  	disk->first_minor = 0;
  	disk->fops = &rbd_bd_ops;
  	disk->private_data = rbd_dev;

  	/* init rq */
-	q = blk_init_queue(rbd_rq_fn, &rbd_dev->lock);
+	spin_lock_init(&rbd_dev->mapping.lock);
+	q = blk_init_queue(rbd_rq_fn, &rbd_dev->mapping.lock);
  	if (!q)
  		goto out_disk;

@@ -1797,9 +1798,10 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)

  	q->queuedata = rbd_dev;

-	rbd_dev->disk = disk;
+	rbd_dev->mapping.disk = disk;

-	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
+	set_capacity(rbd_dev->mapping.disk,
+			rbd_dev->mapping.size / SECTOR_SIZE);

  	return 0;
  out_disk:
@@ -1824,7 +1826,7 @@ static ssize_t rbd_size_show(struct device *dev,
  	sector_t size;

  	down_read(&rbd_dev->header_rwsem);
-	size = get_capacity(rbd_dev->disk);
+	size = get_capacity(rbd_dev->mapping.disk);
  	up_read(&rbd_dev->header_rwsem);

  	return sprintf(buf, "%llu\n", (unsigned long long) size * SECTOR_SIZE);
@@ -1848,7 +1850,7 @@ static ssize_t rbd_major_show(struct device *dev,
  {
  	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

-	return sprintf(buf, "%d\n", rbd_dev->major);
+	return sprintf(buf, "%d\n", rbd_dev->mapping.major);
  }

  static ssize_t rbd_client_id_show(struct device *dev,
@@ -3034,7 +3036,6 @@ static ssize_t rbd_add(struct bus_type *bus,
  		goto err_out_mem;

  	/* static rbd_device initialization */
-	spin_lock_init(&rbd_dev->lock);
  	INIT_LIST_HEAD(&rbd_dev->snaps);
  	init_rwsem(&rbd_dev->header_rwsem);

@@ -3076,14 +3077,15 @@ static ssize_t rbd_add(struct bus_type *bus,
  	/* Fill in the device name, now that we have its id. */
  	BUILD_BUG_ON(DEV_NAME_LEN
  			< sizeof (RBD_DRV_NAME) + MAX_INT_FORMAT_WIDTH);
-	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->mapping.dev_id);
+	sprintf(rbd_dev->mapping.name, "%s%d",
+			RBD_DRV_NAME, rbd_dev->mapping.dev_id);

  	/* Get our block major device number. */

-	rc = register_blkdev(0, rbd_dev->name);
+	rc = register_blkdev(0, rbd_dev->mapping.name);
  	if (rc < 0)
  		goto err_out_id;
-	rbd_dev->major = rc;
+	rbd_dev->mapping.major = rc;

  	/* Set up the blkdev mapping. */

@@ -3112,9 +3114,10 @@ static ssize_t rbd_add(struct bus_type *bus,

  	/* Everything's ready.  Announce the disk to the world. */

-	add_disk(rbd_dev->disk);
+	add_disk(rbd_dev->mapping.disk);

-	pr_info("%s: added with size 0x%llx\n", rbd_dev->disk->disk_name,
+	pr_info("%s: added with size 0x%llx\n",
+		rbd_dev->mapping.disk->disk_name,
  		(unsigned long long) rbd_dev->mapping.size);

  	return count;
@@ -3129,7 +3132,7 @@ err_out_bus:
  err_out_disk:
  	rbd_free_disk(rbd_dev);
  err_out_blkdev:
-	unregister_blkdev(rbd_dev->major, rbd_dev->name);
+	unregister_blkdev(rbd_dev->mapping.major, rbd_dev->mapping.name);
  err_out_id:
  	rbd_dev_id_put(&rbd_dev->mapping);
  err_out_header:
@@ -3189,7 +3192,7 @@ static void rbd_dev_release(struct device *dev)

  	/* clean up and free blkdev */
  	rbd_free_disk(rbd_dev);
-	unregister_blkdev(rbd_dev->major, rbd_dev->name);
+	unregister_blkdev(rbd_dev->mapping.major, rbd_dev->mapping.name);

  	/* release allocated disk header fields */
  	rbd_header_free(&rbd_dev->header);
-- 
1.7.9.5

