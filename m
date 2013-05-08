From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: only set up watch for mapped images
Date: Wed, 08 May 2013 17:08:29 -0500
Message-ID: <518ACCDD.6020802@inktank.com>
References: <518ACC55.7090100@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:47303 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab3EHWI3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 May 2013 18:08:29 -0400
Received: by mail-ob0-f182.google.com with SMTP id eh20so2279538obb.13
        for <ceph-devel@vger.kernel.org>; Wed, 08 May 2013 15:08:29 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xz9sm328458oeb.5.2013.05.08.15.08.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 08 May 2013 15:08:28 -0700 (PDT)
In-Reply-To: <518ACC55.7090100@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Any changes to parent images are immaterial to any mapped clone.
So there is no need to have a watch event registered on header
objects except for the header object of an image that is mapped.
In fact, a watch request is a write operation, and we may only
have read access to a parent image.

We can't set up the watch request until we know the name of the
header object though.  So pass a flag to rbd_dev_image_probe() to
indicate whether this probe is for a mapping or for a parent image.

Change the second parameter to rbd_dev_header_watch_sync() be
Boolean while we're at it.

This resolves:
    http://tracker.ceph.com/issues/4941

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index dbfc44a..e417704 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -358,7 +358,7 @@ static ssize_t rbd_add(struct bus_type *bus, const
char *buf,
 		       size_t count);
 static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
 			  size_t count);
-static int rbd_dev_image_probe(struct rbd_device *rbd_dev);
+static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);

 static struct bus_attribute rbd_bus_attrs[] = {
 	__ATTR(add, S_IWUSR, NULL, rbd_add),
@@ -2664,7 +2664,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id,
u8 opcode, void *data)
  * Request sync osd watch/unwatch.  The value of "start" determines
  * whether a watch request is being initiated or torn down.
  */
-static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, int start)
+static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev, bool
start)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
@@ -2698,7 +2698,7 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 					rbd_dev->watch_request->osd_req);

 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-				rbd_dev->watch_event->cookie, 0, start);
+				rbd_dev->watch_event->cookie, 0, start ? 1 : 0);
 	rbd_osd_req_format_write(obj_request);

 	ret = rbd_obj_request_submit(osdc, obj_request);
@@ -4549,7 +4549,7 @@ static int rbd_dev_probe_parent(struct rbd_device
*rbd_dev)
 	if (!parent)
 		goto out_err;

-	ret = rbd_dev_image_probe(parent);
+	ret = rbd_dev_image_probe(parent, false);
 	if (ret < 0)
 		goto out_err;
 	rbd_dev->parent = parent;
@@ -4654,12 +4654,7 @@ static int rbd_dev_header_name(struct rbd_device
*rbd_dev)

 static void rbd_dev_image_release(struct rbd_device *rbd_dev)
 {
-	int ret;
-
 	rbd_dev_unprobe(rbd_dev);
-	ret = rbd_dev_header_watch_sync(rbd_dev, 0);
-	if (ret)
-		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
 	kfree(rbd_dev->header_name);
 	rbd_dev->header_name = NULL;
 	rbd_dev->image_format = 0;
@@ -4671,9 +4666,11 @@ static void rbd_dev_image_release(struct
rbd_device *rbd_dev)

 /*
  * Probe for the existence of the header object for the given rbd
- * device.
+ * device.  If this image is the one being mapped (i.e., not a
+ * parent), initiate a watch on its header object before using that
+ * object to get detailed information about the rbd image.
  */
-static int rbd_dev_image_probe(struct rbd_device *rbd_dev)
+static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping)
 {
 	int ret;
 	int tmp;
@@ -4693,9 +4690,11 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev)
 	if (ret)
 		goto err_out_format;

-	ret = rbd_dev_header_watch_sync(rbd_dev, 1);
-	if (ret)
-		goto out_header_name;
+	if (mapping) {
+		ret = rbd_dev_header_watch_sync(rbd_dev, true);
+		if (ret)
+			goto out_header_name;
+	}

 	if (rbd_dev->image_format == 1)
 		ret = rbd_dev_v1_header_info(rbd_dev);
@@ -4719,9 +4718,12 @@ static int rbd_dev_image_probe(struct rbd_device
*rbd_dev)
 err_out_probe:
 	rbd_dev_unprobe(rbd_dev);
 err_out_watch:
-	tmp = rbd_dev_header_watch_sync(rbd_dev, 0);
-	if (tmp)
-		rbd_warn(rbd_dev, "unable to tear down watch request\n");
+	if (mapping) {
+		tmp = rbd_dev_header_watch_sync(rbd_dev, false);
+		if (tmp)
+			rbd_warn(rbd_dev, "unable to tear down "
+					"watch request (%d)\n", tmp);
+	}
 out_header_name:
 	kfree(rbd_dev->header_name);
 	rbd_dev->header_name = NULL;
@@ -4788,7 +4790,7 @@ static ssize_t rbd_add(struct bus_type *bus,
 	rbdc = NULL;		/* rbd_dev now owns this */
 	spec = NULL;		/* rbd_dev now owns this */

-	rc = rbd_dev_image_probe(rbd_dev);
+	rc = rbd_dev_image_probe(rbd_dev, true);
 	if (rc < 0)
 		goto err_out_rbd_dev;

@@ -4910,10 +4912,13 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	spin_unlock_irq(&rbd_dev->lock);
 	if (ret < 0)
 		goto done;
-	ret = count;
 	rbd_bus_del_dev(rbd_dev);
+	ret = rbd_dev_header_watch_sync(rbd_dev, false);
+	if (ret)
+		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
 	rbd_dev_image_release(rbd_dev);
 	module_put(THIS_MODULE);
+	ret = count;
 done:
 	mutex_unlock(&ctl_mutex);

-- 
1.7.9.5

