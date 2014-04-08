From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 05/11] rbd: read image size for discard check safely
Date: Tue,  8 Apr 2014 13:42:49 -0700
Message-ID: <7376321311dedcd90e7f16ab1a94cb2c4f34786f.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56383 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756235AbaDHWC0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:26 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id BC899267DB
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id B4781267BC
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In rbd_img_request_fill() the image size is only checked to determine
whether we can truncate an object instead of zeroing it for discard
requests. Take rbd_dev->header_rwsem while reading the image size, and
move this read into the discard check, so that non-discard ops don't
need to take the semaphore in this function.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9dc33d9..486e4b5 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2235,7 +2235,6 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 		(int)type, data_desc);
 
 	img_offset = img_request->offset;
-	img_end = rbd_dev->header.image_size;
 	resid = img_request->length;
 	rbd_assert(resid > 0);
 
@@ -2300,13 +2299,20 @@ static int rbd_img_request_fill(struct rbd_img_request *img_request,
 			if (!offset && (length == object_size)
 				&& (!img_request_layered_test(img_request) ||
 					(rbd_dev->parent_overlap <=
-						obj_request->img_offset)))
+						obj_request->img_offset))) {
 				opcode = CEPH_OSD_OP_DELETE;
-			else if ((offset + length == object_size) ||
-				(obj_request->img_offset + length == img_end))
+			} else if ((offset + length == object_size)) {
 				opcode = CEPH_OSD_OP_TRUNCATE;
-			else
-				opcode = CEPH_OSD_OP_ZERO;
+			} else {
+				down_read(&rbd_dev->header_rwsem);
+				img_end = rbd_dev->header.image_size;
+				up_read(&rbd_dev->header_rwsem);
+
+				if (obj_request->img_offset + length == img_end)
+					opcode = CEPH_OSD_OP_TRUNCATE;
+				else
+					opcode = CEPH_OSD_OP_ZERO;
+			}
 		} else if (img_request_write_test(img_request)) {
 			op_type = OBJ_OP_WRITE;
 			opcode = CEPH_OSD_OP_WRITE;
-- 
1.7.10.4

