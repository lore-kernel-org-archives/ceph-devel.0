From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/9] libceph: call r_unsafe_callback when unsafe reply is received
Date: Tue,  4 Jun 2013 11:19:51 +0800
Message-ID: <1370315998-10418-3-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11730 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489Ab3FDDVK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:21:10 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We can't use !req->r_sent to check if OSD request is sent for the
first time, this is because __cancel_request() zeros req->r_sent
when OSD map changes. Rather than adding a new variable to
ceph_osd_request to indicate if it's sent for the first time, We
can call the unsafe callback only when unsafe OSD reply is received.
If OSD's first reply is safe, just skip calling the unsafe callback.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 net/ceph/osd_client.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 536c0e5..6972d17 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1338,10 +1338,6 @@ static void __send_request(struct ceph_osd_client *osdc,
 
 	ceph_msg_get(req->r_request); /* send consumes a ref */
 
-	/* Mark the request unsafe if this is the first timet's being sent. */
-
-	if (!req->r_sent && req->r_unsafe_callback)
-		req->r_unsafe_callback(req, true);
 	req->r_sent = req->r_osd->o_incarnation;
 
 	ceph_con_send(&req->r_osd->o_con, req->r_request);
@@ -1432,8 +1428,6 @@ static void handle_osds_timeout(struct work_struct *work)
 
 static void complete_request(struct ceph_osd_request *req)
 {
-	if (req->r_unsafe_callback)
-		req->r_unsafe_callback(req, false);
 	complete_all(&req->r_safe_completion);  /* fsync waiter */
 }
 
@@ -1560,14 +1554,20 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 	mutex_unlock(&osdc->request_mutex);
 
 	if (!already_completed) {
+		if (req->r_unsafe_callback &&
+		    result >= 0 && !(flags & CEPH_OSD_FLAG_ONDISK))
+			req->r_unsafe_callback(req, true);
 		if (req->r_callback)
 			req->r_callback(req, msg);
 		else
 			complete_all(&req->r_completion);
 	}
 
-	if (flags & CEPH_OSD_FLAG_ONDISK)
+	if (flags & CEPH_OSD_FLAG_ONDISK) {
+		if (req->r_unsafe_callback && already_completed)
+			req->r_unsafe_callback(req, false);
 		complete_request(req);
+	}
 
 done:
 	dout("req=%p req->r_linger=%d\n", req, req->r_linger);
-- 
1.8.1.4

