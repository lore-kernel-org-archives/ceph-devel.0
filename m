From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 8/9] rbd: return ResponseMessage result from rbd_handle_request_lock()
Date: Tue, 25 Apr 2017 11:33:44 +0200
Message-ID: <1493112825-16403-9-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35716 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428703AbdDYJeT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:19 -0400
Received: by mail-qk0-f196.google.com with SMTP id a19so6834488qkg.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:19 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.18
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:18 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Right now it's just 0, but "no automatic exclusive lock transfers" mode
code will need -EROFS.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bcc43fb8a9b3..9bb4293e05e0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3572,12 +3572,16 @@ static void rbd_handle_released_lock(struct rbd_device *rbd_dev, u8 struct_v,
 	up_read(&rbd_dev->lock_rwsem);
 }
 
-static bool rbd_handle_request_lock(struct rbd_device *rbd_dev, u8 struct_v,
-				    void **p)
+/*
+ * Returns result for ResponseMessage to be encoded (<= 0), or 1 if no
+ * ResponseMessage is needed.
+ */
+static int rbd_handle_request_lock(struct rbd_device *rbd_dev, u8 struct_v,
+				   void **p)
 {
 	struct rbd_client_id my_cid = rbd_get_cid(rbd_dev);
 	struct rbd_client_id cid = { 0 };
-	bool need_to_send;
+	int result = 1;
 
 	if (struct_v >= 2) {
 		cid.gid = ceph_decode_64(p);
@@ -3587,19 +3591,30 @@ static bool rbd_handle_request_lock(struct rbd_device *rbd_dev, u8 struct_v,
 	dout("%s rbd_dev %p cid %llu-%llu\n", __func__, rbd_dev, cid.gid,
 	     cid.handle);
 	if (rbd_cid_equal(&cid, &my_cid))
-		return false;
+		return result;
 
 	down_read(&rbd_dev->lock_rwsem);
-	need_to_send = __rbd_is_lock_owner(rbd_dev);
-	if (rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED) {
-		if (!rbd_cid_equal(&rbd_dev->owner_cid, &rbd_empty_cid)) {
+	if (__rbd_is_lock_owner(rbd_dev)) {
+		if (rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED &&
+		    rbd_cid_equal(&rbd_dev->owner_cid, &rbd_empty_cid))
+			goto out_unlock;
+
+		/*
+		 * encode ResponseMessage(0) so the peer can detect
+		 * a missing owner
+		 */
+		result = 0;
+
+		if (rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED) {
 			dout("%s rbd_dev %p queueing unlock_work\n", __func__,
 			     rbd_dev);
 			queue_work(rbd_dev->task_wq, &rbd_dev->unlock_work);
 		}
 	}
+
+out_unlock:
 	up_read(&rbd_dev->lock_rwsem);
-	return need_to_send;
+	return result;
 }
 
 static void __rbd_acknowledge_notify(struct rbd_device *rbd_dev,
@@ -3682,13 +3697,10 @@ static void rbd_watch_cb(void *arg, u64 notify_id, u64 cookie,
 		rbd_acknowledge_notify(rbd_dev, notify_id, cookie);
 		break;
 	case RBD_NOTIFY_OP_REQUEST_LOCK:
-		if (rbd_handle_request_lock(rbd_dev, struct_v, &p))
-			/*
-			 * send ResponseMessage(0) back so the client
-			 * can detect a missing owner
-			 */
+		ret = rbd_handle_request_lock(rbd_dev, struct_v, &p);
+		if (ret <= 0)
 			rbd_acknowledge_notify_result(rbd_dev, notify_id,
-						      cookie, 0);
+						      cookie, ret);
 		else
 			rbd_acknowledge_notify(rbd_dev, notify_id, cookie);
 		break;
-- 
2.4.3

