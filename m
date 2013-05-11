From: Alex Elder <elder@inktank.com>
Subject: [PATCH] rbd: support reading parent page data for writes
Date: Sat, 11 May 2013 12:37:37 -0500
Message-ID: <518E81E1.2000806@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60302 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab3EKRhl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 May 2013 13:37:41 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so10128252iec.11
        for <ceph-devel@vger.kernel.org>; Sat, 11 May 2013 10:37:40 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id c11sm6120889igv.1.2013.05.11.10.37.37
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 10:37:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently, rbd_img_obj_parent_read_full() assumes the incoming
object request contains bio data.  But if a layered image is part of
a multi-layer stack of images it will result in read requests of
page data to parent images.

This is handling the same kind of issue as was resolved by this
commit:
    5b2ab72d  rbd: support reading parent page data

This resolves:
    http://tracker.ceph.com/issues/5027

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 51c45e7..b9221a0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2160,7 +2160,8 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)
 	struct page **pages;
 	int result;
 	u64 obj_size;
-	u64 xferred;
+	u64 offset;
+	u64 length;

 	rbd_assert(img_request_child_test(img_request));

@@ -2172,10 +2173,10 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)

 	orig_request = img_request->obj_request;
 	rbd_assert(orig_request != NULL);
-	rbd_assert(orig_request->type == OBJ_REQUEST_BIO);
+	rbd_assert(obj_request_type_valid(orig_request->type));
 	result = img_request->result;
 	obj_size = img_request->length;
-	xferred = img_request->xferred;
+	rbd_assert(obj_size == img_request->xferred);
 	rbd_img_request_put(img_request);

 	rbd_assert(orig_request->img_request);
@@ -2204,11 +2205,17 @@ rbd_img_obj_parent_read_full_callback(struct
rbd_img_request *img_request)

 	/* Then the original write request op */

+	offset = orig_request->offset;
+	length = orig_request->length;
 	osd_req_op_extent_init(osd_req, 1, CEPH_OSD_OP_WRITE,
-					orig_request->offset,
-					orig_request->length, 0, 0);
-	osd_req_op_extent_osd_data_bio(osd_req, 1, orig_request->bio_list,
-					orig_request->length);
+					offset, length, 0, 0);
+	if (orig_request->type == OBJ_REQUEST_BIO)
+		osd_req_op_extent_osd_data_bio(osd_req, 1,
+					orig_request->bio_list, length);
+	else
+		osd_req_op_extent_osd_data_pages(osd_req, 1,
+					orig_request->pages, length,
+					offset & ~PAGE_MASK, false, false);

 	rbd_osd_req_format_write(orig_request);

-- 
1.7.9.5

