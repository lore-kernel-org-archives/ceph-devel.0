From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: don't free rbd_dev outside of the release callback
Date: Mon, 19 Oct 2015 20:06:35 +0200
Message-ID: <1445277995-58102-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33576 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbJSQ0p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 12:26:45 -0400
Received: by wijp11 with SMTP id p11so14380428wij.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 09:26:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

struct rbd_device has struct device embedded in it, which means it's
part of kobject universe and has an unpredictable life cycle.  Freeing
its memory outside of the release callback is flawed, yet commits
200a6a8be5db ("rbd: don't destroy rbd_dev in device release function")
and 8ad42cd0c002 ("rbd: don't have device release destroy rbd_dev")
moved rbd_dev_destroy() out to rbd_dev_image_release().

This commit reverts most of that, the key points are:

- rbd_dev->dev is initialized in rbd_dev_create(), making it possible
  to use rbd_dev_destroy() - which is just a put_device() - both before
  we register with device core and after.

- rbd_dev_release() (the release callback) is the only place we
  kfree(rbd_dev).  It's also where we do module_put(), keeping the
  module unload race window as small as possible.

- We pin the module in rbd_dev_create(), but only for mapping
  rbd_dev-s.  Moving image related stuff out of struct rbd_device into
  another struct which isn't tied with sysfs and device core is long
  overdue, but until that happens, this will keep rbd module refcount
  (which users can observe with lsmod) sane.

Fixes: http://tracker.ceph.com/issues/12697

Cc: Alex Elder <elder@linaro.org>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 89 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index df795deffe77..4917de726bdb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -418,8 +418,6 @@ MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (d
 
 static int rbd_img_request_submit(struct rbd_img_request *img_request);
 
-static void rbd_dev_device_release(struct device *dev);
-
 static ssize_t rbd_add(struct bus_type *bus, const char *buf,
 		       size_t count);
 static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
@@ -4038,6 +4036,25 @@ static void rbd_spec_free(struct kref *kref)
 	kfree(spec);
 }
 
+static void rbd_dev_release(struct device *dev)
+{
+	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
+	bool need_put = !!rbd_dev->opts;
+
+	rbd_put_client(rbd_dev->rbd_client);
+	rbd_spec_put(rbd_dev->spec);
+	kfree(rbd_dev->opts);
+	kfree(rbd_dev);
+
+	/*
+	 * This is racy, but way better than putting module outside of
+	 * the release callback.  The race window is pretty small, so
+	 * doing something similar to dm (dm-builtin.c) is overkill.
+	 */
+	if (need_put)
+		module_put(THIS_MODULE);
+}
+
 static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 					 struct rbd_spec *spec,
 					 struct rbd_options *opts)
@@ -4054,6 +4071,12 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	INIT_LIST_HEAD(&rbd_dev->node);
 	init_rwsem(&rbd_dev->header_rwsem);
 
+	rbd_dev->dev.bus = &rbd_bus_type;
+	rbd_dev->dev.type = &rbd_device_type;
+	rbd_dev->dev.parent = &rbd_root_dev;
+	rbd_dev->dev.release = rbd_dev_release;
+	device_initialize(&rbd_dev->dev);
+
 	rbd_dev->rbd_client = rbdc;
 	rbd_dev->spec = spec;
 	rbd_dev->opts = opts;
@@ -4065,15 +4088,21 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 	rbd_dev->layout.fl_object_size = cpu_to_le32(1 << RBD_MAX_OBJ_ORDER);
 	rbd_dev->layout.fl_pg_pool = cpu_to_le32((u32) spec->pool_id);
 
+	/*
+	 * If this is a mapping rbd_dev (as opposed to a parent one),
+	 * pin our module.  We have a ref from do_rbd_add(), so use
+	 * __module_get().
+	 */
+	if (rbd_dev->opts)
+		__module_get(THIS_MODULE);
+
 	return rbd_dev;
 }
 
 static void rbd_dev_destroy(struct rbd_device *rbd_dev)
 {
-	rbd_put_client(rbd_dev->rbd_client);
-	rbd_spec_put(rbd_dev->spec);
-	kfree(rbd_dev->opts);
-	kfree(rbd_dev);
+	if (rbd_dev)
+		put_device(&rbd_dev->dev);
 }
 
 /*
@@ -4699,27 +4728,6 @@ static int rbd_dev_header_info(struct rbd_device *rbd_dev)
 	return rbd_dev_v2_header_info(rbd_dev);
 }
 
-static int rbd_bus_add_dev(struct rbd_device *rbd_dev)
-{
-	struct device *dev;
-	int ret;
-
-	dev = &rbd_dev->dev;
-	dev->bus = &rbd_bus_type;
-	dev->type = &rbd_device_type;
-	dev->parent = &rbd_root_dev;
-	dev->release = rbd_dev_device_release;
-	dev_set_name(dev, "%d", rbd_dev->dev_id);
-	ret = device_register(dev);
-
-	return ret;
-}
-
-static void rbd_bus_del_dev(struct rbd_device *rbd_dev)
-{
-	device_unregister(&rbd_dev->dev);
-}
-
 /*
  * Get a unique rbd identifier for the given new rbd_dev, and add
  * the rbd_dev to the global list.
@@ -5222,7 +5230,8 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
 	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
 	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
 
-	ret = rbd_bus_add_dev(rbd_dev);
+	dev_set_name(&rbd_dev->dev, "%d", rbd_dev->dev_id);
+	ret = device_add(&rbd_dev->dev);
 	if (ret)
 		goto err_out_mapping;
 
@@ -5402,7 +5411,7 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	/* parse add command */
 	rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
 	if (rc < 0)
-		goto err_out_module;
+		goto out;
 
 	rbdc = rbd_get_client(ceph_opts);
 	if (IS_ERR(rbdc)) {
@@ -5457,10 +5466,13 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		 */
 		rbd_dev_header_unwatch_sync(rbd_dev);
 		rbd_dev_image_release(rbd_dev);
-		goto err_out_module;
+		goto out;
 	}
 
-	return count;
+	rc = count;
+out:
+	module_put(THIS_MODULE);
+	return rc;
 
 err_out_rbd_dev:
 	rbd_dev_destroy(rbd_dev);
@@ -5469,12 +5481,7 @@ err_out_client:
 err_out_args:
 	rbd_spec_put(spec);
 	kfree(rbd_opts);
-err_out_module:
-	module_put(THIS_MODULE);
-
-	dout("Error adding device %s\n", buf);
-
-	return (ssize_t)rc;
+	goto out;
 }
 
 static ssize_t rbd_add(struct bus_type *bus,
@@ -5494,12 +5501,11 @@ static ssize_t rbd_add_single_major(struct bus_type *bus,
 	return do_rbd_add(bus, buf, count);
 }
 
-static void rbd_dev_device_release(struct device *dev)
+static void rbd_dev_device_release(struct rbd_device *rbd_dev)
 {
-	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
-
 	rbd_free_disk(rbd_dev);
 	clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
+	device_del(&rbd_dev->dev);
 	rbd_dev_mapping_clear(rbd_dev);
 	if (!single_major)
 		unregister_blkdev(rbd_dev->major, rbd_dev->name);
@@ -5589,9 +5595,8 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	 * rbd_bus_del_dev() will race with rbd_watch_cb(), resulting
 	 * in a potential use after free of rbd_dev->disk or rbd_dev.
 	 */
-	rbd_bus_del_dev(rbd_dev);
+	rbd_dev_device_release(rbd_dev);
 	rbd_dev_image_release(rbd_dev);
-	module_put(THIS_MODULE);
 
 	return count;
 }
-- 
2.4.3

