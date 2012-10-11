From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/3] rbd: consolidate rbd_do_op() calls
Date: Wed, 10 Oct 2012 19:19:55 -0700
Message-ID: <50762CCB.5040007@inktank.com>
References: <50762C54.40101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39012 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901Ab2JKCUB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 22:20:01 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1233911pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 19:20:01 -0700 (PDT)
In-Reply-To: <50762C54.40101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The two calls to rbd_do_op() from rbd_rq_fn() differ only in the
value passed for the snapshot id and the snapshot context.

For reads the snapshot always comes from the mapping, and for writes
the snapshot id is always CEPH_NOSNAP.

The snapshot context is always null for reads.  For writes, the
snapshot context always comes from the rbd header, but it is
acquired under protection of header semaphore and could change
thereafter, so we can't simply use what's available inside
rbd_do_op().

Eliminate the snapid parameter from rbd_do_op(), and set it
based on the I/O direction inside that function instead.  Always
pass the snapshot context acquired in the caller, but reset it
to a null pointer inside rbd_do_op() if the operation is a read.

As a result, there is no difference in the read and write calls
to rbd_do_op() made in rbd_rq_fn(), so just call it unconditionally.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   26 +++++++++-----------------
  1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 396af14..ca28036 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1163,7 +1163,6 @@ done:
  static int rbd_do_op(struct request *rq,
  		     struct rbd_device *rbd_dev,
  		     struct ceph_snap_context *snapc,
-		     u64 snapid,
  		     u64 ofs, u64 len,
  		     struct bio *bio,
  		     struct rbd_req_coll *coll,
@@ -1177,6 +1176,7 @@ static int rbd_do_op(struct request *rq,
  	u32 payload_len;
  	int opcode;
  	int flags;
+	u64 snapid;

  	seg_name = rbd_segment_name(rbd_dev, ofs);
  	if (!seg_name)
@@ -1187,10 +1187,13 @@ static int rbd_do_op(struct request *rq,
  	if (rq_data_dir(rq) == WRITE) {
  		opcode = CEPH_OSD_OP_WRITE;
  		flags = CEPH_OSD_FLAG_WRITE|CEPH_OSD_FLAG_ONDISK;
+		snapid = CEPH_NOSNAP;
  		payload_len = seg_len;
  	} else {
  		opcode = CEPH_OSD_OP_READ;
  		flags = CEPH_OSD_FLAG_READ;
+		snapc = NULL;
+		snapid = rbd_dev->mapping.snap_id;
  		payload_len = 0;
  	}

@@ -1518,24 +1521,13 @@ static void rbd_rq_fn(struct request_queue *q)
  			kref_get(&coll->kref);
  			bio = bio_chain_clone(&rq_bio, &next_bio, &bp,
  					      op_size, GFP_ATOMIC);
-			if (!bio) {
+			if (bio)
+				(void) rbd_do_op(rq, rbd_dev, snapc,
+						ofs, op_size,
+						bio, coll, cur_seg);
+			else
  				rbd_coll_end_req_index(rq, coll, cur_seg,
  						       -ENOMEM, op_size);
-				goto next_seg;
-			}
-
-			/* init OSD command: write or read */
-			if (do_write)
-				(void) rbd_do_op(rq, rbd_dev,
-						snapc, CEPH_NOSNAP,
-						ofs, op_size, bio,
-						coll, cur_seg);
-			else
-				(void) rbd_do_op(rq, rbd_dev,
-						NULL, rbd_dev->mapping.snap_id,
-						ofs, op_size, bio,
-						coll, cur_seg);
-next_seg:
  			size -= op_size;
  			ofs += op_size;

-- 
1.7.9.5

