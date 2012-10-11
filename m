From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] rbd: move dev_id and list links into mapping
Date: Thu, 11 Oct 2012 08:43:31 -0700
Message-ID: <5076E923.3040309@inktank.com>
References: <5076E8CF.1060108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48079 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab2JKPnf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Oct 2012 11:43:35 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1872641pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 11 Oct 2012 08:43:34 -0700 (PDT)
In-Reply-To: <5076E8CF.1060108@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The device id is a property of the mapping, not an rbd image.

Move the dev_id field to reflect that.  The "node" field in an rbd
device structure link together structures recording known device ids
rbd_dev_list.  Move those links into the mapping structure also,
and rename the field "id_list".

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   64 
++++++++++++++++++++++++++-------------------------
  1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cf5d109..8189841 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -169,14 +169,15 @@ struct rbd_mapping {
  	u64                     features;
  	bool                    snap_exists;
  	bool			read_only;
+
+	int			dev_id;		/* blkdev unique id */
+	struct list_head	id_list;
  };

  /*
   * a single device
   */
  struct rbd_device {
-	int			dev_id;		/* blkdev unique id */
-
  	int			major;		/* blkdev assigned major */
  	struct gendisk		*disk;		/* blkdev's gendisk and rq */

@@ -205,8 +206,6 @@ struct rbd_device {

  	struct rbd_mapping	mapping;

-	struct list_head	node;
-
  	/* list of snapshots */
  	struct list_head	snaps;

@@ -666,6 +665,7 @@ static int rbd_dev_set_mapping(struct rbd_device 
*rbd_dev, char *snap_name)
  {
  	int ret;

+	INIT_LIST_HEAD(&rbd_dev->mapping.id_list);
  	if (!memcmp(snap_name, RBD_SNAP_HEAD_NAME,
  		    sizeof (RBD_SNAP_HEAD_NAME))) {
  		rbd_dev->mapping.snap_id = CEPH_NOSNAP;
@@ -1771,7 +1771,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
  		return -ENOMEM;

  	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
-		 rbd_dev->dev_id);
+		 rbd_dev->mapping.dev_id);
  	disk->major = rbd_dev->major;
  	disk->first_minor = 0;
  	disk->fops = &rbd_bd_ops;
@@ -2560,7 +2560,7 @@ static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
  	dev->type = &rbd_device_type;
  	dev->parent = &rbd_root_dev;
  	dev->release = rbd_dev_release;
-	dev_set_name(dev, "%d", rbd_dev->dev_id);
+	dev_set_name(dev, "%d", rbd_dev->mapping.dev_id);
  	ret = device_register(dev);

  	mutex_unlock(&ctl_mutex);
@@ -2595,33 +2595,33 @@ static atomic64_t rbd_dev_id_max = ATOMIC64_INIT(0);
   * Get a unique rbd identifier for the given new rbd_dev, and add
   * the rbd_dev to the global list.  The minimum rbd id is 1.
   */
-static void rbd_dev_id_get(struct rbd_device *rbd_dev)
+static void rbd_dev_id_get(struct rbd_mapping *mapping)
  {
-	rbd_dev->dev_id = atomic64_inc_return(&rbd_dev_id_max);
+	mapping->dev_id = atomic64_inc_return(&rbd_dev_id_max);

  	spin_lock(&rbd_dev_list_lock);
-	list_add_tail(&rbd_dev->node, &rbd_dev_list);
+	list_add_tail(&mapping->id_list, &rbd_dev_list);
  	spin_unlock(&rbd_dev_list_lock);
-	dout("rbd_dev %p given dev id %llu\n", rbd_dev,
-		(unsigned long long) rbd_dev->dev_id);
+	dout("mapping %p given dev id %llu\n", mapping,
+		(unsigned long long) mapping->dev_id);
  }

  /*
   * Remove an rbd_dev from the global list, and record that its
   * identifier is no longer in use.
   */
-static void rbd_dev_id_put(struct rbd_device *rbd_dev)
+static void rbd_dev_id_put(struct rbd_mapping *mapping)
  {
  	struct list_head *tmp;
-	int rbd_id = rbd_dev->dev_id;
+	int rbd_id = mapping->dev_id;
  	int max_id;

  	rbd_assert(rbd_id > 0);

-	dout("rbd_dev %p released dev id %llu\n", rbd_dev,
-		(unsigned long long) rbd_dev->dev_id);
+	dout("mapping %p released dev id %llu\n", mapping,
+		(unsigned long long) mapping->dev_id);
  	spin_lock(&rbd_dev_list_lock);
-	list_del_init(&rbd_dev->node);
+	list_del_init(&mapping->id_list);

  	/*
  	 * If the id being "put" is not the current maximum, there
@@ -2639,11 +2639,11 @@ static void rbd_dev_id_put(struct rbd_device 
*rbd_dev)
  	 */
  	max_id = 0;
  	list_for_each_prev(tmp, &rbd_dev_list) {
-		struct rbd_device *rbd_dev;
+		struct rbd_mapping *rbd_map;

-		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_dev->dev_id > max_id)
-			max_id = rbd_dev->dev_id;
+		rbd_map = list_entry(tmp, struct rbd_mapping, id_list);
+		if (rbd_map->dev_id > max_id)
+			max_id = rbd_map->dev_id;
  	}
  	spin_unlock(&rbd_dev_list_lock);

@@ -3035,7 +3035,6 @@ static ssize_t rbd_add(struct bus_type *bus,

  	/* static rbd_device initialization */
  	spin_lock_init(&rbd_dev->lock);
-	INIT_LIST_HEAD(&rbd_dev->node);
  	INIT_LIST_HEAD(&rbd_dev->snaps);
  	init_rwsem(&rbd_dev->header_rwsem);

@@ -3072,12 +3071,12 @@ static ssize_t rbd_add(struct bus_type *bus,
  		goto err_out_header;

  	/* generate unique id: find highest unique id, add one */
-	rbd_dev_id_get(rbd_dev);
+	rbd_dev_id_get(&rbd_dev->mapping);

  	/* Fill in the device name, now that we have its id. */
  	BUILD_BUG_ON(DEV_NAME_LEN
  			< sizeof (RBD_DRV_NAME) + MAX_INT_FORMAT_WIDTH);
-	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->dev_id);
+	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->mapping.dev_id);

  	/* Get our block major device number. */

@@ -3132,7 +3131,7 @@ err_out_disk:
  err_out_blkdev:
  	unregister_blkdev(rbd_dev->major, rbd_dev->name);
  err_out_id:
-	rbd_dev_id_put(rbd_dev);
+	rbd_dev_id_put(&rbd_dev->mapping);
  err_out_header:
  	rbd_header_free(&rbd_dev->header);
  err_out_client:
@@ -3156,17 +3155,20 @@ err_out_mem:
  static struct rbd_device *__rbd_get_dev(unsigned long dev_id)
  {
  	struct list_head *tmp;
-	struct rbd_device *rbd_dev;

  	spin_lock(&rbd_dev_list_lock);
  	list_for_each(tmp, &rbd_dev_list) {
-		rbd_dev = list_entry(tmp, struct rbd_device, node);
-		if (rbd_dev->dev_id == dev_id) {
-			spin_unlock(&rbd_dev_list_lock);
-			return rbd_dev;
-		}
+		struct rbd_mapping *mapping;
+
+		mapping = list_entry(tmp, struct rbd_mapping, id_list);
+		if (mapping->dev_id != dev_id)
+			continue;
+		spin_unlock(&rbd_dev_list_lock);
+
+		return container_of(mapping, struct rbd_device, mapping);
  	}
  	spin_unlock(&rbd_dev_list_lock);
+
  	return NULL;
  }

@@ -3198,7 +3200,7 @@ static void rbd_dev_release(struct device *dev)
  	kfree(rbd_dev->header_name);
  	kfree(rbd_dev->pool_name);
  	kfree(rbd_dev->image_name);
-	rbd_dev_id_put(rbd_dev);
+	rbd_dev_id_put(&rbd_dev->mapping);
  	kfree(rbd_dev);

  	/* release module ref */
-- 
1.7.9.5

