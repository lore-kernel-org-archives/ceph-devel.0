From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 4/5] drivers/rbd_tcm: Add cluster API CAW locking hooks
Date: Wed, 29 Jul 2015 03:15:51 +0200
Message-ID: <1438132552-14673-5-git-send-email-ddiss@suse.de>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35660 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbbG2BQA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 21:16:00 -0400
In-Reply-To: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>

Use an RBD device lock in addition to a local device semaphore to ensure
that COMPARE AND WRITE operations are handled in an atomic fashion.

Lock acquisition is handled via a new workqueue, which currently polls
periodically for the RBD device lock until it can be acquired. This
polling behaviour should be replaced in future with watch/notify
functionality similar to that used for RBD_NOTIFY_OP_SCSI_LUN_RESET.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/rbd_tcm.c              | 208 +++++++++++++++++++++++++++++++++++
 include/target/target_core_cluster.h |   4 +
 2 files changed, 212 insertions(+)

diff --git a/drivers/block/rbd_tcm.c b/drivers/block/rbd_tcm.c
index f3ee6ff..47a006f 100644
--- a/drivers/block/rbd_tcm.c
+++ b/drivers/block/rbd_tcm.c
@@ -36,11 +36,26 @@ struct rbd_tcm_reset_event {
 	u64 notify_id;
 };
 
+#define RBD_TCM_CAW_LOCK_POLL_HZ	(1 * HZ)
+#define RBD_TCM_CAW_LOCK_TOUT_HZ	(5 * HZ)
+
+struct rbd_tcm_caw_locker {
+	struct delayed_work caw_work;
+	struct delayed_work caw_tout_work;
+	struct completion lock_finished;
+	int lock_rc;
+	int retries;
+	struct rbd_tcm_device *rbd_tcm_dev;
+};
+
 struct rbd_tcm_device {
 	struct rbd_device *rbd_dev;
 	struct se_device *se_dev;
 
 	struct rbd_tcm_reset_event reset_evt;
+
+	struct rbd_tcm_caw_locker *caw_locker;
+	struct workqueue_struct *caw_wq;
 };
 
 static int rbd_tcm_start_reset(struct se_device *se_dev, u32 timeout)
@@ -92,6 +107,8 @@ static int rbd_tcm_detach_device(struct se_device *se_dev)
 	struct request_queue *q = ibock_se_device_to_q(se_dev);
 	struct rbd_tcm_device *rbd_tcm_dev = se_dev->cluster_dev_data;
 
+	destroy_workqueue(rbd_tcm_dev->caw_wq);
+
 	cancel_work_sync(&rbd_tcm_dev->reset_evt.work);
 	se_dev->cluster_dev_data = NULL;
 	rbd_detach_tcm_dev(q->queuedata);
@@ -112,16 +129,207 @@ static int rbd_tcm_attach_device(struct se_device *se_dev)
 	INIT_WORK(&rbd_tcm_dev->reset_evt.work, rbd_tcm_reset_event_workfn);
 	rbd_tcm_dev->reset_evt.rbd_tcm_dev = rbd_tcm_dev;
 
+	/* work queue to serialise COMPARE AND WRITE handling */
+	rbd_tcm_dev->caw_wq = alloc_workqueue("caw-rbd",
+					      WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!rbd_tcm_dev->caw_wq) {
+		rbd_warn(rbd_tcm_dev->rbd_dev,
+			 "Unable to create CAW workqueue for rbd");
+		kfree(rbd_tcm_dev);
+		return -ENOMEM;
+	}
+
 	se_dev->cluster_dev_data = rbd_tcm_dev;
 	return rbd_attach_tcm_dev(q->queuedata, rbd_tcm_dev);
 }
 
+static void
+rbd_tcm_caw_lock_dispatch(struct work_struct *work)
+{
+	struct rbd_tcm_caw_locker *caw_locker
+		= container_of(work, struct rbd_tcm_caw_locker, caw_work.work);
+	struct rbd_device *rbd_dev = caw_locker->rbd_tcm_dev->rbd_dev;
+	int ret;
+
+	pr_debug("CAW lock dispatch running\n");
+
+	ret = rbd_dev_lock(rbd_dev, "rbd_tcm_caw", 1, "cookie", "",
+			   "exclusive COMPARE AND wRITE lock", 0);
+	if (ret == -EEXIST) {
+		rbd_warn(rbd_dev, "CAW lock conflict, deferring operation");
+		/* TODO use unlock notification, instead of polling */
+		caw_locker->retries++;
+		queue_delayed_work(caw_locker->rbd_tcm_dev->caw_wq,
+				   &caw_locker->caw_work,
+				   RBD_TCM_CAW_LOCK_POLL_HZ);
+		return;
+	} else if (ret < 0) {
+		rbd_warn(rbd_dev, "failed to obtain CAW lock: %d", ret);
+		caw_locker->lock_rc = ret;
+		complete(&caw_locker->lock_finished);
+		return;
+	}
+
+	pr_debug("acquired COMPARE AND WRITE lock after %d retries\n",
+		 caw_locker->retries);
+
+	cancel_delayed_work_sync(&caw_locker->caw_tout_work);
+	caw_locker->lock_rc = 0;
+	complete(&caw_locker->lock_finished);
+}
+
+static void
+rbd_tcm_caw_lock_timeout(struct work_struct *work)
+{
+	struct rbd_tcm_caw_locker *caw_locker
+		= container_of(work, struct rbd_tcm_caw_locker,
+			       caw_tout_work.work);
+
+	pr_warn("CAW lock timeout running\n");
+
+	cancel_delayed_work_sync(&caw_locker->caw_work);
+	caw_locker->lock_rc = -ETIMEDOUT;
+	complete(&caw_locker->lock_finished);
+}
+
+/*
+ * Ensure cluster wide exclusive COMPARE AND WRITE access via an RBD device
+ * lock. Local exclusivity is handled via dev->saw_sem.
+ * In future, we may be able to offload the entire atomic read->compare->write
+ * sequence to the OSDs, which would make this interface pretty useless.
+ */
+static int
+rbd_tcm_caw_lock(struct se_device *se_dev)
+{
+	struct rbd_tcm_device *rbd_tcm_dev = se_dev->cluster_dev_data;
+	struct rbd_tcm_caw_locker *caw_locker;
+	int ret;
+
+	ret = down_interruptible(&se_dev->caw_sem);
+	if (ret != 0) {
+		pr_err("failed to obtain local semaphore\n");
+		return ret;
+	}
+
+	BUG_ON(rbd_tcm_dev->caw_locker != NULL);
+
+	pr_debug("got local CAW semaphore\n");
+
+	caw_locker = kzalloc(sizeof(*caw_locker), GFP_KERNEL);
+	if (!caw_locker) {
+		pr_err("Unable to allocate caw_locker\n");
+		ret = -ENOMEM;;
+		goto err_sem_up;
+	}
+
+	init_completion(&caw_locker->lock_finished);
+	/* whichever work finishes first cancels the other */
+	INIT_DELAYED_WORK(&caw_locker->caw_work, rbd_tcm_caw_lock_dispatch);
+	INIT_DELAYED_WORK(&caw_locker->caw_tout_work, rbd_tcm_caw_lock_timeout);
+	caw_locker->lock_rc = -EINTR;
+	caw_locker->rbd_tcm_dev = rbd_tcm_dev;
+
+	rbd_tcm_dev->caw_locker = caw_locker;
+
+	queue_delayed_work(rbd_tcm_dev->caw_wq, &caw_locker->caw_work, 0);
+	queue_delayed_work(rbd_tcm_dev->caw_wq, &caw_locker->caw_tout_work,
+			   RBD_TCM_CAW_LOCK_TOUT_HZ);
+	pr_debug("work queued, awaiting completion\n");
+	wait_for_completion(&caw_locker->lock_finished);
+	if (caw_locker->lock_rc < 0) {
+		ret = caw_locker->lock_rc;
+		goto err_locker_free;
+	}
+
+	/* caw_locker freed following unlock */
+
+	return 0;
+
+err_locker_free:
+	kfree(caw_locker);
+	rbd_tcm_dev->caw_locker = NULL;
+err_sem_up:
+	up(&se_dev->caw_sem);
+	pr_debug("dropped local CAW semaphore on failure\n");
+	return ret;
+}
+
+static void
+rbd_tcm_caw_unlock_dispatch(struct work_struct *work)
+{
+	struct rbd_tcm_caw_locker *caw_locker
+		= container_of(work, struct rbd_tcm_caw_locker, caw_work.work);
+	struct rbd_device *rbd_dev = caw_locker->rbd_tcm_dev->rbd_dev;
+	int ret;
+
+	pr_debug("CAW unlock dispatch running\n");
+
+	ret = rbd_dev_unlock(rbd_dev, "rbd_tcm_caw", "cookie");
+	if (ret < 0)
+		rbd_warn(rbd_dev, "failed to drop CAW lock: %d", ret);
+	else {
+		pr_debug("dropped RBD COMPARE AND WRITE lock\n");
+	}
+
+	cancel_delayed_work_sync(&caw_locker->caw_tout_work);
+	caw_locker->lock_rc = ret;
+	complete(&caw_locker->lock_finished);
+}
+
+static void
+rbd_tcm_caw_unlock_timeout(struct work_struct *work)
+{
+	struct rbd_tcm_caw_locker *caw_locker
+		= container_of(work, struct rbd_tcm_caw_locker,
+			       caw_tout_work.work);
+
+	pr_warn("CAW unlock timeout running\n");
+
+	cancel_delayed_work_sync(&caw_locker->caw_work);
+	caw_locker->lock_rc = -ETIMEDOUT;
+	complete(&caw_locker->lock_finished);
+}
+
+static void
+rbd_tcm_caw_unlock(struct se_device *se_dev)
+{
+	struct rbd_tcm_device *rbd_tcm_dev = se_dev->cluster_dev_data;
+	struct rbd_tcm_caw_locker *caw_locker = rbd_tcm_dev->caw_locker;
+
+	/* set if lock was successfull */
+	BUG_ON(caw_locker == NULL);
+
+	init_completion(&caw_locker->lock_finished);
+	INIT_DELAYED_WORK(&caw_locker->caw_work, rbd_tcm_caw_unlock_dispatch);
+	INIT_DELAYED_WORK(&caw_locker->caw_tout_work, rbd_tcm_caw_unlock_timeout);
+	caw_locker->lock_rc = -EINTR;
+	caw_locker->retries = 0;
+	caw_locker->rbd_tcm_dev = rbd_tcm_dev;
+
+	queue_delayed_work(rbd_tcm_dev->caw_wq, &caw_locker->caw_work, 0);
+	queue_delayed_work(rbd_tcm_dev->caw_wq, &caw_locker->caw_tout_work,
+			   RBD_TCM_CAW_LOCK_TOUT_HZ);
+	pr_debug("work queued, awaiting completion\n");
+	wait_for_completion(&caw_locker->lock_finished);
+	if (caw_locker->lock_rc < 0) {
+		pr_warn("leaving stale RBD CAW lock");
+	}
+
+	kfree(caw_locker);
+	rbd_tcm_dev->caw_locker = NULL;
+
+	up(&se_dev->caw_sem);
+	pr_debug("dropped local CAW semaphore\n");
+}
+
 static struct se_cluster_api rbd_tcm_template = {
 	.name		= "rbd",
 	.owner		= THIS_MODULE,
 	.reset_device	= rbd_tcm_start_reset,
 	.attach_device	= rbd_tcm_attach_device,
 	.detach_device	= rbd_tcm_detach_device,
+	.caw_lock	= rbd_tcm_caw_lock,
+	.caw_unlock	= rbd_tcm_caw_unlock,
 };
 
 int rbd_tcm_register(void)
diff --git a/include/target/target_core_cluster.h b/include/target/target_core_cluster.h
index 4860c2e..cc1e2aa 100644
--- a/include/target/target_core_cluster.h
+++ b/include/target/target_core_cluster.h
@@ -23,6 +23,10 @@ struct se_cluster_api {
 	 * takes longer than timeout seconds then -ETIMEDOUT should be returned.
 	 */
 	int (*reset_device)(struct se_device *dev, u32 timeout);
+
+	/* exclusive device locking for atomic COMPARE AND WRITE */
+	int (*caw_lock)(struct se_device *se_dev);
+	void (*caw_unlock)(struct se_device *se_dev);
 };
 
 extern int core_cluster_api_register(struct se_cluster_api *);
-- 
2.1.4

