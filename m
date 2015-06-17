From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCHv2 3/6] ceph/rbd: update watch-notify ceph_osd_op
Date: Wed, 17 Jun 2015 07:25:53 -0700
Message-ID: <0c6b3f1c8f12c5b9800ea57102db5607f264cef3.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55531 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbFQO1x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 10:27:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id EDA99BF9FB
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 14:27:52 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5HERn6O030474
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 10:27:52 -0400
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
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
[djf: moved watch event definitions to ceph_fs.h]
[djf: removed changes to rbd.c for SCSI]
Signed-off-by: Douglas Fuller <dfuller@redhat.com>
Reviewed-by: Josh Durgin <jdurgin@redhat.com>
---
 drivers/block/rbd.c             | 19 +++++++-----
 include/linux/ceph/ceph_fs.h    |  6 ++--
 include/linux/ceph/osd_client.h | 23 ++++++++++----
 include/linux/ceph/rados.h      | 18 +++++++++--
 net/ceph/osd_client.c           | 66 ++++++++++++++++++++++++++++++++++++-----
 5 files changed, 107 insertions(+), 25 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 65421eb..ed170b1 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3089,8 +3089,8 @@ static int rbd_obj_notify_ack_sync(struct rbd_device *rbd_dev, u64 notify_id)
 	if (!obj_request->osd_req)
 		goto out;
 
-	osd_req_op_watch_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY_ACK,
-					notify_id, 0, 0);
+	osd_req_op_watch_init(obj_request->osd_req, 0,
+			      CEPH_OSD_OP_NOTIFY_ACK, 0, notify_id);
 	rbd_osd_req_format_read(obj_request);
 
 	ret = rbd_obj_request_submit(osdc, obj_request);
@@ -3138,7 +3138,7 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
  */
 static struct rbd_obj_request *rbd_obj_watch_request_helper(
 						struct rbd_device *rbd_dev,
-						bool watch)
+						u8 watch_opcode)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct ceph_options *opts = osdc->client->options;
@@ -3158,10 +3158,11 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
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
@@ -3174,7 +3175,7 @@ static struct rbd_obj_request *rbd_obj_watch_request_helper(
 
 	ret = obj_request->result;
 	if (ret) {
-		if (watch)
+		if (watch_opcode != CEPH_OSD_WATCH_OP_UNWATCH)
 			rbd_obj_request_end(obj_request);
 		goto out;
 	}
@@ -3203,7 +3204,8 @@ static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 	if (ret < 0)
 		return ret;
 
-	obj_request = rbd_obj_watch_request_helper(rbd_dev, true);
+	obj_request = rbd_obj_watch_request_helper(rbd_dev,
+						CEPH_OSD_WATCH_OP_LEGACY_WATCH);
 	if (IS_ERR(obj_request)) {
 		ceph_osdc_cancel_event(rbd_dev->watch_event);
 		rbd_dev->watch_event = NULL;
@@ -3237,7 +3239,8 @@ static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev)
 	rbd_obj_request_put(rbd_dev->watch_request);
 	rbd_dev->watch_request = NULL;
 
-	obj_request = rbd_obj_watch_request_helper(rbd_dev, false);
+	obj_request = rbd_obj_watch_request_helper(rbd_dev,
+						   CEPH_OSD_WATCH_OP_UNWATCH);
 	if (!IS_ERR(obj_request))
 		rbd_obj_request_put(obj_request);
 	else
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d7d072a..06f5ed8 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -153,11 +153,11 @@ struct ceph_dir_layout {
 
 /* watch-notify operations */
 enum {
-  WATCH_NOTIFY				= 1, /* notifying watcher */
-  WATCH_NOTIFY_COMPLETE			= 2, /* notifier notified when done */
+  CEPH_WATCH_EVENT_NOTIFY		= 1, /* notifying watcher */
+  CEPH_WATCH_EVENT_NOTIFY_COMPLETE	= 2, /* notifier notified when done */
+  CEPH_WATCH_EVENT_DISCONNECT		= 3, /* we were disconnected */
 };
 
-
 struct ceph_mon_request_header {
 	__le64 have_version;
 	__le16 session_mon;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 1c4e472..12732d3 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -106,11 +106,15 @@ struct ceph_osd_req_op {
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
+			u64 cookie;
+			struct ceph_osd_data request_data;
+			struct ceph_osd_data response_data;
+		} notify;
+		struct {
 			u64 expected_object_size;
 			u64 expected_write_size;
 		} alloc_hint;
@@ -302,7 +306,16 @@ extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 					struct page **pages, u64 length,
 					u32 alignment, bool pages_from_pool,
 					bool own_pages);
-
+extern void osd_req_op_notify_request_data_pagelist(struct ceph_osd_request *,
+					unsigned int which,
+					struct ceph_pagelist *pagelist);
+extern void osd_req_op_notify_response_data_pages(struct ceph_osd_request *,
+					unsigned int which,
+					struct page **pages, u64 length,
+					u32 alignment, bool pages_from_pool,
+					bool own_pages);
+extern void osd_req_op_notify_init(struct ceph_osd_request *osd_req,
+				   unsigned int which, u16 opcode, u64 cookie);
 extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					const char *class, const char *method);
@@ -311,7 +324,7 @@ extern int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int
 				 size_t size, u8 cmp_op, u8 cmp_mode);
 extern void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
-					u64 cookie, u64 version, int flag);
+					u8 watch_opcode, u64 cookie);
 extern void osd_req_op_alloc_hint_init(struct ceph_osd_request *osd_req,
 				       unsigned int which,
 				       u64 expected_object_size,
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 2f822dc..bcaabf3 100644
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
@@ -450,10 +460,14 @@ struct ceph_osd_op {
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
+			__le64 cookie;
+		} __attribute__ ((packed)) notify;
+		struct {
 			__le64 offset, length;
 			__le64 src_offset;
 		} __attribute__ ((packed)) clonerange;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 8d96a52..2725a68 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -18,6 +18,7 @@
 #include <linux/ceph/decode.h>
 #include <linux/ceph/auth.h>
 #include <linux/ceph/pagelist.h>
+#include <linux/ceph/ceph_fs.h>
 
 #define OSD_OP_FRONT_LEN	4096
 #define OSD_OPREPLY_FRONT_LEN	512
@@ -243,6 +244,29 @@ void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_cls_response_data_pages);
 
+void osd_req_op_notify_response_data_pages(struct ceph_osd_request *osd_req,
+			unsigned int which, struct page **pages, u64 length,
+			u32 alignment, bool pages_from_pool, bool own_pages)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, notify, response_data);
+	ceph_osd_data_pages_init(osd_data, pages, length, alignment,
+				pages_from_pool, own_pages);
+}
+EXPORT_SYMBOL(osd_req_op_notify_response_data_pages);
+
+void osd_req_op_notify_request_data_pagelist(
+			struct ceph_osd_request *osd_req,
+			unsigned int which, struct ceph_pagelist *pagelist)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, notify, request_data);
+	ceph_osd_data_pagelist_init(osd_data, pagelist);
+}
+EXPORT_SYMBOL(osd_req_op_notify_request_data_pagelist);
+
 static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 {
 	switch (osd_data->type) {
@@ -292,6 +316,10 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 		ceph_osd_data_release(&op->cls.request_data);
 		ceph_osd_data_release(&op->cls.response_data);
 		break;
+	case CEPH_OSD_OP_NOTIFY:
+		ceph_osd_data_release(&op->notify.request_data);
+		ceph_osd_data_release(&op->notify.response_data);
+		break;
 	case CEPH_OSD_OP_SETXATTR:
 	case CEPH_OSD_OP_CMPXATTR:
 		ceph_osd_data_release(&op->xattr.osd_data);
@@ -588,9 +616,18 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 }
 EXPORT_SYMBOL(osd_req_op_xattr_init);
 
-void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
-				unsigned int which, u16 opcode,
-				u64 cookie, u64 version, int flag)
+void osd_req_op_notify_init(struct ceph_osd_request *osd_req, unsigned int which,
+			    u16 opcode, u64 cookie)
+{
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
+
+	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY);
+	op->watch.cookie = cookie;
+}
+EXPORT_SYMBOL(osd_req_op_notify_init);
+
+void osd_req_op_watch_init(struct ceph_osd_request *osd_req, unsigned int which,
+			   u16 opcode, u8 watch_opcode, u64 cookie)
 {
 	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which,
 						      opcode, 0);
@@ -598,9 +635,9 @@ void osd_req_op_watch_init(struct ceph_osd_request *osd_req,
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
 
@@ -708,11 +745,26 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 		break;
 	case CEPH_OSD_OP_STARTSYNC:
 		break;
+	case CEPH_OSD_OP_NOTIFY:
+		dst->notify.cookie = cpu_to_le64(src->notify.cookie);
+
+		osd_data = &src->notify.request_data;
+		data_length = ceph_osd_data_length(osd_data);
+		if (data_length) {
+			BUG_ON(osd_data->type == CEPH_OSD_DATA_TYPE_NONE);
+			ceph_osdc_msg_data_add(req->r_request, osd_data);
+			src->payload_len += data_length;
+			request_data_len += data_length;
+		}
+		osd_data = &src->notify.response_data;
+		ceph_osdc_msg_data_add(req->r_reply, osd_data);
+		break;
 	case CEPH_OSD_OP_NOTIFY_ACK:
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
1.9.3

