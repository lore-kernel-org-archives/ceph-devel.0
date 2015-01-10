From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] rbd: convert to blk-mq
Date: Sat, 10 Jan 2015 19:31:28 +0100
Message-ID: <1420914688-27563-1-git-send-email-hch@lst.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34535 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974AbbAJScW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Jan 2015 13:32:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@kernel.org>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel@vger.kernel.org

This converts the rbd driver to use the blk-mq infrastructure.  Except
for switching to a per-request work item this is almost mechanical.

This was tested by Alexandre DERUMIER in November, and found to give
him 120000 iops, although the only comparism available was an old
3.10 kernel which gave 80000iops.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rbd.c | 118 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 51 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3ec85df..52cd677 100644
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
@@ -342,7 +343,6 @@ struct rbd_device {
 
 	struct list_head	rq_queue;	/* incoming rq queue */
 	spinlock_t		lock;		/* queue, flags, open_count */
-	struct work_struct	rq_work;
 
 	struct rbd_image_header	header;
 	unsigned long		flags;		/* possibly lock protected */
@@ -360,6 +360,9 @@ struct rbd_device {
 	atomic_t		parent_ref;
 	struct rbd_device	*parent;
 
+	/* Block layer tags. */
+	struct blk_mq_tag_set	tag_set;
+
 	/* protects updating the header */
 	struct rw_semaphore     header_rwsem;
 
@@ -1817,7 +1820,8 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 
 	/*
 	 * We support a 64-bit length, but ultimately it has to be
-	 * passed to blk_end_request(), which takes an unsigned int.
+	 * passed to the block layer, which just supports a 32-bit
+	 * length field.
 	 */
 	obj_request->xferred = osd_req->r_reply_op_len[0];
 	rbd_assert(obj_request->xferred < (u64)UINT_MAX);
@@ -2281,7 +2285,10 @@ static bool rbd_img_obj_end_request(struct rbd_obj_request *obj_request)
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
@@ -3310,8 +3317,10 @@ out:
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
@@ -3319,6 +3328,13 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
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
@@ -3358,6 +3374,8 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
 		goto err_rq;
 	}
 
+	blk_mq_start_request(rq);
+
 	if (offset && length > U64_MAX - offset + 1) {
 		rbd_warn(rbd_dev, "bad request range (%llu~%llu)", offset,
 			 length);
@@ -3411,52 +3429,18 @@ err_rq:
 			 obj_op_name(op_type), length, offset, result);
 	ceph_put_snap_context(snapc);
 	blk_end_request_all(rq, result);
+err:
+	blk_mq_end_request(rq, result);
 }
 
-static void rbd_request_workfn(struct work_struct *work)
+static int rbd_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
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
+	struct request *rq = bd->rq;
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
-		queue_work(rbd_wq, &rbd_dev->rq_work);
+	queue_work(rbd_wq, work);
+	return 0;
 }
 
 /*
@@ -3517,6 +3501,7 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 		del_gendisk(disk);
 		if (disk->queue)
 			blk_cleanup_queue(disk->queue);
+		blk_mq_free_tag_set(&rbd_dev->tag_set);
 	}
 	put_disk(disk);
 }
@@ -3728,11 +3713,28 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
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
@@ -3750,10 +3752,24 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	disk->fops = &rbd_bd_ops;
 	disk->private_data = rbd_dev;
 
-	q = blk_init_queue(rbd_request_fn, &rbd_dev->lock);
-	if (!q)
+	memset(&rbd_dev->tag_set, 0, sizeof(rbd_dev->tag_set));
+	rbd_dev->tag_set.ops = &rbd_mq_ops;
+	rbd_dev->tag_set.queue_depth = BLKDEV_MAX_RQ;
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
 
@@ -3779,10 +3795,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
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
@@ -4040,7 +4057,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 
 	spin_lock_init(&rbd_dev->lock);
 	INIT_LIST_HEAD(&rbd_dev->rq_queue);
-	INIT_WORK(&rbd_dev->rq_work, rbd_request_workfn);
 	rbd_dev->flags = 0;
 	atomic_set(&rbd_dev->parent_ref, 0);
 	INIT_LIST_HEAD(&rbd_dev->node);
-- 
1.9.1

