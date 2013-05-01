From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] rbd: allocate image object names with a slab allocator
Date: Wed, 01 May 2013 16:36:15 -0500
Message-ID: <51818ACF.5010202@inktank.com>
References: <51818A5C.1080903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:45670 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758841Ab3EAVgR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 May 2013 17:36:17 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so2466095ieb.31
        for <ceph-devel@vger.kernel.org>; Wed, 01 May 2013 14:36:17 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id ha2sm22615301igb.1.2013.05.01.14.36.16
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 14:36:16 -0700 (PDT)
In-Reply-To: <51818A5C.1080903@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The names of objects used for image object requests are always fixed
size.  So create a slab cache to manage them.  Define a new function
rbd_segment_name_free() to match rbd_segment_name() (which is what
supplies the dynamically-allocated name buffer).

This is part of:
    http://tracker.ceph.com/issues/3926

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 28a5ea3..8d9aeef 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -345,8 +345,11 @@ static DEFINE_SPINLOCK(rbd_dev_list_lock);
 static LIST_HEAD(rbd_client_list);		/* clients */
 static DEFINE_SPINLOCK(rbd_client_list_lock);

+/* Slab caches for frequently-allocated structures */
+
 static struct kmem_cache	*rbd_img_request_cache;
 static struct kmem_cache	*rbd_obj_request_cache;
+static struct kmem_cache	*rbd_segment_name_cache;

 static int rbd_img_request_submit(struct rbd_img_request *img_request);

@@ -985,7 +988,7 @@ static const char *rbd_segment_name(struct
rbd_device *rbd_dev, u64 offset)
 	u64 segment;
 	int ret;

-	name = kmalloc(MAX_OBJ_NAME_SIZE + 1, GFP_NOIO);
+	name = kmem_cache_alloc(rbd_segment_name_cache, GFP_NOIO);
 	if (!name)
 		return NULL;
 	segment = offset >> rbd_dev->header.obj_order;
@@ -1001,6 +1004,13 @@ static const char *rbd_segment_name(struct
rbd_device *rbd_dev, u64 offset)
 	return name;
 }

+static void rbd_segment_name_free(const char *name)
+{
+	/* The explicit cast here is needed to drop the const qualifier */
+
+	kmem_cache_free(rbd_segment_name_cache, (void *)name);
+}
+
 static u64 rbd_segment_offset(struct rbd_device *rbd_dev, u64 offset)
 {
 	u64 segment_size = (u64) 1 << rbd_dev->header.obj_order;
@@ -2033,7 +2043,8 @@ static int rbd_img_request_fill(struct
rbd_img_request *img_request,
 		length = rbd_segment_length(rbd_dev, img_offset, resid);
 		obj_request = rbd_obj_request_create(object_name,
 						offset, length, type);
-		kfree(object_name);	/* object request has its own copy */
+		/* object request has its own copy of the object name */
+		rbd_segment_name_free(object_name);
 		if (!obj_request)
 			goto out_unwind;

@@ -5018,17 +5029,32 @@ static int rbd_slab_init(void)
 					sizeof (struct rbd_obj_request),
 					__alignof__(struct rbd_obj_request),
 					0, NULL);
-	if (rbd_obj_request_cache)
-		return 0;
+	if (!rbd_obj_request_cache)
+		goto out_err;

+	rbd_assert(!rbd_segment_name_cache);
+	rbd_segment_name_cache = kmem_cache_create("rbd_segment_name",
+					MAX_OBJ_NAME_SIZE + 1, 1, 0, NULL);
+	if (rbd_segment_name_cache)
+		return 0;
+out_err:
 	kmem_cache_destroy(rbd_img_request_cache);
 	rbd_img_request_cache = NULL;

+	if (rbd_img_request_cache) {
+		kmem_cache_destroy(rbd_obj_request_cache);
+		rbd_img_request_cache = NULL;
+	}
+
 	return -ENOMEM;
 }

 static void rbd_slab_exit(void)
 {
+	rbd_assert(rbd_segment_name_cache);
+	kmem_cache_destroy(rbd_segment_name_cache);
+	rbd_segment_name_cache = NULL;
+
 	rbd_assert(rbd_obj_request_cache);
 	kmem_cache_destroy(rbd_obj_request_cache);
 	rbd_obj_request_cache = NULL;
-- 
1.7.9.5

