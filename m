From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 28/30] mds: move fetch_backtrace() to class MDCache
Date: Thu, 23 May 2013 16:06:56 +0800
Message-ID: <1369296418-14871-29-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51309 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757151Ab3EWINY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:24 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We may want to fetch backtrace while corresponding inode isn't
instantiated. MDCache::fetch_backtrace() will be used by later
patch.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc  | 51 ++++++++-------------------------------------------
 src/mds/CInode.h   |  5 +----
 src/mds/MDCache.cc | 52 ++++++++++++++++++++++++++++++++--------------------
 src/mds/MDCache.h  |  5 ++++-
 4 files changed, 45 insertions(+), 68 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 3a920c9..7943cea 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -973,63 +973,28 @@ void CInode::_fetched(bufferlist& bl, bufferlist& bl2, Context *fin)
   delete fin;
 }
 
-class C_CInode_FetchedBacktrace : public Context {
-  CInode *in;
-  inode_backtrace_t *backtrace;
-  Context *fin;
-public:
-  bufferlist bl;
-  C_CInode_FetchedBacktrace(CInode *i, inode_backtrace_t *bt, Context *f) :
-    in(i), backtrace(bt), fin(f) {}
-
-  void finish(int r) {
-    if (r == 0) {
-      in->_fetched_backtrace(&bl, backtrace, fin);
-    } else {
-      fin->finish(r);
-    }
-  }
-};
-
-void CInode::fetch_backtrace(inode_backtrace_t *bt, Context *fin)
-{
-  object_t oid = get_object_name(ino(), frag_t(), "");
-  object_locator_t oloc(inode.layout.fl_pg_pool);
-
-  SnapContext snapc;
-  C_CInode_FetchedBacktrace *c = new C_CInode_FetchedBacktrace(this, bt, fin);
-  mdcache->mds->objecter->getxattr(oid, oloc, "parent", CEPH_NOSNAP, &c->bl, 0, c);
-}
-
-void CInode::_fetched_backtrace(bufferlist *bl, inode_backtrace_t *bt, Context *fin)
-{
-  ::decode(*bt, *bl);
-  if (fin) {
-    fin->finish(0);
-  }
-}
-
-void CInode::build_backtrace(int64_t location, inode_backtrace_t* bt)
+void CInode::build_backtrace(int64_t pool, inode_backtrace_t& bt)
 {
-  bt->ino = inode.ino;
-  bt->ancestors.clear();
+  bt.ino = inode.ino;
+  bt.ancestors.clear();
+  bt.pool = pool;
 
   CInode *in = this;
   CDentry *pdn = get_parent_dn();
   while (pdn) {
     CInode *diri = pdn->get_dir()->get_inode();
-    bt->ancestors.push_back(inode_backpointer_t(diri->ino(), pdn->name, in->inode.version));
+    bt.ancestors.push_back(inode_backpointer_t(diri->ino(), pdn->name, in->inode.version));
     in = diri;
     pdn = in->get_parent_dn();
   }
   vector<int64_t>::iterator i = inode.old_pools.begin();
   while(i != inode.old_pools.end()) {
     // don't add our own pool id to old_pools to avoid looping (e.g. setlayout 0, 1, 0)
-    if (*i == location) {
+    if (*i == pool) {
       ++i;
       continue;
     }
-    bt->old_pools.insert(*i);
+    bt.old_pools.insert(*i);
     ++i;
   }
 }
@@ -1058,7 +1023,7 @@ void CInode::store_backtrace(Context *fin)
     pool = inode.layout.fl_pg_pool;
 
   inode_backtrace_t bt;
-  build_backtrace(pool, &bt);
+  build_backtrace(pool, bt);
   bufferlist bl;
   ::encode(bt, bl);
 
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index ba87bcb..2533774 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -535,10 +535,7 @@ private:
   void fetch(Context *fin);
   void _fetched(bufferlist& bl, bufferlist& bl2, Context *fin);  
 
-  void fetch_backtrace(inode_backtrace_t *bt, Context *fin);
-  void _fetched_backtrace(bufferlist *bl, inode_backtrace_t *bt, Context *fin);
-
-  void build_backtrace(int64_t location, inode_backtrace_t* bt);
+  void build_backtrace(int64_t pool, inode_backtrace_t& bt);
   void store_backtrace(Context *fin);
   void _stored_backtrace(version_t v, Context *fin);
   void _mark_dirty_parent(LogSegment *ls, bool dirty_pool=false);
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 00ba4eb..cd47786 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8637,6 +8637,20 @@ void MDCache::eval_remote(CDentry *dn)
   }
 }
 
+void MDCache::fetch_backtrace(inodeno_t ino, int64_t pool, bufferlist& bl, Context *fin)
+{
+  object_t oid = CInode::get_object_name(ino, frag_t(), "");
+  mds->objecter->getxattr(oid, object_locator_t(pool), "parent", CEPH_NOSNAP, &bl, 0, fin);
+}
+
+void MDCache::remove_backtrace(inodeno_t ino, int64_t pool, Context *fin)
+{
+  SnapContext snapc;
+  object_t oid = CInode::get_object_name(ino, frag_t(), "");
+  mds->objecter->removexattr(oid, object_locator_t(pool), "parent", snapc,
+			     ceph_clock_now(g_ceph_context), 0, NULL, fin);
+}
+
 class C_MDC_PurgeStrayPurged : public Context {
   MDCache *cache;
   CDentry *dn;
@@ -8651,13 +8665,12 @@ public:
 class C_MDC_PurgeForwardingPointers : public Context {
   MDCache *cache;
   CDentry *dn;
-  Context *fin;
 public:
-  inode_backtrace_t backtrace;
-  C_MDC_PurgeForwardingPointers(MDCache *c, CDentry *d, Context *f) :
-    cache(c), dn(d), fin(f) {}
+  bufferlist bl;
+  C_MDC_PurgeForwardingPointers(MDCache *c, CDentry *d) :
+    cache(c), dn(d) {}
   void finish(int r) {
-    cache->_purge_forwarding_pointers(&backtrace, dn, r, fin);
+    cache->_purge_forwarding_pointers(bl, dn, r);
   }
 };
 
@@ -8672,18 +8685,22 @@ public:
   }
 };
 
-void MDCache::_purge_forwarding_pointers(inode_backtrace_t *backtrace, CDentry *d, int r, Context *fin)
+void MDCache::_purge_forwarding_pointers(bufferlist& bl, CDentry *dn, int r)
 {
   assert(r == 0 || r == -ENOENT || r == -ENODATA);
+  inode_backtrace_t backtrace;
+  if (r == 0)
+    ::decode(backtrace, bl);
+
   // setup gathering context
   C_GatherBuilder gather_bld(g_ceph_context);
 
   // remove all the objects with forwarding pointer backtraces (aka sentinels)
-  for (set<int64_t>::const_iterator i = backtrace->old_pools.begin();
-       i != backtrace->old_pools.end();
+  for (set<int64_t>::const_iterator i = backtrace.old_pools.begin();
+       i != backtrace.old_pools.end();
        ++i) {
     SnapContext snapc;
-    object_t oid = CInode::get_object_name(backtrace->ino, frag_t(), "");
+    object_t oid = CInode::get_object_name(backtrace.ino, frag_t(), "");
     object_locator_t oloc(*i);
 
     mds->objecter->remove(oid, oloc, snapc, ceph_clock_now(g_ceph_context), 0,
@@ -8691,10 +8708,10 @@ void MDCache::_purge_forwarding_pointers(inode_backtrace_t *backtrace, CDentry *
   }
 
   if (gather_bld.has_subs()) {
-    gather_bld.set_finisher(fin);
+    gather_bld.set_finisher(new C_MDC_PurgeStray(this, dn));
     gather_bld.activate();
   } else {
-    fin->finish(r);
+    _purge_stray(dn, r);
   }
 }
 
@@ -8758,17 +8775,12 @@ void MDCache::purge_stray(CDentry *dn)
   if (in->is_dir()) {
     dout(10) << "purge_stray dir ... implement me!" << dendl;  // FIXME XXX
     // remove the backtrace
-    SnapContext snapc;
-    object_t oid = CInode::get_object_name(in->ino(), frag_t(), "");
-    object_locator_t oloc(mds->mdsmap->get_metadata_pool());
-
-    mds->objecter->removexattr(oid, oloc, "parent", snapc, ceph_clock_now(g_ceph_context), 0,
-                               NULL, new C_MDC_PurgeStrayPurged(this, dn));
+    remove_backtrace(in->ino(), mds->mdsmap->get_metadata_pool(),
+		     new C_MDC_PurgeStrayPurged(this, dn));
   } else if (in->is_file()) {
     // get the backtrace before blowing away the object
-    C_MDC_PurgeStray *strayfin = new C_MDC_PurgeStray(this, dn);
-    C_MDC_PurgeForwardingPointers *fpfin = new C_MDC_PurgeForwardingPointers(this, dn, strayfin);
-    in->fetch_backtrace(&fpfin->backtrace, fpfin);
+    C_MDC_PurgeForwardingPointers *fin = new C_MDC_PurgeForwardingPointers(this, dn);
+    fetch_backtrace(in->ino(), in->get_inode().layout.fl_pg_pool, fin->bl, fin);
   } else {
     // not a dir or file; purged!
     _purge_stray_purged(dn);
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 3c73bef..b9a1ead 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -820,12 +820,15 @@ public:
       eval_stray(dn);
   }
 protected:
-  void _purge_forwarding_pointers(inode_backtrace_t *backtrace, CDentry *dn, int r, Context *fin);
+  void fetch_backtrace(inodeno_t ino, int64_t pool, bufferlist& bl, Context *fin);
+  void remove_backtrace(inodeno_t ino, int64_t pool, Context *fin);
+  void _purge_forwarding_pointers(bufferlist& bl, CDentry *dn, int r);
   void _purge_stray(CDentry *dn, int r);
   void purge_stray(CDentry *dn);
   void _purge_stray_purged(CDentry *dn, int r=0);
   void _purge_stray_logged(CDentry *dn, version_t pdv, LogSegment *ls);
   void _purge_stray_logged_truncate(CDentry *dn, LogSegment *ls);
+  friend class C_MDC_FetchedBacktrace;
   friend class C_MDC_PurgeForwardingPointers;
   friend class C_MDC_PurgeStray;
   friend class C_MDC_PurgeStrayLogged;
-- 
1.8.1.4

