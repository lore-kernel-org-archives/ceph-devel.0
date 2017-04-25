From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/9] rbd: ignore unlock errors
Date: Tue, 25 Apr 2017 11:33:40 +0200
Message-ID: <1493112825-16403-5-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35655 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428699AbdDYJeQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id o36so24161483qtb.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:15 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.14
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:14 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently the lock_state is set to UNLOCKED (preventing further I/O),
but RELEASED_LOCK notification isn't sent.  Be consistent with userspace
and treat ceph_cls_unlock() errors as the image is unlocked.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aadf35451be7..4b72286c4be6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3097,7 +3097,7 @@ static int rbd_lock(struct rbd_device *rbd_dev)
 /*
  * lock_rwsem must be held for write
  */
-static int rbd_unlock(struct rbd_device *rbd_dev)
+static void rbd_unlock(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	char cookie[32];
@@ -3105,19 +3105,16 @@ static int rbd_unlock(struct rbd_device *rbd_dev)
 
 	WARN_ON(!__rbd_is_lock_owner(rbd_dev));
 
-	rbd_dev->lock_state = RBD_LOCK_STATE_UNLOCKED;
-
 	format_lock_cookie(rbd_dev, cookie);
 	ret = ceph_cls_unlock(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
 			      RBD_LOCK_NAME, cookie);
-	if (ret && ret != -ENOENT) {
-		rbd_warn(rbd_dev, "cls_unlock failed: %d", ret);
-		return ret;
-	}
+	if (ret && ret != -ENOENT)
+		rbd_warn(rbd_dev, "failed to unlock: %d", ret);
 
+	/* treat errors as the image is unlocked */
+	rbd_dev->lock_state = RBD_LOCK_STATE_UNLOCKED;
 	rbd_set_owner_cid(rbd_dev, &rbd_empty_cid);
 	queue_work(rbd_dev->task_wq, &rbd_dev->released_lock_work);
-	return 0;
 }
 
 static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
@@ -3490,16 +3487,15 @@ static bool rbd_release_lock(struct rbd_device *rbd_dev)
 	if (rbd_dev->lock_state != RBD_LOCK_STATE_RELEASING)
 		return false;
 
-	if (!rbd_unlock(rbd_dev))
-		/*
-		 * Give others a chance to grab the lock - we would re-acquire
-		 * almost immediately if we got new IO during ceph_osdc_sync()
-		 * otherwise.  We need to ack our own notifications, so this
-		 * lock_dwork will be requeued from rbd_wait_state_locked()
-		 * after wake_requests() in rbd_handle_released_lock().
-		 */
-		cancel_delayed_work(&rbd_dev->lock_dwork);
-
+	rbd_unlock(rbd_dev);
+	/*
+	 * Give others a chance to grab the lock - we would re-acquire
+	 * almost immediately if we got new IO during ceph_osdc_sync()
+	 * otherwise.  We need to ack our own notifications, so this
+	 * lock_dwork will be requeued from rbd_wait_state_locked()
+	 * after wake_requests() in rbd_handle_released_lock().
+	 */
+	cancel_delayed_work(&rbd_dev->lock_dwork);
 	return true;
 }
 
-- 
2.4.3

