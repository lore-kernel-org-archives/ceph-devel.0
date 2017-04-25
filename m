From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 9/9] rbd: exclusive map option
Date: Tue, 25 Apr 2017 11:33:45 +0200
Message-ID: <1493112825-16403-10-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33765 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428704AbdDYJeU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:20 -0400
Received: by mail-qk0-f193.google.com with SMTP id o85so13955916qkh.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:20 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.18
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:19 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Support disabling automatic exclusive lock transfers to allow users
to be in charge of which node should own the lock while being able to
reuse exclusive lock's built-in blacklist/break-lock functionality.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 10 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 9bb4293e05e0..f62f40ce0687 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -798,6 +798,7 @@ enum {
 	Opt_read_only,
 	Opt_read_write,
 	Opt_lock_on_read,
+	Opt_exclusive,
 	Opt_err
 };
 
@@ -810,6 +811,7 @@ static match_table_t rbd_opts_tokens = {
 	{Opt_read_write, "read_write"},
 	{Opt_read_write, "rw"},		/* Alternate spelling */
 	{Opt_lock_on_read, "lock_on_read"},
+	{Opt_exclusive, "exclusive"},
 	{Opt_err, NULL}
 };
 
@@ -817,11 +819,13 @@ struct rbd_options {
 	int	queue_depth;
 	bool	read_only;
 	bool	lock_on_read;
+	bool	exclusive;
 };
 
 #define RBD_QUEUE_DEPTH_DEFAULT	BLKDEV_MAX_RQ
 #define RBD_READ_ONLY_DEFAULT	false
 #define RBD_LOCK_ON_READ_DEFAULT false
+#define RBD_EXCLUSIVE_DEFAULT	false
 
 static int parse_rbd_opts_token(char *c, void *private)
 {
@@ -860,6 +864,9 @@ static int parse_rbd_opts_token(char *c, void *private)
 	case Opt_lock_on_read:
 		rbd_opts->lock_on_read = true;
 		break;
+	case Opt_exclusive:
+		rbd_opts->exclusive = true;
+		break;
 	default:
 		/* libceph prints "bad option" msg */
 		return -EINVAL;
@@ -3440,6 +3447,18 @@ static void rbd_acquire_lock(struct work_struct *work)
 	ret = rbd_request_lock(rbd_dev);
 	if (ret == -ETIMEDOUT) {
 		goto again; /* treat this as a dead client */
+	} else if (ret == -EROFS) {
+		rbd_warn(rbd_dev, "peer will not release lock");
+		/*
+		 * If this is rbd_add_acquire_lock(), we want to fail
+		 * immediately -- reuse BLACKLISTED flag.  Otherwise we
+		 * want to block.
+		 */
+		if (!(rbd_dev->disk->flags & GENHD_FL_UP)) {
+			set_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags);
+			/* wake "rbd map --exclusive" process */
+			wake_requests(rbd_dev, false);
+		}
 	} else if (ret < 0) {
 		rbd_warn(rbd_dev, "error requesting lock: %d", ret);
 		mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork,
@@ -3606,9 +3625,15 @@ static int rbd_handle_request_lock(struct rbd_device *rbd_dev, u8 struct_v,
 		result = 0;
 
 		if (rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED) {
-			dout("%s rbd_dev %p queueing unlock_work\n", __func__,
-			     rbd_dev);
-			queue_work(rbd_dev->task_wq, &rbd_dev->unlock_work);
+			if (!rbd_dev->opts->exclusive) {
+				dout("%s rbd_dev %p queueing unlock_work\n",
+				     __func__, rbd_dev);
+				queue_work(rbd_dev->task_wq,
+					   &rbd_dev->unlock_work);
+			} else {
+				/* refuse to release the lock */
+				result = -EROFS;
+			}
 		}
 	}
 
@@ -4073,8 +4098,14 @@ static void rbd_queue_workfn(struct work_struct *work)
 	if (must_be_locked) {
 		down_read(&rbd_dev->lock_rwsem);
 		if (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED &&
-		    !test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags))
+		    !test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags)) {
+			if (rbd_dev->opts->exclusive) {
+				rbd_warn(rbd_dev, "exclusive lock required");
+				result = -EROFS;
+				goto err_unlock;
+			}
 			rbd_wait_state_locked(rbd_dev);
+		}
 		if (test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags)) {
 			result = -EBLACKLISTED;
 			goto err_unlock;
@@ -5640,6 +5671,7 @@ static int rbd_add_parse_args(const char *buf,
 	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
 	rbd_opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
 	rbd_opts->lock_on_read = RBD_LOCK_ON_READ_DEFAULT;
+	rbd_opts->exclusive = RBD_EXCLUSIVE_DEFAULT;
 
 	copts = ceph_parse_options(options, mon_addrs,
 					mon_addrs + mon_addrs_size - 1,
@@ -5698,6 +5730,33 @@ static int rbd_add_get_pool_id(struct rbd_client *rbdc, const char *pool_name)
 	return ret;
 }
 
+static void rbd_dev_image_unlock(struct rbd_device *rbd_dev)
+{
+	down_write(&rbd_dev->lock_rwsem);
+	if (__rbd_is_lock_owner(rbd_dev))
+		rbd_unlock(rbd_dev);
+	up_write(&rbd_dev->lock_rwsem);
+}
+
+static int rbd_add_acquire_lock(struct rbd_device *rbd_dev)
+{
+	if (!(rbd_dev->header.features & RBD_FEATURE_EXCLUSIVE_LOCK)) {
+		rbd_warn(rbd_dev, "exclusive-lock feature is not enabled");
+		return -EINVAL;
+	}
+
+	/* FIXME: "rbd map --exclusive" should be in interruptible */
+	down_read(&rbd_dev->lock_rwsem);
+	rbd_wait_state_locked(rbd_dev);
+	up_read(&rbd_dev->lock_rwsem);
+	if (test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags)) {
+		rbd_warn(rbd_dev, "failed to acquire exclusive lock");
+		return -EROFS;
+	}
+
+	return 0;
+}
+
 /*
  * An rbd format 2 image has a unique identifier, distinct from the
  * name given to it by the user.  Internally, that identifier is
@@ -6141,11 +6200,17 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	if (rc)
 		goto err_out_image_probe;
 
+	if (rbd_dev->opts->exclusive) {
+		rc = rbd_add_acquire_lock(rbd_dev);
+		if (rc)
+			goto err_out_device_setup;
+	}
+
 	/* Everything's ready.  Announce the disk to the world. */
 
 	rc = device_add(&rbd_dev->dev);
 	if (rc)
-		goto err_out_device_setup;
+		goto err_out_image_lock;
 
 	add_disk(rbd_dev->disk);
 	/* see rbd_init_disk() */
@@ -6163,6 +6228,8 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	module_put(THIS_MODULE);
 	return rc;
 
+err_out_image_lock:
+	rbd_dev_image_unlock(rbd_dev);
 err_out_device_setup:
 	rbd_dev_device_release(rbd_dev);
 err_out_image_probe:
@@ -6286,11 +6353,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	spin_unlock(&rbd_dev_list_lock);
 	device_del(&rbd_dev->dev);
 
-	down_write(&rbd_dev->lock_rwsem);
-	if (__rbd_is_lock_owner(rbd_dev))
-		rbd_unlock(rbd_dev);
-	up_write(&rbd_dev->lock_rwsem);
-
+	rbd_dev_image_unlock(rbd_dev);
 	rbd_dev_device_release(rbd_dev);
 	rbd_dev_image_release(rbd_dev);
 	rbd_dev_destroy(rbd_dev);
-- 
2.4.3

