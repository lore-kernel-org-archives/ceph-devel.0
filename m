From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 01/11] rbd: access snapshot context and mapping size safely
Date: Tue,  8 Apr 2014 13:42:45 -0700
Message-ID: <6db75c6e7fb22b00b3ca78ef4f4fd12e6aecdeaa.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:56374 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598AbaDHWCY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 18:02:24 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 87FE5267D6
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
Received: from vit.ops.newdream.net (unknown [38.122.20.226])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 7AF0D267BC
	for <ceph-devel@vger.kernel.org>; Tue,  8 Apr 2014 14:52:31 -0700 (PDT)
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
In-Reply-To: <cover.1396987789.git.josh.durgin@inktank.com>
References: <cover.1396987789.git.josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These fields may both change while the image is mapped if a snapshot
is created or deleted or the image is resized.  They are guarded by
rbd_dev->header_rwsem, so hold that while reading them, and store a
local copy to refer to outside of the critical section. The local copy
will stay consistent since the snapshot context is reference counted,
and the mapping size is just a u64. This prevents torn loads from
giving us inconsistent values.

Move reading header.snapc into the caller of rbd_img_request_create()
so that we only need to take the semaphore once. The read-only caller,
rbd_parent_request_create() can just pass NULL for snapc, since the
snapshot context is only relevant for writes.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 drivers/block/rbd.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4c95b50..b6676b6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1961,7 +1961,8 @@ static bool rbd_dev_parent_get(struct rbd_device *rbd_dev)
 static struct rbd_img_request *rbd_img_request_create(
 					struct rbd_device *rbd_dev,
 					u64 offset, u64 length,
-					bool write_request)
+					bool write_request,
+					struct ceph_snap_context *snapc)
 {
 	struct rbd_img_request *img_request;
 
@@ -1969,12 +1970,6 @@ static struct rbd_img_request *rbd_img_request_create(
 	if (!img_request)
 		return NULL;
 
-	if (write_request) {
-		down_read(&rbd_dev->header_rwsem);
-		ceph_get_snap_context(rbd_dev->header.snapc);
-		up_read(&rbd_dev->header_rwsem);
-	}
-
 	img_request->rq = NULL;
 	img_request->rbd_dev = rbd_dev;
 	img_request->offset = offset;
@@ -1982,7 +1977,7 @@ static struct rbd_img_request *rbd_img_request_create(
 	img_request->flags = 0;
 	if (write_request) {
 		img_request_write_set(img_request);
-		img_request->snapc = rbd_dev->header.snapc;
+		img_request->snapc = snapc;
 	} else {
 		img_request->snap_id = rbd_dev->spec->snap_id;
 	}
@@ -2038,8 +2033,8 @@ static struct rbd_img_request *rbd_parent_request_create(
 	rbd_assert(obj_request->img_request);
 	rbd_dev = obj_request->img_request->rbd_dev;
 
-	parent_request = rbd_img_request_create(rbd_dev->parent,
-						img_offset, length, false);
+	parent_request = rbd_img_request_create(rbd_dev->parent, img_offset,
+						length, false, NULL);
 	if (!parent_request)
 		return NULL;
 
@@ -3065,8 +3060,10 @@ static void rbd_request_fn(struct request_queue *q)
 	while ((rq = blk_fetch_request(q))) {
 		bool write_request = rq_data_dir(rq) == WRITE;
 		struct rbd_img_request *img_request;
+		struct ceph_snap_context *snapc = NULL;
 		u64 offset;
 		u64 length;
+		u64 mapping_size;
 
 		/* Ignore any non-FS requests that filter through. */
 
@@ -3120,8 +3117,16 @@ static void rbd_request_fn(struct request_queue *q)
 			goto end_request;	/* Shouldn't happen */
 		}
 
+		down_read(&rbd_dev->header_rwsem);
+		mapping_size = rbd_dev->mapping.size;
+		if (op_type != OBJ_OP_READ) {
+			snapc = rbd_dev->header.snapc;
+			ceph_get_snap_context(snapc);
+		}
+		up_read(&rbd_dev->header_rwsem);
+
 		result = -EIO;
-		if (offset + length > rbd_dev->mapping.size) {
+		if (offset + length > mapping_size) {
 			rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)\n",
 				offset, length, rbd_dev->mapping.size);
 			goto end_request;
@@ -3129,7 +3134,7 @@ static void rbd_request_fn(struct request_queue *q)
 
 		result = -ENOMEM;
 		img_request = rbd_img_request_create(rbd_dev, offset, length,
-							write_request);
+							write_request, snapc);
 		if (!img_request)
 			goto end_request;
 
@@ -3147,6 +3152,8 @@ end_request:
 			rbd_warn(rbd_dev, "%s %llx at %llx result %d\n",
 				write_request ? "write" : "read",
 				length, offset, result);
+			if (snapc)
+				ceph_put_snap_context(snapc);
 
 			__blk_end_request_all(rq, result);
 		}
-- 
1.7.10.4

