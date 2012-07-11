From: Alex Elder <elder@inktank.com>
Subject: [PATCH 06/16] rbd: rename rbd_dev->block_name
Date: Wed, 11 Jul 2012 09:01:39 -0500
Message-ID: <4FFD8743.3070704@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63502 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab2GKOBm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:01:42 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so1225622yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:01:42 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Each rbd image has a name that forms the basis of all data objects
backing the device.  Old (format 1) images refer to this name as the
"block name," while new (format 2) images use the term "object
prefix" for this.

Change the field name in the in-core rbd image header structure to
reflect the more modern usage.  We intentionally keep the the name
"block_name" in the on-disk definition for format 1 image headers.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 63c132f..57d264c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -78,7 +78,7 @@
  */
 struct rbd_image_header {
 	u64 image_size;
-	char block_name[32];
+	char object_prefix[32];
 	__u8 obj_order;
 	__u8 crypt_type;
 	__u8 comp_type;
@@ -518,7 +518,7 @@ static int rbd_header_from_disk(struct
rbd_image_header *header,
 		header->snap_names = NULL;
 		header->snap_sizes = NULL;
 	}
-	memcpy(header->block_name, ondisk->block_name,
+	memcpy(header->object_prefix, ondisk->block_name,
 	       sizeof(ondisk->block_name));

 	header->image_size = le64_to_cpu(ondisk->image_size);
@@ -620,7 +620,7 @@ static void rbd_header_free(struct rbd_image_header
*header)
  * get the actual striped segment name, offset and length
  */
 static u64 rbd_get_segment(struct rbd_image_header *header,
-			   const char *block_name,
+			   const char *object_prefix,
 			   u64 ofs, u64 len,
 			   char *seg_name, u64 *segofs)
 {
@@ -628,7 +628,7 @@ static u64 rbd_get_segment(struct rbd_image_header
*header,

 	if (seg_name)
 		snprintf(seg_name, RBD_MAX_SEG_NAME_LEN,
-			 "%s.%012llx", block_name, seg);
+			 "%s.%012llx", object_prefix, seg);

 	ofs = ofs & ((1 << header->obj_order) - 1);
 	len = min_t(u64, len, (1 << header->obj_order) - ofs);
@@ -1091,7 +1091,7 @@ static int rbd_do_op(struct request *rq,
 		return -ENOMEM;

 	seg_len = rbd_get_segment(&rbd_dev->header,
-				  rbd_dev->header.block_name,
+				  rbd_dev->header.object_prefix,
 				  ofs, len,
 				  seg_name, &seg_ofs);

@@ -1482,7 +1482,7 @@ static void rbd_rq_fn(struct request_queue *q)
 			/* a bio clone to be passed down to OSD req */
 			dout("rq->bio->bi_vcnt=%d\n", rq->bio->bi_vcnt);
 			op_size = rbd_get_segment(&rbd_dev->header,
-						  rbd_dev->header.block_name,
+						  rbd_dev->header.object_prefix,
 						  ofs, size,
 						  NULL, NULL);
 			kref_get(&coll->kref);
-- 
1.7.5.4

