From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCHv2 5/6] osd_client: add support for notify payloads via notify event
Date: Wed, 17 Jun 2015 07:25:55 -0700
Message-ID: <c486ba353fea150db8bc78b9ad03f07f03882b46.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48955 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289AbbFQO1y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 10:27:54 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 788C7345A95
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 14:27:54 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5HERn6Q030474
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 10:27:54 -0400
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add support in notify events for receiving data from notify_ack. Notify
events are optional; data is discarded if no event is found.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/osd_client.h |   3 +-
 net/ceph/osd_client.c           | 135 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 131 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index c673d75..31e308b 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -198,7 +198,8 @@ struct ceph_osd_event {
 			void (*errcb)(void *, u64, int);
 		} watch;
 		struct {
-			struct ceph_msg_data *notify_data;
+			struct page **notify_data;
+			size_t notify_data_len;
 			struct completion complete;
 		} notify;
 	};
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index af05c0f..99bac91 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -43,7 +43,7 @@ static struct ceph_osd_event *__find_event(struct ceph_osd_client *osdc,
 static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
                        u64 cookie, u64 notify_id, u32 payload_len,
                        void *payload, s32 return_code, u64 notifier_gid,
-                       struct ceph_msg_data *data);
+                       struct page **data, size_t data_len);
 
 /*
  * Implement client access to distributed object storage cluster.
@@ -268,7 +268,7 @@ void osd_req_op_notify_request_data_pagelist(
 {
 	struct ceph_osd_data *osd_data;
 
-	osd_data = osd_req_op_data(osd_req, which, notify, request_data);
+	osd_data = osd_req_op_data(osd_req, which, watch, request_data);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }
 EXPORT_SYMBOL(osd_req_op_notify_request_data_pagelist);
@@ -630,6 +630,13 @@ void osd_req_op_notify_init(struct ceph_osd_request *osd_req,
 	struct ceph_osd_event *notify_event;
 
 	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY);
+
+	notify_event = __find_event(osd_req->r_osdc, cookie);
+	/* Only linger if the caller is interested in the notify acks. */
+	if (notify_event) {
+		ceph_osdc_set_request_linger(osd_req->r_osdc, osd_req);
+		notify_event->osd_req = osd_req;
+	}
 	op->watch.cookie = cookie;
 }
 EXPORT_SYMBOL(osd_req_op_notify_init);
@@ -768,6 +775,14 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
 		ceph_osdc_msg_data_add(req->r_reply, osd_data);
 		break;
 	case CEPH_OSD_OP_NOTIFY_ACK:
+		osd_data = &src->watch.request_data;
+		data_length = ceph_osd_data_length(osd_data);
+		if (data_length) {
+			ceph_osdc_msg_data_add(req->r_request, osd_data);
+			src->payload_len += data_length;
+			request_data_len += data_length;
+		}
+		/* fallthrough */
 	case CEPH_OSD_OP_WATCH:
 		dst->watch.cookie = cpu_to_le64(src->watch.cookie);
 		dst->watch.ver = cpu_to_le64(src->watch.ver);
@@ -1693,6 +1708,84 @@ static void handle_osds_timeout(struct work_struct *work)
 			      round_jiffies_relative(delay));
 }
 
+static void __ping_callback(struct ceph_osd_request *osd_req,
+               struct ceph_msg *msg)
+{
+	struct ceph_osd_req_op * info = &osd_req->r_ops[0];
+	struct ceph_osd_request *target = osd_req->r_priv;
+	u64 result = osd_req->r_reply_op_result[0];
+
+	dout("got pong result %llu\n", result);
+
+	if (target->r_ops[0].watch.gen != info->watch.gen) {
+		dout("ignoring pong result out of phase (%u != %u)\n",
+		     target->r_ops[0].watch.gen, info->watch.gen);
+		return;
+	}
+	if (result != 0)
+		__do_event(osd_req->r_osdc, CEPH_WATCH_EVENT_DISCONNECT,
+		           info->watch.cookie, 0, 0, NULL, result, 0, NULL, 0);
+
+	ceph_osdc_put_request(target);
+	ceph_osdc_put_request(osd_req);
+}
+
+static void __send_linger_ping(struct ceph_osd_request *req)
+{
+	struct ceph_osd_request *ping_req;
+	int ret;
+
+	dout("ping for watch %llu\n", req->r_tid);
+
+	ping_req = ceph_osdc_alloc_request(req->r_osdc, NULL, 1, false,
+	                                   GFP_NOIO);
+	if (!ping_req) {
+		WARN(true, "failed to allocate memory to ping, skipping");
+		return;
+	}
+
+	ping_req->r_base_oloc.pool = req->r_base_oloc.pool;
+	ping_req->r_flags = CEPH_OSD_OP_READ;
+	ceph_oid_copy(&ping_req->r_base_oid, &req->r_base_oid);
+	ping_req->r_callback = __ping_callback;
+	osd_req_op_watch_init(ping_req, 0, CEPH_OSD_OP_WATCH,
+	                      CEPH_OSD_WATCH_OP_PING,
+	                      req->r_ops[0].watch.cookie);
+	ping_req->r_ops[0].watch.gen = req->r_ops[0].watch.gen;
+	ping_req->r_priv = req;
+	ceph_osdc_build_request(ping_req, 0, NULL, cpu_to_le64(CEPH_NOSNAP),
+	                        NULL);
+	ceph_osdc_get_request(req);
+	ret = ceph_osdc_start_request(req->r_osdc, ping_req, false);
+	if (ret) {
+		ceph_osdc_put_request(ping_req);
+		ceph_osdc_cancel_request(ping_req);
+	}
+}
+
+static void handle_linger_ping(struct work_struct *work)
+{
+	struct ceph_osd_client *osdc;
+
+	struct ceph_osd_request *req, *nreq;
+
+	osdc = container_of(work, struct ceph_osd_client,
+	                    linger_ping_work.work);
+
+	dout("scanning for watches to ping about\n");
+
+	list_for_each_entry_safe(req, nreq, &osdc->req_linger, r_linger_item) {
+		int i;
+		for (i = 0; i < req->r_num_ops; i++) {
+			if (req->r_ops[i].op == CEPH_OSD_OP_WATCH)
+				__send_linger_ping(req);
+		}
+	}
+	schedule_delayed_work(&osdc->linger_ping_work,
+	                      osdc->client->options->osd_keepalive_timeout);
+}
+
+>>>>>>> a53afe3... changed data return type to page vector
 static int ceph_oloc_decode(void **p, void *end,
 			    struct ceph_object_locator *oloc)
 {
@@ -2446,7 +2539,7 @@ static void do_event_work(struct work_struct *work)
 static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
                        u64 cookie, u64 notify_id, u32 payload_len,
                        void *payload, s32 return_code, u64 notifier_gid,
-                       struct ceph_msg_data *data)
+                       struct page **data, size_t data_len)
 {
 	struct ceph_osd_event *event;
 	struct ceph_osd_event_work *event_work;
@@ -2486,6 +2579,7 @@ static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
 		case CEPH_WATCH_EVENT_NOTIFY_COMPLETE:
 			if (event) {
 				event->notify.notify_data = data;
+				event->notify.notify_data_len = data_len;
 				if (event->osd_req) {
 					ceph_osdc_cancel_request(event->osd_req);
 					event->osd_req = NULL;
@@ -2532,11 +2626,13 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 	if (msg->hdr.version >= 2)
 		ceph_decode_32_safe(&p, end, return_code, bad);
 
-	if (msg->hdr.version >= 3)
+	if (msg->hdr.version >= 3) {
 		ceph_decode_64_safe(&p, end, notifier_gid, bad);
+		data = list_first_entry(&msg->data, struct ceph_msg_data, links);
+	}
 
 	__do_event(osdc, opcode, cookie, notify_id, payload_len, payload,
-		return_code, notifier_gid, data);
+		return_code, notifier_gid, data->pages, data->length);
 
 	return;
 
@@ -3055,12 +3151,33 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
 	struct ceph_osd *osd = con->private;
 	int type = le16_to_cpu(hdr->type);
 	int front = le32_to_cpu(hdr->front_len);
+	struct ceph_msg *m;
+	size_t len = con->in_hdr.data_len;
 
 	*skip = 0;
 	switch (type) {
 	case CEPH_MSG_OSD_MAP:
 	case CEPH_MSG_WATCH_NOTIFY:
-		return ceph_msg_new(type, front, GFP_NOFS, false);
+		m = ceph_msg_new(type, front, GFP_NOFS, false);
+		if (!m)
+			goto out;
+
+		if (len > 0) {
+			struct page **pages;
+			struct ceph_osd_data osd_data;
+			pages = ceph_alloc_page_vector(
+				      calc_pages_for(0, len), GFP_NOFS);
+			if (!pages)
+				goto out2;
+			osd_data.type = CEPH_OSD_DATA_TYPE_PAGES;
+			osd_data.pages = pages;
+			osd_data.length = len;
+			osd_data.alignment = 0;
+			osd_data.pages_from_pool = false;
+			osd_data.own_pages = false;
+			ceph_osdc_msg_data_add(m, &osd_data);
+		}
+		return m;
 	case CEPH_MSG_OSD_OPREPLY:
 		return get_reply(con, hdr, skip);
 	default:
@@ -3069,6 +3186,12 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
 		*skip = 1;
 		return NULL;
 	}
+out2:
+	ceph_msg_put(m);
+out:
+	pr_err("couldn't allocate reply, will skip\n");
+	*skip = 1;
+	return NULL;
 }
 
 /*
-- 
1.9.3

