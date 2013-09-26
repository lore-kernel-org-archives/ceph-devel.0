From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: cleanup aborted requests when re-sending requests.
Date: Thu, 26 Sep 2013 14:25:36 +0800
Message-ID: <1380176736-2949-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4373 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab3IZGZo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Sep 2013 02:25:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Aborted requests usually get cleared when the reply is received.
If MDS crashes, no reply will be received. So we need to cleanup
aborted requests when re-sending requests.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f51ab26..b959966 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1875,8 +1875,11 @@ static int __do_request(struct ceph_mds_client *mdsc,
 	int mds = -1;
 	int err = -EAGAIN;
 
-	if (req->r_err || req->r_got_result)
+	if (req->r_err || req->r_got_result) {
+		if (req->r_aborted)
+			__unregister_request(mdsc, req);
 		goto out;
+	}
 
 	if (req->r_timeout &&
 	    time_after_eq(jiffies, req->r_started + req->r_timeout)) {
-- 
1.8.1.4

