From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/7] rbd: make rbd_create_rw_ops() return a pointer
Date: Thu, 26 Jul 2012 14:08:34 -0500
Message-ID: <501195B2.1050503@inktank.com>
References: <50119421.1090702@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:35462 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab2GZTIg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jul 2012 15:08:36 -0400
Received: by yhmm54 with SMTP id m54so2351893yhm.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jul 2012 12:08:36 -0700 (PDT)
In-Reply-To: <50119421.1090702@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Either rbd_create_rw_ops() will succeed, or it will fail because a
memory allocation failed.  Have it just return a valid pointer or
null rather than stuffing a pointer into a provided address and
returning an errno.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   70
++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fd91964..4d8b52c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -789,22 +789,24 @@ err_out:
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
@@ -1039,8 +1041,9 @@ static int rbd_req_sync_op(struct rbd_device *rbd_dev,

 	if (!orig_ops) {
 		payload_len = (flags & CEPH_OSD_FLAG_WRITE ? len : 0);
-		ret = rbd_create_rw_ops(&ops, 1, opcode, payload_len);
-		if (ret < 0)
+		ret = -ENOMEM;
+		ops = rbd_create_rw_ops(1, opcode, payload_len);
+		if (!ops)
 			goto done;

 		if ((flags & CEPH_OSD_FLAG_WRITE) && buf) {
@@ -1103,8 +1106,9 @@ static int rbd_do_op(struct request *rq,

 	payload_len = (flags & CEPH_OSD_FLAG_WRITE ? seg_len : 0);

-	ret = rbd_create_rw_ops(&ops, 1, opcode, payload_len);
-	if (ret < 0)
+	ret = -ENOMEM;
+	ops = rbd_create_rw_ops(1, opcode, payload_len);
+	if (!ops)
 		goto done;

 	/* we've taken care of segment sizes earlier when we
@@ -1190,9 +1194,9 @@ static int rbd_req_sync_notify_ack(struct
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
@@ -1239,10 +1243,11 @@ static int rbd_req_sync_watch(struct rbd_device
*rbd_dev)
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
@@ -1282,10 +1287,11 @@ fail:
 static int rbd_req_sync_unwatch(struct rbd_device *rbd_dev)
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
@@ -1332,9 +1338,9 @@ static int rbd_req_sync_notify(struct rbd_device
*rbd_dev)
 	int payload_len = sizeof(u32) + sizeof(u32);
 	int ret;

-	ret = rbd_create_rw_ops(&ops, 1, CEPH_OSD_OP_NOTIFY, payload_len);
-	if (ret < 0)
-		return ret;
+	ops = rbd_create_rw_ops(1, CEPH_OSD_OP_NOTIFY, payload_len);
+	if (!ops)
+		return -ENOMEM;

 	info.rbd_dev = rbd_dev;

@@ -1385,10 +1391,12 @@ static int rbd_req_sync_exec(struct rbd_device
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
1.7.9.5

