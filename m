From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 25/25] mds: fetch missing inodes from disk
Date: Wed, 23 Jan 2013 11:09:01 +0800
Message-ID: <1358910541-15535-26-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8242 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753069Ab3AWDJ1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:27 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The problem of fetching missing inodes from replicas is that replicated inodes
does not have up-to-date rstat and fragstat. So just fetch missing inodes from
disk

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/mds/MDCache.h  |  1 +
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 200aebe..6f778a2 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -4092,6 +4092,7 @@ void MDCache::rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack, set
 
 CInode *MDCache::rejoin_invent_inode(inodeno_t ino, snapid_t last)
 {
+  assert(0);
   CInode *in = new CInode(this, true, 1, last);
   in->inode.ino = ino;
   in->state_set(CInode::STATE_REJOINUNDEF);
@@ -4103,6 +4104,7 @@ CInode *MDCache::rejoin_invent_inode(inodeno_t ino, snapid_t last)
 
 CDir *MDCache::rejoin_invent_dirfrag(dirfrag_t df)
 {
+  assert(0);
   CInode *in = get_inode(df.ino);
   if (!in) {
     in = rejoin_invent_inode(df.ino, CEPH_NOSNAP);
@@ -4119,13 +4121,91 @@ CDir *MDCache::rejoin_invent_dirfrag(dirfrag_t df)
   return dir;
 }
 
+bool MDCache::rejoin_fetch_dirfrags(MMDSCacheRejoin *strong)
+{
+  int skipped = 0;
+  set<CDir*> fetch_queue;
+  for (map<dirfrag_t, MMDSCacheRejoin::dirfrag_strong>::iterator p = strong->strong_dirfrags.begin();
+       p != strong->strong_dirfrags.end();
+       ++p) {
+    CInode *diri = get_inode(p->first.ino);
+    if (!diri) {
+      skipped++;
+      continue;
+    }
+    CDir *dir = diri->get_dirfrag(p->first.frag);
+    if (dir && dir->is_complete())
+      continue;
+
+    set<CDir*> frags;
+    bool refragged = false;
+    if (!dir) {
+      if (diri->dirfragtree.is_leaf(p->first.frag))
+	dir = diri->get_or_open_dirfrag(this, p->first.frag);
+      else {
+	list<frag_t> ls;
+	diri->dirfragtree.get_leaves_under(p->first.frag, ls);
+	if (ls.empty())
+	  ls.push_back(diri->dirfragtree[p->first.frag.value()]);
+	for (list<frag_t>::iterator q = ls.begin(); q != ls.end(); ++q) {
+	  dir = diri->get_or_open_dirfrag(this, p->first.frag);
+	  frags.insert(dir);
+	}
+	refragged = true;
+      }
+    }
+
+    map<string_snap_t,MMDSCacheRejoin::dn_strong>& dmap = strong->strong_dentries[p->first];
+    for (map<string_snap_t,MMDSCacheRejoin::dn_strong>::iterator q = dmap.begin();
+	q != dmap.end();
+	++q) {
+      if (!q->second.is_primary())
+	continue;
+      CDentry *dn;
+      if (!refragged)
+	dn = dir->lookup(q->first.name, q->first.snapid);
+      else {
+	frag_t fg = diri->pick_dirfrag(q->first.name);
+	dir = diri->get_dirfrag(fg);
+	assert(dir);
+	dn = dir->lookup(q->first.name, q->first.snapid);
+      }
+      if (!dn) {
+	fetch_queue.insert(dir);
+	if (!refragged)
+	  break;
+	frags.erase(dir);
+	if (frags.empty())
+	  break;
+      }
+    }
+  }
+
+  if (!fetch_queue.empty()) {
+    dout(10) << "rejoin_fetch_dirfrags " << fetch_queue.size() << " dirfrags" << dendl;
+    strong->get();
+    C_GatherBuilder gather(g_ceph_context, new C_MDS_RetryMessage(mds, strong));
+    for (set<CDir*>::iterator p = fetch_queue.begin(); p != fetch_queue.end(); p++) {
+      CDir *dir = *p;
+      dir->fetch(gather.new_sub());
+    }
+    gather.activate();
+    return true;
+  }
+  assert(!skipped);
+  return false;
+}
+
 /* This functions DOES NOT put the passed message before returning */
 void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 {
   int from = strong->get_source().num();
 
   // only a recovering node will get a strong rejoin.
-  assert(mds->is_rejoin());      
+  assert(mds->is_rejoin());
+
+  if (rejoin_fetch_dirfrags(strong))
+    return;
 
   MMDSCacheRejoin *missing = 0;  // if i'm missing something..
   
@@ -4203,6 +4283,7 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
 	} else if (q->second.is_null()) {
 	  dn = dir->add_null_dentry(q->first.name, q->second.first, q->first.snapid);
 	} else {
+	  assert(0);
 	  CInode *in = get_inode(q->second.ino, q->first.snapid);
 	  if (!in) in = rejoin_invent_inode(q->second.ino, q->first.snapid);
 	  dn = dir->add_primary_dentry(q->first.name, in, q->second.first, q->first.snapid);
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index efb0b38..b4ff4c1 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -410,6 +410,7 @@ protected:
   void handle_cache_rejoin_weak(MMDSCacheRejoin *m);
   CInode* rejoin_invent_inode(inodeno_t ino, snapid_t last);
   CDir* rejoin_invent_dirfrag(dirfrag_t df);
+  bool rejoin_fetch_dirfrags(MMDSCacheRejoin *m);
   void handle_cache_rejoin_strong(MMDSCacheRejoin *m);
   void rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack, set<vinodeno_t>& acked_inodes);
   void handle_cache_rejoin_ack(MMDSCacheRejoin *m);
-- 
1.7.11.7

