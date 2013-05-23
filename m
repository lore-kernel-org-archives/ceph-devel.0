From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/30] mds: fix import cancel race
Date: Thu, 23 May 2013 16:06:36 +0800
Message-ID: <1369296418-14871-9-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab3EWINI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:08 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Current code uses import state to detect obsolete import discover/prep
message. it does not work for the case: cancel a subtree import, import
the same subtree again, the discover/prep message for the first import
get dispatched.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Migrator.cc | 65 +++++++++++++++++++++++++++--------------------------
 src/mds/Migrator.h  |  1 +
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 8103a52..59abb31 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1586,27 +1586,26 @@ void Migrator::handle_export_discover(MExportDirDiscover *m)
 
   dout(7) << "handle_export_discover on " << m->get_path() << dendl;
 
-  if (!mds->mdcache->is_open()) {
-    dout(5) << " waiting for root" << dendl;
-    mds->mdcache->wait_for_open(new C_MDS_RetryMessage(mds, m));
-    return;
-  }
-
   // note import state
   dirfrag_t df = m->get_dirfrag();
-  
   // only start discovering on this message once.
   if (!m->started) {
     m->started = true;
+    import_pending_msg[df] = m;
     import_state[df] = IMPORT_DISCOVERING;
     import_peer[df] = from;
+  } else {
+    // am i retrying after ancient path_traverse results?
+    if (import_pending_msg.count(df) == 0 || import_pending_msg[df] != m) {
+      dout(7) << " dropping obsolete message" << dendl;
+      m->put();
+      return;
+    }
   }
 
-  // am i retrying after ancient path_traverse results?
-  if (import_state.count(df) == 0 ||
-      import_state[df] != IMPORT_DISCOVERING) {
-    dout(7) << "hmm import_state is off, i must be obsolete lookup" << dendl;
-    m->put();
+  if (!mds->mdcache->is_open()) {
+    dout(5) << " waiting for root" << dendl;
+    mds->mdcache->wait_for_open(new C_MDS_RetryMessage(mds, m));
     return;
   }
 
@@ -1632,6 +1631,7 @@ void Migrator::handle_export_discover(MExportDirDiscover *m)
   dout(7) << "handle_export_discover have " << df << " inode " << *in << dendl;
   
   import_state[m->get_dirfrag()] = IMPORT_DISCOVERED;
+  import_pending_msg.erase(m->get_dirfrag());
 
   // pin inode in the cache (for now)
   assert(in->is_dir());
@@ -1646,6 +1646,7 @@ void Migrator::handle_export_discover(MExportDirDiscover *m)
 
 void Migrator::import_reverse_discovering(dirfrag_t df)
 {
+  import_pending_msg.erase(df);
   import_state.erase(df);
   import_peer.erase(df);
 }
@@ -1660,6 +1661,7 @@ void Migrator::import_reverse_discovered(dirfrag_t df, CInode *diri)
 
 void Migrator::import_reverse_prepping(CDir *dir)
 {
+  import_pending_msg.erase(dir->dirfrag());
   set<CDir*> bounds;
   cache->map_dirfrag_set(import_bound_ls[dir], bounds);
   import_remove_pins(dir, bounds);
@@ -1703,32 +1705,29 @@ void Migrator::handle_export_prep(MExportDirPrep *m)
   int oldauth = m->get_source().num();
   assert(oldauth != mds->get_nodeid());
 
-  // make sure we didn't abort
-  if (import_state.count(m->get_dirfrag()) == 0 ||
-      (import_state[m->get_dirfrag()] != IMPORT_DISCOVERED &&
-       import_state[m->get_dirfrag()] != IMPORT_PREPPING) ||
-      import_peer[m->get_dirfrag()] != oldauth) {
-    dout(10) << "handle_export_prep import has aborted, dropping" << dendl;
-    m->put();
-    return;
-  }
-
-  CInode *diri = cache->get_inode(m->get_dirfrag().ino);
-  assert(diri);
-  
+  CDir *dir;
+  CInode *diri;
   list<Context*> finished;
 
   // assimilate root dir.
-  CDir *dir;
-
   if (!m->did_assim()) {
+    diri = cache->get_inode(m->get_dirfrag().ino);
+    assert(diri);
     bufferlist::iterator p = m->basedir.begin();
     dir = cache->add_replica_dir(p, diri, oldauth, finished);
     dout(7) << "handle_export_prep on " << *dir << " (first pass)" << dendl;
   } else {
+    if (import_pending_msg.count(m->get_dirfrag()) == 0 ||
+	import_pending_msg[m->get_dirfrag()] != m) {
+      dout(7) << "handle_export_prep obsolete message, dropping" << dendl;
+      m->put();
+      return;
+    }
+
     dir = cache->get_dirfrag(m->get_dirfrag());
     assert(dir);
     dout(7) << "handle_export_prep on " << *dir << " (subsequent pass)" << dendl;
+    diri = dir->get_inode();
   }
   assert(dir->is_auth() == false);
 
@@ -1747,16 +1746,17 @@ void Migrator::handle_export_prep(MExportDirPrep *m)
   if (!m->did_assim()) {
     dout(7) << "doing assim on " << *dir << dendl;
     m->mark_assim();  // only do this the first time!
+    import_pending_msg[dir->dirfrag()] = m;
+
+    // change import state
+    import_state[dir->dirfrag()] = IMPORT_PREPPING;
+    import_bound_ls[dir] = m->get_bounds();
+    assert(g_conf->mds_kill_import_at != 3);
 
     // move pin to dir
     diri->put(CInode::PIN_IMPORTING);
     dir->get(CDir::PIN_IMPORTING);  
     dir->state_set(CDir::STATE_IMPORTING);
-
-    // change import state
-    import_state[dir->dirfrag()] = IMPORT_PREPPING;
-    assert(g_conf->mds_kill_import_at != 3);
-    import_bound_ls[dir] = m->get_bounds();
     
     // bystander list
     import_bystanders[dir] = m->get_bystanders();
@@ -1872,6 +1872,7 @@ void Migrator::handle_export_prep(MExportDirPrep *m)
   
   // note new state
   import_state[dir->dirfrag()] = IMPORT_PREPPED;
+  import_pending_msg.erase(dir->dirfrag());
   assert(g_conf->mds_kill_import_at != 4);
   // done 
   m->put();
diff --git a/src/mds/Migrator.h b/src/mds/Migrator.h
index f395bc1..70b59bc 100644
--- a/src/mds/Migrator.h
+++ b/src/mds/Migrator.h
@@ -116,6 +116,7 @@ public:
 protected:
   map<dirfrag_t,int>              import_state;  // FIXME make these dirfrags
   map<dirfrag_t,int>              import_peer;
+  map<dirfrag_t,Message*>         import_pending_msg;
   map<CDir*,set<int> >            import_bystanders;
   map<CDir*,list<dirfrag_t> >     import_bound_ls;
   map<CDir*,list<ScatterLock*> >  import_updated_scatterlocks;
-- 
1.8.1.4

