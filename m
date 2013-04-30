From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] libceph: fix "safe" completion
Date: Tue, 30 Apr 2013 21:17:44 +0800
Message-ID: <1367327864-21408-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:33650 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760613Ab3D3NRw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Apr 2013 09:17:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

complete_request() is never called if the first OSD replay doesn't
have ONDISK flag.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 include/linux/ceph/osd_client.h |  1 -
 net/ceph/osd_client.c           | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 4191cd2..70f79fb 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -145,7 +145,6 @@ struct ceph_osd_request {
 	s32               r_reply_op_result[CEPH_OSD_MAX_OP];
 	int               r_got_reply;
 	int		  r_linger;
-	int		  r_completed;
 
 	struct ceph_osd_client *r_osdc;
 	struct kref       r_kref;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 57d8db5..8a5fc37 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1522,6 +1522,8 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 	for (i = 0; i < numops; i++)
 		req->r_reply_op_result[i] = ceph_decode_32(&p);
 
+	already_completed = req->r_got_reply;
+
 	if (!req->r_got_reply) {
 
 		req->r_result = result;
@@ -1552,16 +1554,14 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 	    ((flags & CEPH_OSD_FLAG_WRITE) == 0))
 		__unregister_request(osdc, req);
 
-	already_completed = req->r_completed;
-	req->r_completed = 1;
 	mutex_unlock(&osdc->request_mutex);
-	if (already_completed)
-		goto done;
 
-	if (req->r_callback)
-		req->r_callback(req, msg);
-	else
-		complete_all(&req->r_completion);
+	if (!already_completed) {
+		if (req->r_callback)
+			req->r_callback(req, msg);
+		else
+			complete_all(&req->r_completion);
+	}
 
 	if (flags & CEPH_OSD_FLAG_ONDISK)
 		complete_request(req);
-- 
1.8.1.4

