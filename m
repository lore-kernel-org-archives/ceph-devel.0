From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCHv2 6/6] osd_client: send watch ping messages
Date: Wed, 17 Jun 2015 07:25:56 -0700
Message-ID: <e788e9d089b338a9aa3b7f57cc0b8f324359a37e.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349AbbFQO1z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 10:27:55 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 58D4019F3B9
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 14:27:55 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5HERn6R030474
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 10:27:55 -0400
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Send CEPH_OSD_WATCH_OP_PING every osd_keepalive_timeout for each watch
event registered. When errors are detected, look up the watch event and
send it CEPH_WATCH_EVENT_DISCONNECTED.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/osd_client.h |  1 +
 net/ceph/osd_client.c           | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 31e308b..7fbbd22 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -238,6 +238,7 @@ struct ceph_osd_client {
 	int                    num_requests;
 	struct delayed_work    timeout_work;
 	struct delayed_work    osds_timeout_work;
+	struct delayed_work    linger_ping_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry 	       *debugfs_file;
 #endif
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 99bac91..9a5fcae 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -110,6 +110,7 @@ static void ceph_osd_data_pages_init(struct ceph_osd_data *osd_data,
 	osd_data->own_pages = own_pages;
 }
 
+
 static void ceph_osd_data_pagelist_init(struct ceph_osd_data *osd_data,
 			struct ceph_pagelist *pagelist)
 {
@@ -1363,6 +1364,13 @@ static void __register_linger_request(struct ceph_osd_client *osdc,
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
@@ -1383,6 +1391,12 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 
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
@@ -1391,6 +1405,9 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 			req->r_osd = NULL;
 	}
 	ceph_osdc_put_request(req);
+
+	if (list_empty(&osdc->req_linger))
+		cancel_delayed_work(&osdc->linger_ping_work);
 }
 
 void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
@@ -1785,7 +1802,6 @@ static void handle_linger_ping(struct work_struct *work)
 	                      osdc->client->options->osd_keepalive_timeout);
 }
 
->>>>>>> a53afe3... changed data return type to page vector
 static int ceph_oloc_decode(void **p, void *end,
 			    struct ceph_object_locator *oloc)
 {
@@ -2873,6 +2889,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	osdc->num_requests = 0;
 	INIT_DELAYED_WORK(&osdc->timeout_work, handle_timeout);
 	INIT_DELAYED_WORK(&osdc->osds_timeout_work, handle_osds_timeout);
+	INIT_DELAYED_WORK(&osdc->linger_ping_work, handle_linger_ping);
 	spin_lock_init(&osdc->event_lock);
 	osdc->event_tree = RB_ROOT;
 	osdc->event_count = 0;
-- 
1.9.3

