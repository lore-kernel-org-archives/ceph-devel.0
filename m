From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: don't wait for the lock forever if blacklisted
Date: Wed, 12 Oct 2016 16:03:28 +0200
Message-ID: <1476281008-30556-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34552 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754998AbcJLOEi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Oct 2016 10:04:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id x23so1585678lfi.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Oct 2016 07:04:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mike Christie <mchristi@redhat.com>

-EBLACKLISTED from __rbd_register_watch() means that our ceph_client
got blacklisted - we won't be able to restore the watch and reacquire
the lock.  Wake up and fail all outstanding requests waiting for the
lock and arrange for all new requests that require the lock to fail
immediately.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 7a9792cb6ef1..fbc025a87261 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -415,15 +415,15 @@ struct rbd_device {
 };
 
 /*
- * Flag bits for rbd_dev->flags.  If atomicity is required,
- * rbd_dev->lock is used to protect access.
- *
- * Currently, only the "removing" flag (which is coupled with the
- * "open_count" field) requires atomic access.
+ * Flag bits for rbd_dev->flags:
+ * - REMOVING (which is coupled with rbd_dev->open_count) is protected
+ *   by rbd_dev->lock
+ * - BLACKLISTED is protected by rbd_dev->lock_rwsem
  */
 enum rbd_dev_flags {
 	RBD_DEV_FLAG_EXISTS,	/* mapped snapshot has not been deleted */
 	RBD_DEV_FLAG_REMOVING,	/* this mapping is being removed */
+	RBD_DEV_FLAG_BLACKLISTED, /* our ceph_client is blacklisted */
 };
 
 static DEFINE_MUTEX(client_mutex);	/* Serialize client creation */
@@ -3926,6 +3926,7 @@ static void rbd_reregister_watch(struct work_struct *work)
 	struct rbd_device *rbd_dev = container_of(to_delayed_work(work),
 					    struct rbd_device, watch_dwork);
 	bool was_lock_owner = false;
+	bool need_to_wake = false;
 	int ret;
 
 	dout("%s rbd_dev %p\n", __func__, rbd_dev);
@@ -3935,19 +3936,27 @@ static void rbd_reregister_watch(struct work_struct *work)
 		was_lock_owner = rbd_release_lock(rbd_dev);
 
 	mutex_lock(&rbd_dev->watch_mutex);
-	if (rbd_dev->watch_state != RBD_WATCH_STATE_ERROR)
-		goto fail_unlock;
+	if (rbd_dev->watch_state != RBD_WATCH_STATE_ERROR) {
+		mutex_unlock(&rbd_dev->watch_mutex);
+		goto out;
+	}
 
 	ret = __rbd_register_watch(rbd_dev);
 	if (ret) {
 		rbd_warn(rbd_dev, "failed to reregister watch: %d", ret);
-		if (ret != -EBLACKLISTED)
+		if (ret == -EBLACKLISTED) {
+			set_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags);
+			need_to_wake = true;
+		} else {
 			queue_delayed_work(rbd_dev->task_wq,
 					   &rbd_dev->watch_dwork,
 					   RBD_RETRY_DELAY);
-		goto fail_unlock;
+		}
+		mutex_unlock(&rbd_dev->watch_mutex);
+		goto out;
 	}
 
+	need_to_wake = true;
 	rbd_dev->watch_state = RBD_WATCH_STATE_REGISTERED;
 	rbd_dev->watch_cookie = rbd_dev->watch_handle->linger_id;
 	mutex_unlock(&rbd_dev->watch_mutex);
@@ -3963,13 +3972,10 @@ static void rbd_reregister_watch(struct work_struct *work)
 				 ret);
 	}
 
+out:
 	up_write(&rbd_dev->lock_rwsem);
-	wake_requests(rbd_dev, true);
-	return;
-
-fail_unlock:
-	mutex_unlock(&rbd_dev->watch_mutex);
-	up_write(&rbd_dev->lock_rwsem);
+	if (need_to_wake)
+		wake_requests(rbd_dev, true);
 }
 
 /*
@@ -4074,7 +4080,9 @@ static void rbd_wait_state_locked(struct rbd_device *rbd_dev)
 		up_read(&rbd_dev->lock_rwsem);
 		schedule();
 		down_read(&rbd_dev->lock_rwsem);
-	} while (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED);
+	} while (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED &&
+		 !test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags));
+
 	finish_wait(&rbd_dev->lock_waitq, &wait);
 }
 
@@ -4166,8 +4174,16 @@ static void rbd_queue_workfn(struct work_struct *work)
 
 	if (must_be_locked) {
 		down_read(&rbd_dev->lock_rwsem);
-		if (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED)
+		if (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED &&
+		    !test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags))
 			rbd_wait_state_locked(rbd_dev);
+
+		WARN_ON((rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED) ^
+			!test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags));
+		if (test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags)) {
+			result = -EBLACKLISTED;
+			goto err_unlock;
+		}
 	}
 
 	img_request = rbd_img_request_create(rbd_dev, offset, length, op_type,
-- 
2.4.3

