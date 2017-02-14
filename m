From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 15/15] rbd: kill obj_request->object_name and rbd_segment_name_cache
Date: Tue, 14 Feb 2017 21:12:04 +0100
Message-ID: <1487103124-2974-16-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34152 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755015AbdBNUMz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:55 -0500
Received: by mail-qk0-f195.google.com with SMTP id e1so20709449qkh.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:49 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c         | 79 ++++-----------------------------------------
 include/linux/ceph/osdmap.h |  7 ----
 2 files changed, 7 insertions(+), 79 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3133bb66ce18..24e05b02d033 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -231,7 +231,6 @@ enum obj_req_flags {
 };
 
 struct rbd_obj_request {
-	const char		*object_name;
 	u64			object_no;
 	u64			offset;		/* object start byte */
 	u64			length;		/* bytes from offset */
@@ -440,7 +439,6 @@ static DEFINE_SPINLOCK(rbd_client_list_lock);
 
 static struct kmem_cache	*rbd_img_request_cache;
 static struct kmem_cache	*rbd_obj_request_cache;
-static struct kmem_cache	*rbd_segment_name_cache;
 
 static int rbd_major;
 static DEFINE_IDA(rbd_dev_id_ida);
@@ -1249,37 +1247,6 @@ static void rbd_dev_mapping_clear(struct rbd_device *rbd_dev)
 	rbd_dev->mapping.features = 0;
 }
 
-static void rbd_segment_name_free(const char *name)
-{
-	/* The explicit cast here is needed to drop the const qualifier */
-
-	kmem_cache_free(rbd_segment_name_cache, (void *)name);
-}
-
-static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
-{
-	const char *name_format = rbd_dev->image_format == 1 ?
-				      RBD_V1_DATA_FORMAT : RBD_V2_DATA_FORMAT;
-	char *name;
-	u64 segment;
-	int ret;
-
-	name = kmem_cache_alloc(rbd_segment_name_cache, GFP_NOIO);
-	if (!name)
-		return NULL;
-	segment = offset >> rbd_dev->header.obj_order;
-	ret = snprintf(name, CEPH_MAX_OID_NAME_LEN + 1, name_format,
-			rbd_dev->header.object_prefix, segment);
-	if (ret < 0 || ret > CEPH_MAX_OID_NAME_LEN) {
-		pr_err("error formatting segment name for #%llu (%d)\n",
-			segment, ret);
-		rbd_segment_name_free(name);
-		name = NULL;
-	}
-
-	return name;
-}
-
 static u64 rbd_segment_offset(struct rbd_device *rbd_dev, u64 offset)
 {
 	u64 segment_size = rbd_obj_bytes(&rbd_dev->header);
@@ -2050,29 +2017,17 @@ static void rbd_osd_req_destroy(struct ceph_osd_request *osd_req)
 	ceph_osdc_put_request(osd_req);
 }
 
-/* object_name is assumed to be a non-null pointer and NUL-terminated */
-
-static struct rbd_obj_request *rbd_obj_request_create(const char *object_name,
-						enum obj_request_type type)
+static struct rbd_obj_request *
+rbd_obj_request_create(enum obj_request_type type)
 {
 	struct rbd_obj_request *obj_request;
-	size_t size;
-	char *name;
 
 	rbd_assert(obj_request_type_valid(type));
 
-	size = strlen(object_name) + 1;
-	name = kmalloc(size, GFP_NOIO);
-	if (!name)
-		return NULL;
-
 	obj_request = kmem_cache_zalloc(rbd_obj_request_cache, GFP_NOIO);
-	if (!obj_request) {
-		kfree(name);
+	if (!obj_request)
 		return NULL;
-	}
 
-	obj_request->object_name = memcpy(name, object_name, size);
 	obj_request->which = BAD_WHICH;
 	obj_request->type = type;
 	INIT_LIST_HEAD(&obj_request->links);
@@ -2114,8 +2069,6 @@ static void rbd_obj_request_destroy(struct kref *kref)
 		break;
 	}
 
-	kfree(obj_request->object_name);
-	obj_request->object_name = NULL;
 	kmem_cache_free(rbd_obj_request_cache, obj_request);
 }
 
@@ -2490,17 +2443,11 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 
 	while (resid) {
 		struct ceph_osd_request *osd_req;
-		const char *object_name;
 		u64 object_no = img_offset >> rbd_dev->header.obj_order;
 		u64 offset = rbd_segment_offset(rbd_dev, img_offset);
 		u64 length = rbd_segment_length(rbd_dev, img_offset, resid);
 
-		object_name = rbd_segment_name(rbd_dev, img_offset);
-		if (!object_name)
-			goto out_unwind;
-		obj_request = rbd_obj_request_create(object_name, type);
-		/* object request has its own copy of the object name */
-		rbd_segment_name_free(object_name);
+		obj_request = rbd_obj_request_create(type);
 		if (!obj_request)
 			goto out_unwind;
 
@@ -2846,8 +2793,7 @@ static int rbd_img_obj_exists_submit(struct rbd_obj_request *obj_request)
 	size_t size;
 	int ret;
 
-	stat_request = rbd_obj_request_create(obj_request->object_name,
-					      OBJ_REQUEST_PAGES);
+	stat_request = rbd_obj_request_create(OBJ_REQUEST_PAGES);
 	if (!stat_request)
 		return -ENOMEM;
 
@@ -6389,27 +6335,16 @@ static int rbd_slab_init(void)
 	if (!rbd_obj_request_cache)
 		goto out_err;
 
-	rbd_assert(!rbd_segment_name_cache);
-	rbd_segment_name_cache = kmem_cache_create("rbd_segment_name",
-					CEPH_MAX_OID_NAME_LEN + 1, 1, 0, NULL);
-	if (rbd_segment_name_cache)
-		return 0;
-out_err:
-	kmem_cache_destroy(rbd_obj_request_cache);
-	rbd_obj_request_cache = NULL;
+	return 0;
 
+out_err:
 	kmem_cache_destroy(rbd_img_request_cache);
 	rbd_img_request_cache = NULL;
-
 	return -ENOMEM;
 }
 
 static void rbd_slab_exit(void)
 {
-	rbd_assert(rbd_segment_name_cache);
-	kmem_cache_destroy(rbd_segment_name_cache);
-	rbd_segment_name_cache = NULL;
-
 	rbd_assert(rbd_obj_request_cache);
 	kmem_cache_destroy(rbd_obj_request_cache);
 	rbd_obj_request_cache = NULL;
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 8cebdc4158c3..938656f70807 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -82,13 +82,6 @@ void ceph_oloc_copy(struct ceph_object_locator *dest,
 void ceph_oloc_destroy(struct ceph_object_locator *oloc);
 
 /*
- * Maximum supported by kernel client object name length
- *
- * (probably outdated: must be >= RBD_MAX_MD_NAME_LEN -- currently 100)
- */
-#define CEPH_MAX_OID_NAME_LEN 100
-
-/*
  * 51-char inline_name is long enough for all cephfs and all but one
  * rbd requests: <imgname> in "<imgname>.rbd"/"rbd_id.<imgname>" can be
  * arbitrarily long (~PAGE_SIZE).  It's done once during rbd map; all
-- 
2.4.3

