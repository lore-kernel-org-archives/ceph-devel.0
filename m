From: Alex Elder <elder@inktank.com>
Subject: [PATCH 5/5] rbd: reference count parent requests
Date: Sat, 11 May 2013 12:44:43 -0500
Message-ID: <518E838B.1060006@inktank.com>
References: <518E831E.6000206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f171.google.com ([209.85.210.171]:65334 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152Ab3EKRoo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:44:44 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so5997380iar.2
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:44:44 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id w8sm5627940igl.9.2013.05.11.10.44.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:44:43 -0700 (PDT)
In-Reply-To: <518E831E.6000206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Keep a reference count for uses of the parent information for an rbd
device.

An initial reference is set in rbd_img_request_create() if the
target image has a parent (with non-zero overlap).  Each image
request for an image with a non-zero parent overlap gets another
reference when it's created, and that reference is dropped when the
request is destroyed.

The initial reference is dropped when the image gets torn down.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |  104
++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 72b53cd..71705f3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -55,6 +55,39 @@
 #define	SECTOR_SHIFT	9
 #define	SECTOR_SIZE	(1ULL << SECTOR_SHIFT)

+/*
+ * Increment the given counter and return its updated value.
+ * If the counter is already 0 it will not be incremented.
+ * If the counter is already at its maximum value returns
+ * -EINVAL without updating it.
+ */
+static int atomic_inc_return_safe(atomic_t *v)
+{
+	unsigned int counter;
+
+	counter = (unsigned int)__atomic_add_unless(v, 1, 0);
+	if (counter <= (unsigned int)INT_MAX)
+		return (int)counter;
+
+	atomic_dec(v);
+
+	return -EINVAL;
+}
+
+/* Decrement the counter.  Return the resulting value, or -EINVAL */
+static int atomic_dec_return_safe(atomic_t *v)
+{
+	int counter;
+
+	counter = atomic_dec_return(v);
+	if (counter >= 0)
+		return counter;
+
+	atomic_inc(v);
+
+	return -EINVAL;
+}
+
 #define RBD_DRV_NAME "rbd"
 #define RBD_DRV_NAME_LONG "rbd (rados block device)"

@@ -310,6 +343,7 @@ struct rbd_device {

 	struct rbd_spec		*parent_spec;
 	u64			parent_overlap;
+	atomic_t		parent_ref;
 	struct rbd_device	*parent;

 	/* protects updating the header */
@@ -359,6 +393,7 @@ static ssize_t rbd_add(struct bus_type *bus, const
char *buf,
 static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
 			  size_t count);
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
+static void rbd_spec_put(struct rbd_spec *spec);

 static struct bus_attribute rbd_bus_attrs[] = {
 	__ATTR(add, S_IWUSR, NULL, rbd_add),
@@ -1503,6 +1538,12 @@ static void img_request_layered_set(struct
rbd_img_request *img_request)
 	smp_mb();
 }

+static void img_request_layered_clear(struct rbd_img_request *img_request)
+{
+	clear_bit(IMG_REQ_LAYERED, &img_request->flags);
+	smp_mb();
+}
+
 static bool img_request_layered_test(struct rbd_img_request *img_request)
 {
 	smp_mb();
@@ -1858,6 +1899,58 @@ static void rbd_dev_unparent(struct rbd_device
*rbd_dev)
 }

 /*
+ * Parent image reference counting is used to determine when an
+ * image's parent fields can be safely torn down--after there are no
+ * more in-flight requests to the parent image.  When the last
+ * reference is dropped, cleaning them up is safe.
+ */
+static void rbd_dev_parent_put(struct rbd_device *rbd_dev)
+{
+	int counter;
+
+	if (!rbd_dev->parent_spec)
+		return;
+
+	counter = atomic_dec_return_safe(&rbd_dev->parent_ref);
+	if (counter > 0)
+		return;
+
+	/* Last reference; clean up parent data structures */
+
+	if (!counter)
+		rbd_dev_unparent(rbd_dev);
+	else
+		rbd_warn(rbd_dev, "parent reference underflow\n");
+}
+
+/*
+ * If an image has a non-zero parent overlap, get a reference to its
+ * parent.
+ *
+ * Returns true if the rbd device has a parent with a non-zero
+ * overlap and a reference for it was successfully taken, or
+ * false otherwise.
+ */
+static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
+{
+	int counter;
+
+	if (!rbd_dev->parent_spec)
+		return false;
+
+	counter = atomic_inc_return_safe(&rbd_dev->parent_ref);
+	if (counter > 0 && rbd_dev->parent_overlap)
+		return true;
+
+	/* Image was flattened, but parent is not yet torn down */
+
+	if (counter < 0)
+		rbd_warn(rbd_dev, "parent reference overflow\n");
+
+	return false;
+}
+
+/*
  * Caller is responsible for filling in the list of object requests
  * that comprises the image request, and the Linux request pointer
  * (if there is one).
@@ -1890,7 +1983,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	} else {
 		img_request->snap_id = rbd_dev->spec->snap_id;
 	}
-	if (rbd_dev->parent_overlap)
+	if (rbd_dev_parent_get(rbd_dev))
 		img_request_layered_set(img_request);
 	spin_lock_init(&img_request->completion_lock);
 	img_request->next_completion = 0;
@@ -1921,6 +2014,11 @@ static void rbd_img_request_destroy(struct kref
*kref)
 		rbd_img_obj_request_del(img_request, obj_request);
 	rbd_assert(img_request->obj_request_count == 0);

+	if (img_request_layered_test(img_request)) {
+		img_request_layered_clear(img_request);
+		rbd_dev_parent_put(img_request->rbd_dev);
+	}
+
 	if (img_request_write_test(img_request))
 		ceph_put_snap_context(img_request->snapc);

@@ -3492,6 +3590,7 @@ static struct rbd_device *rbd_dev_create(struct
rbd_client *rbdc,

 	spin_lock_init(&rbd_dev->lock);
 	rbd_dev->flags = 0;
+	atomic_set(&rbd_dev->parent_ref, 0);
 	INIT_LIST_HEAD(&rbd_dev->node);
 	init_rwsem(&rbd_dev->header_rwsem);

@@ -4533,7 +4632,7 @@ static void rbd_dev_unprobe(struct rbd_device
*rbd_dev)
 {
 	struct rbd_image_header	*header;

-	rbd_dev_unparent(rbd_dev);
+	rbd_dev_parent_put(rbd_dev);

 	/* Free dynamic fields from the header, then zero it out */

@@ -4605,6 +4704,7 @@ static int rbd_dev_probe_parent(struct rbd_device
*rbd_dev)
 	if (ret < 0)
 		goto out_err;
 	rbd_dev->parent = parent;
+	atomic_set(&rbd_dev->parent_ref, 1);

 	return 0;
 out_err:
-- 
1.7.9.5

