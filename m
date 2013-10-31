From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: wake up 'safe' waiters when unregistering request
Date: Thu, 31 Oct 2013 09:10:47 +0800
Message-ID: <1383181847-7041-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5422 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab3JaBKv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Oct 2013 21:10:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We also need to wake up 'safe' waiters if error occurs or request
aborted. Otherwise sync(2)/fsync(2) may hang forever.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8ef7926..cb6a7ae 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -643,6 +643,8 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
 		iput(req->r_unsafe_dir);
 		req->r_unsafe_dir = NULL;
 	}
+	
+	complete_all(&req->r_safe_completion);
 
 	ceph_mdsc_put_request(req);
 }
@@ -2186,7 +2188,6 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	if (head->safe) {
 		req->r_got_safe = true;
 		__unregister_request(mdsc, req);
-		complete_all(&req->r_safe_completion);
 
 		if (req->r_got_unsafe) {
 			/*
-- 
1.8.1.4

