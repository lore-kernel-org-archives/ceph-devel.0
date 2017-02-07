From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 3/5] libceph: add an epoch_barrier field to struct ceph_osd_client
Date: Tue,  7 Feb 2017 07:28:26 -0500
Message-ID: <20170207122828.5550-4-jlayton@redhat.com>
References: <20170207122828.5550-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753685AbdBGM2b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 7 Feb 2017 07:28:31 -0500
In-Reply-To: <20170207122828.5550-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

Cephfs can get cap update requests that contain a new epoch barrier in
them. When that happens we want to pause all OSD traffic until the right
map epoch arrives. Add a way for the upper layers to set the epoch_barrier
in ceph_osd_client and fix libceph to pause requests until it has the
right map epoch.

Add an epoch_barrier field to ceph_osd_client that is protected by the
osdc->lock rwsem. When the barrier is set, and the current OSD map
epoch is below that, pause the request target when submitting the
request or when revisiting it.

If we get a new map, compare the new epoch against the barrier before
kicking requests and request another map if the map epoch is still lower
than the one we want.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/ceph/osd_client.h |  2 ++
 net/ceph/osd_client.c           | 42 +++++++++++++++++++++++++++++++++--------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 1aaf4851f180..d8114a0df4dd 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -271,6 +271,7 @@ struct ceph_osd_client {
 	struct rb_root         osds;          /* osds */
 	struct list_head       osd_lru;       /* idle osds */
 	spinlock_t             osd_lru_lock;
+	u32		       epoch_barrier;
 	struct ceph_osd        homeless_osd;
 	atomic64_t             last_tid;      /* tid of last request */
 	u64                    last_linger_id;
@@ -311,6 +312,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
 				   struct ceph_msg *msg);
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);
+void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);
 
 extern void osd_req_op_init(struct ceph_osd_request *osd_req,
 			    unsigned int which, u16 opcode, u32 flags);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5a4f60000a73..7957b2ba1541 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1300,8 +1300,10 @@ static bool target_should_be_paused(struct ceph_osd_client *osdc,
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
@@ -1611,21 +1613,24 @@ static void send_request(struct ceph_osd_request *req)
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
 
@@ -1654,8 +1659,14 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
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
@@ -3334,7 +3345,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		  ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
 		  have_pool_full(osdc);
-	if (was_pauserd || was_pausewr || pauserd || pausewr)
+	if (was_pauserd || was_pausewr || pauserd || pausewr ||
+	    (osdc->epoch_barrier && osdc->osdmap->epoch < osdc->epoch_barrier))
 		maybe_request_map(osdc);
 
 	kick_requests(osdc, &need_resend, &need_resend_linger);
@@ -3353,6 +3365,20 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
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

