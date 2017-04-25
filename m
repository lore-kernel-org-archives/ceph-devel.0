From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 7/9] rbd: kill rbd_is_lock_supported()
Date: Tue, 25 Apr 2017 11:33:43 +0200
Message-ID: <1493112825-16403-8-git-send-email-idryomov@gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36665 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428702AbdDYJeT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Apr 2017 05:34:19 -0400
Received: by mail-qk0-f193.google.com with SMTP id y63so15639407qkd.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Apr 2017 02:34:18 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w6sm7461396qta.50.2017.04.25.02.34.17
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:34:17 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently the exclusive lock is acquired only if the mapping is
writable, i.e. an image HEAD mapped in rw mode.  This means that we
don't acquire the lock for executing a read from a snapshot or an image
HEAD mapped in ro mode, even if lock_on_read is set.  This is somewhat
weird and inconsistent with "no automatic exclusive lock transfers"
mode, where the lock is acquired unconditionally.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b859ce00ee1e..bcc43fb8a9b3 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -478,13 +478,6 @@ static int minor_to_rbd_dev_id(int minor)
 	return minor >> RBD_SINGLE_MAJOR_PART_SHIFT;
 }
 
-static bool rbd_is_lock_supported(struct rbd_device *rbd_dev)
-{
-	return (rbd_dev->header.features & RBD_FEATURE_EXCLUSIVE_LOCK) &&
-	       rbd_dev->spec->snap_id == CEPH_NOSNAP &&
-	       !rbd_dev->mapping.read_only;
-}
-
 static bool __rbd_is_lock_owner(struct rbd_device *rbd_dev)
 {
 	return rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED ||
@@ -4052,10 +4045,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 	if (op_type != OBJ_OP_READ) {
 		snapc = rbd_dev->header.snapc;
 		ceph_get_snap_context(snapc);
-		must_be_locked = rbd_is_lock_supported(rbd_dev);
-	} else {
-		must_be_locked = rbd_dev->opts->lock_on_read &&
-					rbd_is_lock_supported(rbd_dev);
 	}
 	up_read(&rbd_dev->header_rwsem);
 
@@ -4066,6 +4055,9 @@ static void rbd_queue_workfn(struct work_struct *work)
 		goto err_rq;
 	}
 
+	must_be_locked =
+	    (rbd_dev->header.features & RBD_FEATURE_EXCLUSIVE_LOCK) &&
+	    (op_type != OBJ_OP_READ || rbd_dev->opts->lock_on_read);
 	if (must_be_locked) {
 		down_read(&rbd_dev->lock_rwsem);
 		if (rbd_dev->lock_state != RBD_LOCK_STATE_LOCKED &&
-- 
2.4.3

