From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCHv2 4/6] osd_client, rbd: update event interface for watch/notify2
Date: Wed, 17 Jun 2015 07:25:54 -0700
Message-ID: <7fbb2dc2af702d07326369133839eab5e09054c3.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48952 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbbFQO1x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 10:27:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id C04263582C7
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 14:27:53 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5HERn6P030474
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 10:27:53 -0400
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
In-Reply-To: <cover.1434550968.git.dfuller@redhat.com>
References: <cover.1434550968.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Change unused ceph_osd_event structure to refer to pending watch/notify2
messages. Watch events include the separate watch and watch error callbacks
used for watch/notify2. Update rbd to use separate watch and watch error
callbacks via the new watch event.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 drivers/block/rbd.c             |  39 ++++++---
 include/linux/ceph/osd_client.h |  27 +++++--
 net/ceph/osd_client.c           | 173 +++++++++++++++++++++++++++++-----------
 3 files changed, 175 insertions(+), 64 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ed170b1..ffe9eb6 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -427,6 +427,8 @@ static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
 				       size_t count);
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, bool mapping);
 static void rbd_spec_put(struct rbd_spec *spec);
+static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev);
+static void rbd_dev_header_unwatch_sync(struct rbd_device *rbd_dev);
 
 static int rbd_dev_id_to_minor(int dev_id)
 {
@@ -3103,19 +3105,17 @@ out:
 	return ret;
 }
 
-static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
-			 u64 notifier_gid, void *data, void *payload,
-			 u32 payload_len)
+static void rbd_watch_cb(void *arg, u64 notify_id, u64 cookie, u64 notifier_id,
+                        void *data, size_t data_len)
 {
-	struct rbd_device *rbd_dev = (struct rbd_device *)data;
+	struct rbd_device *rbd_dev = (struct rbd_device *)arg;
 	int ret;
 
 	if (!rbd_dev)
 		return;
 
-	dout("%s: \"%s\" notify_id %llu opcode %u\n", __func__,
-		rbd_dev->header_name, (unsigned long long)notify_id,
-		(unsigned int)opcode);
+	dout("%s: \"%s\" notify_id %llu bl len %lu\n", __func__,
+	    rbd_dev->header_name, (unsigned long long)notify_id, data_len);
 
 	/*
 	 * Until adequate refresh error handling is in place, there is
@@ -3132,6 +3132,24 @@ static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, s32 return_code,
 		rbd_warn(rbd_dev, "notify_ack ret %d", ret);
 }
 
+static void rbd_watch_error_cb(void *arg, u64 cookie, int err)
+{
+	struct rbd_device *rbd_dev = (struct rbd_device *)arg;
+	int ret;
+
+	dout("%s: watch error %d on cookie %llu\n", rbd_dev->header_name,
+		err, cookie);
+	rbd_warn(rbd_dev, "%s: watch error %d on cookie %llu\n",
+	         rbd_dev->header_name, err, cookie);
+
+	/* reset watch */
+	rbd_dev_header_unwatch_sync(rbd_dev);
+	ret = rbd_dev_header_watch_sync(rbd_dev);
+	rbd_dev_refresh(rbd_dev);
+	if (ret)
+		rbd_warn(rbd_dev, "refresh failed: %d", ret);
+}
+
 /*
  * Send a (un)watch request and wait for the ack.  Return a request
  * with a ref held on success or error.
@@ -3199,13 +3217,14 @@ static int rbd_dev_header_watch_sync(struct rbd_device *rbd_dev)
 	rbd_assert(!rbd_dev->watch_event);
 	rbd_assert(!rbd_dev->watch_request);
 
-	ret = ceph_osdc_create_event(osdc, rbd_watch_cb, rbd_dev,
-				     &rbd_dev->watch_event);
+	ret = ceph_osdc_create_watch_event(osdc, rbd_watch_cb,
+	                                  rbd_watch_error_cb,
+	                                  rbd_dev, &rbd_dev->watch_event);
 	if (ret < 0)
 		return ret;
 
 	obj_request = rbd_obj_watch_request_helper(rbd_dev,
-						CEPH_OSD_WATCH_OP_LEGACY_WATCH);
+						CEPH_OSD_WATCH_OP_WATCH);
 	if (IS_ERR(obj_request)) {
 		ceph_osdc_cancel_event(rbd_dev->watch_event);
 		rbd_dev->watch_event = NULL;
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 12732d3..c673d75 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -108,6 +108,7 @@ struct ceph_osd_req_op {
 			u64 ver;
 			__u8 op;
 			u32 gen;
+			struct ceph_osd_data request_data;
 		} watch;
 		struct {
 			u64 cookie;
@@ -186,13 +187,21 @@ struct ceph_request_redirect {
 
 struct ceph_osd_event {
 	u64 cookie;
-	int one_shot;
 	struct ceph_osd_client *osdc;
-	void (*cb)(u64, u64, u8, s32, u64, void *, void *, u32);
+	struct ceph_osd_request *osd_req;
 	void *data;
 	struct rb_node node;
-	struct list_head osd_node;
 	struct kref kref;
+	union {
+		struct {
+			void (*watchcb)(void *, u64, u64, u64, void *, size_t);
+			void (*errcb)(void *, u64, int);
+		} watch;
+		struct {
+			struct ceph_msg_data *notify_data;
+			struct completion complete;
+		} notify;
+	};
 };
 
 struct ceph_osd_event_work {
@@ -385,10 +394,14 @@ extern int ceph_osdc_writepages(struct ceph_osd_client *osdc,
 				struct page **pages, int nr_pages);
 
 /* watch/notify events */
-extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
-				  void (*event_cb)(u64, u64, u8, s32, u64,
-						   void *, void *, u32),
-				  void *data, struct ceph_osd_event **pevent);
+extern int ceph_osdc_create_watch_event(struct ceph_osd_client *osdc,
+                         void (*watchcb)(void *, u64, u64, u64, void *, size_t),
+                         void (*errcb)(void *, u64, int),
+                         void *data, struct ceph_osd_event **pevent);
+extern int ceph_osdc_create_notify_event(struct ceph_osd_client *osdc,
+                                         struct ceph_osd_event **pevent);
+extern void ceph_osdc_wait_event(struct ceph_osd_client *osdc,
+				struct ceph_osd_event *event);
 extern void ceph_osdc_cancel_event(struct ceph_osd_event *event);
 extern void ceph_osdc_put_event(struct ceph_osd_event *event);
 #endif
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2725a68..af05c0f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -37,7 +37,13 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 					struct ceph_osd_request *req);
 static void __enqueue_request(struct ceph_osd_request *req);
 static void __send_request(struct ceph_osd_client *osdc,
-			   struct ceph_osd_request *req);
+                           struct ceph_osd_request *req);
+static struct ceph_osd_event *__find_event(struct ceph_osd_client *osdc,
+                                           u64 cookie);
+static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
+                       u64 cookie, u64 notify_id, u32 payload_len,
+                       void *payload, s32 return_code, u64 notifier_gid,
+                       struct ceph_msg_data *data);
 
 /*
  * Implement client access to distributed object storage cluster.
@@ -616,10 +622,12 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 }
 EXPORT_SYMBOL(osd_req_op_xattr_init);
 
-void osd_req_op_notify_init(struct ceph_osd_request *osd_req, unsigned int which,
+void osd_req_op_notify_init(struct ceph_osd_request *osd_req,
+                            unsigned int which,
 			    u16 opcode, u64 cookie)
 {
-	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode);
+	struct ceph_osd_req_op *op = _osd_req_op_init(osd_req, which, opcode, 0);
+	struct ceph_osd_event *notify_event;
 
 	BUG_ON(opcode != CEPH_OSD_OP_NOTIFY);
 	op->watch.cookie = cookie;
@@ -2274,7 +2282,7 @@ void ceph_osdc_put_event(struct ceph_osd_event *event)
 EXPORT_SYMBOL(ceph_osdc_put_event);
 
 static void __insert_event(struct ceph_osd_client *osdc,
-			     struct ceph_osd_event *new)
+                           struct ceph_osd_event *new)
 {
 	struct rb_node **p = &osdc->event_tree.rb_node;
 	struct rb_node *parent = NULL;
@@ -2296,7 +2304,7 @@ static void __insert_event(struct ceph_osd_client *osdc,
 }
 
 static struct ceph_osd_event *__find_event(struct ceph_osd_client *osdc,
-					        u64 cookie)
+                                           u64 cookie)
 {
 	struct rb_node **p = &osdc->event_tree.rb_node;
 	struct rb_node *parent = NULL;
@@ -2328,27 +2336,60 @@ static void __remove_event(struct ceph_osd_event *event)
 	}
 }
 
-int ceph_osdc_create_event(struct ceph_osd_client *osdc,
-			   void (*event_cb)(u64, u64, u8, s32, u64, void *,
-					    void *, u32),
-			   void *data, struct ceph_osd_event **pevent)
+static struct ceph_osd_event *__alloc_event(struct ceph_osd_client *osdc,
+                                            void *data)
 {
 	struct ceph_osd_event *event;
 
 	event = kmalloc(sizeof(*event), GFP_NOIO);
 	if (!event)
-		return -ENOMEM;
+		return NULL;
 
 	dout("create_event %p\n", event);
-	event->cb = event_cb;
-	event->one_shot = 0;
 	event->data = data;
 	event->osdc = osdc;
-	INIT_LIST_HEAD(&event->osd_node);
+	event->osd_req = NULL;
 	RB_CLEAR_NODE(&event->node);
 	kref_init(&event->kref);   /* one ref for us */
 	kref_get(&event->kref);    /* one ref for the caller */
 
+	return event;
+}
+
+int ceph_osdc_create_watch_event(struct ceph_osd_client *osdc,
+                         void (*watchcb)(void *, u64, u64, u64, void *, size_t),
+                         void (*errcb)(void *, u64, int),
+                         void *data, struct ceph_osd_event **pevent)
+{
+	struct ceph_osd_event *event;
+	
+	event = __alloc_event(osdc, data);
+	if (!event)
+		return -ENOMEM;
+
+	event->watch.watchcb = watchcb;
+	event->watch.errcb = errcb;
+
+	spin_lock(&osdc->event_lock);
+	event->cookie = ++osdc->event_count;
+	__insert_event(osdc, event);
+	spin_unlock(&osdc->event_lock);
+	*pevent = event;
+	return 0;
+}
+EXPORT_SYMBOL(ceph_osdc_create_watch_event);
+
+int ceph_osdc_create_notify_event(struct ceph_osd_client *osdc,
+                                  struct ceph_osd_event **pevent)
+{
+	struct ceph_osd_event *event;
+	
+	event = __alloc_event(osdc, NULL);
+	if (!event)
+		return -ENOMEM;
+
+	init_completion(&event->notify.complete);
+
 	spin_lock(&osdc->event_lock);
 	event->cookie = ++osdc->event_count;
 	__insert_event(osdc, event);
@@ -2357,7 +2398,14 @@ int ceph_osdc_create_event(struct ceph_osd_client *osdc,
 	*pevent = event;
 	return 0;
 }
-EXPORT_SYMBOL(ceph_osdc_create_event);
+EXPORT_SYMBOL(ceph_osdc_create_notify_event);
+
+void ceph_osdc_wait_event(struct ceph_osd_client *osdc,
+                          struct ceph_osd_event *event)
+{
+	wait_for_completion(&event->notify.complete);
+}
+EXPORT_SYMBOL(ceph_osdc_wait_event);
 
 void ceph_osdc_cancel_event(struct ceph_osd_event *event)
 {
@@ -2377,20 +2425,78 @@ static void do_event_work(struct work_struct *work)
 	struct ceph_osd_event_work *event_work =
 		container_of(work, struct ceph_osd_event_work, work);
 	struct ceph_osd_event *event = event_work->event;
-	u64 ver = event_work->ver;
 	u64 notify_id = event_work->notify_id;
 	u8 opcode = event_work->opcode;
 	s32 return_code = event_work->return_code;
 	u64 notifier_gid = event_work->notifier_gid;
 
 	dout("do_event_work completing %p\n", event);
-	event->cb(ver, notify_id, opcode, return_code, notifier_gid,
-		  event->data, event_work->payload, event_work->payload_len);
+	if (opcode == CEPH_WATCH_EVENT_NOTIFY)
+		event->watch.watchcb(event->data, notify_id,
+		                     event->cookie, notifier_gid,
+		                     event_work->payload,
+		                     event_work->payload_len);
+	else if (opcode == CEPH_WATCH_EVENT_DISCONNECT && event->watch.errcb)
+		event->watch.errcb(event->data, event->cookie, return_code);
 	dout("do_event_work completed %p\n", event);
 	ceph_osdc_put_event(event);
 	kfree(event_work);
 }
 
+static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
+                       u64 cookie, u64 notify_id, u32 payload_len,
+                       void *payload, s32 return_code, u64 notifier_gid,
+                       struct ceph_msg_data *data)
+{
+	struct ceph_osd_event *event;
+	struct ceph_osd_event_work *event_work;
+
+	spin_lock(&osdc->event_lock);
+	event = __find_event(osdc, cookie);
+	if (event)
+		get_event(event);
+	spin_unlock(&osdc->event_lock);
+
+	dout("handle_watch_notify cookie %lld event %p notify id %llu payload "
+	     "len %u return code %d notifier gid %llu\n",
+             cookie, event, notify_id, payload_len, return_code, notifier_gid);
+	switch(opcode) {
+		case CEPH_WATCH_EVENT_NOTIFY:
+		case CEPH_WATCH_EVENT_DISCONNECT:
+			if (event) {
+				event_work = kmalloc(sizeof(*event_work),
+				                     GFP_NOIO);
+				if (!event_work) {
+					pr_err("couldn't allocate event_work\n");
+					ceph_osdc_put_event(event);
+					return;
+				}
+				INIT_WORK(&event_work->work, do_event_work);
+				event_work->event = event;
+				event_work->notify_id = notify_id;
+				event_work->opcode = opcode;
+				event_work->return_code = return_code;
+				event_work->notifier_gid = notifier_gid;
+				event_work->payload = payload;
+				event_work->payload_len = payload_len;
+
+				queue_work(osdc->notify_wq, &event_work->work);
+			}
+			break;
+		case CEPH_WATCH_EVENT_NOTIFY_COMPLETE:
+			if (event) {
+				event->notify.notify_data = data;
+				if (event->osd_req) {
+					ceph_osdc_cancel_request(event->osd_req);
+					event->osd_req = NULL;
+				}
+				complete_all(&event->notify.complete);
+			}
+			break;
+		default:
+			BUG();
+	}
+}
 
 /*
  * Process osd watch notifications
@@ -2399,13 +2505,12 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 				struct ceph_msg *msg)
 {
 	void *p, *end, *payload = NULL;
+	struct ceph_msg_data *data = NULL;
 	u8 proto_ver;
 	u64 cookie, ver, notify_id, notifier_gid = 0;
 	u8 opcode;
 	u32 payload_len = 0;
 	s32 return_code = 0;
-	struct ceph_osd_event *event;
-	struct ceph_osd_event_work *event_work;
 
 	p = msg->front.iov_base;
 	end = p + msg->front.iov_len;
@@ -2430,34 +2535,8 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
 	if (msg->hdr.version >= 3)
 		ceph_decode_64_safe(&p, end, notifier_gid, bad);
 
-	spin_lock(&osdc->event_lock);
-	event = __find_event(osdc, cookie);
-	if (event) {
-		BUG_ON(event->one_shot);
-		get_event(event);
-	}
-	spin_unlock(&osdc->event_lock);
-	dout("handle_watch_notify cookie %lld ver %lld event %p notify id %llu payload len %u return code %d notifier gid %llu\n",
-	     cookie, ver, event, notify_id, payload_len, return_code, notifier_gid);
-	if (event) {
-		event_work = kmalloc(sizeof(*event_work), GFP_NOIO);
-		if (!event_work) {
-			pr_err("couldn't allocate event_work\n");
-			ceph_osdc_put_event(event);
-			return;
-		}
-		INIT_WORK(&event_work->work, do_event_work);
-		event_work->event = event;
-		event_work->ver = ver;
-		event_work->notify_id = notify_id;
-		event_work->opcode = opcode;
-		event_work->return_code = return_code;
-		event_work->notifier_gid = notifier_gid;
-		event_work->payload = payload;
-		event_work->payload_len = payload_len;
-
-		queue_work(osdc->notify_wq, &event_work->work);
-	}
+	__do_event(osdc, opcode, cookie, notify_id, payload_len, payload,
+		return_code, notifier_gid, data);
 
 	return;
 
-- 
1.9.3

