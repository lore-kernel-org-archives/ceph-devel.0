From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH 6/6] osd_client: send watch ping messages
Date: Fri, 12 Jun 2015 08:56:59 -0700
Message-ID: <3d2f491172fd1c2c33c46a4bcf64743af5f45568.1434124007.git.dfuller@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449AbbFLP67 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jun 2015 11:58:59 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 21F74376B67
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 15:58:59 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5CFwpGq025558
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 11:58:59 -0400
In-Reply-To: <cover.1434124007.git.dfuller@redhat.com>
In-Reply-To: <cover.1434124007.git.dfuller@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Send CEPH_OSD_WATCH_OP_PING every osd_keepalive_timeout for each watch
event registered. When errors are detected, look up the watch event and
send it CEPH_WATCH_EVENT_DISCONNECTED.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/osd_client.h |   1 +
 net/ceph/osd_client.c           | 102 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index b7d4234..5aef3db 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -237,6 +237,7 @@ struct ceph_osd_client {
 	int                    num_requests;
 	struct delayed_work    timeout_work;
 	struct delayed_work    osds_timeout_work;
+	struct delayed_work    linger_ping_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry 	       *debugfs_file;
 #endif
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d56f7a6..e57db93 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -109,6 +109,7 @@ static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
 	osd_data->own_pages = own_pages;
 }
 
+
 static void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
 			struct ceph_pagelist *pagelist)
 {
@@ -1362,6 +1363,13 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
 	dout("%s %p tid %llu\n", __func__, req, req->r_tid);
 	WARN_ON(!req->r_linger);
 
+	++req->r_ops[0].watch.gen;
+
+	if (list_empty(&osdc->req_linger))
+		schedule_delayed_work(&osdc->linger_ping_work,
+			       round_jiffies_relative(
+			         osdc->client->options->osd_keepalive_timeout));
+
 	ceph_osdc_get_request(req);
 	list_add_tail(&req->r_linger_item, &osdc->req_linger);
 	if (req->r_osd)
@@ -1382,6 +1390,12 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 
 	dout("%s %p tid %llu\n", __func__, req, req->r_tid);
 	list_del_init(&req->r_linger_item);
+	if (++req->r_ops[0].watch.gen > 1 &&
+		req->r_ops[0].watch.op == CEPH_OSD_WATCH_OP_WATCH) {
+		struct timespec mtime = CURRENT_TIME;
+		req->r_ops[0].watch.op = CEPH_OSD_WATCH_OP_RECONNECT;
+		ceph_osdc_build_request(req, 0, req->r_snapc, req->r_snapid, &mtime);
+	}
 
 	if (req->r_osd) {
 		list_del_init(&req->r_linger_osd_item);
@@ -1390,6 +1404,9 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 			req->r_osd = NULL;
 	}
 	ceph_osdc_put_request(req);
+
+	if (list_empty(&osdc->req_linger))
+		cancel_delayed_work(&osdc->linger_ping_work);
 }
 
 void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
@@ -1707,6 +1724,83 @@ static void handle_osds_timeout(struct work_struct *work)
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
+		           info->watch.cookie, 0, 0, NULL, result, 0, NULL);
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
 static int ceph_oloc_decode(void **p, void *end,
 			    struct ceph_object_locator *oloc)
 {
@@ -2795,6 +2889,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	osdc->num_requests = 0;
 	INIT_DELAYED_WORK(&osdc->timeout_work, handle_timeout);
 	INIT_DELAYED_WORK(&osdc->osds_timeout_work, handle_osds_timeout);
+	INIT_DELAYED_WORK(&osdc->linger_ping_work, handle_linger_ping);
 	spin_lock_init(&osdc->event_lock);
 	osdc->event_tree = RB_ROOT;
 	osdc->event_count = 0;
@@ -3079,12 +3174,15 @@ static struct ceph_msg *alloc_msg(struct ceph_connection *con,
 	case CEPH_MSG_OSD_MAP:
 	case CEPH_MSG_WATCH_NOTIFY:
 		{
-			struct ceph_msg *m = ceph_msg_new(type, front, GFP_NOFS, false);
+			struct ceph_msg *m = ceph_msg_new(type, front,
+			                                  GFP_NOFS, false);
 			size_t len = con->in_hdr.data_len;
 			if (len > 0) {
 				struct page **pages;
 				struct ceph_osd_data osd_data;
-				pages = ceph_alloc_page_vector(calc_pages_for(0, len), GFP_KERNEL);
+				pages = ceph_alloc_page_vector(
+				              calc_pages_for(0, len), GFP_NOFS);
+				WARN_ON(!pages);
 				osd_data.type = CEPH_OSD_DATA_TYPE_PAGES;
 				osd_data.pages = pages;
 				osd_data.length = len;
-- 
1.9.3

