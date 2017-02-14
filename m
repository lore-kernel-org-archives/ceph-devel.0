From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 08/15] rbd: use rbd_obj_bytes() more
Date: Tue, 14 Feb 2017 21:11:57 +0100
Message-ID: <1487103124-2974-9-git-send-email-idryomov@gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33318 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754961AbdBNUMn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Feb 2017 15:12:43 -0500
Received: by mail-qt0-f193.google.com with SMTP id n13so18833367qtc.0
        for <ceph-devel@vger.kernel.org>; Tue, 14 Feb 2017 12:12:42 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@ieee.org>

Returning u64 doesn't make sense: max header->obj_order is 25 and
ceph_file_layout::object_size is u32.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 68036c29c07c..f2f52b7db33d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -971,6 +971,14 @@ static bool rbd_dev_ondisk_valid(struct rbd_image_header_ondisk *ondisk)
 }
 
 /*
+ * returns the size of an object in the image
+ */
+static u32 rbd_obj_bytes(struct rbd_image_header *header)
+{
+	return 1U << header->obj_order;
+}
+
+/*
  * Fill an rbd image header with information from the given format 1
  * on-disk header.
  */
@@ -1255,7 +1263,7 @@ static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
 
 static u64 rbd_segment_offset(struct rbd_device *rbd_dev, u64 offset)
 {
-	u64 segment_size = (u64) 1 << rbd_dev->header.obj_order;
+	u64 segment_size = rbd_obj_bytes(&rbd_dev->header);
 
 	return offset & (segment_size - 1);
 }
@@ -1263,7 +1271,7 @@ static u64 rbd_segment_offset(struct rbd_device *rbd_dev, u64 offset)
 static u64 rbd_segment_length(struct rbd_device *rbd_dev,
 				u64 offset, u64 length)
 {
-	u64 segment_size = (u64) 1 << rbd_dev->header.obj_order;
+	u64 segment_size = rbd_obj_bytes(&rbd_dev->header);
 
 	offset &= segment_size - 1;
 
@@ -1275,14 +1283,6 @@ static u64 rbd_segment_length(struct rbd_device *rbd_dev,
 }
 
 /*
- * returns the size of an object in the image
- */
-static u64 rbd_obj_bytes(struct rbd_image_header *header)
-{
-	return 1 << header->obj_order;
-}
-
-/*
  * bio helpers
  */
 
@@ -2721,7 +2721,7 @@ static int rbd_img_obj_parent_read_full(struct rbd_obj_request *obj_request)
 	 * child image to which the original request was to be sent.
 	 */
 	img_offset = obj_request->img_offset - obj_request->offset;
-	length = (u64)1 << rbd_dev->header.obj_order;
+	length = rbd_obj_bytes(&rbd_dev->header);
 
 	/*
 	 * There is no defined parent data beyond the parent
@@ -5130,7 +5130,7 @@ static int rbd_dev_v2_striping_info(struct rbd_device *rbd_dev)
 	 * out, and only fail if the image has non-default values.
 	 */
 	ret = -EINVAL;
-	obj_size = (u64)1 << rbd_dev->header.obj_order;
+	obj_size = rbd_obj_bytes(&rbd_dev->header);
 	p = &striping_info_buf;
 	stripe_unit = ceph_decode_64(&p);
 	if (stripe_unit != obj_size) {
-- 
2.4.3

