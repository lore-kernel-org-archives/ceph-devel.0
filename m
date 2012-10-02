From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/12] mds: Consider stopping MDS when finding peer inode
Date: Tue,  2 Oct 2012 16:55:42 +0800
Message-ID: <1349168152-13281-2-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab2JBI4D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:03 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

To migrate strays, the receiving MDS need find stopping MDS' mdsdir

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index efa6671..1a93d9b 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -7225,8 +7225,9 @@ void MDCache::find_ino_peers(inodeno_t ino, Context *c, int hint)
 void MDCache::_do_find_ino_peer(find_ino_peer_info_t& fip)
 {
   set<int> all, active;
-  mds->mdsmap->get_active_mds_set(active);
   mds->mdsmap->get_mds_set(all);
+  mds->mdsmap->get_active_mds_set(active);
+  mds->mdsmap->get_mds_set(active, MDSMap::STATE_STOPPING);
 
   dout(10) << "_do_find_ino_peer " << fip.tid << " " << fip.ino
 	   << " active " << active << " all " << all
-- 
1.7.11.4

