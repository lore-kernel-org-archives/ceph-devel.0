From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCHv2 2/6] ceph/rbd: add support for header version 2 and 3
Date: Wed, 17 Jun 2015 07:25:52 -0700
Message-ID: <80f77029ea44e7e02868ebff86f3c97b66e3935c.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58823 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812AbbFQO1w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 10:27:52 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 28254A10AB
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 14:27:52 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5HERn6N030474
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 10:27:52 -0400
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

This adds support watch-notify header 2 and 3 support, so we can
get a return_code from those operations.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
[djf: fixed decoding bits]
Signed-off-by: Douglas Fuller <dfuller@redhat.com>
Reviewed-by: Josh Durgin <jdurgin@redhat.com>
---
 drivers/block/rbd.c             |  5 +++--
 include/linux/ceph/osd_client.h | 10 ++++++----
 net/ceph/osd_client.c           | 25 +++++++++++++++++++------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4b9ba9f..65421eb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3103,8 +3103,9 @@ out:
 	return ret;
 }
 
-static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data,
-			 void *payload, int payload_len)
+static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
+			 u64 notifier_gid, void *data, void *payload,
+			 u32 payload_len)
 {
 	struct rbd_device *rbd_dev = (struct rbd_device *)data;
 	int ret;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index eab96b5..1c4e472 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -184,7 +184,7 @@ struct ceph_osd_event {
 	u64 cookie;
 	int one_shot;
 	struct ceph_osd_client *osdc;
-	void (*cb)(u64, u64, u8, void *, void *, int);
+	void (*cb)(u64, u64, u8, s32, u64, void *, void *, u32);
 	void *data;
 	struct rb_node node;
 	struct list_head osd_node;
@@ -197,8 +197,10 @@ struct ceph_osd_event_work {
         u64 ver;
         u64 notify_id;
         u8 opcode;
+	s32 return_code;
+	u64 notifier_gid;
 	void *payload;
-	int payload_len;
+	u32 payload_len;
 };
 
 struct ceph_osd_client {
@@ -371,8 +373,8 @@ extern int ceph_osdc_writepages(struct ceph_osd_client *osdc,
 
 /* watch/notify events */
 extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
-				  void (*event_cb)(u64, u64, u8, void *, void *,
-						   int),
+				  void (*event_cb)(u64, u64, u8, s32, u64,
+						   void *, void *, u32),
 				  void *data, struct ceph_osd_event **pevent);
 extern void ceph_osdc_cancel_event(struct ceph_osd_event *event);
 extern void ceph_osdc_put_event(struct ceph_osd_event *event);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index aa1c5c46..8d96a52 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2277,7 +2277,8 @@ static void __remove_event(struct ceph_osd_event *event)
 }
 
 int ceph_osdc_create_event(struct ceph_osd_client *osdc,
-			   void (*event_cb)(u64, u64, u8, void *, void *, int),
+			   void (*event_cb)(u64, u64, u8, s32, u64, void *,
+					    void *, u32),
 			   void *data, struct ceph_osd_event **pevent)
 {
 	struct ceph_osd_event *event;
@@ -2327,10 +2328,12 @@ static void do_event_work(struct work_struct *work)
 	u64 ver = event_work->ver;
 	u64 notify_id = event_work->notify_id;
 	u8 opcode = event_work->opcode;
+	s32 return_code = event_work->return_code;
+	u64 notifier_gid = event_work->notifier_gid;
 
 	dout("do_event_work completing %p\n", event);
-	event->cb(ver, notify_id, opcode, event->data, event_work->payload,
-		  event_work->payload_len);
+	event->cb(ver, notify_id, opcode, return_code, notifier_gid,
+		  event->data, event_work->payload, event_work->payload_len);
 	dout("do_event_work completed %p\n", event);
 	ceph_osdc_put_event(event);
 	kfree(event_work);
@@ -2345,9 +2348,10 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 {
 	void *p, *end, *payload = NULL;
 	u8 proto_ver;
-	u64 cookie, ver, notify_id;
+	u64 cookie, ver, notify_id, notifier_gid = 0;
 	u8 opcode;
 	u32 payload_len = 0;
+	s32 return_code = 0;
 	struct ceph_osd_event *event;
 	struct ceph_osd_event_work *event_work;
 
@@ -2365,8 +2369,15 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 		if (end - p < payload_len)
 			goto bad;
 		payload = p;
+		p += payload_len;
 	}
 
+	if (msg->hdr.version >= 2)
+		ceph_decode_32_safe(&p, end, return_code, bad);
+
+	if (msg->hdr.version >= 3)
+		ceph_decode_64_safe(&p, end, notifier_gid, bad);
+
 	spin_lock(&osdc->event_lock);
 	event = __find_event(osdc, cookie);
 	if (event) {
@@ -2374,8 +2385,8 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 		get_event(event);
 	}
 	spin_unlock(&osdc->event_lock);
-	dout("handle_watch_notify cookie %lld ver %lld event %p notify id %llu payload len %u\n",
-	     cookie, ver, event, notify_id, payload_len);
+	dout("handle_watch_notify cookie %lld ver %lld event %p notify id %llu payload len %u return code %d notifier gid %llu\n",
+	     cookie, ver, event, notify_id, payload_len, return_code, notifier_gid);
 	if (event) {
 		event_work = kmalloc(sizeof(*event_work), GFP_NOIO);
 		if (!event_work) {
@@ -2388,6 +2399,8 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 		event_work->ver = ver;
 		event_work->notify_id = notify_id;
 		event_work->opcode = opcode;
+		event_work->return_code = return_code;
+		event_work->notifier_gid = notifier_gid;
 		event_work->payload = payload;
 		event_work->payload_len = payload_len;
 
-- 
1.9.3

