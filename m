From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 18/47] block-rbd: Fix jump targets in rbd_queue_workfn()
Date: Mon, 12 Sep 2016 21:04:26 +0200
Message-ID: <b9b5afb4-9326-2549-7efb-a232830f69d5@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, Alex Elder <elder@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Sep 2016 18:28:23 +0200

* Adjust jump targets according to the current Linux coding
  style convention.

* Delete a duplicate check then at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/rbd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 97d4d63..2b5f76e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4113,7 +4113,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 		dout("%s: non-fs request type %d\n", __func__,
 			(int) rq->cmd_type);
 		result = -EIO;
-		goto err;
+		goto end_request;
 	}
 
 	if (req_op(rq) == REQ_OP_DISCARD)
@@ -4128,7 +4128,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 	if (!length) {
 		dout("%s: zero-length request\n", __func__);
 		result = 0;
-		goto err_rq;
+		goto put_snap_context;
 	}
 
 	/* Only reads are allowed to a read-only device */
@@ -4136,7 +4136,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 	if (op_type != OBJ_OP_READ) {
 		if (rbd_dev->mapping.read_only) {
 			result = -EROFS;
-			goto err_rq;
+			goto warn_more;
 		}
 		rbd_assert(rbd_dev->spec->snap_id == CEPH_NOSNAP);
 	}
@@ -4151,14 +4151,14 @@ static void rbd_queue_workfn(struct work_struct *work)
 		dout("request for non-existent snapshot");
 		rbd_assert(rbd_dev->spec->snap_id != CEPH_NOSNAP);
 		result = -ENXIO;
-		goto err_rq;
+		goto warn_more;
 	}
 
 	if (offset && length > U64_MAX - offset + 1) {
 		rbd_warn(rbd_dev, "bad request range (%llu~%llu)", offset,
 			 length);
 		result = -EINVAL;
-		goto err_rq;	/* Shouldn't happen */
+		goto warn_more;	/* Shouldn't happen */
 	}
 
 	blk_mq_start_request(rq);
@@ -4176,7 +4176,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 		rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
 			 length, mapping_size);
 		result = -EIO;
-		goto err_rq;
+		goto warn_more;
 	}
 
 	if (must_be_locked) {
@@ -4189,7 +4189,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 					     snapc);
 	if (!img_request) {
 		result = -ENOMEM;
-		goto err_unlock;
+		goto unlock;
 	}
 	img_request->rq = rq;
 	snapc = NULL; /* img_request consumes a ref */
@@ -4201,27 +4201,30 @@ static void rbd_queue_workfn(struct work_struct *work)
 		result = rbd_img_request_fill(img_request, OBJ_REQUEST_BIO,
 					      rq->bio);
 	if (result)
-		goto err_img_request;
+		goto put_request;
 
 	result = rbd_img_request_submit(img_request);
 	if (result)
-		goto err_img_request;
+		goto put_request;
 
 	if (must_be_locked)
 		up_read(&rbd_dev->lock_rwsem);
 	return;
-
-err_img_request:
+ put_request:
 	rbd_img_request_put(img_request);
-err_unlock:
+ unlock:
 	if (must_be_locked)
 		up_read(&rbd_dev->lock_rwsem);
-err_rq:
-	if (result)
-		rbd_warn(rbd_dev, "%s %llx at %llx result %d",
-			 obj_op_name(op_type), length, offset, result);
+ warn_more:
+	rbd_warn(rbd_dev,
+		 "%s %llx at %llx result %d",
+		 obj_op_name(op_type),
+		 length,
+		 offset,
+		 result);
+ put_snap_context:
 	ceph_put_snap_context(snapc);
-err:
+ end_request:
 	blk_mq_end_request(rq, result);
 }
 
-- 
2.10.0
