From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: Hold caps_list_lock when adjusting caps_{use,total}_count
Date: Sat,  3 Nov 2012 10:32:37 +0800
Message-ID: <1351909957-15243-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:45937 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752156Ab2KCCcl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 2 Nov 2012 22:32:41 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index c633d1d..8072aef 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -236,8 +236,10 @@ static struct ceph_cap *get_cap(struct ceph_mds_client *mdsc,
 	if (!ctx) {
 		cap = kmem_cache_alloc(ceph_cap_cachep, GFP_NOFS);
 		if (cap) {
+			spin_lock(&mdsc->caps_list_lock);
 			mdsc->caps_use_count++;
 			mdsc->caps_total_count++;
+			spin_unlock(&mdsc->caps_list_lock);
 		}
 		return cap;
 	}
-- 
1.7.11.7

