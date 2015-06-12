From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 5/6] osd_client: add support for notify payloads via notify event
Date: Fri, 12 Jun 2015 08:56:58 -0700
Message-ID: <0010a14dcbe868312b9be6c7add8ec9d43fc0a28.1434124007.git.dfuller@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbbFLP66 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jun 2015 11:58:58 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 546CFC79F4
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 15:58:58 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5CFwpGp025558
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 11:58:58 -0400
In-Reply-To: <cover.1434124007.git.dfuller@redhat.com>
In-Reply-To: <cover.1434124007.git.dfuller@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add support in notify events for receiving data from notify_ack. Notify
events are optional; data is discarded if no event is found.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 net/ceph/osd_client.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d435bf2..d56f7a6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -267,7 +267,7 @@ void osd_req_op_notify_request_data_pagelist(
 {
 	struct ceph_osd_data *osd_data;
 
-	osd_data = osd_req_op_data(osd_req, which, notify, request_data);
+	osd_data = osd_req_op_data(osd_req, which, watch, request_data);
 	ceph_osd_data_pagelist_init(osd_data, pagelist);
 }
 EXPORT_SYMBOL(osd_req_op_notify_request_data_pagelist);
@@ -629,6 +629,13 @@ void osd_req_op_notify_init(struct ceph_osd_request *osd_req,
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
@@ -767,6 +774,14 @@ static u64 osd_req_encode_op(struct ceph_osd_request *req,
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
@@ -2533,8 +2548,10 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 	if (msg->hdr.version >= 2)
 		ceph_decode_32_safe(&p, end, return_code, bad);
 
-	if (msg->hdr.version >= 3)
+	if (msg->hdr.version >= 3) {
 		ceph_decode_32_safe(&p, end, notifier_gid, bad);
+		data = list_first_entry(&msg->data, struct ceph_msg_data, links);
+	}
 
 	__do_event(osdc, opcode, cookie, notify_id, payload_len, payload,
 		return_code, notifier_gid, data);
@@ -3061,7 +3078,23 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
 	switch (type) {
 	case CEPH_MSG_OSD_MAP:
 	case CEPH_MSG_WATCH_NOTIFY:
-		return ceph_msg_new(type, front, GFP_NOFS, false);
+		{
+			struct ceph_msg *m = ceph_msg_new(type, front, GFP_NOFS, false);
+			size_t len = con->in_hdr.data_len;
+			if (len > 0) {
+				struct page **pages;
+				struct ceph_osd_data osd_data;
+				pages = ceph_alloc_page_vector(calc_pages_for(0, len), GFP_KERNEL);
+				osd_data.type = CEPH_OSD_DATA_TYPE_PAGES;
+				osd_data.pages = pages;
+				osd_data.length = len;
+				osd_data.alignment = 0;
+				osd_data.pages_from_pool = false;
+				osd_data.own_pages = false;
+				ceph_osdc_msg_data_add(m, &osd_data);
+			}
+			return m;
+		}
 	case CEPH_MSG_OSD_OPREPLY:
 		return get_reply(con, hdr, skip);
 	default:
-- 
1.9.3

