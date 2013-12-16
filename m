From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 7/7] rbd: add support for single-major device number allocation scheme
Date: Mon, 16 Dec 2013 19:16:33 +0200
Message-ID: <1387214193-18489-8-git-send-email-ilya.dryomov@inktank.com>
References: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:58184 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab3LPRRd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 12:17:33 -0500
Received: by mail-ee0-f53.google.com with SMTP id b57so2381697eek.40
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 09:17:32 -0800 (PST)
In-Reply-To: <1387214193-18489-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Currently each rbd device is allocated its own major number, which
leads to a hard limit of 230-250 images mapped at once.  This commit
adds support for a new single-major device number allocation scheme,
which is hidden behind a new single_major boolean module parameter and
is disabled by default for backwards compatibility reasons.  (Old
userspace cannot correctly unmap images mapped under single-major
scheme and would essentially just unmap a random image, if that.)

$ rbd showmapped
id pool image snap device
0  rbd  b100  -    /dev/rbd0
1  rbd  b101  -    /dev/rbd1
2  rbd  b102  -    /dev/rbd2
3  rbd  b103  -    /dev/rbd3

Old scheme (modprobe rbd):

$ ls -l /dev/rbd*
brw-rw---- 1 root disk 253, 0 Dec 10 12:24 /dev/rbd0
brw-rw---- 1 root disk 252, 0 Dec 10 12:28 /dev/rbd1
brw-rw---- 1 root disk 252, 1 Dec 10 12:28 /dev/rbd1p1
brw-rw---- 1 root disk 252, 2 Dec 10 12:28 /dev/rbd1p2
brw-rw---- 1 root disk 252, 3 Dec 10 12:28 /dev/rbd1p3
brw-rw---- 1 root disk 251, 0 Dec 10 12:28 /dev/rbd2
brw-rw---- 1 root disk 251, 1 Dec 10 12:28 /dev/rbd2p1
brw-rw---- 1 root disk 250, 0 Dec 10 12:24 /dev/rbd3

New scheme (modprobe rbd single_major=Y):

$ ls -l /dev/rbd*
brw-rw---- 1 root disk 253,   0 Dec 10 12:30 /dev/rbd0
brw-rw---- 1 root disk 253, 256 Dec 10 12:30 /dev/rbd1
brw-rw---- 1 root disk 253, 257 Dec 10 12:30 /dev/rbd1p1
brw-rw---- 1 root disk 253, 258 Dec 10 12:30 /dev/rbd1p2
brw-rw---- 1 root disk 253, 259 Dec 10 12:30 /dev/rbd1p3
brw-rw---- 1 root disk 253, 512 Dec 10 12:30 /dev/rbd2
brw-rw---- 1 root disk 253, 513 Dec 10 12:30 /dev/rbd2p1
brw-rw---- 1 root disk 253, 768 Dec 10 12:30 /dev/rbd3

(major 253 was assigned dynamically at module load time)

The new limit is 4096 images mapped at once, and it comes from the fact
that, as before, 256 minor numbers are reserved for each mapping.
(A follow-up commit changes the number of minors reserved and the way
we deal with partitions over that number.)

If single_major is set to true, two new sysfs interfaces show up:
/sys/bus/rbd/{add,remove}_single_major.  These are to be used instead
of /sys/bus/rbd/{add,remove}, which are disabled for backwards
compatibility reasons outlined above.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
Reviewed-by: Alex Elder <elder@linaro.org>
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd |   22 ++++++
 drivers/block/rbd.c                     |  132 ++++++++++++++++++++++++++-----
 2 files changed, 134 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index 17b119c692da..501adc2a9ec7 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -18,6 +18,28 @@ Removal of a device:
 
   $ echo <dev-id> > /sys/bus/rbd/remove
 
+What:		/sys/bus/rbd/add_single_major
+Date:		December 2013
+KernelVersion:	3.14
+Contact:	Sage Weil <sage@inktank.com>
+Description:	Available only if rbd module is inserted with single_major
+		parameter set to true.
+		Usage is the same as for /sys/bus/rbd/add.  If present,
+		should be used instead of the latter: any attempts to use
+		/sys/bus/rbd/add if /sys/bus/rbd/add_single_major is
+		available will fail for backwards compatibility reasons.
+
+What:		/sys/bus/rbd/remove_single_major
+Date:		December 2013
+KernelVersion:	3.14
+Contact:	Sage Weil <sage@inktank.com>
+Description:	Available only if rbd module is inserted with single_major
+		parameter set to true.
+		Usage is the same as for /sys/bus/rbd/remove.  If present,
+		should be used instead of the latter: any attempts to use
+		/sys/bus/rbd/remove if /sys/bus/rbd/remove_single_major is
+		available will fail for backwards compatibility reasons.
+
 Entries under /sys/bus/rbd/devices/<dev-id>/
 --------------------------------------------
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3fa18b0c5e4d..e5ddcb58e9a2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -91,7 +91,7 @@ static int atomic_dec_return_safe(atomic_t *v)
 
 #define RBD_DRV_NAME "rbd"
 
-#define RBD_MINORS_PER_MAJOR	256		/* max minors per blkdev */
+#define RBD_PART_SHIFT	8
 
 #define RBD_SNAP_DEV_NAME_PREFIX	"snap_"
 #define RBD_MAX_SNAP_NAME_LEN	\
@@ -387,8 +387,17 @@ static struct kmem_cache	*rbd_img_request_cache;
 static struct kmem_cache	*rbd_obj_request_cache;
 static struct kmem_cache	*rbd_segment_name_cache;
 
+static int rbd_major;
 static DEFINE_IDA(rbd_dev_id_ida);
 
+/*
+ * Default to false for now, as single-major requires >= 0.75 version of
+ * userspace rbd utility.
+ */
+static bool single_major = false;
+module_param(single_major, bool, S_IRUGO);
+MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: false)");
+
 static int rbd_img_request_submit(struct rbd_img_request *img_request);
 
 static void rbd_dev_device_release(struct device *dev);
@@ -397,21 +406,44 @@ static ssize_t rbd_add(struct bus_type *bus, const char *buf,
 		       size_t count);
 static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
 			  size_t count);
+static ssize_t rbd_add_single_major(struct bus_type *bus, const char *buf,
+				    size_t count);
+static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
+				       size_t count);
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
 static void rbd_spec_put(struct rbd_spec *spec);
 
+static int rbd_dev_id_to_minor(int dev_id)
+{
+	return dev_id << RBD_PART_SHIFT;
+}
+
+static int minor_to_rbd_dev_id(int minor)
+{
+	return minor >> RBD_PART_SHIFT;
+}
+
 static BUS_ATTR(add, S_IWUSR, NULL, rbd_add);
 static BUS_ATTR(remove, S_IWUSR, NULL, rbd_remove);
+static BUS_ATTR(add_single_major, S_IWUSR, NULL, rbd_add_single_major);
+static BUS_ATTR(remove_single_major, S_IWUSR, NULL, rbd_remove_single_major);
 
 static struct attribute *rbd_bus_attrs[] = {
 	&bus_attr_add.attr,
 	&bus_attr_remove.attr,
+	&bus_attr_add_single_major.attr,
+	&bus_attr_remove_single_major.attr,
 	NULL,
 };
 
 static umode_t rbd_bus_is_visible(struct kobject *kobj,
 				  struct attribute *attr, int index)
 {
+	if (!single_major &&
+	    (attr == &bus_attr_add_single_major.attr ||
+	     attr == &bus_attr_remove_single_major.attr))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -3402,7 +3434,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	u64 segment_size;
 
 	/* create gendisk info */
-	disk = alloc_disk(RBD_MINORS_PER_MAJOR);
+	disk = alloc_disk(1 << RBD_PART_SHIFT);
 	if (!disk)
 		return -ENOMEM;
 
@@ -4403,7 +4435,9 @@ static int rbd_dev_id_get(struct rbd_device *rbd_dev)
 {
 	int new_dev_id;
 
-	new_dev_id = ida_simple_get(&rbd_dev_id_ida, 0, 0, GFP_KERNEL);
+	new_dev_id = ida_simple_get(&rbd_dev_id_ida,
+				    0, minor_to_rbd_dev_id(1 << MINORBITS),
+				    GFP_KERNEL);
 	if (new_dev_id < 0)
 		return new_dev_id;
 
@@ -4863,13 +4897,19 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 			< sizeof (RBD_DRV_NAME) + MAX_INT_FORMAT_WIDTH);
 	sprintf(rbd_dev->name, "%s%d", RBD_DRV_NAME, rbd_dev->dev_id);
 
-	/* Get our block major device number. */
+	/* Record our major and minor device numbers. */
 
-	ret = register_blkdev(0, rbd_dev->name);
-	if (ret < 0)
-		goto err_out_id;
-	rbd_dev->major = ret;
-	rbd_dev->minor = 0;
+	if (!single_major) {
+		ret = register_blkdev(0, rbd_dev->name);
+		if (ret < 0)
+			goto err_out_id;
+
+		rbd_dev->major = ret;
+		rbd_dev->minor = 0;
+	} else {
+		rbd_dev->major = rbd_major;
+		rbd_dev->minor = rbd_dev_id_to_minor(rbd_dev->dev_id);
+	}
 
 	/* Set up the blkdev mapping. */
 
@@ -4901,7 +4941,8 @@ err_out_mapping:
 err_out_disk:
 	rbd_free_disk(rbd_dev);
 err_out_blkdev:
-	unregister_blkdev(rbd_dev->major, rbd_dev->name);
+	if (!single_major)
+		unregister_blkdev(rbd_dev->major, rbd_dev->name);
 err_out_id:
 	rbd_dev_id_put(rbd_dev);
 	rbd_dev_mapping_clear(rbd_dev);
@@ -5022,9 +5063,9 @@ err_out_format:
 	return ret;
 }
 
-static ssize_t rbd_add(struct bus_type *bus,
-		       const char *buf,
-		       size_t count)
+static ssize_t do_rbd_add(struct bus_type *bus,
+			  const char *buf,
+			  size_t count)
 {
 	struct rbd_device *rbd_dev = NULL;
 	struct ceph_options *ceph_opts = NULL;
@@ -5106,6 +5147,23 @@ err_out_module:
 	return (ssize_t)rc;
 }
 
+static ssize_t rbd_add(struct bus_type *bus,
+		       const char *buf,
+		       size_t count)
+{
+	if (single_major)
+		return -EINVAL;
+
+	return do_rbd_add(bus, buf, count);
+}
+
+static ssize_t rbd_add_single_major(struct bus_type *bus,
+				    const char *buf,
+				    size_t count)
+{
+	return do_rbd_add(bus, buf, count);
+}
+
 static void rbd_dev_device_release(struct device *dev)
 {
 	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
@@ -5113,8 +5171,8 @@ static void rbd_dev_device_release(struct device *dev)
 	rbd_free_disk(rbd_dev);
 	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
 	rbd_dev_mapping_clear(rbd_dev);
-	unregister_blkdev(rbd_dev->major, rbd_dev->name);
-	rbd_dev->major = 0;
+	if (!single_major)
+		unregister_blkdev(rbd_dev->major, rbd_dev->name);
 	rbd_dev_id_put(rbd_dev);
 	rbd_dev_mapping_clear(rbd_dev);
 }
@@ -5145,9 +5203,9 @@ static void rbd_dev_remove_parent(struct rbd_device *rbd_dev)
 	}
 }
 
-static ssize_t rbd_remove(struct bus_type *bus,
-			  const char *buf,
-			  size_t count)
+static ssize_t do_rbd_remove(struct bus_type *bus,
+			     const char *buf,
+			     size_t count)
 {
 	struct rbd_device *rbd_dev = NULL;
 	struct list_head *tmp;
@@ -5210,6 +5268,23 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	return count;
 }
 
+static ssize_t rbd_remove(struct bus_type *bus,
+			  const char *buf,
+			  size_t count)
+{
+	if (single_major)
+		return -EINVAL;
+
+	return do_rbd_remove(bus, buf, count);
+}
+
+static ssize_t rbd_remove_single_major(struct bus_type *bus,
+				       const char *buf,
+				       size_t count)
+{
+	return do_rbd_remove(bus, buf, count);
+}
+
 /*
  * create control files in sysfs
  * /sys/bus/rbd/...
@@ -5298,13 +5373,28 @@ static int __init rbd_init(void)
 	if (rc)
 		return rc;
 
+	if (single_major) {
+		rbd_major = register_blkdev(0, RBD_DRV_NAME);
+		if (rbd_major < 0) {
+			rc = rbd_major;
+			goto err_out_slab;
+		}
+	}
+
 	rc = rbd_sysfs_init();
 	if (rc)
-		goto err_out_slab;
+		goto err_out_blkdev;
+
+	if (single_major)
+		pr_info("loaded (major %d)\n", rbd_major);
+	else
+		pr_info("loaded\n");
 
-	pr_info("loaded\n");
 	return 0;
 
+err_out_blkdev:
+	if (single_major)
+		unregister_blkdev(rbd_major, RBD_DRV_NAME);
 err_out_slab:
 	rbd_slab_exit();
 	return rc;
@@ -5313,6 +5403,8 @@ err_out_slab:
 static void __exit rbd_exit(void)
 {
 	rbd_sysfs_cleanup();
+	if (single_major)
+		unregister_blkdev(rbd_major, RBD_DRV_NAME);
 	rbd_slab_exit();
 }
 
-- 
1.7.10.4

