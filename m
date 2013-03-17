From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 37/39] mds: eval inodes with caps imported by cache rejoin message
Date: Sun, 17 Mar 2013 22:51:40 +0800
Message-ID: <1363531902-24909-38-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932755Ab3CQOyG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:54:06 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 30687ec..24f1109 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -3823,6 +3823,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
 	dout(10) << " claiming cap import " << p->first << " client." << q->first << " on " << *in << dendl;
 	rejoin_import_cap(in, q->first, q->second, from);
       }
+      mds->locker->eval(in, CEPH_CAP_LOCKS, true);
     }
   } else {
     assert(mds->is_rejoin());
-- 
1.7.11.7

