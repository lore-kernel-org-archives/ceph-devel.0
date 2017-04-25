From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6/9] rbd: support updating the lock cookie without releasing the lock
Date: Tue, 25 Apr 2017 11:33:42 +0200
Message-ID: <1493112825-16403-7-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36504 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428701AbdDYJeS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id t52so24174398qtb.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:17 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.16
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:16 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

As we no longer release the lock before potentially raising BLACKLISTED
in rbd_reregister_watch(), the "either locked or blacklisted" assert in
rbd_queue_workfn() needs to go: we can be both locked and blacklisted
at that point now.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c                  | 66 ++++++++++++++++++++++--------------
 include/linux/ceph/cls_lock_client.h |  5 +++
 net/ceph/cls_lock_client.c           | 51 ++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ed8a3d0eee3b..b859ce00ee1e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3820,24 +3820,51 @@ static void rbd_unregister_watch(struct rbd_device *rbd_dev)
 	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
 }
 
+/*
+ * lock_rwsem must be held for write
+ */
+static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
+{
+	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	char cookie[32];
+	int ret;
+
+	WARN_ON(rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED);
+
+	format_lock_cookie(rbd_dev, cookie);
+	ret = ceph_cls_set_cookie(osdc, &rbd_dev->header_oid,
+				  &rbd_dev->header_oloc, RBD_LOCK_NAME,
+				  CEPH_CLS_LOCK_EXCLUSIVE, rbd_dev->lock_cookie,
+				  RBD_LOCK_TAG, cookie);
+	if (ret) {
+		if (ret != -EOPNOTSUPP)
+			rbd_warn(rbd_dev, "failed to update lock cookie: %d",
+				 ret);
+
+		/*
+		 * Lock cookie cannot be updated on older OSDs, so do
+		 * a manual release and queue an acquire.
+		 */
+		if (rbd_release_lock(rbd_dev))
+			queue_delayed_work(rbd_dev->task_wq,
+					   &rbd_dev->lock_dwork, 0);
+	} else {
+		strcpy(rbd_dev->lock_cookie, cookie);
+	}
+}
+
 static void rbd_reregister_watch(struct work_struct *work)
 {
 	struct rbd_device *rbd_dev = container_of(to_delayed_work(work),
 					    struct rbd_device, watch_dwork);
-	bool was_lock_owner = false;
-	bool need_to_wake = false;
 	int ret;
 
 	dout("%s rbd_dev %p\n", __func__, rbd_dev);
 
-	down_write(&rbd_dev->lock_rwsem);
-	if (rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED)
-		was_lock_owner = rbd_release_lock(rbd_dev);
-
 	mutex_lock(&rbd_dev->watch_mutex);
 	if (rbd_dev->watch_state != RBD_WATCH_STATE_ERROR) {
 		mutex_unlock(&rbd_dev->watch_mutex);
-		goto out;
+		return;
 	}
 
 	ret = __rbd_register_watch(rbd_dev);
@@ -3845,36 +3872,28 @@ static void rbd_reregister_watch(struct work_struct *work)
 		rbd_warn(rbd_dev, "failed to reregister watch: %d", ret);
 		if (ret == -EBLACKLISTED || ret == -ENOENT) {
 			set_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags);
-			need_to_wake = true;
+			wake_requests(rbd_dev, true);
 		} else {
 			queue_delayed_work(rbd_dev->task_wq,
 					   &rbd_dev->watch_dwork,
 					   RBD_RETRY_DELAY);
 		}
 		mutex_unlock(&rbd_dev->watch_mutex);
-		goto out;
+		return;
 	}
 
-	need_to_wake = true;
 	rbd_dev->watch_state = RBD_WATCH_STATE_REGISTERED;
 	rbd_dev->watch_cookie = rbd_dev->watch_handle->linger_id;
 	mutex_unlock(&rbd_dev->watch_mutex);
 
+	down_write(&rbd_dev->lock_rwsem);
+	if (rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED)
+		rbd_reacquire_lock(rbd_dev);
+	up_write(&rbd_dev->lock_rwsem);
+
 	ret = rbd_dev_refresh(rbd_dev);
 	if (ret)
 		rbd_warn(rbd_dev, "reregisteration refresh failed: %d", ret);
-
-	if (was_lock_owner) {
-		ret = rbd_try_lock(rbd_dev);
-		if (ret)
-			rbd_warn(rbd_dev, "reregisteration lock failed: %d",
-				 ret);
-	}
-
-out:
-	up_write(&rbd_dev->lock_rwsem);
-	if (need_to_wake)
-		wake_requests(rbd_dev, true);
 }
 
 /*
@@ -4052,9 +4071,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 		if (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED &&
 		    !test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags))
 			rbd_wait_state_locked(rbd_dev);
-
-		WARN_ON((rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED) ^
-			!test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags));
 		if (test_bit(RBD_DEV_FLAG_BLACKLISTED, &rbd_dev->flags)) {
 			result = -EBLACKLISTED;
 			goto err_unlock;
diff --git a/include/linux/ceph/cls_lock_client.h b/include/linux/ceph/cls_lock_client.h
index 84884d8d4710..0594d3bba774 100644
--- a/include/linux/ceph/cls_lock_client.h
+++ b/include/linux/ceph/cls_lock_client.h
@@ -37,6 +37,11 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 			struct ceph_object_locator *oloc,
 			char *lock_name, char *cookie,
 			struct ceph_entity_name *locker);
+int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
+			struct ceph_object_id *oid,
+			struct ceph_object_locator *oloc,
+			char *lock_name, u8 type, char *old_cookie,
+			char *tag, char *new_cookie);
 
 void ceph_free_lockers(struct ceph_locker *lockers, u32 num_lockers);
 
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index b9233b990399..08ada893f01e 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -179,6 +179,57 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 }
 EXPORT_SYMBOL(ceph_cls_break_lock);
 
+int ceph_cls_set_cookie(struct ceph_osd_client *osdc,
+			struct ceph_object_id *oid,
+			struct ceph_object_locator *oloc,
+			char *lock_name, u8 type, char *old_cookie,
+			char *tag, char *new_cookie)
+{
+	int cookie_op_buf_size;
+	int name_len = strlen(lock_name);
+	int old_cookie_len = strlen(old_cookie);
+	int tag_len = strlen(tag);
+	int new_cookie_len = strlen(new_cookie);
+	void *p, *end;
+	struct page *cookie_op_page;
+	int ret;
+
+	cookie_op_buf_size = name_len + sizeof(__le32) +
+			     old_cookie_len + sizeof(__le32) +
+			     tag_len + sizeof(__le32) +
+			     new_cookie_len + sizeof(__le32) +
+			     sizeof(u8) + CEPH_ENCODING_START_BLK_LEN;
+	if (cookie_op_buf_size > PAGE_SIZE)
+		return -E2BIG;
+
+	cookie_op_page = alloc_page(GFP_NOIO);
+	if (!cookie_op_page)
+		return -ENOMEM;
+
+	p = page_address(cookie_op_page);
+	end = p + cookie_op_buf_size;
+
+	/* encode cls_lock_set_cookie_op struct */
+	ceph_start_encoding(&p, 1, 1,
+			    cookie_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_8(&p, type);
+	ceph_encode_string(&p, end, old_cookie, old_cookie_len);
+	ceph_encode_string(&p, end, tag, tag_len);
+	ceph_encode_string(&p, end, new_cookie, new_cookie_len);
+
+	dout("%s lock_name %s type %d old_cookie %s tag %s new_cookie %s\n",
+	     __func__, lock_name, type, old_cookie, tag, new_cookie);
+	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "set_cookie",
+			     CEPH_OSD_FLAG_WRITE, cookie_op_page,
+			     cookie_op_buf_size, NULL, NULL);
+
+	dout("%s: status %d\n", __func__, ret);
+	__free_page(cookie_op_page);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_cls_set_cookie);
+
 void ceph_free_lockers(struct ceph_locker *lockers, u32 num_lockers)
 {
 	int i;
-- 
2.4.3

