From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v6 3/7] libceph: abort already submitted but abortable requests when map or pool goes full
Date: Thu, 30 Mar 2017 14:07:03 -0400
Message-ID: <20170330180707.11137-3-jlayton@redhat.com>
References: <20170330180546.11021-1-jlayton@redhat.com>
 <20170330180707.11137-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933150AbdC3SHM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 14:07:12 -0400
In-Reply-To: <20170330180707.11137-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: jspray@redhat.com, ceph-devel@vger.kernel.org

When a Ceph volume hits capacity, a flag is set in the OSD map to
indicate that, and a new map is sprayed around the cluster. With cephfs
we want it to shut down any abortable requests that are in progress with
an -ENOSPC error as they'd just hang otherwise.

Add a new ceph_osdc_abort_on_full helper function to handle this. It
will first check whether there is an out-of-space condition in the
cluster and then walk the tree and abort any request that has
r_abort_on_full set with a -ENOSPC error. Call this new function
directly whenever we get a new OSD map.

Reviewed-by: "Yan, Zheng” <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 net/ceph/osd_client.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 781048990599..4e56cd1ec265 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1806,6 +1806,40 @@ static void abort_request(struct ceph_osd_request *req, int err)
 	complete_request(req, err);
 }
 
+/*
+ * Drop all pending requests that are stalled waiting on a full condition to
+ * clear, and complete them with ENOSPC as the return code.
+ */
+static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
+{
+	struct rb_node *n;
+	bool osdmap_full = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
+
+	dout("enter abort_on_full\n");
+
+	if (!osdmap_full && !have_pool_full(osdc))
+		goto out;
+
+	for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
+		struct ceph_osd *osd = rb_entry(n, struct ceph_osd, o_node);
+		struct rb_node *m;
+
+		m = rb_first(&osd->o_requests);
+		while (m) {
+			struct ceph_osd_request *req = rb_entry(m,
+					struct ceph_osd_request, r_node);
+			m = rb_next(m);
+
+			if (req->r_abort_on_full &&
+			    (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
+			     pool_full(osdc, req->r_t.target_oloc.pool)))
+				abort_request(req, -ENOSPC);
+		}
+	}
+out:
+	dout("return abort_on_full\n");
+}
+
 static void check_pool_dne(struct ceph_osd_request *req)
 {
 	struct ceph_osd_client *osdc = req->r_osdc;
@@ -3264,6 +3298,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 
 	kick_requests(osdc, &need_resend, &need_resend_linger);
 
+	ceph_osdc_abort_on_full(osdc);
 	ceph_monc_got_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
 			  osdc->osdmap->epoch);
 	up_write(&osdc->lock);
-- 
2.9.3

