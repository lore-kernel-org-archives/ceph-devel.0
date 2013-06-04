From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/9] libceph: fix safe completion
Date: Tue,  4 Jun 2013 11:19:50 +0800
Message-ID: <1370315998-10418-2-git-send-email-zheng.z.yan@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35828 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489Ab3FDDUv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:20:51 -0400
In-Reply-To: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

handle_reply() calls complete_request() only if the first OSD reply
has ONDISK flag.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 include/linux/ceph/osd_client.h |  1 -
 net/ceph/osd_client.c           | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 186db0b..ce6df39 100644
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
index a3395fd..536c0e5 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1525,6 +1525,8 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
 	for (i = 0; i < numops; i++)
 		req->r_reply_op_result[i] = ceph_decode_32(&p);
 
+	already_completed = req->r_got_reply;
+
 	if (!req->r_got_reply) {
 
 		req->r_result = result;
@@ -1555,16 +1557,14 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
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

