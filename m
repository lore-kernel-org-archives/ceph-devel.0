From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 3/4] Rbd: helper functions to manipulate rbd_copyup_request
Date: Thu, 21 May 2015 17:19:54 +0800
Message-ID: <a1e6068984d14e1fb42ccf3af18961db7a087baa.1432177493.git.liwang@ubuntukylin.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:37268 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbEUJ2q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 05:28:46 -0400
In-Reply-To: <cover.1432177493.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1432177493.git.liwang@ubuntukylin.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Alex Elder <elder@kernel.org>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

From: Min Chen <minchen@ubuntukylin.com>

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 drivers/block/rbd.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 581cb7b..99a3a556 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1202,6 +1202,26 @@ static void rbd_dev_mapping_clear(struct rbd_device *rbd_dev)
 	rbd_dev->mapping.features = 0;
 }
 
+static inline u64 rbd_object_no(struct rbd_device *rbd_dev, const char *object_name)
+{
+	const char *ptr = NULL;
+	size_t len = 0;
+	u64 offset_width = 10;
+	u64 obj_no = (u64)-1;
+
+	rbd_assert(rbd_dev);
+	rbd_assert(object_name);
+
+	ptr = object_name;
+	len = strlen(object_name);
+	if (rbd_dev->image_format == 2)
+		offset_width = 16;
+	rbd_assert(len >= offset_width);
+	ptr += len - offset_width;
+	obj_no = simple_strtoull(ptr, NULL, 16);
+	return obj_no;
+}
+
 static void rbd_segment_name_free(const char *name)
 {
 	/* The explicit cast here is needed to drop the const qualifier */
@@ -1518,6 +1538,8 @@ static void rbd_obj_request_put(struct rbd_obj_request *obj_request)
 	kref_put(&obj_request->kref, rbd_obj_request_destroy);
 }
 
+static void rbd_copyup_request_destroy(struct kref *kref);
+
 static void rbd_img_request_get(struct rbd_img_request *img_request)
 {
 	dout("%s: img %p (was %d)\n", __func__, img_request,
@@ -1575,6 +1597,34 @@ static inline void rbd_img_obj_request_del(struct rbd_img_request *img_request,
 	rbd_obj_request_put(obj_request);
 }
 
+static inline void rbd_img_copyup_request_add(struct rbd_img_request *img_request,
+					struct rbd_copyup_request *copyup_request)
+{
+	rbd_assert(copyup_request->img_request == NULL)
+	copyup_request->img_request = img_request;
+	/*
+	* For object locality, the new request is more likely to
+	* access the last inserted object, so, just insert copyup_request
+	* after head of list_head(copyup_list)
+	*/
+	spin_lock(&img_request->copyup_list_lock);
+	list_add(&copyup_request->links, &img_request->copyup_list);
+	spin_unlock(&img_request->copyup_list_lock);
+}
+
+static inline void rbd_img_copyup_request_del(struct rbd_img_request *img_request,
+					struct rbd_copyup_request *copyup_request)
+{
+	rbd_assert(copyup_request != NULL);
+	spin_lock(&img_request->copyup_list_lock);
+	list_del(&copyup_request->links);
+	spin_unlock(&img_request->copyup_list_lock);
+
+	rbd_assert(copyup_request->img_request == img_request);
+	copyup_request->img_request = NULL;
+	copyup_request->callback = NULL;
+}
+
 static bool obj_request_type_valid(enum obj_request_type type)
 {
 	switch (type) {
@@ -1726,6 +1776,8 @@ rbd_img_request_op_type(struct rbd_img_request *img_request)
 		return OBJ_OP_READ;
 }
 
+static void rbd_img_copyup_start(struct rbd_img_request *img_request, const char *object_name);
+
 static void
 rbd_img_obj_request_read_callback(struct rbd_obj_request *obj_request)
 {
@@ -2108,6 +2160,82 @@ static void rbd_obj_request_destroy(struct kref *kref)
 	kmem_cache_free(rbd_obj_request_cache, obj_request);
 }
 
+static struct rbd_copyup_request *rbd_copyup_request_create(const char *object_name,
+						struct rbd_device *rbd_dev)
+{
+	struct rbd_copyup_request *copyup_request = NULL;
+	size_t size = 0;
+	u64 length = 0;
+	char *name = NULL;
+	struct page **pages = NULL;
+	u32	page_count = 0;
+
+	rbd_assert(rbd_dev);
+	rbd_assert(object_name);
+
+	/* Allocate memory for object_name */
+	size = strlen(object_name) + 1;
+	name = kmalloc(size, GFP_KERNEL);
+	if(!name)
+		goto out_name;
+
+	/* Allocate memory for entire object */
+	length = (u64)1 << rbd_dev->header.obj_order;
+	page_count = (u32)calc_pages_for(0,length);
+	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
+	if (IS_ERR(pages))
+		goto out_pages;
+
+	/* Allocate memory for struct rbd_copyup_request */
+	copyup_request = kmem_cache_zalloc(rbd_copyup_request_cache, GFP_KERNEL);
+	if(!copyup_request)
+		goto out_request;
+
+	/* Init all members of struct rbd_copyup_request */
+	copyup_request->object_name = memcpy(name, object_name, size);
+	copyup_request->object_no = rbd_object_no(rbd_dev, object_name);
+	copyup_request->copyup_pages = pages;
+	copyup_request->copyup_page_count = page_count;
+
+	INIT_LIST_HEAD(&copyup_request->links);
+
+	init_completion(&copyup_request->completion);
+
+	return copyup_request;
+out_request:
+	if (copyup_request)
+		kmem_cache_free(rbd_copyup_request_cache, copyup_request);
+out_pages:
+	if (pages)
+		ceph_release_page_vector(pages, page_count);
+out_name:
+	if (name)
+		kfree(name);
+	return NULL;
+}
+
+static void rbd_copyup_request_destroy(struct kref *kref)
+{
+	struct rbd_copyup_request *copyup_request;
+	copyup_request = container_of(kref, struct rbd_copyup_request, kref);
+
+	if (copyup_request->osd_req) {
+		rbd_osd_req_destroy(copyup_request->osd_req);
+		copyup_request->osd_req = NULL;
+	}
+
+	if (copyup_request->copyup_pages) {
+		ceph_release_page_vector(copyup_request->copyup_pages, copyup_request->copyup_page_count);
+		copyup_request->copyup_pages = NULL;
+	}
+
+	if (copyup_request->object_name) {
+		kfree(copyup_request->object_name);
+		copyup_request->object_name = NULL;
+	}
+	kmem_cache_free(rbd_copyup_request_cache, copyup_request);
+}
+
 /* It's OK to call this for a device with no parent */
 
 static void rbd_spec_put(struct rbd_spec *spec);
-- 
1.9.1

