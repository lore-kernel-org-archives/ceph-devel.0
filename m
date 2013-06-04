From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: initialize some member variables of MDCache
Date: Tue,  4 Jun 2013 11:19:25 +0800
Message-ID: <1370315966-10363-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3188 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab3FDDTa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Jun 2013 23:19:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

I added some member variables to class MDCache, but forget to
initialize them.

Fixes: #5236
Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 8c17172..e2ecba8 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -147,6 +147,7 @@ MDCache::MDCache(MDS *m)
                         (0.9 *(g_conf->osd_max_write_size << 20));
 
   discover_last_tid = 0;
+  open_ino_last_tid = 0;
   find_ino_peer_last_tid = 0;
 
   last_cap_id = 0;
@@ -155,6 +156,10 @@ MDCache::MDCache(MDS *m)
   client_lease_durations[1] = 30.0;
   client_lease_durations[2] = 300.0;
 
+  resolves_pending = false;
+  rejoins_pending = false;
+  cap_imports_num_opening = 0;
+
   opening_root = open = false;
   lru.lru_set_max(g_conf->mds_cache_size);
   lru.lru_set_midpoint(g_conf->mds_cache_mid);
-- 
1.8.1.4

