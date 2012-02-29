From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] rbd: a few simple changes
Date: Tue, 28 Feb 2012 19:46:31 -0800
Message-ID: <4F4D9F97.1030906@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33960 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030760Ab2B2Dqc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:46:32 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 535FA24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:46:32 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 4796624314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:46:32 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Here are a few very simple cleanups:
     - Add a "RBD_" prefix to the two driver name string definitions.
     - Move the definition of struct rbd_request below struct rbd_req_coll
       to avoid the need for an empty declaration of the latter.
     - Move and group the definitions of rbd_root_dev_release() and
       rbd_root_dev, as well as rbd_bus_type and rbd_bus_attrs[],
       close to the top of the file.  Arrange the latter so
       rbd_bus_type.bus_attrs can be initialized statically.
     - Get rid of an unnecessary local variable in rbd_open().
     - Rework some hokey logic in rbd_bus_add_dev(), so the value of
       "ret" at the end is either 0 or -ENOENT to avoid the need for
       the code duplication that was there.
     - Rename a goto target in rbd_add().

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  drivers/block/rbd.c |  107 
+++++++++++++++++++++++++--------------------------
  1 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index f6dba36..e7d6dfc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -41,8 +41,8 @@

  #include "rbd_types.h"

-#define DRV_NAME "rbd"
-#define DRV_NAME_LONG "rbd (rados block device)"
+#define RBD_DRV_NAME "rbd"
+#define RBD_DRV_NAME_LONG "rbd (rados block device)"

  #define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */

@@ -83,7 +83,7 @@ struct rbd_options {
  };

  /*
- * an instance of the client.  multiple devices may share a client.
+ * an instance of the client.  multiple devices may share an rbd client.
   */
  struct rbd_client {
  	struct ceph_client	*client;
@@ -92,20 +92,9 @@ struct rbd_client {
  	struct list_head	node;
  };

-struct rbd_req_coll;
-
  /*
- * a single io request
+ * a request completion status
   */
-struct rbd_request {
-	struct request		*rq;		/* blk layer request */
-	struct bio		*bio;		/* cloned bio */
-	struct page		**pages;	/* list of used pages */
-	u64			len;
-	int			coll_index;
-	struct rbd_req_coll	*coll;
-};
-
  struct rbd_req_status {
  	int done;
  	int rc;
@@ -122,6 +111,18 @@ struct rbd_req_coll {
  	struct rbd_req_status	status[0];
  };

+/*
+ * a single io request
+ */
+struct rbd_request {
+	struct request		*rq;		/* blk layer request */
+	struct bio		*bio;		/* cloned bio */
+	struct page		**pages;	/* list of used pages */
+	u64			len;
+	int			coll_index;
+	struct rbd_req_coll	*coll;
+};
+
  struct rbd_snap {
  	struct	device		dev;
  	const char		*name;
@@ -170,10 +171,6 @@ struct rbd_device {
  	struct device		dev;
  };

-static struct bus_type rbd_bus_type = {
-	.name		= "rbd",
-};
-
  static DEFINE_MUTEX(ctl_mutex);	  /* Serialize 
open/close/setup/teardown */

  static LIST_HEAD(rbd_dev_list);    /* devices */
@@ -191,6 +188,31 @@ static ssize_t rbd_snap_add(struct device *dev,
  static void __rbd_remove_snap_dev(struct rbd_device *rbd_dev,
  				  struct rbd_snap *snap);

+static ssize_t rbd_add(struct bus_type *bus, const char *buf,
+		       size_t count);
+static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
+			  size_t count);
+
+static struct bus_attribute rbd_bus_attrs[] = {
+	__ATTR(add, S_IWUSR, NULL, rbd_add),
+	__ATTR(remove, S_IWUSR, NULL, rbd_remove),
+	__ATTR_NULL
+};
+
+static struct bus_type rbd_bus_type = {
+	.name		= "rbd",
+	.bus_attrs	= rbd_bus_attrs,
+};
+
+static void rbd_root_dev_release(struct device *dev)
+{
+}
+
+static struct device rbd_root_dev = {
+	.init_name =    "rbd",
+	.release =      rbd_root_dev_release,
+};
+

  static struct rbd_device *dev_to_rbd(struct device *dev)
  {
@@ -211,8 +233,7 @@ static int __rbd_update_snaps(struct rbd_device 
*rbd_dev);

  static int rbd_open(struct block_device *bdev, fmode_t mode)
  {
-	struct gendisk *disk = bdev->bd_disk;
-	struct rbd_device *rbd_dev = disk->private_data;
+	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;

  	rbd_get_dev(rbd_dev);

@@ -1215,8 +1236,8 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, 
u8 opcode, void *data)
  	rc = __rbd_update_snaps(dev);
  	mutex_unlock(&ctl_mutex);
  	if (rc)
-		pr_warning(DRV_NAME "%d got notification but failed to update"
-			   " snaps: %d\n", dev->major, rc);
+		pr_warning(RBD_DRV_NAME "%d got notification but failed to "
+			   " update snaps: %d\n", dev->major, rc);

  	rbd_req_sync_notify_ack(dev, ver, notify_id, dev->obj_md_name);
  }
@@ -1746,7 +1767,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
  	if (!disk)
  		goto out;

-	snprintf(disk->disk_name, sizeof(disk->disk_name), DRV_NAME "%d",
+	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
  		 rbd_dev->id);
  	disk->major = rbd_dev->major;
  	disk->first_minor = 0;
@@ -2092,19 +2113,9 @@ static int __rbd_init_snaps_header(struct 
rbd_device *rbd_dev)
  	return 0;
  }

-
-static void rbd_root_dev_release(struct device *dev)
-{
-}
-
-static struct device rbd_root_dev = {
-	.init_name =    "rbd",
-	.release =      rbd_root_dev_release,
-};
-
  static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
  {
-	int ret = -ENOMEM;
+	int ret;
  	struct device *dev;
  	struct rbd_snap *snap;

@@ -2118,7 +2129,7 @@ static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
  	dev_set_name(dev, "%d", rbd_dev->id);
  	ret = device_register(dev);
  	if (ret < 0)
-		goto done_free;
+		goto out;

  	list_for_each_entry(snap, &rbd_dev->snaps, node) {
  		ret = rbd_register_snap_dev(rbd_dev, snap,
@@ -2126,10 +2137,7 @@ static int rbd_bus_add_dev(struct rbd_device 
*rbd_dev)
  		if (ret < 0)
  			break;
  	}
-
-	mutex_unlock(&ctl_mutex);
-	return 0;
-done_free:
+out:
  	mutex_unlock(&ctl_mutex);
  	return ret;
  }
@@ -2265,7 +2273,7 @@ static ssize_t rbd_add(struct bus_type *bus,
  		   mon_dev_name, options, rbd_dev->pool_name,
  		   rbd_dev->obj, rbd_dev->snap_name) < 4) {
  		rc = -EINVAL;
-		goto err_out_slot;
+		goto err_put_id;
  	}

  	if (rbd_dev->snap_name[0] == 0)
@@ -2277,11 +2285,11 @@ static ssize_t rbd_add(struct bus_type *bus,
  		 rbd_dev->obj, RBD_SUFFIX);

  	/* initialize rest of new object */
-	snprintf(rbd_dev->name, DEV_NAME_LEN, DRV_NAME "%d", rbd_dev->id);
+	snprintf(rbd_dev->name, DEV_NAME_LEN, RBD_DRV_NAME "%d", rbd_dev->id);

  	rc = rbd_get_client(rbd_dev, mon_dev_name, options);
  	if (rc < 0)
-		goto err_out_slot;
+		goto err_put_id;

  	/* pick the pool */
  	osdc = &rbd_dev->rbd_client->client->osdc;
@@ -2327,9 +2335,8 @@ err_out_blkdev:
  	unregister_blkdev(rbd_dev->major, rbd_dev->name);
  err_out_client:
  	rbd_put_client(rbd_dev);
-err_out_slot:
+err_put_id:
  	rbd_id_put(rbd_dev);
-
  	kfree(rbd_dev);
  err_out_opt:
  	kfree(options);
@@ -2460,12 +2467,6 @@ err_unlock:
  	return ret;
  }

-static struct bus_attribute rbd_bus_attrs[] = {
-	__ATTR(add, S_IWUSR, NULL, rbd_add),
-	__ATTR(remove, S_IWUSR, NULL, rbd_remove),
-	__ATTR_NULL
-};
-
  /*
   * create control files in sysfs
   * /sys/bus/rbd/...
@@ -2474,8 +2475,6 @@ static int rbd_sysfs_init(void)
  {
  	int ret;

-	rbd_bus_type.bus_attrs = rbd_bus_attrs;
-
  	ret = bus_register(&rbd_bus_type);
  	if (ret < 0)
  		return ret;
@@ -2498,7 +2497,7 @@ int __init rbd_init(void)
  	rc = rbd_sysfs_init();
  	if (rc)
  		return rc;
-	pr_info("loaded " DRV_NAME_LONG "\n");
+	pr_info("loaded " RBD_DRV_NAME_LONG "\n");
  	return 0;
  }

-- 
1.7.5.4

