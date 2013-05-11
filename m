From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: re-submit write request for flattened clone
Date: Sat, 11 May 2013 12:47:31 -0500
Message-ID: <518E8433.5030707@inktank.com>
References: <518E83D3.4050709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52509 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab3EKRrc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:47:32 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so10028502iea.32
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:47:32 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id d4sm5734554igc.3.2013.05.11.10.47.30
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:47:31 -0700 (PDT)
In-Reply-To: <518E83D3.4050709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add code to rbd_img_parent_read_full_callback() to detect when a
clone's parent image has disappeared, and re-submit the original
write request in that case.  (See the previous commit for more
reasoning about why this is appropriate.)

Rename some variables in rbd_img_obj_parent_read_full_callback()
to match the convention used in the previous patch.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4dca3ce..dfa6bfc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2314,7 +2314,7 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)
 	struct ceph_osd_client *osdc;
 	struct rbd_device *rbd_dev;
 	struct page **pages;
-	int result;
+	int img_result;
 	u64 obj_size;
 	u64 offset;
 	u64 length;
@@ -2330,7 +2330,7 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)
 	orig_request = img_request->obj_request;
 	rbd_assert(orig_request != NULL);
 	rbd_assert(obj_request_type_valid(orig_request->type));
-	result = img_request->result;
+	img_result = img_request->result;
 	obj_size = img_request->length;
 	rbd_assert(obj_size == img_request->xferred);
 	rbd_img_request_put(img_request);
@@ -2340,7 +2340,24 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)
 	rbd_assert(rbd_dev);
 	rbd_assert(obj_size == (u64)1 << rbd_dev->header.obj_order);

-	if (result)
+	/*
+	 * If the overlap has become 0 (most likely because the
+	 * image has been flattened) we need to free the pages
+	 * and re-submit the original write request.
+	 */
+	if (!rbd_dev->parent_overlap) {
+		struct ceph_osd_client *osdc;
+		u32 page_count;
+
+		page_count = (u32)calc_pages_for(0, obj_size);
+		ceph_release_page_vector(pages, page_count);
+		osdc = &rbd_dev->rbd_client->client->osdc;
+		img_result = rbd_obj_request_submit(osdc, orig_request);
+		if (!img_result)
+			return;
+	}
+
+	if (img_result)
 		goto out_err;

 	/*
@@ -2349,7 +2366,7 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)
 	 * request.  Allocate the new copyup osd request for the
 	 * original request, and release the old one.
 	 */
-	result = -ENOMEM;
+	img_result = -ENOMEM;
 	osd_req = rbd_osd_req_create_copyup(orig_request);
 	if (!osd_req)
 		goto out_err;
@@ -2383,13 +2400,13 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)

 	orig_request->callback = rbd_img_obj_copyup_callback;
 	osdc = &rbd_dev->rbd_client->client->osdc;
-	result = rbd_obj_request_submit(osdc, orig_request);
-	if (!result)
+	img_result = rbd_obj_request_submit(osdc, orig_request);
+	if (!img_result)
 		return;
 out_err:
 	/* Record the error code and complete the request */

-	orig_request->result = result;
+	orig_request->result = img_result;
 	orig_request->xferred = 0;
 	obj_request_done_set(orig_request);
 	rbd_obj_request_complete(orig_request);
-- 
1.7.9.5

