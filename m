From: mchristi@redhat.com
Subject: [PATCH 04/10] ceph/rbd: add support for watch notify payloads
Date: Tue, 28 Apr 2015 17:05:41 -0500
Message-ID: <1430258747-12506-5-git-send-email-mchristi@redhat.com>
References: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51138 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030935AbbD1WFw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Apr 2015 18:05:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5qHm024546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:52 -0400
Received: from rh2.redhat.com (vpn-49-183.rdu2.redhat.com [10.10.49.183])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t3SM5mbP013102
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2015 18:05:51 -0400
In-Reply-To: <1430258747-12506-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This patch adds support for proto version 1 of watch-notify,
so drivers like rbd can be sent a buffer with information like
the notify operation being performed.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/block/rbd.c             |  3 ++-
 include/linux/ceph/osd_client.h |  7 +++++--
 net/ceph/osd_client.c           | 21 ++++++++++++++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index fafe558..bb4a0fe 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3081,7 +3081,8 @@ out:
 	return ret;
 }
 
-static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
+static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data,
+			 void *payload, int payload_len)
 {
 	struct rbd_device *rbd_dev = (struct rbd_device *)data;
 	int ret;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 61b19c4..2e9f89e 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -184,7 +184,7 @@ struct ceph_osd_event {
 	u64 cookie;
 	int one_shot;
 	struct ceph_osd_client *osdc;
-	void (*cb)(u64, u64, u8, void *);
+	void (*cb)(u64, u64, u8, void *, void *, int);
 	void *data;
 	struct rb_node node;
 	struct list_head osd_node;
@@ -197,6 +197,8 @@ struct ceph_osd_event_work {
         u64 ver;
         u64 notify_id;
         u8 opcode;
+	void *payload;
+	int payload_len;
 };
 
 struct ceph_osd_client {
@@ -369,7 +371,8 @@ extern int ceph_osdc_writepages(struct ceph_osd_client *osdc,
 
 /* watch/notify events */
 extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
-				  void (*event_cb)(u64, u64, u8, void *),
+				  void (*event_cb)(u64, u64, u8, void *, void *,
+						   int),
 				  void *data, struct ceph_osd_event **pevent);
 extern void ceph_osdc_cancel_event(struct ceph_osd_event *event);
 extern void ceph_osdc_put_event(struct ceph_osd_event *event);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 41a4abc..305a0b9 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2262,7 +2262,7 @@ static void __remove_event(struct ceph_osd_event *event)
 }
 
 int ceph_osdc_create_event(struct ceph_osd_client *osdc,
-			   void (*event_cb)(u64, u64, u8, void *),
+			   void (*event_cb)(u64, u64, u8, void *, void *, int),
 			   void *data, struct ceph_osd_event **pevent)
 {
 	struct ceph_osd_event *event;
@@ -2314,7 +2314,8 @@ static void do_event_work(struct work_struct *work)
 	u8 opcode = event_work->opcode;
 
 	dout("do_event_work completing %p\n", event);
-	event->cb(ver, notify_id, opcode, event->data);
+	event->cb(ver, notify_id, opcode, event->data, event_work->payload,
+		  event_work->payload_len);
 	dout("do_event_work completed %p\n", event);
 	ceph_osdc_put_event(event);
 	kfree(event_work);
@@ -2327,10 +2328,11 @@ static void do_event_work(struct work_struct *work)
 static void handle_watch_notify(struct ceph_osd_client *osdc,
 				struct ceph_msg *msg)
 {
-	void *p, *end;
+	void *p, *end, *payload = NULL;
 	u8 proto_ver;
 	u64 cookie, ver, notify_id;
 	u8 opcode;
+	u32 payload_len = 0;
 	struct ceph_osd_event *event;
 	struct ceph_osd_event_work *event_work;
 
@@ -2343,6 +2345,13 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 	ceph_decode_64_safe(&p, end, ver, bad);
 	ceph_decode_64_safe(&p, end, notify_id, bad);
 
+	if (proto_ver >= 1) {
+		ceph_decode_32_safe(&p, end, payload_len, bad);
+		if (end - p < payload_len)
+			goto bad;
+		payload = p;
+	}
+
 	spin_lock(&osdc->event_lock);
 	event = __find_event(osdc, cookie);
 	if (event) {
@@ -2350,8 +2359,8 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 		get_event(event);
 	}
 	spin_unlock(&osdc->event_lock);
-	dout("handle_watch_notify cookie %lld ver %lld event %p\n",
-	     cookie, ver, event);
+	dout("handle_watch_notify cookie %lld ver %lld event %p notify id %llu payload len %u\n",
+	     cookie, ver, event, notify_id, payload_len);
 	if (event) {
 		event_work = kmalloc(sizeof(*event_work), GFP_NOIO);
 		if (!event_work) {
@@ -2364,6 +2373,8 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 		event_work->ver = ver;
 		event_work->notify_id = notify_id;
 		event_work->opcode = opcode;
+		event_work->payload = payload;
+		event_work->payload_len = payload_len;
 
 		queue_work(osdc->notify_wq, &event_work->work);
 	}
-- 
1.8.3.1

