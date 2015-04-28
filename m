From: mchristi@redhat.com
Subject: [PATCH 01/10] rbd: add obj request execution helper
Date: Tue, 28 Apr 2015 17:05:38 -0500
Message-ID: <1430258747-12506-2-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43114 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030888AbbD1WFv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5oSI023748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:51 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbM013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:49 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch breaks out the code that allocates buffers and executes
the request from rbd_obj_method_sync, so future functions in this
patchset can use it.

It also adds support for OBJ_OP_WRITE requests which is needed for
the locking functions which will be added in the next patches.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c | 156 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 95 insertions(+), 61 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b40af32..fafe558 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3224,89 +3224,123 @@ static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
 }
 
 /*
- * Synchronous osd object method call.  Returns the number of bytes
- * returned in the outbound buffer, or a negative error code.
+ * Synchronous osd object op call.  Returns the number of bytes
+ * returned in the inbound buffer, or a negative error code.
  */
-static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
-			     const char *object_name,
-			     const char *class_name,
-			     const char *method_name,
-			     const void *outbound,
-			     size_t outbound_size,
-			     void *inbound,
-			     size_t inbound_size)
+static int rbd_obj_request_sync(struct rbd_device *rbd_dev,
+				struct rbd_obj_request *obj_request,
+				const void *outbound, size_t outbound_size,
+				void *inbound, size_t inbound_size)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	struct rbd_obj_request *obj_request;
-	struct page **pages;
-	u32 page_count;
-	int ret;
-
-	/*
-	 * Method calls are ultimately read operations.  The result
-	 * should placed into the inbound buffer provided.  They
-	 * also supply outbound data--parameters for the object
-	 * method.  Currently if this is present it will be a
-	 * snapshot id.
-	 */
-	page_count = (u32)calc_pages_for(0, inbound_size);
-	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
-
-	ret = -ENOMEM;
-	obj_request = rbd_obj_request_create(object_name, 0, inbound_size,
-							OBJ_REQUEST_PAGES);
-	if (!obj_request)
-		goto out;
-
-	obj_request->pages = pages;
-	obj_request->page_count = page_count;
-
-	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_READ, 1,
-						  obj_request);
-	if (!obj_request->osd_req)
-		goto out;
+	struct page **pages = NULL;
+	u32 page_count = 0;
+	int ret = -ENOMEM;
+	u16 op = obj_request->osd_req->r_ops[0].op;
+	struct ceph_pagelist *pagelist;
+
+	if (inbound_size) {
+		page_count = (u32)calc_pages_for(0, inbound_size);
+		pages = ceph_alloc_page_vector(page_count, GFP_NOIO);
+		if (IS_ERR(pages))
+			return PTR_ERR(pages);
+
+		obj_request->pages = pages;
+		obj_request->page_count = page_count;
+
+		switch (op) {
+		case CEPH_OSD_OP_CALL:
+			osd_req_op_cls_response_data_pages(obj_request->osd_req,
+							   0, pages,
+							   inbound_size,
+							   0, false, false);
+			break;
+		default:
+			BUG();
+		}
+	}
 
-	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
-					class_name, method_name);
 	if (outbound_size) {
-		struct ceph_pagelist *pagelist;
-
-		pagelist = kmalloc(sizeof (*pagelist), GFP_NOFS);
+		pagelist = kmalloc(sizeof (*pagelist), GFP_NOIO);
 		if (!pagelist)
-			goto out;
+			goto free_pages;
 
 		ceph_pagelist_init(pagelist);
 		ceph_pagelist_append(pagelist, outbound, outbound_size);
-		osd_req_op_cls_request_data_pagelist(obj_request->osd_req, 0,
-						pagelist);
+
+		switch (op) {
+		case CEPH_OSD_OP_CALL:
+			osd_req_op_cls_request_data_pagelist(
+							obj_request->osd_req, 0,
+							pagelist);
+			break;
+		default:
+			BUG();
+		}
 	}
-	osd_req_op_cls_response_data_pages(obj_request->osd_req, 0,
-					obj_request->pages, inbound_size,
-					0, false, false);
-	rbd_osd_req_format_read(obj_request);
+
+	if (inbound_size)
+		rbd_osd_req_format_read(obj_request);
+	else
+		rbd_osd_req_format_write(obj_request);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
 	if (ret)
-		goto out;
+		goto done;
 	ret = rbd_obj_request_wait(obj_request);
 	if (ret)
-		goto out;
+		goto done;
 
 	ret = obj_request->result;
 	if (ret < 0)
-		goto out;
+		goto done;
 
 	rbd_assert(obj_request->xferred < (u64)INT_MAX);
 	ret = (int)obj_request->xferred;
-	ceph_copy_from_page_vector(pages, inbound, 0, obj_request->xferred);
-out:
-	if (obj_request)
-		rbd_obj_request_put(obj_request);
-	else
-		ceph_release_page_vector(pages, page_count);
+	if (inbound_size)
+		ceph_copy_from_page_vector(pages, inbound, 0,
+					   obj_request->xferred);
+done:
+	return ret;
+
+free_pages:
+	ceph_release_page_vector(pages, page_count);
+	return ret;
+}
 
+/*
+ * Synchronous osd object method call.  Returns the number of bytes
+ * returned in the inbound buffer, or a negative error code.
+ */
+static int rbd_obj_method_sync(struct rbd_device *rbd_dev,
+			       const char *object_name,
+			       const char *class_name,
+			       const char *method_name,
+			       const void *outbound,
+			       size_t outbound_size,
+			       void *inbound,
+			       size_t inbound_size)
+{
+	struct rbd_obj_request *obj_request;
+	int ret = -ENOMEM;
+
+	obj_request = rbd_obj_request_create(object_name, 0, inbound_size,
+					     OBJ_REQUEST_PAGES);
+	if (!obj_request)
+		return -ENOMEM;
+
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev,
+					inbound ? OBJ_OP_READ : OBJ_OP_WRITE,
+					1, obj_request);
+	if (!obj_request->osd_req)
+		goto out;
+
+	osd_req_op_cls_init(obj_request->osd_req, 0, CEPH_OSD_OP_CALL,
+			    class_name, method_name);
+	ret = rbd_obj_request_sync(rbd_dev, obj_request, outbound, outbound_size,
+				   inbound, inbound_size);
+out:
+	rbd_obj_request_put(obj_request);
 	return ret;
 }
 
-- 
1.8.3.1

