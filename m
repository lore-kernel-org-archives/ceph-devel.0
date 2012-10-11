From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/3] rbd: kill rbd_req_{read,write}()
Date: Wed, 10 Oct 2012 19:19:41 -0700
Message-ID: <50762CBD.2070402@inktank.com>
References: <50762C54.40101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56796 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964912Ab2JKCTq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 22:19:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1338767pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 19:19:45 -0700 (PDT)
In-Reply-To: <50762C54.40101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Both rbd_req_read() and rbd_req_write() are simple wrapper routines
for rbd_do_op(), and each is only called once.  Replace each wrapper
call with a direct call to rbd_do_op(), and get rid of the wrapper
functions.

Signed-off-by: Alex Elder <elder@inktank.com>
---
  drivers/block/rbd.c |   60 
+++++++++++----------------------------------------
  1 file changed, 13 insertions(+), 47 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8f56d37..cc74b36 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1211,41 +1211,6 @@ done:
  }

  /*
- * Request async osd write
- */
-static int rbd_req_write(struct request *rq,
-			 struct rbd_device *rbd_dev,
-			 struct ceph_snap_context *snapc,
-			 u64 ofs, u64 len,
-			 struct bio *bio,
-			 struct rbd_req_coll *coll,
-			 int coll_index)
-{
-	return rbd_do_op(rq, rbd_dev, snapc, CEPH_NOSNAP,
-			 CEPH_OSD_OP_WRITE,
-			 CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
-			 ofs, len, bio, coll, coll_index);
-}
-
-/*
- * Request async osd read
- */
-static int rbd_req_read(struct request *rq,
-			 struct rbd_device *rbd_dev,
-			 u64 snapid,
-			 u64 ofs, u64 len,
-			 struct bio *bio,
-			 struct rbd_req_coll *coll,
-			 int coll_index)
-{
-	return rbd_do_op(rq, rbd_dev, NULL,
-			 snapid,
-			 CEPH_OSD_OP_READ,
-			 CEPH_OSD_FLAG_READ,
-			 ofs, len, bio, coll, coll_index);
-}
-
-/*
   * Request sync osd read
   */
  static int rbd_req_sync_read(struct rbd_device *rbd_dev,
@@ -1550,21 +1515,22 @@ static void rbd_rq_fn(struct request_queue *q)
  				goto next_seg;
  			}

-
  			/* init OSD command: write or read */
  			if (do_write)
-				rbd_req_write(rq, rbd_dev,
-					      snapc,
-					      ofs,
-					      op_size, bio,
-					      coll, cur_seg);
+				(void) rbd_do_op(rq, rbd_dev,
+						snapc, CEPH_NOSNAP,
+						CEPH_OSD_OP_WRITE,
+						CEPH_OSD_FLAG_WRITE |
+						    CEPH_OSD_FLAG_ONDISK,
+						ofs, op_size, bio,
+						coll, cur_seg);
  			else
-				rbd_req_read(rq, rbd_dev,
-					     rbd_dev->mapping.snap_id,
-					     ofs,
-					     op_size, bio,
-					     coll, cur_seg);
-
+				(void) rbd_do_op(rq, rbd_dev,
+						NULL, rbd_dev->mapping.snap_id,
+						CEPH_OSD_OP_READ,
+						CEPH_OSD_FLAG_READ,
+						ofs, op_size, bio,
+						coll, cur_seg);
  next_seg:
  			size -= op_size;
  			ofs += op_size;
-- 
1.7.9.5

