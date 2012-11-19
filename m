From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/6] ceph: Hold caps_list_lock when adjusting caps_{use,total}_count
Date: Mon, 19 Nov 2012 10:49:05 +0800
Message-ID: <1353293349-15494-3-git-send-email-zheng.z.yan@intel.com>
References: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab2KSCtP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:49:15 -0500
In-Reply-To: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
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

