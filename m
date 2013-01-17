From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] rbd: encapsulate handling for a single request
Date: Thu, 17 Jan 2013 15:04:11 -0600
Message-ID: <50F8674B.7010109@inktank.com>
References: <50E6094F.9080101@inktank.com> <50E60981.2090801@inktank.com> <50F5EA25.2070303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38110 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753350Ab3AQVEO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 16:04:14 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so5418151iea.35
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 13:04:14 -0800 (PST)
In-Reply-To: <50F5EA25.2070303@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

In rbd_rq_fn(), requests are fetched from the block layer and each
request is processed, looping through the request's list of bio's
until they've all been consumed.

Separate the handling for a single request into its own function to
make it a bit easier to see what's going on.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: Changed to handle 0-length requests the same as before.

 drivers/block/rbd.c |  119
+++++++++++++++++++++++++++------------------------
 1 file changed, 63 insertions(+), 56 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8d93b6a..738d1e4 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1583,6 +1583,64 @@ static struct rbd_req_coll *rbd_alloc_coll(int
num_reqs)
 	return coll;
 }

+static int rbd_dev_do_request(struct request *rq,
+				struct rbd_device *rbd_dev,
+				struct ceph_snap_context *snapc,
+				u64 ofs, unsigned int size,
+				struct bio *bio_chain)
+{
+	int num_segs;
+	struct rbd_req_coll *coll;
+	unsigned int bio_offset;
+	int cur_seg = 0;
+
+	dout("%s 0x%x bytes at 0x%llx\n",
+		rq_data_dir(rq) == WRITE ? "write" : "read",
+		size, (unsigned long long) blk_rq_pos(rq) * SECTOR_SIZE);
+
+	num_segs = rbd_get_num_segments(&rbd_dev->header, ofs, size);
+	if (num_segs <= 0)
+		return num_segs;
+
+	coll = rbd_alloc_coll(num_segs);
+	if (!coll)
+		return -ENOMEM;
+
+	bio_offset = 0;
+	do {
+		u64 limit = rbd_segment_length(rbd_dev, ofs, size);
+		unsigned int clone_size;
+		struct bio *bio_clone;
+
+		BUG_ON(limit > (u64)UINT_MAX);
+		clone_size = (unsigned int)limit;
+		dout("bio_chain->bi_vcnt=%hu\n", bio_chain->bi_vcnt);
+
+		kref_get(&coll->kref);
+
+		/* Pass a cloned bio chain via an osd request */
+
+		bio_clone = bio_chain_clone_range(&bio_chain,
+					&bio_offset, clone_size,
+					GFP_ATOMIC);
+		if (bio_clone)
+			(void)rbd_do_op(rq, rbd_dev, snapc,
+					ofs, clone_size,
+					bio_clone, coll, cur_seg);
+		else
+			rbd_coll_end_req_index(rq, coll, cur_seg,
+						(s32)-ENOMEM,
+						clone_size);
+		size -= clone_size;
+		ofs += clone_size;
+
+		cur_seg++;
+	} while (size > 0);
+	kref_put(&coll->kref, rbd_coll_release);
+
+	return 0;
+}
+
 /*
  * block device queue callback
  */
@@ -1596,10 +1654,8 @@ static void rbd_rq_fn(struct request_queue *q)
 		bool do_write;
 		unsigned int size;
 		u64 ofs;
-		int num_segs, cur_seg = 0;
-		struct rbd_req_coll *coll;
 		struct ceph_snap_context *snapc;
-		unsigned int bio_offset;
+		int result;

 		dout("fetched request\n");

@@ -1637,60 +1693,11 @@ static void rbd_rq_fn(struct request_queue *q)
 		ofs = blk_rq_pos(rq) * SECTOR_SIZE;
 		bio = rq->bio;

-		dout("%s 0x%x bytes at 0x%llx\n",
-		     do_write ? "write" : "read",
-		     size, (unsigned long long) blk_rq_pos(rq) * SECTOR_SIZE);
-
-		num_segs = rbd_get_num_segments(&rbd_dev->header, ofs, size);
-		if (num_segs <= 0) {
-			spin_lock_irq(q->queue_lock);
-			__blk_end_request_all(rq, num_segs);
-			ceph_put_snap_context(snapc);
-			continue;
-		}
-		coll = rbd_alloc_coll(num_segs);
-		if (!coll) {
-			spin_lock_irq(q->queue_lock);
-			__blk_end_request_all(rq, -ENOMEM);
-			ceph_put_snap_context(snapc);
-			continue;
-		}
-
-		bio_offset = 0;
-		do {
-			u64 limit = rbd_segment_length(rbd_dev, ofs, size);
-			unsigned int chain_size;
-			struct bio *bio_chain;
-
-			BUG_ON(limit > (u64) UINT_MAX);
-			chain_size = (unsigned int) limit;
-			dout("rq->bio->bi_vcnt=%hu\n", rq->bio->bi_vcnt);
-
-			kref_get(&coll->kref);
-
-			/* Pass a cloned bio chain via an osd request */
-
-			bio_chain = bio_chain_clone_range(&bio,
-						&bio_offset, chain_size,
-						GFP_ATOMIC);
-			if (bio_chain)
-				(void) rbd_do_op(rq, rbd_dev, snapc,
-						ofs, chain_size,
-						bio_chain, coll, cur_seg);
-			else
-				rbd_coll_end_req_index(rq, coll, cur_seg,
-						       (s32)-ENOMEM,
-						       chain_size);
-			size -= chain_size;
-			ofs += chain_size;
-
-			cur_seg++;
-		} while (size > 0);
-		kref_put(&coll->kref, rbd_coll_release);
-
-		spin_lock_irq(q->queue_lock);
-
+		result = rbd_dev_do_request(rq, rbd_dev, snapc, ofs, size, bio);
 		ceph_put_snap_context(snapc);
+		spin_lock_irq(q->queue_lock);
+		if (!size || result < 0)
+			__blk_end_request_all(rq, result);
 	}
 }

-- 
1.7.9.5

