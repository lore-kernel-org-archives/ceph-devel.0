From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 2/4] Rbd: add a new request: rbd_copyup_request
Date: Thu, 21 May 2015 17:19:53 +0800
Message-ID: <831f6e358c92970ea2eeb4d59bf974e2613cbc29.1432177493.git.liwang@ubuntukylin.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:37309 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbbEUJ2r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 05:28:47 -0400
In-Reply-To: <cover.1432177493.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1432177493.git.liwang@ubuntukylin.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Alex Elder <elder@kernel.org>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, Min Chen <minchen@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>, Li Wang <liwang@ubuntukylin.com>

From: Min Chen <minchen@ubuntukylin.com>

Rbd_copyup_request is used only when copy_on_read enabled
for RBD child images. It is independent of rbd_obj_request.

Signed-off-by: Min Chen <minchen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 drivers/block/rbd.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 446204b..581cb7b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -207,6 +207,9 @@ typedef void (*rbd_img_callback_t)(struct rbd_img_request *);
 struct rbd_obj_request;
 typedef void (*rbd_obj_callback_t)(struct rbd_obj_request *);
 
+struct rbd_copyup_request;
+typedef void (*rbd_copyup_callback_t)(struct rbd_copyup_request *);
+
 enum obj_request_type {
 	OBJ_REQUEST_NODATA, OBJ_REQUEST_BIO, OBJ_REQUEST_PAGES
 };
@@ -279,6 +282,27 @@ struct rbd_obj_request {
 	struct kref		kref;
 };
 
+struct rbd_copyup_request {
+	const char *	object_name;
+	u64		object_no;
+
+	struct page 	**copyup_pages;
+	u32		copyup_page_count;
+
+	struct rbd_img_request *img_request;
+	/* links for img_request->copyup_requests list */
+	struct list_head	links;
+
+	struct ceph_osd_request		*osd_req;
+
+	rbd_copyup_callback_t 	callback;
+	struct completion	completion;
+
+	int result;
+
+	struct kref	kref;
+};
+
 enum img_req_flags {
 	IMG_REQ_WRITE,		/* I/O direction: read = 0, write = 1 */
 	IMG_REQ_CHILD,		/* initiator: block = 0, child image = 1 */
@@ -310,6 +334,9 @@ struct rbd_img_request {
 	u32			obj_request_count;
 	struct list_head	obj_requests;	/* rbd_obj_request structs */
 
+	struct list_head	copyup_list;	/* rbd_copyup_request list */
+	spinlock_t		copyup_list_lock; /* protects copyup list */
+
 	struct kref		kref;
 };
 
@@ -320,6 +347,9 @@ struct rbd_img_request {
 #define for_each_obj_request_safe(ireq, oreq, n) \
 	list_for_each_entry_safe_reverse(oreq, n, &(ireq)->obj_requests, links)
 
+#define for_each_copyup_request(ireq, cpreq) \
+	list_for_each_entry(cpreq, &(ireq)->copyup_list, links)
+
 struct rbd_mapping {
 	u64                     size;
 	u64                     features;
@@ -399,6 +429,7 @@ static DEFINE_SPINLOCK(rbd_client_list_lock);
 
 static struct kmem_cache	*rbd_img_request_cache;
 static struct kmem_cache	*rbd_obj_request_cache;
+static struct kmem_cache	*rbd_copyup_request_cache;
 static struct kmem_cache	*rbd_segment_name_cache;
 
 static int rbd_major;
@@ -2178,6 +2209,8 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->result = 0;
 	img_request->obj_request_count = 0;
 	INIT_LIST_HEAD(&img_request->obj_requests);
+	INIT_LIST_HEAD(&img_request->copyup_list);
+	spin_lock_init(&img_request->copyup_list_lock);
 	kref_init(&img_request->kref);
 
 	dout("%s: rbd_dev %p %s %llu/%llu -> img %p\n", __func__, rbd_dev,
@@ -5666,6 +5699,14 @@ static int rbd_slab_init(void)
 	if (!rbd_obj_request_cache)
 		goto out_err;
 
+	rbd_assert(!rbd_copyup_request_cache);
+	rbd_copyup_request_cache = kmem_cache_create("rbd_copyup_request",
+					sizeof (struct rbd_copyup_request),
+					__alignof__(struct rbd_copyup_request),
+					0, NULL);
+	if (!rbd_copyup_request_cache)
+		goto out_err;
+
 	rbd_assert(!rbd_segment_name_cache);
 	rbd_segment_name_cache = kmem_cache_create("rbd_segment_name",
 					CEPH_MAX_OID_NAME_LEN + 1, 1, 0, NULL);
@@ -5677,6 +5718,11 @@ out_err:
 		rbd_obj_request_cache = NULL;
 	}
 
+	if (rbd_copyup_request_cache) {
+		kmem_cache_destroy(rbd_copyup_request_cache);
+		rbd_copyup_request_cache = NULL;
+	}
+
 	kmem_cache_destroy(rbd_img_request_cache);
 	rbd_img_request_cache = NULL;
 
@@ -5693,6 +5739,10 @@ static void rbd_slab_exit(void)
 	kmem_cache_destroy(rbd_obj_request_cache);
 	rbd_obj_request_cache = NULL;
 
+	rbd_assert(rbd_copyup_request_cache);
+	kmem_cache_destroy(rbd_copyup_request_cache);
+	rbd_copyup_request_cache = NULL;
+
 	rbd_assert(rbd_img_request_cache);
 	kmem_cache_destroy(rbd_img_request_cache);
 	rbd_img_request_cache = NULL;
-- 
1.9.1

