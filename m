From: Alex Elder <elder@inktank.com>
Subject: [PATCH 04/12] rbd: implement sync object read with new code
Date: Tue, 22 Jan 2013 16:29:16 -0600
Message-ID: <50FF12BC.6050802@inktank.com>
References: <50FF11EA.3000808@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:47467 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3AVW3T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 17:29:19 -0500
Received: by mail-ia0-f173.google.com with SMTP id l29so3593888iag.4
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 14:29:18 -0800 (PST)
In-Reply-To: <50FF11EA.3000808@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reimplement the synchronous read operation used for reading a
version 1 header using the new request tracking code.  Name the
resulting function rbd_obj_read_sync() to better reflect that
it's a full object operation, not an object request.  To do this,
implement a new obj_req_pages object request type.

This implements a new mechanism to allow the caller to wait for
completion for an rbd_obj_request by calling rbd_obj_request_wait().

This partially resolves:
    http://tracker.newdream.net/issues/3755

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   96
++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c1b99c7..5a8fef4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -164,7 +164,7 @@ struct rbd_client {

 struct rbd_image_request;

-enum obj_req_type { obj_req_bio };	/* More types to come */
+enum obj_req_type { obj_req_bio, obj_req_pages };

 struct rbd_obj_request;
 typedef void (*rbd_obj_callback_t)(struct rbd_obj_request *);
@@ -178,7 +178,13 @@ struct rbd_obj_request {
 	u32			which;		/* posn in image req array */

 	enum obj_req_type	type;
-	struct bio		*bio_list;
+	union {
+		struct bio	*bio_list;
+		struct {
+			struct page	**pages;
+			u32		page_count;
+		};
+	};

 	struct ceph_osd_request	*osd_req;

@@ -188,6 +194,7 @@ struct rbd_obj_request {
 	atomic_t		done;

 	rbd_obj_callback_t	callback;
+	struct completion	completion;

 	struct kref		kref;
 };
@@ -1065,6 +1072,7 @@ static bool obj_req_type_valid(enum obj_req_type type)
 {
 	switch (type) {
 	case obj_req_bio:
+	case obj_req_pages:
 		return true;
 	default:
 		return false;
@@ -1278,8 +1286,15 @@ static int rbd_obj_request_submit(struct
ceph_osd_client *osdc,
 	return ret;
 }

+/* Caller is responsible for rbd_obj_request_destroy(obj_request) */
+
+static int rbd_obj_request_wait(struct rbd_obj_request *obj_request)
+{
+	return wait_for_completion_interruptible(&obj_request->completion);
+}
+
 /*
- * Request sync osd read
+ * Synchronously read a range from an object into a provided buffer
  */
 static int rbd_req_sync_read(struct rbd_device *rbd_dev,
 			  const char *object_name,
@@ -1503,6 +1518,8 @@ static void rbd_obj_request_complete(struct
rbd_obj_request *obj_request)
 {
 	if (obj_request->callback)
 		obj_request->callback(obj_request);
+	else
+		complete_all(&obj_request->completion);
 }

 static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
@@ -1583,6 +1600,11 @@ static struct ceph_osd_request *rbd_osd_req_create(
 		/* osd client requires "num pages" even for bio */
 		osd_req->r_num_pages = calc_pages_for(offset, length);
 		break;
+	case obj_req_pages:
+		osd_req->r_pages = obj_request->pages;
+		osd_req->r_num_pages = obj_request->page_count;
+		osd_req->r_page_alignment = offset & ~PAGE_MASK;
+		break;
 	}

 	if (write_request) {
@@ -1643,6 +1665,7 @@ static struct rbd_obj_request
*rbd_obj_request_create(const char *object_name,
 	obj_request->length = length;
 	obj_request->type = type;
 	atomic_set(&obj_request->done, 0);
+	init_completion(&obj_request->completion);
 	kref_init(&obj_request->kref);

 	return obj_request;
@@ -1662,6 +1685,11 @@ static void rbd_obj_request_destroy(struct kref
*kref)
 		if (obj_request->bio_list)
 			bio_chain_put(obj_request->bio_list);
 		break;
+	case obj_req_pages:
+		if (obj_request->pages)
+			ceph_release_page_vector(obj_request->pages,
+						obj_request->page_count);
+		break;
 	}

 	kfree(obj_request);
@@ -1984,6 +2012,65 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 	put_disk(disk);
 }

+static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
+				const char *object_name,
+				u64 offset, u64 length,
+				char *buf, u64 *version)
+
+{
+	struct ceph_osd_req_op *op;
+	struct rbd_obj_request *obj_request;
+	struct ceph_osd_client *osdc;
+	struct page **pages = NULL;
+	u32 page_count;
+	int ret;
+
+	page_count = (u32) calc_pages_for(offset, length);
+	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
+	if (IS_ERR(pages))
+		ret = PTR_ERR(pages);
+
+	ret = -ENOMEM;
+	obj_request = rbd_obj_request_create(object_name, offset, length,
+						obj_req_pages);
+	if (!obj_request)
+		goto out_err;
+
+	obj_request->pages = pages;
+	obj_request->page_count = page_count;
+
+	op = rbd_osd_req_op_create(CEPH_OSD_OP_READ, offset, length);
+	if (!op)
+		goto out_err;
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, false,
+						obj_request, op);
+	rbd_osd_req_op_destroy(op);
+	if (!obj_request->osd_req)
+		goto out_err;
+
+	osdc = &rbd_dev->rbd_client->client->osdc;
+	ret = rbd_obj_request_submit(osdc, obj_request);
+	if (ret)
+		goto out_err;
+	ret = rbd_obj_request_wait(obj_request);
+	if (ret)
+		goto out_err;
+
+	ret = obj_request->result;
+	if (ret < 0)
+		goto out_err;
+	ret = ceph_copy_from_page_vector(pages, buf, 0, obj_request->xferred);
+	if (version)
+		*version = obj_request->version;
+out_err:
+	if (obj_request)
+		rbd_obj_request_put(obj_request);
+	else
+		ceph_release_page_vector(pages, page_count);
+
+	return ret;
+}
+
 /*
  * Read the complete header for the given rbd device.
  *
@@ -2022,7 +2109,8 @@ rbd_dev_v1_header_read(struct rbd_device *rbd_dev,
u64 *version)
 		if (!ondisk)
 			return ERR_PTR(-ENOMEM);

-		ret = rbd_req_sync_read(rbd_dev, rbd_dev->header_name,
+		(void) rbd_req_sync_read;	/* avoid a warning */
+		ret = rbd_obj_read_sync(rbd_dev, rbd_dev->header_name,
 				       0, size,
 				       (char *) ondisk, version);

-- 
1.7.9.5

