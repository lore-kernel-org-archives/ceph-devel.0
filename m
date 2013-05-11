From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: define parent image request routines
Date: Sat, 11 May 2013 12:44:29 -0500
Message-ID: <518E837D.6040507@inktank.com>
References: <518E831E.6000206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:48664 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab3EKRoa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:44:30 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so9961756iec.21
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:44:30 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ua6sm5748434igb.0.2013.05.11.10.44.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:44:29 -0700 (PDT)
In-Reply-To: <518E831E.6000206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define rbd_parent_request_create() and rbd_parent_request_destroy()
to handle the creation of parent image requests submitted for
layered image objects.  For simplicity, let rbd_img_request_put()
handle dropping the reference to any image request (parent or not),
and call whichever destructor is appropriate on the last put.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   78
++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 607c536..72b53cd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1357,13 +1357,18 @@ static void rbd_obj_request_put(struct
rbd_obj_request *obj_request)
 	kref_put(&obj_request->kref, rbd_obj_request_destroy);
 }

+static bool img_request_child_test(struct rbd_img_request *img_request);
+static void rbd_parent_request_destroy(struct kref *kref);
 static void rbd_img_request_destroy(struct kref *kref);
 static void rbd_img_request_put(struct rbd_img_request *img_request)
 {
 	rbd_assert(img_request != NULL);
 	dout("%s: img %p (was %d)\n", __func__, img_request,
 		atomic_read(&img_request->kref.refcount));
-	kref_put(&img_request->kref, rbd_img_request_destroy);
+	if (img_request_child_test(img_request))
+		kref_put(&img_request->kref, rbd_parent_request_destroy);
+	else
+		kref_put(&img_request->kref, rbd_img_request_destroy);
 }

 static inline void rbd_img_obj_request_add(struct rbd_img_request
*img_request,
@@ -1480,6 +1485,12 @@ static void img_request_child_set(struct
rbd_img_request *img_request)
 	smp_mb();
 }

+static void img_request_child_clear(struct rbd_img_request *img_request)
+{
+	clear_bit(IMG_REQ_CHILD, &img_request->flags);
+	smp_mb();
+}
+
 static bool img_request_child_test(struct rbd_img_request *img_request)
 {
 	smp_mb();
@@ -1854,8 +1865,7 @@ static void rbd_dev_unparent(struct rbd_device
*rbd_dev)
 static struct rbd_img_request *rbd_img_request_create(
 					struct rbd_device *rbd_dev,
 					u64 offset, u64 length,
-					bool write_request,
-					bool child_request)
+					bool write_request)
 {
 	struct rbd_img_request *img_request;

@@ -1880,8 +1890,6 @@ static struct rbd_img_request *rbd_img_request_create(
 	} else {
 		img_request->snap_id = rbd_dev->spec->snap_id;
 	}
-	if (child_request)
-		img_request_child_set(img_request);
 	if (rbd_dev->parent_overlap)
 		img_request_layered_set(img_request);
 	spin_lock_init(&img_request->completion_lock);
@@ -1916,12 +1924,46 @@ static void rbd_img_request_destroy(struct kref
*kref)
 	if (img_request_write_test(img_request))
 		ceph_put_snap_context(img_request->snapc);

-	if (img_request_child_test(img_request))
-		rbd_obj_request_put(img_request->obj_request);
-
 	kmem_cache_free(rbd_img_request_cache, img_request);
 }

+static struct rbd_img_request *rbd_parent_request_create(
+					struct rbd_obj_request *obj_request,
+					u64 img_offset, u64 length)
+{
+	struct rbd_img_request *parent_request;
+	struct rbd_device *rbd_dev;
+
+	rbd_assert(obj_request->img_request);
+	rbd_dev = obj_request->img_request->rbd_dev;
+
+	parent_request = rbd_img_request_create(rbd_dev->parent,
+						img_offset, length, false);
+	if (!parent_request)
+		return NULL;
+
+	img_request_child_set(parent_request);
+	rbd_obj_request_get(obj_request);
+	parent_request->obj_request = obj_request;
+
+	return parent_request;
+}
+
+static void rbd_parent_request_destroy(struct kref *kref)
+{
+	struct rbd_img_request *parent_request;
+	struct rbd_obj_request *orig_request;
+
+	parent_request = container_of(kref, struct rbd_img_request, kref);
+	orig_request = parent_request->obj_request;
+
+	parent_request->obj_request = NULL;
+	rbd_obj_request_put(orig_request);
+	img_request_child_clear(parent_request);
+
+	rbd_img_request_destroy(kref);
+}
+
 static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 {
 	struct rbd_img_request *img_request;
@@ -2313,13 +2355,10 @@ static int rbd_img_obj_parent_read_full(struct
rbd_obj_request *obj_request)
 	}

 	result = -ENOMEM;
-	parent_request = rbd_img_request_create(rbd_dev->parent,
-						img_offset, length,
-						false, true);
+	parent_request = rbd_parent_request_create(obj_request,
+						img_offset, length);
 	if (!parent_request)
 		goto out_err;
-	rbd_obj_request_get(obj_request);
-	parent_request->obj_request = obj_request;

 	result = rbd_img_request_fill(parent_request, OBJ_REQUEST_PAGES, pages);
 	if (result)
@@ -2570,7 +2609,6 @@ out:

 static void rbd_img_parent_read(struct rbd_obj_request *obj_request)
 {
-	struct rbd_device *rbd_dev;
 	struct rbd_img_request *img_request;
 	int result;

@@ -2579,20 +2617,14 @@ static void rbd_img_parent_read(struct
rbd_obj_request *obj_request)
 	rbd_assert(obj_request->result == (s32) -ENOENT);
 	rbd_assert(obj_request_type_valid(obj_request->type));

-	rbd_dev = obj_request->img_request->rbd_dev;
-	rbd_assert(rbd_dev->parent != NULL);
 	/* rbd_read_finish(obj_request, obj_request->length); */
-	img_request = rbd_img_request_create(rbd_dev->parent,
+	img_request = rbd_parent_request_create(obj_request,
 						obj_request->img_offset,
-						obj_request->length,
-						false, true);
+						obj_request->length);
 	result = -ENOMEM;
 	if (!img_request)
 		goto out_err;

-	rbd_obj_request_get(obj_request);
-	img_request->obj_request = obj_request;
-
 	if (obj_request->type == OBJ_REQUEST_BIO)
 		result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
 						obj_request->bio_list);
@@ -2903,7 +2935,7 @@ static void rbd_request_fn(struct request_queue *q)

 		result = -ENOMEM;
 		img_request = rbd_img_request_create(rbd_dev, offset, length,
-							write_request, false);
+							write_request);
 		if (!img_request)
 			goto end_request;

-- 
1.7.9.5

