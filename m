From: Josh Durgin <josh.durgin@inktank.com>
Subject: [PATCH 2/3] libceph: add function to ensure notifies are complete
Date: Wed, 28 Aug 2013 23:24:06 -0700
Message-ID: <1377757447-23515-3-git-send-email-josh.durgin@inktank.com>
References: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35214 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab3H2Ggh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 02:36:37 -0400
In-Reply-To: <1377757447-23515-1-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@inktank.com>

Without a way to flush the osd client's notify workqueue, a watch
event that is unregistered could continue receiving callbacks
indefinitely.

Unregistering the event simply means no new notifies are added to the
queue, but there may still be events in the queue that will call the
watch callback for the event. If the queue is flushed after the event
is unregistered, the caller can be sure no more watch callbacks will
occur for the canceled watch.

Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
---
 include/linux/ceph/osd_client.h |    2 ++
 net/ceph/osd_client.c           |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index ce6df39..8f47625 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -335,6 +335,8 @@ extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 				  struct ceph_osd_request *req);
 extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
 
+extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
+
 extern int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 			       struct ceph_vino vino,
 			       struct ceph_file_layout *layout,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 1606f74..2b4b32a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2216,6 +2216,17 @@ void ceph_osdc_sync(struct ceph_osd_client *osdc)
 EXPORT_SYMBOL(ceph_osdc_sync);
 
 /*
+ * Call all pending notify callbacks - for use after a watch is
+ * unregistered, to make sure no more callbacks for it will be invoked
+ */
+extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc)
+{
+	flush_workqueue(osdc->notify_wq);
+}
+EXPORT_SYMBOL(ceph_osdc_flush_notifies);
+
+
+/*
  * init, shutdown
  */
 int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
-- 
1.7.2.5

