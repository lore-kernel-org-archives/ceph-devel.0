From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/2] rbd: small changes
Date: Tue, 28 Feb 2012 20:37:18 -0800
Message-ID: <4F4DAB7E.2080308@dreamhost.com>
References: <4F4DA340.3040202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54628 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab2B2EhU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:37:20 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E997E24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:37:19 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 929E324314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:37:19 -0800 (PST)
In-Reply-To: <4F4DA340.3040202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here is another set of small code tidy-ups:
     - Define SECTOR_SHIFT and SECTOR_SIZE, and use these symbolic
       names throughout.  Tell the blk_queue system our physical
       block size, in the (unlikely) event we want to use something
       other than the default.
     - Delete the definition of struct rbd_info, which is never used.
     - Move the definition of dev_to_rbd() down in its source file,
       just above where it gets first used, and change its name to
       dev_to_rbd_dev().
     - Replace an open-coded operation in rbd_dev_release() to use
       dev_to_rbd_dev() instead.
     - Calculate the segment size for a given rbd_device just once in
       rbd_init_disk().
     - Use the '%zd' conversion specifier in rbd_snap_size_show(),
       since the value formatted is a size_t.
     - Switch to the '%llu' conversion specifier in rbd_snap_id_show().
       since the value formatted is unsigned.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c       |   85 
+++++++++++++++++++++++++++-----------------
  drivers/block/rbd_types.h |    4 --
  2 files changed, 52 insertions(+), 37 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a04322c..229f974 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -41,6 +41,15 @@

  #include "rbd_types.h"

+/*
+ * The basic unit of block I/O is a sector.  It is interpreted in a
+ * number of contexts in Linux (blk, bio, genhd), but the default is
+ * universally 512 bytes.  These symbols are just slightly more
+ * meaningful than the bare numbers they represent.
+ */
+#define	SECTOR_SHIFT	9
+#define	SECTOR_SIZE	(1ULL << SECTOR_SHIFT)
+
  #define RBD_DRV_NAME "rbd"
  #define RBD_DRV_NAME_LONG "rbd (rados block device)"

@@ -221,11 +230,6 @@ static struct device rbd_root_dev = {
  };


-static struct rbd_device *dev_to_rbd(struct device *dev)
-{
-	return container_of(dev, struct rbd_device, dev);
-}
-
  static struct device *rbd_get_dev(struct rbd_device *rbd_dev)
  {
  	return get_device(&rbd_dev->dev);
@@ -742,7 +746,7 @@ static struct bio *bio_chain_clone(struct bio **old, 
struct bio **next,

  			/* split the bio. We'll release it either in the next
  			   call, or it will have to be released outside */
-			bp = bio_split(old_chain, (len - total) / 512ULL);
+			bp = bio_split(old_chain, (len - total) / SECTOR_SIZE);
  			if (!bp)
  				goto err_out;

@@ -1470,7 +1474,7 @@ static void rbd_rq_fn(struct request_queue *q)
  		do_write = (rq_data_dir(rq) == WRITE);

  		size = blk_rq_bytes(rq);
-		ofs = blk_rq_pos(rq) * 512ULL;
+		ofs = blk_rq_pos(rq) * SECTOR_SIZE;
  		rq_bio = rq->bio;
  		if (do_write && rbd_dev->read_only) {
  			__blk_end_request_all(rq, -EROFS);
@@ -1481,7 +1485,7 @@ static void rbd_rq_fn(struct request_queue *q)

  		dout("%s 0x%x bytes at 0x%llx\n",
  		     do_write ? "write" : "read",
-		     size, blk_rq_pos(rq) * 512ULL);
+		     size, blk_rq_pos(rq) * SECTOR_SIZE);

  		num_segs = rbd_get_num_segments(&rbd_dev->header, ofs, size);
  		coll = rbd_alloc_coll(num_segs);
@@ -1546,13 +1550,17 @@ static int rbd_merge_bvec(struct request_queue 
*q, struct bvec_merge_data *bmd,
  			  struct bio_vec *bvec)
  {
  	struct rbd_device *rbd_dev = q->queuedata;
-	unsigned int chunk_sectors = 1 << (rbd_dev->header.obj_order - 9);
-	sector_t sector = bmd->bi_sector + get_start_sect(bmd->bi_bdev);
-	unsigned int bio_sectors = bmd->bi_size >> 9;
+	unsigned int chunk_sectors;
+	sector_t sector;
+	unsigned int bio_sectors;
  	int max;

+	chunk_sectors = 1 << (rbd_dev->header.obj_order - SECTOR_SHIFT);
+	sector = bmd->bi_sector + get_start_sect(bmd->bi_bdev);
+	bio_sectors = bmd->bi_size >> SECTOR_SHIFT;
+
  	max =  (chunk_sectors - ((sector & (chunk_sectors - 1))
-				 + bio_sectors)) << 9;
+				 + bio_sectors)) << SECTOR_SHIFT;
  	if (max < 0)
  		max = 0; /* bio_add cannot handle a negative return */
  	if (max <= bvec->bv_len && bio_sectors == 0)
@@ -1707,7 +1715,7 @@ static int __rbd_update_snaps(struct rbd_device 
*rbd_dev)
  		return ret;

  	/* resized? */
-	set_capacity(rbd_dev->disk, h.image_size / 512ULL);
+	set_capacity(rbd_dev->disk, h.image_size / SECTOR_SIZE);

  	down_write(&rbd_dev->header.snap_rwsem);

@@ -1744,6 +1752,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
  	struct gendisk *disk;
  	struct request_queue *q;
  	int rc;
+	u64 segment_size;
  	u64 total_size = 0;

  	/* contact OSD, request size info about the object being mapped */
@@ -1779,11 +1788,15 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
  	if (!q)
  		goto out_disk;

+	/* We use the default size, but let's be explicit about it. */
+	blk_queue_physical_block_size(q, SECTOR_SIZE);
+
  	/* set io sizes to object size */
-	blk_queue_max_hw_sectors(q, rbd_obj_bytes(&rbd_dev->header) / 512ULL);
-	blk_queue_max_segment_size(q, rbd_obj_bytes(&rbd_dev->header));
-	blk_queue_io_min(q, rbd_obj_bytes(&rbd_dev->header));
-	blk_queue_io_opt(q, rbd_obj_bytes(&rbd_dev->header));
+	segment_size = rbd_obj_bytes(&rbd_dev->header);
+	blk_queue_max_hw_sectors(q, segment_size / SECTOR_SIZE);
+	blk_queue_max_segment_size(q, segment_size);
+	blk_queue_io_min(q, segment_size);
+	blk_queue_io_opt(q, segment_size);

  	blk_queue_merge_bvec(q, rbd_merge_bvec);
  	disk->queue = q;
@@ -1794,7 +1807,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
  	rbd_dev->q = q;

  	/* finally, announce the disk to the world */
-	set_capacity(disk, total_size / 512ULL);
+	set_capacity(disk, total_size / SECTOR_SIZE);
  	add_disk(disk);

  	pr_info("%s: added with size 0x%llx\n",
@@ -1811,10 +1824,15 @@ out:
    sysfs
  */

+static struct rbd_device *dev_to_rbd_dev(struct device *dev)
+{
+	return container_of(dev, struct rbd_device, dev);
+}
+
  static ssize_t rbd_size_show(struct device *dev,
  			     struct device_attribute *attr, char *buf)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

  	return sprintf(buf, "%llu\n", (unsigned long 
long)rbd_dev->header.image_size);
  }
@@ -1822,7 +1840,7 @@ static ssize_t rbd_size_show(struct device *dev,
  static ssize_t rbd_major_show(struct device *dev,
  			      struct device_attribute *attr, char *buf)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

  	return sprintf(buf, "%d\n", rbd_dev->major);
  }
@@ -1830,7 +1848,7 @@ static ssize_t rbd_major_show(struct device *dev,
  static ssize_t rbd_client_id_show(struct device *dev,
  				  struct device_attribute *attr, char *buf)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

  	return sprintf(buf, "client%lld\n",
  			ceph_client_id(rbd_dev->rbd_client->client));
@@ -1839,7 +1857,7 @@ static ssize_t rbd_client_id_show(struct device *dev,
  static ssize_t rbd_pool_show(struct device *dev,
  			     struct device_attribute *attr, char *buf)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

  	return sprintf(buf, "%s\n", rbd_dev->pool_name);
  }
@@ -1847,7 +1865,7 @@ static ssize_t rbd_pool_show(struct device *dev,
  static ssize_t rbd_name_show(struct device *dev,
  			     struct device_attribute *attr, char *buf)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

  	return sprintf(buf, "%s\n", rbd_dev->obj);
  }
@@ -1856,7 +1874,7 @@ static ssize_t rbd_snap_show(struct device *dev,
  			     struct device_attribute *attr,
  			     char *buf)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

  	return sprintf(buf, "%s\n", rbd_dev->snap_name);
  }
@@ -1866,7 +1884,7 @@ static ssize_t rbd_image_refresh(struct device *dev,
  				 const char *buf,
  				 size_t size)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
  	int rc;
  	int ret = size;

@@ -1931,7 +1949,7 @@ static ssize_t rbd_snap_size_show(struct device *dev,
  {
  	struct rbd_snap *snap = container_of(dev, struct rbd_snap, dev);

-	return sprintf(buf, "%lld\n", (long long)snap->size);
+	return sprintf(buf, "%zd\n", snap->size);
  }

  static ssize_t rbd_snap_id_show(struct device *dev,
@@ -1940,7 +1958,7 @@ static ssize_t rbd_snap_id_show(struct device *dev,
  {
  	struct rbd_snap *snap = container_of(dev, struct rbd_snap, dev);

-	return sprintf(buf, "%lld\n", (long long)snap->id);
+	return sprintf(buf, "%llu\n", (unsigned long long) snap->id);
  }

  static DEVICE_ATTR(snap_size, S_IRUGO, rbd_snap_size_show, NULL);
@@ -2231,7 +2249,8 @@ static void rbd_id_put(struct rbd_device *rbd_dev)
  /*
   * Skips over white space at *buf, and updates *buf to point to the
   * first found non-space character (if any). Returns the length of
- * the token (string of non-white space characters) found.
+ * the token (string of non-white space characters) found.  Note
+ * that *buf must be terminated with '\0'.
   */
  static inline size_t next_token(const char **buf)
  {
@@ -2249,13 +2268,14 @@ static inline size_t next_token(const char **buf)
  /*
   * Finds the next token in *buf, and if the provided token buffer is
   * big enough, copies the found token into it.  The result, if
- * copied, is guaranteed to be terminated with '\0'.
+ * copied, is guaranteed to be terminated with '\0'.  Note that *buf
+ * must be terminated with '\0' on entry.
   *
   * Returns the length of the token found (not including the '\0').
   * Return value will be 0 if no token is found, and it will be >=
   * token_size if the token would not fit.
   *
- * The *buf pointer will be updated point beyond the end of the
+ * The *buf pointer will be updated to point beyond the end of the
   * found token.  Note that this occurs even if the token buffer is
   * too small to hold it.
   */
@@ -2452,8 +2472,7 @@ static struct rbd_device *__rbd_get_dev(unsigned 
long id)

  static void rbd_dev_release(struct device *dev)
  {
-	struct rbd_device *rbd_dev =
-			container_of(dev, struct rbd_device, dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);

  	if (rbd_dev->watch_request) {
  		struct ceph_client *client = rbd_dev->rbd_client->client;
@@ -2516,7 +2535,7 @@ static ssize_t rbd_snap_add(struct device *dev,
  			    const char *buf,
  			    size_t count)
  {
-	struct rbd_device *rbd_dev = dev_to_rbd(dev);
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
  	int ret;
  	char *name = kmalloc(count + 1, GFP_KERNEL);
  	if (!name)
diff --git a/drivers/block/rbd_types.h b/drivers/block/rbd_types.h
index fc6c678..9507086 100644
--- a/drivers/block/rbd_types.h
+++ b/drivers/block/rbd_types.h
@@ -41,10 +41,6 @@
  #define RBD_HEADER_SIGNATURE	"RBD"
  #define RBD_HEADER_VERSION	"001.005"

-struct rbd_info {
-	__le64 max_id;
-} __attribute__ ((packed));
-
  struct rbd_image_snap_ondisk {
  	__le64 id;
  	__le64 image_size;
-- 
1.7.5.4

