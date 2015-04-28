From: mchristi@redhat.com
Subject: [PATCH 07/10] ceph/rbd: update watch-notify ceph_osd_op
Date: Tue, 28 Apr 2015 17:05:44 -0500
Message-ID: <1430258747-12506-8-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030990AbbD1WFy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:54 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5sll011233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:54 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbS013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:53 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This syncs the ceph_osd_op struct with the current version of ceph
where the watch struct has been updated to support more ops and
the notify-ack support has been broken out of the watch struct.

Ceph commits
1a82cc3926fc7bc4cfbdd2fd4dfee8660d5107a1
2288f318e1b1f6a1c42b185fc1b4c41f23995247
73720130c34424bf1fe36058ebe8da66976f40fb

It still has us use the legacy watch op for now. I will add support
later. It is mostly a prepartion patch for more advanced notify support.

Questions:

1. Should linger also be set for CEPH_OSD_WATCH_OP_RECONNECT?
2. Not sure what watch.gen is used for. Is that for our internal
use or does the osd do something with it.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c             | 19 +++++++++++--------
 include/linux/ceph/osd_client.h |  7 +++----
 include/linux/ceph/rados.h      | 15 +++++++++++++--
 net/ceph/osd_client.c           | 14 +++++++-------
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 8caf345..a70447c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3067,8 +3067,8 @@ static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
 	if (!obj_request->osd_req)
 		goto out;
 
-	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
-					notify_id, 0, 0);
+	osd_req_op_watch_init(obj_request->osd_req, 0,
+			      CEPH_OSD_OP_NOTIFY_ACK, 0, notify_id);
 	rbd_osd_req_format_read(obj_request);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
@@ -3116,7 +3116,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
  */
 static struct rbd_obj_request *rbd_obj_watch_request_helper(
 						struct rbd_device *rbd_dev,
-						bool watch)
+						u8 watch_opcode)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_obj_request *obj_request;
@@ -3135,10 +3135,11 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
 	}
 
 	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_WATCH,
-			      rbd_dev->watch_event->cookie, 0, watch);
+			      watch_opcode, rbd_dev->watch_event->cookie);
 	rbd_osd_req_format_write(obj_request);
 
-	if (watch)
+	if (watch_opcode == CEPH_OSD_WATCH_OP_LEGACY_WATCH ||
+	    watch_opcode == CEPH_OSD_WATCH_OP_WATCH)
 		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
@@ -3151,7 +3152,7 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
 
 	ret = obj_request->result;
 	if (ret) {
-		if (watch)
+		if (watch_opcode != CEPH_OSD_WATCH_OP_UNWATCH)
 			rbd_obj_request_end(obj_request);
 		goto out;
 	}
@@ -3180,7 +3181,8 @@ static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 	if (ret < 0)
 		return ret;
 
-	obj_request = rbd_obj_watch_request_helper(rbd_dev, true);
+	obj_request = rbd_obj_watch_request_helper(rbd_dev,
+						CEPH_OSD_WATCH_OP_LEGACY_WATCH);
 	if (IS_ERR(obj_request)) {
 		ceph_osdc_cancel_event(rbd_dev->watch_event);
 		rbd_dev->watch_event = NULL;
@@ -3214,7 +3216,8 @@ static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
 	rbd_obj_request_put(rbd_dev->watch_request);
 	rbd_dev->watch_request = NULL;
 
-	obj_request = rbd_obj_watch_request_helper(rbd_dev, false);
+	obj_request = rbd_obj_watch_request_helper(rbd_dev,
+						   CEPH_OSD_WATCH_OP_UNWATCH);
 	if (!IS_ERR(obj_request))
 		rbd_obj_request_put(obj_request);
 	else
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index f180883..8c4ba9a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -106,9 +106,8 @@ struct ceph_osd_req_op {
 		struct {
 			u64 cookie;
 			u64 ver;
-			u32 prot_ver;
-			u32 timeout;
-			__u8 flag;
+			__u8 op;
+			u32 gen;
 		} watch;
 		struct {
 			u64 expected_object_size;
@@ -311,7 +310,7 @@ extern int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int
 				 size_t size, u8 cmp_op, u8 cmp_mode);
 extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
-					u64 cookie, u64 version, int flag);
+					u8 watch_opcode, u64 cookie);
 extern void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
 				       unsigned int which,
 				       u64 expected_object_size,
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 2f822dc..7d3721f 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -417,6 +417,16 @@ enum {
 
 #define RADOS_NOTIFY_VER	1
 
+enum {
+	CEPH_OSD_WATCH_OP_UNWATCH = 0,
+	CEPH_OSD_WATCH_OP_LEGACY_WATCH = 1,
+	/* note: use only ODD ids to prevent pre-giant code from
+	 * interpreting the op as UNWATCH */
+	CEPH_OSD_WATCH_OP_WATCH = 3,
+	CEPH_OSD_WATCH_OP_RECONNECT = 5,
+	CEPH_OSD_WATCH_OP_PING = 7,
+};
+
 /*
  * an individual object operation.  each may be accompanied by some data
  * payload
@@ -450,8 +460,9 @@ struct ceph_osd_op {
 	        } __attribute__ ((packed)) snap;
 		struct {
 			__le64 cookie;
-			__le64 ver;
-			__u8 flag;	/* 0 = unwatch, 1 = watch */
+			__le64 ver;	/* no longer used */
+			__u8 op;	/* CEPH_OSD_WATCH_OP_* */
+			__u32 gen;	/* registration generation */
 		} __attribute__ ((packed)) watch;
 		struct {
 			__le64 offset, length;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0ce860d..cfdb6aa 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -581,18 +581,17 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 }
 EXPORT_SYMBOL(osd_req_op_xattr_init);
 
-void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
-				unsigned int which, u16 opcode,
-				u64 cookie, u64 version, int flag)
+void osd_req_op_watch_init(struct ceph_osd_request *osd_req, unsigned int which,
+			   u16 opcode, u8 watch_opcode, u64 cookie)
 {
 	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
 
 	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY_ACK && opcode != CEPH_OSD_OP_WATCH);
 
 	op->watch.cookie = cookie;
-	op->watch.ver = version;
-	if (opcode == CEPH_OSD_OP_WATCH && flag)
-		op->watch.flag = (u8)1;
+	op->watch.ver = 0;
+	op->watch.op = watch_opcode;
+	op->watch.gen = 0;
 }
 EXPORT_SYMBOL(osd_req_op_watch_init);
 
@@ -703,7 +702,8 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 	case CEPH_OSD_OP_WATCH:
 		dst->watch.cookie = cpu_to_le64(src->watch.cookie);
 		dst->watch.ver = cpu_to_le64(src->watch.ver);
-		dst->watch.flag = src->watch.flag;
+		dst->watch.op = src->watch.op;
+		dst->watch.gen = cpu_to_le32(src->watch.gen);
 		break;
 	case CEPH_OSD_OP_SETALLOCHINT:
 		dst->alloc_hint.expected_object_size =
-- 
1.8.3.1

