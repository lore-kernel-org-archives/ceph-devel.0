From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 3/5] rbd: export rbd_dev_[un]lock()
Date: Wed, 29 Jul 2015 03:15:50 +0200
Message-ID: <1438132552-14673-4-git-send-email-ddiss@suse.de>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35658 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbbG2BQA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 21:16:00 -0400
In-Reply-To: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>

To be used for COMPARE AND WRITE device locking.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/rbd.h      | 3 +++
 drivers/block/rbd_main.c | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.h b/drivers/block/rbd.h
index 60c6b85..1c6f947 100644
--- a/drivers/block/rbd.h
+++ b/drivers/block/rbd.h
@@ -24,6 +24,9 @@ extern int rbd_obj_notify_scsi_event_sync(struct rbd_device *rbd_dev, u32 event,
 extern int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id);
 extern int rbd_attach_tcm_dev(struct rbd_device *rbd_dev, void *data);
 extern int rbd_detach_tcm_dev(struct rbd_device *rbd_dev);
+extern int rbd_dev_lock(struct rbd_device *rbd_dev, char *name, u8 type,
+			char *cookie, char *tag, char *desc, u8 flags);
+extern int rbd_dev_unlock(struct rbd_device *rbd_dev, char *name, char *cookie);
 
 #if defined(CONFIG_TCM_IBLOCK) || defined(CONFIG_TCM_IBLOCK_MODULE)
 
diff --git a/drivers/block/rbd_main.c b/drivers/block/rbd_main.c
index 57e76ed..cb90c08 100644
--- a/drivers/block/rbd_main.c
+++ b/drivers/block/rbd_main.c
@@ -4134,11 +4134,11 @@ int rbd_attach_tcm_dev(struct rbd_device *rbd_dev, void *data)
  * @type: lock type (RADOS_LOCK_EXCLUSIVE or RADOS_LOCK_SHARED)
  * @cookie: user-defined identifier for this instance of the lock
  * @tag: if RADOS_LOCK_SHARED, tag of the lock. NULL if non shared.
- * desc: user-defined lock description
+ * @desc: user-defined lock description
  * @flags: lock flags
  */
-static int rbd_dev_lock(struct rbd_device *rbd_dev, char *name, u8 type,
-			char *cookie, char *tag, char *desc, u8 flags)
+int rbd_dev_lock(struct rbd_device *rbd_dev, char *name, u8 type,
+		 char *cookie, char *tag, char *desc, u8 flags)
 {
 	int lock_op_buf_size;
 	int name_len = strlen(name);
@@ -4194,7 +4194,7 @@ static int rbd_dev_lock(struct rbd_device *rbd_dev, char *name, u8 type,
  * @name: the name of the lock
  * @cookie: user-defined identifier for this instance of the lock
  */
-static int rbd_dev_unlock(struct rbd_device *rbd_dev, char *name, char *cookie)
+int rbd_dev_unlock(struct rbd_device *rbd_dev, char *name, char *cookie)
 {
 	int unlock_op_buf_size;
 	int name_len = strlen(name);
-- 
2.1.4

