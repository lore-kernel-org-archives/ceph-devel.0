From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/3] rbd: kill drop rbd_do_op() opcode and flags
Date: Wed, 10 Oct 2012 19:19:48 -0700
Message-ID: <50762CC4.60506@inktank.com>
References: <50762C54.40101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39012 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964918Ab2JKCTw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 22:19:52 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1233911pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 19:19:51 -0700 (PDT)
In-Reply-To: <50762C54.40101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The only callers of rbd_do_op() are in rbd_rq_fn(), where call one
is used for writes and the other used for reads.  The request passed
to rbd_do_op() already encodes the I/O direction, and that
information can be used inside the function to set the opcode and
flags value (rather than passing them in as arguments).

So get rid of the opcode and flags arguments to rbd_do_op().

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   18 +++++++++++-------
  1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index cc74b36..396af14 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1164,7 +1164,6 @@ static int rbd_do_op(struct request *rq,
  		     struct rbd_device *rbd_dev,
  		     struct ceph_snap_context *snapc,
  		     u64 snapid,
-		     int opcode, int flags,
  		     u64 ofs, u64 len,
  		     struct bio *bio,
  		     struct rbd_req_coll *coll,
@@ -1176,6 +1175,8 @@ static int rbd_do_op(struct request *rq,
  	int ret;
  	struct ceph_osd_req_op *ops;
  	u32 payload_len;
+	int opcode;
+	int flags;

  	seg_name = rbd_segment_name(rbd_dev, ofs);
  	if (!seg_name)
@@ -1183,7 +1184,15 @@ static int rbd_do_op(struct request *rq,
  	seg_len = rbd_segment_length(rbd_dev, ofs, len);
  	seg_ofs = rbd_segment_offset(rbd_dev, ofs);

-	payload_len = (flags & CEPH_OSD_FLAG_WRITE ? seg_len : 0);
+	if (rq_data_dir(rq) == WRITE) {
+		opcode = CEPH_OSD_OP_WRITE;
+		flags = CEPH_OSD_FLAG_WRITE|CEPH_OSD_FLAG_ONDISK;
+		payload_len = seg_len;
+	} else {
+		opcode = CEPH_OSD_OP_READ;
+		flags = CEPH_OSD_FLAG_READ;
+		payload_len = 0;
+	}

  	ret = -ENOMEM;
  	ops = rbd_create_rw_ops(1, opcode, payload_len);
@@ -1519,16 +1528,11 @@ static void rbd_rq_fn(struct request_queue *q)
  			if (do_write)
  				(void) rbd_do_op(rq, rbd_dev,
  						snapc, CEPH_NOSNAP,
-						CEPH_OSD_OP_WRITE,
-						CEPH_OSD_FLAG_WRITE |
-						    CEPH_OSD_FLAG_ONDISK,
  						ofs, op_size, bio,
  						coll, cur_seg);
  			else
  				(void) rbd_do_op(rq, rbd_dev,
  						NULL, rbd_dev->mapping.snap_id,
-						CEPH_OSD_OP_READ,
-						CEPH_OSD_FLAG_READ,
  						ofs, op_size, bio,
  						coll, cur_seg);
  next_seg:
-- 
1.7.9.5

