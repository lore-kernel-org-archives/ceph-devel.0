From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v6 4/7] libceph: add an epoch_barrier field to struct ceph_osd_client
Date: Thu, 30 Mar 2017 14:07:04 -0400
Message-ID: <20170330180707.11137-4-jlayton@redhat.com>
References: <20170330180546.11021-1-jlayton@redhat.com>
 <20170330180707.11137-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934026AbdC3SHN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 14:07:13 -0400
In-Reply-To: <20170330180707.11137-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

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

If we get a map with a full pool, or at quota condition, then set the
barrier to the current epoch value.

Reviewed-by: "Yan, Zheng” <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/ceph/osd_client.h |  2 ++
 net/ceph/debugfs.c              |  3 ++-
 net/ceph/osd_client.c           | 48 +++++++++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 8cf644197b1a..85650b415e73 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -267,6 +267,7 @@ struct ceph_osd_client {
 	struct rb_root         osds;          /* osds */
 	struct list_head       osd_lru;       /* idle osds */
 	spinlock_t             osd_lru_lock;
+	u32		       epoch_barrier;
 	struct ceph_osd        homeless_osd;
 	atomic64_t             last_tid;      /* tid of last request */
 	u64                    last_linger_id;
@@ -305,6 +306,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
 				   struct ceph_msg *msg);
 extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
 				 struct ceph_msg *msg);
+void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);
 
 extern void osd_req_op_init(struct ceph_osd_request *osd_req,
 			    unsigned int which, u16 opcode, u32 flags);
diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index d7e63a4f5578..71ba13927b3d 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -62,7 +62,8 @@ static int osdmap_show(struct seq_file *s, void *p)
 		return 0;
 
 	down_read(&osdc->lock);
-	seq_printf(s, "epoch %d flags 0x%x\n", map->epoch, map->flags);
+	seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
+			osdc->epoch_barrier, map->flags);
 
 	for (n = rb_first(&map->pg_pools); n; n = rb_next(n)) {
 		struct ceph_pg_pool_info *pi =
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 4e56cd1ec265..3a94e8a1c7ff 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1298,8 +1298,9 @@ static bool target_should_be_paused(struct ceph_osd_client *osdc,
 		       __pool_full(pi);
 
 	WARN_ON(pi->id != t->base_oloc.pool);
-	return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
-	       (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
+	return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
+	       ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) ||
+	       (osdc->osdmap->epoch < osdc->epoch_barrier);
 }
 
 enum calc_target_result {
@@ -1609,13 +1610,15 @@ static void send_request(struct ceph_osd_request *req)
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
+	    epoch < osdc->epoch_barrier) {
 		dout("%s osdc %p continuous\n", __func__, osdc);
 		continuous = true;
 	} else {
@@ -1653,8 +1656,13 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
 		goto promote;
 	}
 
-	if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
-	    ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
+	if (osdc->osdmap->epoch < osdc->epoch_barrier) {
+		dout("req %p epoch %u barrier %u\n", req, osdc->osdmap->epoch,
+		     osdc->epoch_barrier);
+		req->r_t.paused = true;
+		maybe_request_map(osdc);
+	} else if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
+		   ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
 		dout("req %p pausewr\n", req);
 		req->r_t.paused = true;
 		maybe_request_map(osdc);
@@ -1808,7 +1816,8 @@ static void abort_request(struct ceph_osd_request *req, int err)
 
 /*
  * Drop all pending requests that are stalled waiting on a full condition to
- * clear, and complete them with ENOSPC as the return code.
+ * clear, and complete them with ENOSPC as the return code. Set the
+ * osdc->epoch_barrier to the latest replay version epoch that was aborted.
  */
 static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
 {
@@ -1836,8 +1845,10 @@ static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
 				abort_request(req, -ENOSPC);
 		}
 	}
+	/* Update the epoch barrier to current epoch */
+	osdc->epoch_barrier = osdc->osdmap->epoch;
 out:
-	dout("return abort_on_full\n");
+	dout("return abort_on_full barrier=%u\n", osdc->epoch_barrier);
 }
 
 static void check_pool_dne(struct ceph_osd_request *req)
@@ -3293,7 +3304,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	pausewr = ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
 		  ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
 		  have_pool_full(osdc);
-	if (was_pauserd || was_pausewr || pauserd || pausewr)
+	if (was_pauserd || was_pausewr || pauserd || pausewr ||
+	    osdc->osdmap->epoch < osdc->epoch_barrier)
 		maybe_request_map(osdc);
 
 	kick_requests(osdc, &need_resend, &need_resend_linger);
@@ -3311,6 +3323,24 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	up_write(&osdc->lock);
 }
 
+void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb)
+{
+	down_read(&osdc->lock);
+	if (unlikely(eb > osdc->epoch_barrier)) {
+		up_read(&osdc->lock);
+		down_write(&osdc->lock);
+		if (osdc->epoch_barrier < eb) {
+			dout("updating epoch_barrier from %u to %u\n",
+					osdc->epoch_barrier, eb);
+			osdc->epoch_barrier = eb;
+		}
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

