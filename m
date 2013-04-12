From: Alex Elder <elder@inktank.com>
Subject: [PATCH 03/11] rbd: record image-relative offset in object requests
Date: Thu, 11 Apr 2013 21:17:28 -0500
Message-ID: <51676EB8.7030009@inktank.com>
References: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:51512 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab3DLCRa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:17:30 -0400
Received: by mail-ia0-f178.google.com with SMTP id w21so217852iac.9
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:17:29 -0700 (PDT)
In-Reply-To: <51676E0F.2010504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For an image object request we will need to know what offset within
the rbd image the request covers.  Record that when the object
request gets created.

Update the I/O error warnings so they use this so what's reported
is more informative.

Rename a local variable to fit the convention used everywhere else.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e8374ae..f0124c5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -176,6 +176,7 @@ struct rbd_obj_request {
 	u64			length;		/* bytes from offset */

 	struct rbd_img_request	*img_request;
+	u64			img_offset;	/* image relative offset */
 	struct list_head	links;		/* img_request->obj_requests */
 	u32			which;		/* posn image request list */

@@ -1576,8 +1577,13 @@ static void rbd_img_obj_callback(struct
rbd_obj_request *obj_request)
 		xferred = (unsigned int)obj_request->xferred;
 		result = obj_request->result;
 		if (result) {
-			rbd_warn(NULL, "obj_request %s result %d xferred %u\n",
+			struct rbd_device *rbd_dev = img_request->rbd_dev;
+
+			rbd_warn(rbd_dev, "%s %llx at %llx (%llx)\n",
 				img_request->write_request ? "write" : "read",
+				obj_request->length, obj_request->img_offset,
+				obj_request->offset);
+			rbd_warn(rbd_dev, "  result %d xferred %x\n",
 				result, xferred);
 			if (!img_request->result)
 				img_request->result = result;
@@ -1604,7 +1610,7 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 	struct rbd_obj_request *next_obj_request;
 	bool write_request = img_request->write_request;
 	unsigned int bio_offset;
-	u64 image_offset;
+	u64 img_offset;
 	u64 resid;
 	u16 opcode;

@@ -1612,8 +1618,8 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,

 	opcode = write_request ? CEPH_OSD_OP_WRITE : CEPH_OSD_OP_READ;
 	bio_offset = 0;
-	image_offset = img_request->offset;
-	rbd_assert(image_offset == bio_list->bi_sector << SECTOR_SHIFT);
+	img_offset = img_request->offset;
+	rbd_assert(img_offset == bio_list->bi_sector << SECTOR_SHIFT);
 	resid = img_request->length;
 	rbd_assert(resid > 0);
 	while (resid) {
@@ -1623,11 +1629,11 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 		u64 offset;
 		u64 length;

-		object_name = rbd_segment_name(rbd_dev, image_offset);
+		object_name = rbd_segment_name(rbd_dev, img_offset);
 		if (!object_name)
 			goto out_unwind;
-		offset = rbd_segment_offset(rbd_dev, image_offset);
-		length = rbd_segment_length(rbd_dev, image_offset, resid);
+		offset = rbd_segment_offset(rbd_dev, img_offset);
+		length = rbd_segment_length(rbd_dev, img_offset, resid);
 		obj_request = rbd_obj_request_create(object_name,
 						offset, length,
 						OBJ_REQUEST_BIO);
@@ -1656,9 +1662,10 @@ static int rbd_img_request_fill_bio(struct
rbd_img_request *img_request,
 				obj_request->bio_list, obj_request->length);
 		rbd_osd_req_format(obj_request, write_request);

+		obj_request->img_offset = img_offset;
 		rbd_img_obj_request_add(img_request, obj_request);

-		image_offset += length;
+		img_offset += length;
 		resid -= length;
 	}

@@ -1993,8 +2000,10 @@ static void rbd_request_fn(struct request_queue *q)
 end_request:
 		spin_lock_irq(q->queue_lock);
 		if (result < 0) {
-			rbd_warn(rbd_dev, "obj_request %s result %d\n",
-				write_request ? "write" : "read", result);
+			rbd_warn(rbd_dev, "%s %llx at %llx result %d\n",
+				write_request ? "write" : "read",
+				length, offset, result);
+
 			__blk_end_request_all(rq, result);
 		}
 	}
-- 
1.7.9.5

