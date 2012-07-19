From: Alex Elder <elder@inktank.com>
Subject: [PATCH 10/12] rbd: make rbd_create_rw_ops() return a pointer
Date: Thu, 19 Jul 2012 16:08:59 -0500
Message-ID: <5008776B.7030500@inktank.com>
References: <500874F5.4090205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52993 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab2GSVJC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jul 2012 17:09:02 -0400
Received: by mail-yw0-f46.google.com with SMTP id m54so3293293yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jul 2012 14:09:02 -0700 (PDT)
In-Reply-To: <500874F5.4090205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Either rbd_create_rw_ops() will succeed, or it will fail because a
memory allocation failed.  Have it just return a valid pointer or
null rather than stuffing a pointer into a provided address and
returning an errno.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   68
++++++++++++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 79b0762..0535612 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -783,22 +783,24 @@ err_out:
 /*
  * helpers for osd request op vectors.
  */
-static int rbd_create_rw_ops(struct ceph_osd_req_op **ops,
-			    int num_ops,
-			    int opcode,
-			    u32 payload_len)
-{
-	*ops = kzalloc(sizeof(struct ceph_osd_req_op) * (num_ops + 1),
-		       GFP_NOIO);
-	if (!*ops)
-		return -ENOMEM;
-	(*ops)[0].op = opcode;
+static struct ceph_osd_req_op *rbd_create_rw_ops(int num_ops,
+					int opcode, u32 payload_len)
+{
+	struct ceph_osd_req_op *ops;
+
+	ops = kzalloc(sizeof (*ops) * (num_ops + 1), GFP_NOIO);
+	if (!ops)
+		return NULL;
+
+	ops[0].op = opcode;
+
 	/*
 	 * op extent offset and length will be set later on
 	 * in calc_raw_layout()
 	 */
-	(*ops)[0].payload_len = payload_len;
-	return 0;
+	ops[0].payload_len = payload_len;
+
+	return ops;
 }

 static void rbd_destroy_ops(struct ceph_osd_req_op *ops)
@@ -1033,8 +1035,9 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,

 	if (!orig_ops) {
 		payload_len = (flags & CEPH_OSD_FLAG_WRITE ? len : 0);
-		ret = rbd_create_rw_ops(&ops, 1, opcode, payload_len);
-		if (ret < 0)
+		ret = -ENOMEM;
+		ops = rbd_create_rw_ops(1, opcode, payload_len);
+		if (!ops)
 			goto done;

 		if ((flags & CEPH_OSD_FLAG_WRITE) && buf) {
@@ -1097,8 +1100,9 @@ static int rbd_do_op(struct request *rq,

 	payload_len = (flags & CEPH_OSD_FLAG_WRITE ? seg_len : 0);

-	ret = rbd_create_rw_ops(&ops, 1, opcode, payload_len);
-	if (ret < 0)
+	ret = -ENOMEM;
+	ops = rbd_create_rw_ops(1, opcode, payload_len);
+	if (!ops)
 		goto done;

 	/* we've taken care of segment sizes earlier when we
@@ -1185,9 +1189,9 @@ static int rbd_req_sync_notify_ack(struct
rbd_device *rbd_dev,
 	struct ceph_osd_req_op *ops;
 	int ret;

-	ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_NOTIFY_ACK, 0);
-	if (ret < 0)
-		return ret;
+	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_NOTIFY_ACK, 0);
+	if (!ops)
+		return -ENOMEM;

 	ops[0].watch.ver = cpu_to_le64(ver);
 	ops[0].watch.cookie = notify_id;
@@ -1236,10 +1240,11 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev,
 {
 	struct ceph_osd_req_op *ops;
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
+	int ret;

-	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_WATCH, 0);
-	if (ret < 0)
-		return ret;
+	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_WATCH, 0);
+	if (!ops)
+		return -ENOMEM;

 	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0,
 				     (void *)rbd_dev, &rbd_dev->watch_event);
@@ -1279,10 +1284,11 @@ static int rbd_req_sync_unwatch(struct
rbd_device *rbd_dev,
 				const char *object_name)
 {
 	struct ceph_osd_req_op *ops;
+	int ret;

-	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_WATCH, 0);
-	if (ret < 0)
-		return ret;
+	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_WATCH, 0);
+	if (!ops)
+		return -ENOMEM;

 	ops[0].watch.ver = 0;
 	ops[0].watch.cookie = cpu_to_le64(rbd_dev->watch_event->cookie);
@@ -1328,9 +1334,9 @@ static int rbd_req_sync_notify(struct rbd_device
*rbd_dev,
 	int payload_len = sizeof(u32) + sizeof(u32);
 	int ret;

-	ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_NOTIFY, payload_len);
-	if (ret < 0)
-		return ret;
+	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_NOTIFY, payload_len);
+	if (!ops)
+		return -ENOMEM;

 	info.rbd_dev = rbd_dev;

@@ -1379,10 +1385,12 @@ static int rbd_req_sync_exec(struct rbd_device
*rbd_dev,
 	struct ceph_osd_req_op *ops;
 	int class_name_len = strlen(class_name);
 	int method_name_len = strlen(method_name);
-	int ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_CALL,
+	int ret;
+
+	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_CALL,
 				    class_name_len + method_name_len + len);
-	if (ret < 0)
-		return ret;
+	if (!ops)
+		return -ENOMEM;

 	ops[0].cls.class_name = class_name;
 	ops[0].cls.class_len = (__u8) class_name_len;
-- 
1.7.5.4

