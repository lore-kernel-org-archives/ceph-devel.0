From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 4/4] Rbd: implement the copy-on-read logic
Date: Thu, 21 May 2015 17:19:55 +0800
Message-ID: <447c0db42cc71e92b1c2209f80e0e419628c3a9c.1432177493.git.liwang@ubuntukylin.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:37322 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbEUJ2r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 05:28:47 -0400
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
 drivers/block/rbd.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 99a3a556..51d8398 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1851,12 +1851,16 @@ static void rbd_osd_read_callback(struct rbd_obj_request *obj_request)
 		obj_request, img_request, obj_request->result,
 		obj_request->xferred, obj_request->length);
 	if (layered && obj_request->result == -ENOENT &&
-			obj_request->img_offset < rbd_dev->parent_overlap)
+			obj_request->img_offset < rbd_dev->parent_overlap) {
 		rbd_img_parent_read(obj_request);
-	else if (img_request)
+		rbd_assert(obj_request->img_request);
+		if(is_copy_on_read(obj_request->img_request->rbd_dev))
+			rbd_img_copyup_start(obj_request->img_request, obj_request->object_name);
+	} else if (img_request) {
 		rbd_img_obj_request_read_callback(obj_request);
-	else
+	} else {
 		obj_request_done_set(obj_request);
+	}
 }
 
 static void rbd_osd_write_callback(struct rbd_obj_request *obj_request)
@@ -2915,6 +2919,182 @@ out_err:
 	return result;
 }
 
+static void rbd_img_copyup_end(struct rbd_copyup_request *copyup_request)
+{
+	struct rbd_img_request *img_request = NULL;
+	rbd_assert(copyup_request);
+	img_request = copyup_request->img_request;
+	rbd_img_copyup_request_del(img_request, copyup_request);
+	rbd_copyup_request_destroy(&copyup_request->kref);
+	rbd_img_request_put(img_request);
+}
+
+static void rbd_osd_req_copyup_callback(struct ceph_osd_request *osd_req,
+					struct ceph_msg *msg)
+{
+	struct rbd_copyup_request *copyup_request = NULL;
+	rbd_assert(osd_req);
+	copyup_request = osd_req->r_priv;
+	copyup_request->result = osd_req->r_result;
+	if(copyup_request->callback)
+		copyup_request->callback(copyup_request);
+	else
+		complete_all(&copyup_request->completion);
+}
+
+static void rbd_img_copyup_write_async(struct rbd_copyup_request *copyup_request)
+{
+	struct rbd_img_request *img_request = NULL;
+	struct ceph_snap_context *snapc = NULL;
+	struct ceph_osd_request *osd_req = NULL;
+	struct ceph_osd_client *osdc = NULL;
+	struct rbd_device *rbd_dev = NULL;
+	struct page **pages = NULL;
+	struct timespec mtime = CURRENT_TIME;
+	u32 page_count = 0;
+	u64 object_size = 0;
+	int result = 0;
+
+	/* if copyup_request read from parent failed, just end it */
+	if (copyup_request->result < 0) {
+		rbd_img_copyup_end(copyup_request);
+		goto out;
+	}
+
+	img_request = copyup_request->img_request;
+	rbd_assert(img_request);
+	rbd_dev = img_request->rbd_dev;
+	rbd_assert(rbd_dev);
+	osdc = &rbd_dev->rbd_client->client->osdc;
+	rbd_assert(osdc);
+	snapc = rbd_dev->header.snapc;
+
+	ceph_osdc_put_request(copyup_request->osd_req);
+
+	copyup_request->osd_req = NULL;
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
+	if (!osd_req)
+		goto out;
+
+	pages = copyup_request->copyup_pages;
+	page_count = copyup_request->copyup_page_count;
+	object_size = (u64)1 << rbd_dev->header.obj_order;
+
+	/* Initialize copyup op */
+	osd_req_op_cls_init(osd_req, 0, CEPH_OSD_OP_CALL, "rbd", "copyup");
+	osd_req_op_cls_request_data_pages(osd_req, 0, pages, object_size, 0, false, false);
+	osd_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
+	osd_req->r_callback = rbd_osd_req_copyup_callback;
+	osd_req->r_priv = copyup_request;
+
+	osd_req->r_base_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->layout);
+	ceph_oid_set_name(&osd_req->r_base_oid, copyup_request->object_name);
+
+	copyup_request->osd_req = osd_req;
+	copyup_request->callback = rbd_img_copyup_end;
+
+	ceph_osdc_build_request(osd_req, 0, snapc, CEPH_NOSNAP, &mtime);
+	result = ceph_osdc_start_request(osdc, osd_req, false);
+	if(!result)
+		goto out;
+
+	ceph_osdc_put_request(osd_req);
+out:
+	return;
+}
+
+static void rbd_img_copyup_start(struct rbd_img_request *img_request,
+				const char *object_name)
+{
+	struct rbd_copyup_request *copyup_request = NULL;
+	struct rbd_device *rbd_dev = NULL;
+	struct ceph_snap_context *snapc = NULL;
+	struct ceph_osd_client *osdc = NULL;
+	struct ceph_osd_request *osd_req = NULL;
+		const char *parent_object_name = NULL;
+
+	int result = 0;
+	u64 object_no = (u64)-1;
+	u64 object_size = 0;
+	u64 snap_id = 0;
+	__u8 obj_order = 0;
+	bool is_read = false;
+
+	rbd_assert(img_request != NULL);
+	rbd_assert(object_name != NULL);
+
+	rbd_dev = img_request->rbd_dev;
+	rbd_assert(rbd_dev != NULL);
+
+	is_read = !img_request_write_test(img_request) &&
+			!img_request_discard_test(img_request);
+
+	object_no = rbd_object_no(rbd_dev, object_name);
+	obj_order = rbd_dev->header.obj_order;
+	object_size = (u64)1 << obj_order;
+
+	spin_lock(&img_request->copyup_list_lock);
+	/* Find if object_no exists in copyup_list */
+	for_each_copyup_request(img_request, copyup_request) {
+		/* Found, just return */
+		if(copyup_request->object_no == object_no) {
+			spin_unlock(&img_request->copyup_list_lock);
+			return;
+		}
+	}
+	spin_unlock(&img_request->copyup_list_lock);
+
+	/* Not found, send new copyup request */
+	copyup_request = NULL;
+	osdc = &rbd_dev->rbd_client->client->osdc;
+	parent_object_name = rbd_segment_name(rbd_dev->parent, object_no << obj_order);
+	if (!parent_object_name)
+		goto out;
+	osd_req = ceph_osdc_alloc_request(osdc, snapc, 1, false, GFP_ATOMIC);
+	if (!osd_req)
+		goto out;
+	copyup_request = rbd_copyup_request_create(object_name, rbd_dev);
+	if (!copyup_request) {
+		ceph_osdc_put_request(osd_req);
+		goto out;
+	}
+
+	/* Init osd_req */
+	osd_req_op_extent_init(osd_req, 0, CEPH_OSD_OP_READ, 0, object_size, 0, 0);
+	osd_req_op_extent_osd_data_pages(osd_req, 0, copyup_request->copyup_pages, object_size,
+					0, false, false);
+
+	osd_req->r_flags = CEPH_OSD_FLAG_READ;
+	osd_req->r_callback = rbd_osd_req_copyup_callback;
+	osd_req->r_priv = copyup_request;
+
+	osd_req->r_base_oloc.pool = ceph_file_layout_pg_pool(rbd_dev->parent->layout);
+	ceph_oid_set_name(&osd_req->r_base_oid, parent_object_name);
+	rbd_segment_name_free(parent_object_name);
+
+	/* Init copyup request */
+	rbd_assert(copyup_request->osd_req == NULL);
+	copyup_request->osd_req = osd_req;
+	copyup_request->callback = rbd_img_copyup_write_async;
+
+	/* Encode osd_req data */
+	snap_id = img_request ? img_request->snap_id : CEPH_NOSNAP;
+	ceph_osdc_build_request(osd_req, 0, NULL, snap_id, NULL);
+
+	/* Add copyup request to img_request->copyup_list */
+	rbd_img_copyup_request_add(img_request, copyup_request);
+
+	rbd_img_request_get(img_request);
+
+	/* Send osd_req */
+	result = ceph_osdc_start_request(osdc, osd_req, false);
+	if (!result)
+		goto out;
+out:
+	return;
+}
+
+
 static void rbd_img_obj_exists_callback(struct rbd_obj_request *obj_request)
 {
 	struct rbd_obj_request *orig_request;
-- 
1.9.1

