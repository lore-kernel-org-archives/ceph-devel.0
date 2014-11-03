From: Christoph Hellwig <hch@infradead.org>
Subject: Re: krbd blk-mq support ?
Date: Mon, 3 Nov 2014 03:08:07 -0800
Message-ID: <20141103110807.GA3186@infradead.org>
References: <20141027094556.GA31604@infradead.org>
 <fc083e2c-6a73-4ff8-934c-4e3ba1d64b50@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42570 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbaKCLII (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 06:08:08 -0500
Content-Disposition: inline
In-Reply-To: <fc083e2c-6a73-4ff8-934c-4e3ba1d64b50@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

Hi Alexandre,

can you try the patch below instead of the previous three patches?
This one uses a per-request work struct to allow for more concurrency.

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0a54c58..b981096 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -38,6 +38,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/blk-mq.h>
 #include <linux/fs.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
@@ -343,7 +344,6 @@ struct rbd_device {
 	struct list_head	rq_queue;	/* incoming rq queue */
 	spinlock_t		lock;		/* queue, flags, open_count */
 	struct workqueue_struct	*rq_wq;
-	struct work_struct	rq_work;
 
 	struct rbd_image_header	header;
 	unsigned long		flags;		/* possibly lock protected */
@@ -361,6 +361,9 @@ struct rbd_device {
 	atomic_t		parent_ref;
 	struct rbd_device	*parent;
 
+	/* Block layer tags. */
+	struct blk_mq_tag_set	tag_set;
+
 	/* protects updating the header */
 	struct rw_semaphore     header_rwsem;
 
@@ -1816,7 +1819,8 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 
 	/*
 	 * We support a 64-bit length, but ultimately it has to be
-	 * passed to blk_end_request(), which takes an unsigned int.
+	 * passed to the block layer, which just supports a 32-bit
+	 * length field.
 	 */
 	obj_request->xferred = osd_req->r_reply_op_len[0];
 	rbd_assert(obj_request->xferred < (u64)UINT_MAX);
@@ -2280,7 +2284,10 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
 		more = obj_request->which < img_request->obj_request_count - 1;
 	} else {
 		rbd_assert(img_request->rq != NULL);
-		more = blk_end_request(img_request->rq, result, xferred);
+	
+		more = blk_update_request(img_request->rq, result, xferred);
+		if (!more)
+			__blk_mq_end_request(img_request->rq, result);
 	}
 
 	return more;
@@ -3305,8 +3312,10 @@ out:
 	return ret;
 }
 
-static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
+static void rbd_queue_workfn(struct work_struct *work)
 {
+	struct request *rq = blk_mq_rq_from_pdu(work);
+	struct rbd_device *rbd_dev = rq->q->queuedata;
 	struct rbd_img_request *img_request;
 	struct ceph_snap_context *snapc = NULL;
 	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
@@ -3314,6 +3323,13 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
 	enum obj_operation_type op_type;
 	u64 mapping_size;
 	int result;
+		
+	if (rq->cmd_type != REQ_TYPE_FS) {
+		dout("%s: non-fs request type %d\n", __func__,
+			(int) rq->cmd_type);
+		result = -EIO;
+		goto err;
+	}
 
 	if (rq->cmd_flags & REQ_DISCARD)
 		op_type = OBJ_OP_DISCARD;
@@ -3353,6 +3369,8 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
 		goto err_rq;
 	}
 
+	blk_mq_start_request(rq);
+
 	if (offset && length > U64_MAX - offset + 1) {
 		rbd_warn(rbd_dev, "bad request range (%llu~%llu)", offset,
 			 length);
@@ -3406,53 +3424,18 @@ err_rq:
 			 obj_op_name(op_type), length, offset, result);
 	if (snapc)
 		ceph_put_snap_context(snapc);
-	blk_end_request_all(rq, result);
+err:
+	blk_mq_end_request(rq, result);
 }
 
-static void rbd_request_workfn(struct work_struct *work)
+static int rbd_queue_rq(struct blk_mq_hw_ctx *hctx, struct request *rq,
+		bool last)
 {
-	struct rbd_device *rbd_dev =
-	    container_of(work, struct rbd_device, rq_work);
-	struct request *rq, *next;
-	LIST_HEAD(requests);
-
-	spin_lock_irq(&rbd_dev->lock); /* rq->q->queue_lock */
-	list_splice_init(&rbd_dev->rq_queue, &requests);
-	spin_unlock_irq(&rbd_dev->lock);
-
-	list_for_each_entry_safe(rq, next, &requests, queuelist) {
-		list_del_init(&rq->queuelist);
-		rbd_handle_request(rbd_dev, rq);
-	}
-}
+	struct rbd_device *rbd_dev = rq->q->queuedata;
+	struct work_struct *work = blk_mq_rq_to_pdu(rq);
 
-/*
- * Called with q->queue_lock held and interrupts disabled, possibly on
- * the way to schedule().  Do not sleep here!
- */
-static void rbd_request_fn(struct request_queue *q)
-{
-	struct rbd_device *rbd_dev = q->queuedata;
-	struct request *rq;
-	int queued = 0;
-
-	rbd_assert(rbd_dev);
-
-	while ((rq = blk_fetch_request(q))) {
-		/* Ignore any non-FS requests that filter through. */
-		if (rq->cmd_type != REQ_TYPE_FS) {
-			dout("%s: non-fs request type %d\n", __func__,
-				(int) rq->cmd_type);
-			__blk_end_request_all(rq, 0);
-			continue;
-		}
-
-		list_add_tail(&rq->queuelist, &rbd_dev->rq_queue);
-		queued++;
-	}
-
-	if (queued)
-		queue_work(rbd_dev->rq_wq, &rbd_dev->rq_work);
+	queue_work(rbd_dev->rq_wq, work);
+	return 0;
 }
 
 /*
@@ -3513,6 +3496,7 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 		del_gendisk(disk);
 		if (disk->queue)
 			blk_cleanup_queue(disk->queue);
+		blk_mq_free_tag_set(&rbd_dev->tag_set);
 	}
 	put_disk(disk);
 }
@@ -3724,11 +3708,28 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	return 0;
 }
 
+static int rbd_init_request(void *data, struct request *rq,
+		unsigned int hctx_idx, unsigned int request_idx,
+		unsigned int numa_node)
+{
+	struct work_struct *work = blk_mq_rq_to_pdu(rq);
+
+	INIT_WORK(work, rbd_queue_workfn);
+	return 0;
+}
+
+static struct blk_mq_ops rbd_mq_ops = {
+	.queue_rq	= rbd_queue_rq,
+	.map_queue	= blk_mq_map_queue,
+	.init_request	= rbd_init_request,
+};
+
 static int rbd_init_disk(struct rbd_device *rbd_dev)
 {
 	struct gendisk *disk;
 	struct request_queue *q;
 	u64 segment_size;
+	int err;
 
 	/* create gendisk info */
 	disk = alloc_disk(single_major ?
@@ -3746,10 +3747,24 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	disk->fops = &rbd_bd_ops;
 	disk->private_data = rbd_dev;
 
-	q = blk_init_queue(rbd_request_fn, &rbd_dev->lock);
-	if (!q)
+	memset(&rbd_dev->tag_set, 0, sizeof(rbd_dev->tag_set));
+	rbd_dev->tag_set.ops = &rbd_mq_ops;
+	rbd_dev->tag_set.queue_depth = 128; //
+	rbd_dev->tag_set.numa_node = NUMA_NO_NODE;
+	rbd_dev->tag_set.flags =
+		BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	rbd_dev->tag_set.nr_hw_queues = 1;
+	rbd_dev->tag_set.cmd_size = sizeof(struct work_struct);
+
+	err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
+	if (err)
 		goto out_disk;
 
+	err = -ENOMEM;
+	q = blk_mq_init_queue(&rbd_dev->tag_set);
+	if (!q)
+		goto out_tag_set;
+
 	/* We use the default size, but let's be explicit about it. */
 	blk_queue_physical_block_size(q, SECTOR_SIZE);
 
@@ -3775,10 +3790,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	rbd_dev->disk = disk;
 
 	return 0;
+out_tag_set:
+	blk_mq_free_tag_set(&rbd_dev->tag_set);
 out_disk:
 	put_disk(disk);
-
-	return -ENOMEM;
+	return err;
 }
 
 /*
@@ -4036,7 +4052,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 
 	spin_lock_init(&rbd_dev->lock);
 	INIT_LIST_HEAD(&rbd_dev->rq_queue);
-	INIT_WORK(&rbd_dev->rq_work, rbd_request_workfn);
 	rbd_dev->flags = 0;
 	atomic_set(&rbd_dev->parent_ref, 0);
 	INIT_LIST_HEAD(&rbd_dev->node);
-- 
1.9.1

