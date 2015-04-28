From: mchristi@redhat.com
Subject: [PATCH 08/10] ceph/rbd: add notify support
Date: Tue, 28 Apr 2015 17:05:45 -0500
Message-ID: <1430258747-12506-9-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031017AbbD1WFy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:54 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id D24BE8E3E4
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 22:05:54 +0000 (UTC)
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbT013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:54 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This adds support for rados's notify call. It is being used to notify
scsi PR and TMF watchers that the scsi pr info has changed, or that
we want to sync up on TMF execution (currently only LUN_RESET).

I did not add support for the notify2 recv buffer as I am not using
it yet. Currently, this results in log messages like:

kernel: libceph: read_partial_message skipping long message (48 > 0)

This commit message used to say, I was going to add it later as I need
it to be able to send scsi sense codes, but I guess Doug is going to do
that now. Thanks Doug!

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c             | 118 ++++++++++++++++++++++++++++++++++++----
 include/linux/ceph/osd_client.h |  16 +++++-
 include/linux/ceph/rados.h      |   9 +++
 net/ceph/osd_client.c           |  51 +++++++++++++++++
 4 files changed, 182 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a70447c..aed38c0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -132,6 +132,21 @@ static int atomic_dec_return_safe(atomic_t *v)
 #define DEV_NAME_LEN		32
 #define MAX_INT_FORMAT_WIDTH	((5 * sizeof (int)) / 2 + 1)
 
+enum rbd_notify_op {
+	RBD_NOTIFY_OP_ACQUIRED_LOCK	= 0,
+	RBD_NOTIFY_OP_RELEASED_LOCK	= 1,
+	RBD_NOTIFY_OP_REQUEST_LOCK	= 2,
+	RBD_NOTIFY_OP_HEADER_UPDATE	= 3,
+	RBD_NOTIFY_OP_ASYNC_PROGRESS	= 4,
+	RBD_NOTIFY_OP_ASYNC_COMPLETE	= 5,
+	RBD_NOTIFY_OP_FLATTEN		= 6,
+	RBD_NOTIFY_OP_RESIZE		= 7,
+	RBD_NOTIFY_OP_SNAP_CREATE	= 8,
+	RBD_NOTIFY_OP_SCSI_PR_UPDATE	= 9,
+	RBD_NOTIFY_OP_SCSI_LUN_RESET_START	= 10,
+	RBD_NOTIFY_OP_SCSI_LUN_RESET_COMPLETE	= 11,
+};
+
 /*
  * block device image metadata (in-memory version)
  */
@@ -1847,6 +1862,7 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
 	case CEPH_OSD_OP_CALL:
 	case CEPH_OSD_OP_NOTIFY_ACK:
 	case CEPH_OSD_OP_WATCH:
+	case CEPH_OSD_OP_NOTIFY:
 		rbd_osd_trivial_callback(obj_request);
 		break;
 	default:
@@ -3087,27 +3103,51 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
 {
 	struct rbd_device *rbd_dev = (struct rbd_device *)data;
 	int ret;
+	u32 len, notify_op = -1;
+	void *p = payload, *end = p + payload_len;
 
 	if (!rbd_dev)
 		return;
 
-	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
+	dout("%s: \"%s\" notify_id %llu opcode %u rc %d bl len %u\n", __func__,
 		rbd_dev->header_name, (unsigned long long)notify_id,
-		(unsigned int)opcode);
+		(unsigned int)opcode, return_code, payload_len);
 
-	/*
-	 * Until adequate refresh error handling is in place, there is
-	 * not much we can do here, except warn.
-	 *
-	 * See http://tracker.ceph.com/issues/5040
-	 */
-	ret = rbd_dev_refresh(rbd_dev);
-	if (ret)
-		rbd_warn(rbd_dev, "refresh failed: %d", ret);
+	if (payload_len) {
+		if (ceph_start_decoding(&p, end, 1, &len))
+			goto decode_fail;
+		ceph_decode_32_safe(&p, end, notify_op, decode_fail);
+	}
+
+	if (opcode == CEPH_WATCH_EVENT_DISCONNECT)
+		return;
+
+	dout("%s: \"%s\" RBD notify op %u\n", __func__, rbd_dev->header_name,
+	     notify_op);
+
+	switch (notify_op) {
+	case RBD_NOTIFY_OP_SCSI_PR_UPDATE:
+		break;
+	default:
+		/*
+		 * Until adequate refresh error handling is in place, there is
+		 * not much we can do here, except warn.
+		 *
+		 * See http://tracker.ceph.com/issues/5040
+		 */
+		ret = rbd_dev_refresh(rbd_dev);
+		if (ret)
+			rbd_warn(rbd_dev, "refresh failed: %d", ret);
+	}
 
 	ret = rbd_obj_notify_ack_sync(rbd_dev, notify_id);
 	if (ret)
 		rbd_warn(rbd_dev, "notify_ack ret %d", ret);
+	return;
+
+decode_fail:
+	rbd_warn(rbd_dev, "Invalid op/notify_op %u/%u", (unsigned int)opcode,
+		 notify_op);
 }
 
 /*
@@ -3260,6 +3300,12 @@ static int rbd_obj_request_sync(struct rbd_device *rbd_dev,
 							   inbound_size,
 							   0, false, false);
 			break;
+		case CEPH_OSD_OP_NOTIFY:
+			osd_req_op_notify_response_data_pages(
+							obj_request->osd_req,
+							0, pages, inbound_size,
+							0, false, false);
+			break;
 		default:
 			BUG();
 		}
@@ -3279,6 +3325,11 @@ static int rbd_obj_request_sync(struct rbd_device *rbd_dev,
 							obj_request->osd_req, 0,
 							pagelist);
 			break;
+		case CEPH_OSD_OP_NOTIFY:
+			osd_req_op_notify_request_data_pagelist(
+							obj_request->osd_req, 0,
+							pagelist);
+			break;
 		default:
 			BUG();
 		}
@@ -3349,6 +3400,51 @@ out:
 	return ret;
 }
 
+static int rbd_obj_notify_scsi_event_sync(struct rbd_device *rbd_dev,
+					  u32 notify_op,
+					  u32 notify_timeout)
+{
+	struct rbd_obj_request *obj_request;
+	int ret = -ENOMEM;
+	struct {
+		__le32 version;
+		__le32 timeout;
+		__le32 buf_len;
+		/* payload only supports basic ops where we just send the op */
+		u8 curr_ver;
+		u8 compat_ver;
+		__le32 len;
+		__le32 notify_op;
+	} __attribute__ ((packed)) notify_buf = { 0 };
+
+	notify_buf.version = cpu_to_le32(0);
+	notify_buf.timeout = cpu_to_le32(notify_timeout);
+	notify_buf.buf_len = cpu_to_le32(10);
+	notify_buf.curr_ver = 2;
+	notify_buf.compat_ver = 1;
+	notify_buf.len = cpu_to_le32(sizeof(__le32));
+	notify_buf.notify_op = cpu_to_le32(notify_op);
+
+	obj_request = rbd_obj_request_create(rbd_dev->header_name, 0, 0,
+					     OBJ_REQUEST_PAGES);
+	if (!obj_request)
+		return -ENOMEM;
+
+	obj_request->osd_req = rbd_osd_req_create(rbd_dev, OBJ_OP_WRITE,
+						  1, obj_request);
+	if (!obj_request->osd_req)
+		goto out;
+
+	osd_req_op_notify_init(obj_request->osd_req, 0, CEPH_OSD_OP_NOTIFY,
+			       rbd_dev->watch_event->cookie);
+
+	ret = rbd_obj_request_sync(rbd_dev, obj_request, &notify_buf,
+				   sizeof(notify_buf), NULL, 0);
+out:
+	rbd_obj_request_put(obj_request);
+	return ret;
+}
+
 static void rbd_queue_workfn(struct work_struct *work)
 {
 	struct request *rq = blk_mq_rq_from_pdu(work);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 8c4ba9a..d512dfa 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -110,6 +110,11 @@ struct ceph_osd_req_op {
 			u32 gen;
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
@@ -301,7 +306,16 @@ extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
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
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 7d3721f..cae82b36 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -427,6 +427,12 @@ enum {
 	CEPH_OSD_WATCH_OP_PING = 7,
 };
 
+enum {
+	CEPH_WATCH_EVENT_NOTIFY			= 1, /* notifying watcher */
+	CEPH_WATCH_EVENT_NOTIFY_COMPLETE	= 2, /* notifier notified when done */
+	CEPH_WATCH_EVENT_DISCONNECT		= 3, /* we were disconnected */
+};
+
 /*
  * an individual object operation.  each may be accompanied by some data
  * payload
@@ -465,6 +471,9 @@ struct ceph_osd_op {
 			__u32 gen;	/* registration generation */
 		} __attribute__ ((packed)) watch;
 		struct {
+			__le64 cookie;
+		} __attribute__ ((packed)) notify;
+		struct {
 			__le64 offset, length;
 			__le64 src_offset;
 		} __attribute__ ((packed)) clonerange;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cfdb6aa..8e90ee3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -243,6 +243,29 @@ void osd_req_op_cls_response_data_pages(struct ceph_osd_request *osd_req,
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
@@ -292,6 +315,10 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
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
@@ -581,6 +608,16 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 }
 EXPORT_SYMBOL(osd_req_op_xattr_init);
 
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
 void osd_req_op_watch_init(struct ceph_osd_request *osd_req, unsigned int which,
 			   u16 opcode, u8 watch_opcode, u64 cookie)
 {
@@ -698,6 +735,20 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
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
-- 
1.8.3.1

