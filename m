From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 15/39] mds: don't send MDentry{Link,Unlink} before receiving cache rejoin
Date: Sun, 17 Mar 2013 22:51:18 +0800
Message-ID: <1363531902-24909-16-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3CQOwk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:40 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The active MDS calls MDCache::rejoin_scour_survivor_replicas() when it
receives the cache rejoin message. The function will remove the objects
replicated by MDentry{Link,Unlink} from replica map.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 69db1dd..f102205 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -3893,6 +3893,8 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
     }
   }
 
+  assert(rejoin_gather.count(from));
+  rejoin_gather.erase(from);
   if (survivor) {
     // survivor.  do everything now.
     for (map<inodeno_t,MMDSCacheRejoin::lock_bls>::iterator p = weak->inode_scatterlocks.begin();
@@ -3911,8 +3913,6 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
       mds->locker->eval_gather(*p);
   } else {
     // done?
-    assert(rejoin_gather.count(from));
-    rejoin_gather.erase(from);
     if (rejoin_gather.empty()) {
       rejoin_gather_finish();
     } else {
@@ -9582,7 +9582,9 @@ void MDCache::send_dentry_link(CDentry *dn)
   for (map<int,int>::iterator p = dn->replicas_begin(); 
        p != dn->replicas_end(); 
        ++p) {
-    if (mds->mdsmap->get_state(p->first) < MDSMap::STATE_REJOIN) 
+    if (mds->mdsmap->get_state(p->first) < MDSMap::STATE_REJOIN ||
+	(mds->mdsmap->get_state(p->first) == MDSMap::STATE_REJOIN &&
+	 rejoin_gather.count(p->first)))
       continue;
     CDentry::linkage_t *dnl = dn->get_linkage();
     MDentryLink *m = new MDentryLink(subtree->dirfrag(), dn->get_dir()->dirfrag(),
@@ -9668,6 +9670,11 @@ void MDCache::send_dentry_unlink(CDentry *dn, CDentry *straydn, MDRequest *mdr)
     if (mdr && mdr->more()->witnessed.count(it->first))
       continue;
 
+    if (mds->mdsmap->get_state(it->first) < MDSMap::STATE_REJOIN ||
+	(mds->mdsmap->get_state(it->first) == MDSMap::STATE_REJOIN &&
+	 rejoin_gather.count(it->first)))
+      continue;
+
     MDentryUnlink *unlink = new MDentryUnlink(dn->get_dir()->dirfrag(), dn->name);
     if (straydn)
       replicate_stray(straydn, it->first, unlink->straybl);
-- 
1.7.11.7

