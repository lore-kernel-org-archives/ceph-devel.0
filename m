From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v1 3/7] libceph: rename and export maybe_request_map
Date: Fri, 20 Jan 2017 10:17:34 -0500
Message-ID: <20170120151738.9584-4-jlayton@redhat.com>
References: <20170120151738.9584-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbdATPRl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 20 Jan 2017 10:17:41 -0500
In-Reply-To: <20170120151738.9584-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jspray@redhat.com, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

We need to be able to call this with the osdc->lock already held, so
ceph_osdc_maybe_request_map won't do. Rename and export it as
__ceph_osdc_maybe_request_map, and turn ceph_osdc_maybe_request_map
into a static inline helper that takes the osdc->lock and then calls
__ceph_osdc_maybe_request_map.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/ceph/osd_client.h |  9 ++++++++-
 net/ceph/osd_client.c           | 25 +++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 35f74c86533e..b1eeb5a86657 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -403,7 +403,14 @@ extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
 
 extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
-void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc);
+void __ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc);
+
+static inline void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc)
+{
+	down_read(&osdc->lock);
+	__ceph_osdc_maybe_request_map(osdc);
+	up_read(&osdc->lock);
+}
 
 int ceph_osdc_call(struct ceph_osd_client *osdc,
 		   struct ceph_object_id *oid,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 290968865a41..97c266f96708 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1608,7 +1608,7 @@ static void send_request(struct ceph_osd_request *req)
 	ceph_con_send(&osd->o_con, ceph_msg_get(req->r_request));
 }
 
-static void maybe_request_map(struct ceph_osd_client *osdc)
+void __ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc)
 {
 	bool continuous = false;
 
@@ -1628,6 +1628,7 @@ static void maybe_request_map(struct ceph_osd_client *osdc)
 			       osdc->osdmap->epoch + 1, continuous))
 		ceph_monc_renew_subs(&osdc->client->monc);
 }
+EXPORT_SYMBOL(__ceph_osdc_maybe_request_map);
 
 static void send_map_check(struct ceph_osd_request *req);
 
@@ -1657,12 +1658,12 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 	    ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
 		dout("req %p pausewr\n", req);
 		req->r_t.paused = true;
-		maybe_request_map(osdc);
+		__ceph_osdc_maybe_request_map(osdc);
 	} else if ((req->r_flags & CEPH_OSD_FLAG_READ) &&
 		   ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD)) {
 		dout("req %p pauserd\n", req);
 		req->r_t.paused = true;
-		maybe_request_map(osdc);
+		__ceph_osdc_maybe_request_map(osdc);
 	} else if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
 		   !(req->r_flags & (CEPH_OSD_FLAG_FULL_TRY |
 				     CEPH_OSD_FLAG_FULL_FORCE)) &&
@@ -1671,11 +1672,11 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 		dout("req %p full/pool_full\n", req);
 		pr_warn_ratelimited("FULL or reached pool quota\n");
 		req->r_t.paused = true;
-		maybe_request_map(osdc);
+		__ceph_osdc_maybe_request_map(osdc);
 	} else if (!osd_homeless(osd)) {
 		need_send = true;
 	} else {
-		maybe_request_map(osdc);
+		__ceph_osdc_maybe_request_map(osdc);
 	}
 
 	mutex_lock(&osd->lock);
@@ -2587,7 +2588,7 @@ static void handle_timeout(struct work_struct *work)
 	}
 
 	if (atomic_read(&osdc->num_homeless) || !list_empty(&slow_osds))
-		maybe_request_map(osdc);
+		__ceph_osdc_maybe_request_map(osdc);
 
 	while (!list_empty(&slow_osds)) {
 		struct ceph_osd *osd = list_first_entry(&slow_osds,
@@ -3327,7 +3328,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 		  ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
 		  ceph_osdc_have_pool_full(osdc);
 	if (was_pauserd || was_pausewr || pauserd || pausewr)
-		maybe_request_map(osdc);
+		__ceph_osdc_maybe_request_map(osdc);
 
 	kick_requests(osdc, &need_resend, &need_resend_linger);
 
@@ -3391,7 +3392,7 @@ static void osd_fault(struct ceph_connection *con)
 
 	if (!reopen_osd(osd))
 		kick_osd_requests(osd);
-	maybe_request_map(osdc);
+	__ceph_osdc_maybe_request_map(osdc);
 
 out_unlock:
 	up_write(&osdc->lock);
@@ -4060,14 +4061,6 @@ void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc)
 }
 EXPORT_SYMBOL(ceph_osdc_flush_notifies);
 
-void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc)
-{
-	down_read(&osdc->lock);
-	maybe_request_map(osdc);
-	up_read(&osdc->lock);
-}
-EXPORT_SYMBOL(ceph_osdc_maybe_request_map);
-
 /*
  * Execute an OSD class method on an object.
  *
-- 
2.9.3

