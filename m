From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 2/6] libceph: add ceph_osdc_complete_writes
Date: Mon,  6 Feb 2017 08:29:23 -0500
Message-ID: <20170206132927.9219-3-jlayton@redhat.com>
References: <20170206132927.9219-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbdBFN3a (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Feb 2017 08:29:30 -0500
In-Reply-To: <20170206132927.9219-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, jspray@redhat.com

From: John Spray <john.spray@redhat.com>

When a Ceph volume hits capacity, a flag is set in the OSD map to
indicate that, and a new map is sprayed around the cluster. When the
cephfs client sees that, we want it to shut down any OSD writes that are
in-progress with an -ENOSPC error as they'll just hang otherwise.

Add a callback to the osdc that gets called on map updates and a way
for upper layers to register that callback.

[ jlayton: code style cleanup and adaptation to new osd msg handling ]

Signed-off-by: John Spray <john.spray@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/ceph/osd_client.h | 12 ++++++++++
 net/ceph/osd_client.c           | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index e7d7cf284cf4..34010c86b307 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -21,6 +21,7 @@ struct ceph_osd_client;
 /*
  * completion callback for async writepages
  */
+typedef void (*ceph_osdc_map_callback_t)(struct ceph_osd_client *, void *);
 typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *);
 typedef void (*ceph_osdc_unsafe_callback_t)(struct ceph_osd_request *, bool);
 
@@ -290,6 +291,9 @@ struct ceph_osd_client {
 	struct ceph_msgpool	msgpool_op_reply;
 
 	struct workqueue_struct	*notify_wq;
+
+	ceph_osdc_map_callback_t	map_cb;
+	void			*map_p;
 };
 
 static inline bool ceph_osdmap_flag(struct ceph_osd_client *osdc, int flag)
@@ -393,6 +397,7 @@ extern void ceph_osdc_put_request(struct ceph_osd_request *req);
 extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
 				   struct ceph_osd_request *req,
 				   bool nofail);
+extern u32 ceph_osdc_complete_writes(struct ceph_osd_client *osdc, int r);
 extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
 extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 				  struct ceph_osd_request *req);
@@ -459,5 +464,12 @@ int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
 			    struct ceph_object_locator *oloc,
 			    struct ceph_watch_item **watchers,
 			    u32 *num_watchers);
+
+static inline void ceph_osdc_register_map_cb(struct ceph_osd_client *osdc,
+        ceph_osdc_map_callback_t cb, void *data)
+{
+	osdc->map_cb = cb;
+	osdc->map_p = data;
+}
 #endif
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 90d190f8f791..aeee87a0e0da 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -18,6 +18,7 @@
 #include <linux/ceph/decode.h>
 #include <linux/ceph/auth.h>
 #include <linux/ceph/pagelist.h>
+#include <linux/lockdep.h>
 
 #define OSD_OPREPLY_FRONT_LEN	512
 
@@ -1782,6 +1783,51 @@ static void complete_request(struct ceph_osd_request *req, int err)
 	ceph_osdc_put_request(req);
 }
 
+/*
+ * Drop all pending write/modify requests and complete
+ * them with the `r` as return code.
+ *
+ * Returns the highest OSD map epoch of a request that was
+ * cancelled, or 0 if none were cancelled.
+ */
+u32 ceph_osdc_complete_writes(struct ceph_osd_client *osdc, int r)
+{
+	struct ceph_osd_request *req;
+	struct ceph_osd *osd;
+	struct rb_node *m, *n;
+	u32 latest_epoch = 0;
+
+	lockdep_assert_held(&osdc->lock);
+
+	dout("enter complete_writes r=%d\n", r);
+
+	for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
+		osd = rb_entry(n, struct ceph_osd, o_node);
+		m = rb_first(&osd->o_requests);
+		mutex_lock(&osd->lock);
+		while (m) {
+			req = rb_entry(m, struct ceph_osd_request, r_node);
+			m = rb_next(m);
+
+			if (req->r_flags & CEPH_OSD_FLAG_WRITE &&
+			    (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
+			     pool_full(osdc, req->r_t.base_oloc.pool))) {
+				u32 cur_epoch = le32_to_cpu(req->r_replay_version.epoch);
+
+				dout("%s: complete tid=%llu flags 0x%x\n", __func__, req->r_tid, req->r_flags);
+				complete_request(req, r);
+				if (cur_epoch > latest_epoch)
+					latest_epoch = cur_epoch;
+			}
+		}
+		mutex_unlock(&osd->lock);
+	}
+
+	dout("return complete_writes latest_epoch=%u\n", latest_epoch);
+	return latest_epoch;
+}
+EXPORT_SYMBOL(ceph_osdc_complete_writes);
+
 static void cancel_map_check(struct ceph_osd_request *req)
 {
 	struct ceph_osd_client *osdc = req->r_osdc;
@@ -3298,6 +3344,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 
 	ceph_monc_got_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
 			  osdc->osdmap->epoch);
+	if (osdc->map_cb)
+		osdc->map_cb(osdc, osdc->map_p);
 	up_write(&osdc->lock);
 	wake_up_all(&osdc->client->auth_wq);
 	return;
@@ -4116,6 +4164,8 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	osdc->linger_requests = RB_ROOT;
 	osdc->map_checks = RB_ROOT;
 	osdc->linger_map_checks = RB_ROOT;
+	osdc->map_cb = NULL;
+	osdc->map_p = NULL;
 	INIT_DELAYED_WORK(&osdc->timeout_work, handle_timeout);
 	INIT_DELAYED_WORK(&osdc->osds_timeout_work, handle_osds_timeout);
 
-- 
2.9.3

