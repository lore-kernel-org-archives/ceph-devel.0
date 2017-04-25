From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5/9] rbd: store lock cookie
Date: Tue, 25 Apr 2017 11:33:41 +0200
Message-ID: <1493112825-16403-6-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35668 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428700AbdDYJeR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:17 -0400
Received: by mail-qt0-f196.google.com with SMTP id o36so24161571qtb.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:16 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.15
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:15 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In preparation for supporting set_cookie method (or rather set_cookie
fallback for older OSDs), store the lock cookie on lock and use it on
unlock instead of recalculating from rbd_dev->watch_cookie.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4b72286c4be6..ed8a3d0eee3b 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -387,6 +387,7 @@ struct rbd_device {
 
 	struct rw_semaphore	lock_rwsem;
 	enum rbd_lock_state	lock_state;
+	char			lock_cookie[32];
 	struct rbd_client_id	owner_cid;
 	struct work_struct	acquired_lock_work;
 	struct work_struct	released_lock_work;
@@ -3079,7 +3080,8 @@ static int rbd_lock(struct rbd_device *rbd_dev)
 	char cookie[32];
 	int ret;
 
-	WARN_ON(__rbd_is_lock_owner(rbd_dev));
+	WARN_ON(__rbd_is_lock_owner(rbd_dev) ||
+		rbd_dev->lock_cookie[0] != '\0');
 
 	format_lock_cookie(rbd_dev, cookie);
 	ret = ceph_cls_lock(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
@@ -3089,6 +3091,7 @@ static int rbd_lock(struct rbd_device *rbd_dev)
 		return ret;
 
 	rbd_dev->lock_state = RBD_LOCK_STATE_LOCKED;
+	strcpy(rbd_dev->lock_cookie, cookie);
 	rbd_set_owner_cid(rbd_dev, &cid);
 	queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
 	return 0;
@@ -3100,19 +3103,19 @@ static int rbd_lock(struct rbd_device *rbd_dev)
 static void rbd_unlock(struct rbd_device *rbd_dev)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	char cookie[32];
 	int ret;
 
-	WARN_ON(!__rbd_is_lock_owner(rbd_dev));
+	WARN_ON(!__rbd_is_lock_owner(rbd_dev) ||
+		rbd_dev->lock_cookie[0] == '\0');
 
-	format_lock_cookie(rbd_dev, cookie);
 	ret = ceph_cls_unlock(osdc, &rbd_dev->header_oid, &rbd_dev->header_oloc,
-			      RBD_LOCK_NAME, cookie);
+			      RBD_LOCK_NAME, rbd_dev->lock_cookie);
 	if (ret && ret != -ENOENT)
 		rbd_warn(rbd_dev, "failed to unlock: %d", ret);
 
 	/* treat errors as the image is unlocked */
 	rbd_dev->lock_state = RBD_LOCK_STATE_UNLOCKED;
+	rbd_dev->lock_cookie[0] = '\0';
 	rbd_set_owner_cid(rbd_dev, &rbd_empty_cid);
 	queue_work(rbd_dev->task_wq, &rbd_dev->released_lock_work);
 }
-- 
2.4.3

