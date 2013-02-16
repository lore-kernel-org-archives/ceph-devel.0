From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/2] libceph: kill ceph_osdc_wait_event()
Date: Sat, 16 Feb 2013 10:38:01 -0600
Message-ID: <511FB5E9.4010800@inktank.com>
References: <511FB598.50603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:37764 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3BPQiF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:38:05 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so1563817qcs.6
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:38:03 -0800 (PST)
In-Reply-To: <511FB598.50603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are no actual users of ceph_osdc_wait_event().  This would
have been one-shot events, but we no longer support those so just
get rid of this function.

Since this leaves nothing else that waits for the completion of an
event, we can get rid of the completion in a struct ceph_osd_event.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/osd_client.h |    3 ---
 net/ceph/osd_client.c           |   18 ------------------
 2 files changed, 21 deletions(-)

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 39c55d6..388158f 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -107,7 +107,6 @@ struct ceph_osd_event {
 	struct rb_node node;
 	struct list_head osd_node;
 	struct kref kref;
-	struct completion completion;
 };

 struct ceph_osd_event_work {
@@ -275,8 +274,6 @@ extern int ceph_osdc_create_event(struct
ceph_osd_client *osdc,
 				  void (*event_cb)(u64, u64, u8, void *),
 				  void *data, struct ceph_osd_event **pevent);
 extern void ceph_osdc_cancel_event(struct ceph_osd_event *event);
-extern int ceph_osdc_wait_event(struct ceph_osd_event *event,
-				unsigned long timeout);
 extern void ceph_osdc_put_event(struct ceph_osd_event *event);
 #endif

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4322faa..ad6b8b3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1494,7 +1494,6 @@ int ceph_osdc_create_event(struct ceph_osd_client
*osdc,
 	RB_CLEAR_NODE(&event->node);
 	kref_init(&event->kref);   /* one ref for us */
 	kref_get(&event->kref);    /* one ref for the caller */
-	init_completion(&event->completion);

 	spin_lock(&osdc->event_lock);
 	event->cookie = ++osdc->event_count;
@@ -1530,7 +1529,6 @@ static void do_event_work(struct work_struct *work)

 	dout("do_event_work completing %p\n", event);
 	event->cb(ver, notify_id, opcode, event->data);
-	complete(&event->completion);
 	dout("do_event_work completed %p\n", event);
 	ceph_osdc_put_event(event);
 	kfree(event_work);
@@ -1588,7 +1586,6 @@ static void handle_watch_notify(struct
ceph_osd_client *osdc,
 	return;

 done_err:
-	complete(&event->completion);
 	ceph_osdc_put_event(event);
 	return;

@@ -1597,21 +1594,6 @@ bad:
 	return;
 }

-int ceph_osdc_wait_event(struct ceph_osd_event *event, unsigned long
timeout)
-{
-	int err;
-
-	dout("wait_event %p\n", event);
-	err = wait_for_completion_interruptible_timeout(&event->completion,
-							timeout * HZ);
-	ceph_osdc_put_event(event);
-	if (err > 0)
-		err = 0;
-	dout("wait_event %p returns %d\n", event, err);
-	return err;
-}
-EXPORT_SYMBOL(ceph_osdc_wait_event);
-
 /*
  * Register request, send initial attempt.
  */
-- 
1.7.9.5

