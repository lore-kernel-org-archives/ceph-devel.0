From: Alex Elder <elder@inktank.com>
Subject: [PATCH 10/11] rbd: check for overflow in rbd_get_num_segments()
Date: Fri, 24 Aug 2012 11:36:10 -0500
Message-ID: <5037AD7A.4080300@inktank.com>
References: <5037AB20.4000103@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49774 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839Ab2HXQgM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:36:12 -0400
Received: by mail-iy0-f174.google.com with SMTP id o24so3740650ial.19
        for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 09:36:12 -0700 (PDT)
In-Reply-To: <5037AB20.4000103@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It is possible in rbd_get_num_segments() for an overflow to occur
when adding the offset and length.  This is easily avoided.

Since the function returns an int and the one caller is already
prepared to handle errors, have it return -ERANGE if overflow would
occur.

The overflow check would not work if a zero-length request was
being tested, so short-circuit that case, returning 0 for the
number of segments required.  (This condition might be avoided
elsewhere already, I don't know.)

Have the caller end the request if either an error or 0 is returned.
The returned value is passed to __blk_end_request_all(), meaning
a 0 length request is not treated an error.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fad4ecb..b649446 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -50,6 +50,10 @@
 #define	SECTOR_SHIFT	9
 #define	SECTOR_SIZE	(1ULL << SECTOR_SHIFT)

+/* It might be useful to have this defined elsewhere too */
+
+#define	U64_MAX	((u64) (~0ULL))
+
 #define RBD_DRV_NAME "rbd"
 #define RBD_DRV_NAME_LONG "rbd (rados block device)"

@@ -678,8 +682,17 @@ static u64 rbd_get_segment(struct rbd_image_header
*header,
 static int rbd_get_num_segments(struct rbd_image_header *header,
 				u64 ofs, u64 len)
 {
-	u64 start_seg = ofs >> header->obj_order;
-	u64 end_seg = (ofs + len - 1) >> header->obj_order;
+	u64 start_seg;
+	u64 end_seg;
+
+	if (!len)
+		return 0;
+	if (len - 1 > U64_MAX - ofs)
+		return -ERANGE;
+
+	start_seg = ofs >> header->obj_order;
+	end_seg = (ofs + len - 1) >> header->obj_order;
+
 	return end_seg - start_seg + 1;
 }

@@ -1502,6 +1515,12 @@ static void rbd_rq_fn(struct request_queue *q)
 		     size, (unsigned long long) blk_rq_pos(rq) * SECTOR_SIZE);

 		num_segs = rbd_get_num_segments(&rbd_dev->header, ofs, size);
+		if (num_segs <= 0) {
+			spin_lock_irq(q->queue_lock);
+			__blk_end_request_all(rq, num_segs);
+			ceph_put_snap_context(snapc);
+			continue;
+		}
 		coll = rbd_alloc_coll(num_segs);
 		if (!coll) {
 			spin_lock_irq(q->queue_lock);
-- 
1.7.9.5

