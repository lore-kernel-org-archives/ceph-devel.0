From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v4 3/6] libceph: add an epoch_barrier field to struct ceph_osd_client
Date: Thu,  9 Feb 2017 09:48:33 -0500
Message-ID: <20170209144836.12525-4-jlayton@redhat.com>
References: <20170209144836.12525-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753060AbdBIOsp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 09:48:45 -0500
In-Reply-To: <20170209144836.12525-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Cephfs can get cap update requests that contain a new epoch barrier in
them. When that happens we want to pause all OSD traffic until the right
map epoch arrives.

Add an epoch_barrier field to ceph_osd_client that is protected by the
osdc->lock rwsem. When the barrier is set, and the current OSD map
epoch is below that, pause the request target when submitting the
request or when revisiting it. Add a way for upper layers (cephfs)
to update the epoch_barrier as well.

If we get a new map, compare the new epoch against the barrier before
kicking requests and request another map if the map epoch is still lower
than the one we want.

If we end up cancelling requests because of a new map showing a full OSD
or pool condition, then set the barrier higher than the highest replay
epoch of all the cancelled requests.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/ceph/osd_client.h |  2 ++
 net/ceph/osd_client.c           | 51 +++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 5da666cc5891..b4e5a1b45f24 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -270,6 +270,7 @@ struct ceph_osd_client {
 	struct rb_root         osds;          /* osds */
 	struct list_head       osd_lru;       /* idle osds */
 	spinlock_t             osd_lru_lock;
+	u32		       epoch_barrier;
 	struct ceph_osd        homeless_osd;
 	atomic64_t             last_tid;      /* tid of last request */
 	u64                    last_linger_id;
@@ -308,6 +309,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
 				   struct ceph_msg *msg);
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);
+void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);
 
 extern void osd_req_op_init(struct ceph_osd_request *osd_req,
 			    unsigned int which, u16 opcode, u32 flags);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index cdb0b58c4c99..8f5ac958fef4 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1299,8 +1299,10 @@ static bool target_should_be_paused(struct ceph_osd_client *osdc,
 		       __pool_full(pi);
 
 	WARN_ON(pi->id != t->base_oloc.pool);
-	return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
-	       (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
+	return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
+	       ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) ||
+	       (osdc->epoch_barrier &&
+		osdc->osdmap->epoch < osdc->epoch_barrier);
 }
 
 enum calc_target_result {
@@ -1610,21 +1612,24 @@ static void send_request(struct ceph_osd_request *req)
 static void maybe_request_map(struct ceph_osd_client *osdc)
 {
 	bool continuous = false;
+	u32 epoch = osdc->osdmap->epoch;
 
 	verify_osdc_locked(osdc);
-	WARN_ON(!osdc->osdmap->epoch);
+	WARN_ON_ONCE(epoch == 0);
 
 	if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
 	    ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD) ||
-	    ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
+	    ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
+	    (osdc->epoch_barrier && epoch < osdc->epoch_barrier)) {
 		dout("%s osdc %p continuous\n", __func__, osdc);
 		continuous = true;
 	} else {
 		dout("%s osdc %p onetime\n", __func__, osdc);
 	}
 
+	++epoch;
 	if (ceph_monc_want_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
-			       osdc->osdmap->epoch + 1, continuous))
+			       epoch, continuous))
 		ceph_monc_renew_subs(&osdc->client->monc);
 }
 
@@ -1653,8 +1658,14 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 		goto promote;
 	}
 
-	if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
-	    ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
+	if (osdc->epoch_barrier &&
+	    osdc->osdmap->epoch < osdc->epoch_barrier) {
+		dout("req %p epoch %u barrier %u\n", req, osdc->osdmap->epoch,
+		     osdc->epoch_barrier);
+		req->r_t.paused = true;
+		maybe_request_map(osdc);
+	} else if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
+		   ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
 		dout("req %p pausewr\n", req);
 		req->r_t.paused = true;
 		maybe_request_map(osdc);
@@ -1779,7 +1790,8 @@ static void complete_request(struct ceph_osd_request *req, int err)
 
 /*
  * Drop all pending requests that are stalled waiting on a full condition to
- * clear, and complete them with ENOSPC as the return code.
+ * clear, and complete them with ENOSPC as the return code. Set the
+ * osdc->epoch_barrier to the latest replay version epoch that was aborted.
  */
 static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
 {
@@ -1815,7 +1827,11 @@ static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
 		mutex_unlock(&osd->lock);
 	}
 out:
-	dout("return abort_on_full latest_epoch=%u\n", latest_epoch);
+	if (latest_epoch)
+		osdc->epoch_barrier = max(latest_epoch + 1,
+					  osdc->epoch_barrier);
+	dout("return abort_on_full latest_epoch=%u barrier=%u\n", latest_epoch,
+					osdc->epoch_barrier);
 }
 
 static void cancel_map_check(struct ceph_osd_request *req)
@@ -3326,7 +3342,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		  ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
 		  have_pool_full(osdc);
-	if (was_pauserd || was_pausewr || pauserd || pausewr)
+	if (was_pauserd || was_pausewr || pauserd || pausewr ||
+	    (osdc->epoch_barrier && osdc->osdmap->epoch < osdc->epoch_barrier))
 		maybe_request_map(osdc);
 
 	kick_requests(osdc, &need_resend, &need_resend_linger);
@@ -3344,6 +3361,20 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	up_write(&osdc->lock);
 }
 
+void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb)
+{
+	down_read(&osdc->lock);
+	if (unlikely(eb > osdc->epoch_barrier)) {
+		up_read(&osdc->lock);
+		down_write(&osdc->lock);
+		osdc->epoch_barrier = max(eb, osdc->epoch_barrier);
+		up_write(&osdc->lock);
+	} else {
+		up_read(&osdc->lock);
+	}
+}
+EXPORT_SYMBOL(ceph_osdc_update_epoch_barrier);
+
 /*
  * Resubmit requests pending on the given osd.
  */
-- 
2.9.3

