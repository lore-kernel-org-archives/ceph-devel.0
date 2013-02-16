From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: kill ceph_osdc_create_event() "one_shot" parameter
Date: Sat, 16 Feb 2013 10:37:47 -0600
Message-ID: <511FB5DB.7070304@inktank.com>
References: <511FB598.50603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:54488 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3BPQhu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:37:50 -0500
Received: by mail-qa0-f44.google.com with SMTP id bv4so736535qab.10
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:37:49 -0800 (PST)
In-Reply-To: <511FB598.50603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is only one caller of ceph_osdc_create_event(), and it
provides 0 as its "one_shot" argument.  Get rid of that argument and
just use 0 in its place.

Replace the code in handle_watch_notify() that executes if one_shot
is nonzero in the event with a BUG_ON() call.

While modifying "osd_client.c", give handle_watch_notify() static
scope.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c             |    2 +-
 include/linux/ceph/osd_client.h |    3 +--
 net/ceph/osd_client.c           |   11 +++++------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 982963e..13ee789 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1744,7 +1744,7 @@ static int rbd_dev_header_watch_sync(struct
rbd_device *rbd_dev, int start)
 	rbd_assert(start ^ !!rbd_dev->watch_request);

 	if (start) {
-		ret = ceph_osdc_create_event(osdc, rbd_watch_cb, 0, rbd_dev,
+		ret = ceph_osdc_create_event(osdc, rbd_watch_cb, rbd_dev,
 						&rbd_dev->watch_event);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index c39e7ed..39c55d6 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -273,8 +273,7 @@ extern int ceph_osdc_writepages(struct
ceph_osd_client *osdc,
 /* watch/notify events */
 extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
 				  void (*event_cb)(u64, u64, u8, void *),
-				  int one_shot, void *data,
-				  struct ceph_osd_event **pevent);
+				  void *data, struct ceph_osd_event **pevent);
 extern void ceph_osdc_cancel_event(struct ceph_osd_event *event);
 extern int ceph_osdc_wait_event(struct ceph_osd_event *event,
 				unsigned long timeout);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cd3a489..4322faa 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1477,8 +1477,7 @@ static void __remove_event(struct ceph_osd_event
*event)

 int ceph_osdc_create_event(struct ceph_osd_client *osdc,
 			   void (*event_cb)(u64, u64, u8, void *),
-			   int one_shot, void *data,
-			   struct ceph_osd_event **pevent)
+			   void *data, struct ceph_osd_event **pevent)
 {
 	struct ceph_osd_event *event;

@@ -1488,7 +1487,7 @@ int ceph_osdc_create_event(struct ceph_osd_client
*osdc,

 	dout("create_event %p\n", event);
 	event->cb = event_cb;
-	event->one_shot = one_shot;
+	event->one_shot = 0;
 	event->data = data;
 	event->osdc = osdc;
 	INIT_LIST_HEAD(&event->osd_node);
@@ -1541,7 +1540,8 @@ static void do_event_work(struct work_struct *work)
 /*
  * Process osd watch notifications
  */
-void handle_watch_notify(struct ceph_osd_client *osdc, struct ceph_msg
*msg)
+static void handle_watch_notify(struct ceph_osd_client *osdc,
+				struct ceph_msg *msg)
 {
 	void *p, *end;
 	u8 proto_ver;
@@ -1562,9 +1562,8 @@ void handle_watch_notify(struct ceph_osd_client
*osdc, struct ceph_msg *msg)
 	spin_lock(&osdc->event_lock);
 	event = __find_event(osdc, cookie);
 	if (event) {
+		BUG_ON(event->one_shot);
 		get_event(event);
-		if (event->one_shot)
-			__remove_event(event);
 	}
 	spin_unlock(&osdc->event_lock);
 	dout("handle_watch_notify cookie %lld ver %lld event %p\n",
-- 
1.7.9.5

