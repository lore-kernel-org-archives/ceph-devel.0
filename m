From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: lock_on_read map option
Date: Thu, 22 Sep 2016 16:22:57 +0200
Message-ID: <1474554177-4029-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33758 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756833AbcIVOXY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 10:23:24 -0400
Received: by mail-yw0-f194.google.com with SMTP id g192so4797663ywh.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 07:23:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Mike Christie <mchristi@redhat.com>

Add a per-device option to acquire exclusive lock on reads (in addition
to writes and discards).  The use case is iSCSI, where it will be used
to prevent execution of stale writes after the implicit failover.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index d305b9ebe2cf..eca04b6dc747 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -795,6 +795,7 @@ enum {
 	/* string args above */
 	Opt_read_only,
 	Opt_read_write,
+	Opt_lock_on_read,
 	Opt_err
 };
 
@@ -806,16 +807,19 @@ static match_table_t rbd_opts_tokens = {
 	{Opt_read_only, "ro"},		/* Alternate spelling */
 	{Opt_read_write, "read_write"},
 	{Opt_read_write, "rw"},		/* Alternate spelling */
+	{Opt_lock_on_read, "lock_on_read"},
 	{Opt_err, NULL}
 };
 
 struct rbd_options {
 	int	queue_depth;
 	bool	read_only;
+	bool	lock_on_read;
 };
 
 #define RBD_QUEUE_DEPTH_DEFAULT	BLKDEV_MAX_RQ
 #define RBD_READ_ONLY_DEFAULT	false
+#define RBD_LOCK_ON_READ_DEFAULT false
 
 static int parse_rbd_opts_token(char *c, void *private)
 {
@@ -851,6 +855,9 @@ static int parse_rbd_opts_token(char *c, void *private)
 	case Opt_read_write:
 		rbd_opts->read_only = false;
 		break;
+	case Opt_lock_on_read:
+		rbd_opts->lock_on_read = true;
+		break;
 	default:
 		/* libceph prints "bad option" msg */
 		return -EINVAL;
@@ -4073,7 +4080,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 	u64 length = blk_rq_bytes(rq);
 	enum obj_operation_type op_type;
 	u64 mapping_size;
-	bool must_be_locked = false;
+	bool must_be_locked;
 	int result;
 
 	if (rq->cmd_type != REQ_TYPE_FS) {
@@ -4136,6 +4143,9 @@ static void rbd_queue_workfn(struct work_struct *work)
 		snapc = rbd_dev->header.snapc;
 		ceph_get_snap_context(snapc);
 		must_be_locked = rbd_is_lock_supported(rbd_dev);
+	} else {
+		must_be_locked = rbd_dev->opts->lock_on_read &&
+					rbd_is_lock_supported(rbd_dev);
 	}
 	up_read(&rbd_dev->header_rwsem);
 
@@ -5721,6 +5731,7 @@ static int rbd_add_parse_args(const char *buf,
 
 	rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
 	rbd_opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
+	rbd_opts->lock_on_read = RBD_LOCK_ON_READ_DEFAULT;
 
 	copts = ceph_parse_options(options, mon_addrs,
 					mon_addrs + mon_addrs_size - 1,
-- 
2.4.3

