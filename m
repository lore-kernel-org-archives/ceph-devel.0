From: Christoph Hellwig <hch@infradead.org>
Subject: Re: krbd blk-mq support ?
Date: Fri, 24 Oct 2014 03:55:01 -0700
Message-ID: <20141024105501.GA14699@infradead.org>
References: <9894b2d1-b7c6-4a17-9747-d8a41ec208a4@mailpro>
 <7a39f49a-2e11-48d6-90ce-e88dd652f6b9@mailpro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36182 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaJXKzF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Oct 2014 06:55:05 -0400
Content-Disposition: inline
In-Reply-To: <7a39f49a-2e11-48d6-90ce-e88dd652f6b9@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If you're willing to experiment give the patches below a try, not that
I don't have a ceph test cluster available, so the conversion is
untestested.


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-blk-mq-handle-single-queue-case-in-blk_mq_hctx_next_.patch"

From 00668f00afc6f0cfbce05d1186116469c1f3f9b3 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 24 Oct 2014 11:53:36 +0200
Subject: blk-mq: handle single queue case in blk_mq_hctx_next_cpu

Don't duplicate the code to handle the not cpu bounce case in the
caller, do it inside blk_mq_hctx_next_cpu instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 68929ba..eaaedea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -760,10 +760,11 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
  */
 static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 {
-	int cpu = hctx->next_cpu;
+	if (hctx->queue->nr_hw_queues == 1)
+		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {
-		int next_cpu;
+		int cpu = hctx->next_cpu, next_cpu;
 
 		next_cpu = cpumask_next(hctx->next_cpu, hctx->cpumask);
 		if (next_cpu >= nr_cpu_ids)
@@ -771,9 +772,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 
 		hctx->next_cpu = next_cpu;
 		hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
+	
+		return cpu;
 	}
 
-	return cpu;
+	return hctx->next_cpu;
 }
 
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
@@ -781,16 +784,13 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
 		return;
 
-	if (!async && cpumask_test_cpu(smp_processor_id(), hctx->cpumask))
+	if (!async && cpumask_test_cpu(smp_processor_id(), hctx->cpumask)) {
 		__blk_mq_run_hw_queue(hctx);
-	else if (hctx->queue->nr_hw_queues == 1)
-		kblockd_schedule_delayed_work(&hctx->run_work, 0);
-	else {
-		unsigned int cpu;
-
-		cpu = blk_mq_hctx_next_cpu(hctx);
-		kblockd_schedule_delayed_work_on(cpu, &hctx->run_work, 0);
+		return;
 	}
+
+	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
+			&hctx->run_work, 0);
 }
 
 void blk_mq_run_queues(struct request_queue *q, bool async)
@@ -888,16 +888,8 @@ static void blk_mq_delay_work_fn(struct work_struct *work)
 
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 {
-	unsigned long tmo = msecs_to_jiffies(msecs);
-
-	if (hctx->queue->nr_hw_queues == 1)
-		kblockd_schedule_delayed_work(&hctx->delay_work, tmo);
-	else {
-		unsigned int cpu;
-
-		cpu = blk_mq_hctx_next_cpu(hctx);
-		kblockd_schedule_delayed_work_on(cpu, &hctx->delay_work, tmo);
-	}
+	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
+			&hctx->delay_work, msecs_to_jiffies(msecs));
 }
 EXPORT_SYMBOL(blk_mq_delay_queue);
 
-- 
1.9.1


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-blk-mq-allow-direct-dispatch-to-a-driver-specific-wo.patch"

From 6002e20c4d2b150fcbe82a7bc45c90d30cb61b78 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 24 Oct 2014 12:04:07 +0200
Subject: blk-mq: allow direct dispatch to a driver specific workqueue

We have various block drivers that need to execute long term blocking
operations during I/O submission like file system or network I/O.

Currently these drivers just queue up work to an internal workqueue
from their request_fn.  With blk-mq we can make sure they always get
called on their own workqueue directly for I/O submission by:

 1) adding a flag to prevent inline submission of I/O, and
 2) allowing the driver to pass in a workqueue in the tag_set that
    will be used instead of kblockd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       |  2 +-
 block/blk-mq.c         | 12 +++++++++---
 block/blk.h            |  1 +
 include/linux/blk-mq.h |  4 ++++
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0421b53..7f7249f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -61,7 +61,7 @@ struct kmem_cache *blk_requestq_cachep;
 /*
  * Controlling structure to kblockd
  */
-static struct workqueue_struct *kblockd_workqueue;
+struct workqueue_struct *kblockd_workqueue;
 
 void blk_queue_congestion_threshold(struct request_queue *q)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index eaaedea..cea2f96 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -784,12 +784,13 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
 		return;
 
-	if (!async && cpumask_test_cpu(smp_processor_id(), hctx->cpumask)) {
+	if (!async && !(hctx->flags & BLK_MQ_F_WORKQUEUE) &&
+	    cpumask_test_cpu(smp_processor_id(), hctx->cpumask)) {
 		__blk_mq_run_hw_queue(hctx);
 		return;
 	}
 
-	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
+	queue_delayed_work_on(blk_mq_hctx_next_cpu(hctx), hctx->wq,
 			&hctx->run_work, 0);
 }
 
@@ -888,7 +889,7 @@ static void blk_mq_delay_work_fn(struct work_struct *work)
 
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 {
-	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
+	queue_delayed_work_on(blk_mq_hctx_next_cpu(hctx), hctx->wq,
 			&hctx->delay_work, msecs_to_jiffies(msecs));
 }
 EXPORT_SYMBOL(blk_mq_delay_queue);
@@ -1551,6 +1552,11 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	hctx->flags = set->flags;
 	hctx->cmd_size = set->cmd_size;
 
+	if (set->wq)
+		hctx->wq = set->wq;
+	else
+		hctx->wq = kblockd_workqueue;
+
 	blk_mq_init_cpu_notifier(&hctx->cpu_notifier,
 					blk_mq_hctx_notify, hctx);
 	blk_mq_register_cpu_notifier(&hctx->cpu_notifier);
diff --git a/block/blk.h b/block/blk.h
index 43b0361..fb46ad0 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,6 +25,7 @@ struct blk_flush_queue {
 	spinlock_t		mq_flush_lock;
 };
 
+extern struct workqueue_struct *kblockd_workqueue;
 extern struct kmem_cache *blk_requestq_cachep;
 extern struct kmem_cache *request_cachep;
 extern struct kobj_type blk_queue_ktype;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index c9be158..d61ecfe 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -37,6 +37,8 @@ struct blk_mq_hw_ctx {
 	unsigned int		queue_num;
 	struct blk_flush_queue	*fq;
 
+	struct workqueue_struct	*wq;
+
 	void			*driver_data;
 
 	struct blk_mq_ctxmap	ctx_map;
@@ -64,6 +66,7 @@ struct blk_mq_hw_ctx {
 
 struct blk_mq_tag_set {
 	struct blk_mq_ops	*ops;
+	struct workqueue_struct	*wq;
 	unsigned int		nr_hw_queues;
 	unsigned int		queue_depth;	/* max hw supported */
 	unsigned int		reserved_tags;
@@ -140,6 +143,7 @@ enum {
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_SYSFS_UP	= 1 << 3,
+	BLK_MQ_F_WORKQUEUE	= 1 << 4,
 
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
-- 
1.9.1


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0003-rbd-WIP-conversion-to-blk-mq.patch"

From 135c8e415d3800f33142debd93d64af246ccaa57 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 24 Oct 2014 12:46:40 +0200
Subject: rbd: WIP conversion to blk-mq

---
 drivers/block/rbd.c | 106 ++++++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 57 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0a54c58..9321f35 100644
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
+static int rbd_queue_rq(struct blk_mq_hw_ctx *hctx, struct request *rq,
+		bool last)
 {
+	struct rbd_device *rbd_dev = rq->q->queuedata;
 	struct rbd_img_request *img_request;
 	struct ceph_snap_context *snapc = NULL;
 	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
@@ -3314,6 +3323,12 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
 	enum obj_operation_type op_type;
 	u64 mapping_size;
 	int result;
+		
+	if (rq->cmd_type != REQ_TYPE_FS) {
+		dout("%s: non-fs request type %d\n", __func__,
+			(int) rq->cmd_type);
+		return BLK_MQ_RQ_QUEUE_ERROR;
+	}
 
 	if (rq->cmd_flags & REQ_DISCARD)
 		op_type = OBJ_OP_DISCARD;
@@ -3353,6 +3368,8 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
 		goto err_rq;
 	}
 
+	blk_mq_start_request(rq);
+
 	if (offset && length > U64_MAX - offset + 1) {
 		rbd_warn(rbd_dev, "bad request range (%llu~%llu)", offset,
 			 length);
@@ -3396,7 +3413,7 @@ static void rbd_handle_request(struct rbd_device *rbd_dev, struct request *rq)
 	if (result)
 		goto err_img_request;
 
-	return;
+	return 0;
 
 err_img_request:
 	rbd_img_request_put(img_request);
@@ -3406,53 +3423,8 @@ err_rq:
 			 obj_op_name(op_type), length, offset, result);
 	if (snapc)
 		ceph_put_snap_context(snapc);
-	blk_end_request_all(rq, result);
-}
-
-static void rbd_request_workfn(struct work_struct *work)
-{
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
-
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
+	blk_mq_end_request(rq, result);
+	return 0;
 }
 
 /*
@@ -3513,6 +3485,7 @@ static void rbd_free_disk(struct rbd_device *rbd_dev)
 		del_gendisk(disk);
 		if (disk->queue)
 			blk_cleanup_queue(disk->queue);
+		blk_mq_free_tag_set(&rbd_dev->tag_set);
 	}
 	put_disk(disk);
 }
@@ -3724,11 +3697,17 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev)
 	return 0;
 }
 
+static struct blk_mq_ops rbd_mq_ops = {
+	.queue_rq	= rbd_queue_rq,
+	.map_queue	= blk_mq_map_queue,
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
@@ -3746,10 +3725,23 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
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
 
@@ -3775,10 +3767,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
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
@@ -4036,7 +4029,6 @@ static struct rbd_device *rbd_dev_create(struct rbd_client *rbdc,
 
 	spin_lock_init(&rbd_dev->lock);
 	INIT_LIST_HEAD(&rbd_dev->rq_queue);
-	INIT_WORK(&rbd_dev->rq_work, rbd_request_workfn);
 	rbd_dev->flags = 0;
 	atomic_set(&rbd_dev->parent_ref, 0);
 	INIT_LIST_HEAD(&rbd_dev->node);
-- 
1.9.1


--ZGiS0Q5IWpPtfppv--
