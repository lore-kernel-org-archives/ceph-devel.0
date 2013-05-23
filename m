From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 30/30] mds: open missing cap inodes
Date: Thu, 23 May 2013 16:06:58 +0800
Message-ID: <1369296418-14871-31-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51313 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757208Ab3EWIN1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:27 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When a recovering MDS enters reconnect stage, client sends reconnect
messages to it. The message lists open files, their path, and issued
caps. If an inode is not in the cache, the recovering MDS uses the
path client provides to determine if it's the inode's authority. If
not, the recovering MDS exports the inode's caps to other MDS. The
issue here is that the path client provides isn't always accuracy.

The fix is use recently added "open inode by ino" function to open
any missing cap inodes when the recovering MDS enters rejoin stage.
Send cache rejoin messages to other MDS after all caps' authorities
are determined.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc             | 205 ++++++++++++++++++++++++++++++-----------
 src/mds/MDCache.h              |  17 ++--
 src/mds/MDS.cc                 |   7 ++
 src/mds/MDS.h                  |   1 +
 src/mds/Server.cc              |  17 +---
 src/messages/MMDSCacheRejoin.h |  15 +--
 6 files changed, 175 insertions(+), 87 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 3ed6bd5..8a7a9d5 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2456,8 +2456,6 @@ void MDCache::resolve_start()
       adjust_subtree_auth(rootdir, CDIR_AUTH_UNKNOWN);
   }
   resolve_gather = recovery_set;
-  resolve_gather.erase(mds->get_nodeid());
-  rejoin_gather = resolve_gather;
 }
 
 void MDCache::send_resolves()
@@ -2989,7 +2987,6 @@ void MDCache::maybe_resolve_finish()
   if (mds->is_resolve()) {
     trim_unlinked_inodes();
     recalc_auth_bits();
-    trim_non_auth();
     mds->resolve_done();
   } else {
     maybe_send_pending_rejoins();
@@ -3471,6 +3468,15 @@ void MDCache::recalc_auth_bits()
  *   after recovery.
  */
 
+void MDCache::rejoin_start()
+{
+  dout(10) << "rejoin_start" << dendl;
+
+  rejoin_gather = recovery_set;
+  // need finish opening cap inodes before sending cache rejoins
+  rejoin_gather.insert(mds->get_nodeid());
+  process_imported_caps();
+}
 
 /*
  * rejoin phase!
@@ -3487,6 +3493,11 @@ void MDCache::rejoin_send_rejoins()
 {
   dout(10) << "rejoin_send_rejoins with recovery_set " << recovery_set << dendl;
 
+  if (rejoin_gather.count(mds->get_nodeid())) {
+    dout(7) << "rejoin_send_rejoins still processing imported caps, delaying" << dendl;
+    rejoins_pending = true;
+    return;
+  }
   if (!resolve_gather.empty()) {
     dout(7) << "rejoin_send_rejoins still waiting for resolves ("
 	    << resolve_gather << ")" << dendl;
@@ -3496,12 +3507,6 @@ void MDCache::rejoin_send_rejoins()
 
   map<int, MMDSCacheRejoin*> rejoins;
 
-  // encode cap list once.
-  bufferlist cap_export_bl;
-  if (mds->is_rejoin()) {
-    ::encode(cap_exports, cap_export_bl);
-    ::encode(cap_export_paths, cap_export_bl);
-  }
 
   // if i am rejoining, send a rejoin to everyone.
   // otherwise, just send to others who are rejoining.
@@ -3510,12 +3515,20 @@ void MDCache::rejoin_send_rejoins()
        ++p) {
     if (*p == mds->get_nodeid())  continue;  // nothing to myself!
     if (rejoin_sent.count(*p)) continue;     // already sent a rejoin to this node!
-    if (mds->is_rejoin()) {
+    if (mds->is_rejoin())
       rejoins[*p] = new MMDSCacheRejoin(MMDSCacheRejoin::OP_WEAK);
-      rejoins[*p]->copy_cap_exports(cap_export_bl);
-    } else if (mds->mdsmap->is_rejoin(*p))
+    else if (mds->mdsmap->is_rejoin(*p))
       rejoins[*p] = new MMDSCacheRejoin(MMDSCacheRejoin::OP_STRONG);
-  }	
+  }
+
+  if (mds->is_rejoin()) {
+    for (map<inodeno_t,map<client_t,ceph_mds_cap_reconnect> >::iterator p = cap_exports.begin();
+         p != cap_exports.end();
+	 p++) {
+      assert(cap_export_targets.count(p->first));
+      rejoins[cap_export_targets[p->first]]->cap_exports[p->first] = p->second;
+    }
+  }
   
   assert(!migrator->is_importing());
   assert(!migrator->is_exporting());
@@ -3841,7 +3854,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
 	 p != weak->cap_exports.end();
 	 ++p) {
       CInode *in = get_inode(p->first);
-      if (!in || !in->is_auth()) continue;
+      assert(!in || in->is_auth());
       for (map<client_t,ceph_mds_cap_reconnect>::iterator q = p->second.begin();
 	   q != p->second.end();
 	   ++q) {
@@ -3858,16 +3871,7 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
 	 p != weak->cap_exports.end();
 	 ++p) {
       CInode *in = get_inode(p->first);
-      if (in && !in->is_auth())
-	continue;
-      filepath& path = weak->cap_export_paths[p->first];
-      if (!in) {
-	if (!path_is_mine(path))
-	  continue;
-	cap_import_paths[p->first] = path;
-	dout(10) << " noting cap import " << p->first << " path " << path << dendl;
-      }
-      
+      assert(in && in->is_auth());
       // note
       for (map<client_t,ceph_mds_cap_reconnect>::iterator q = p->second.begin();
 	   q != p->second.end();
@@ -4036,6 +4040,7 @@ public:
   }
 };
 
+#if 0
 /**
  * parallel_fetch -- make a pass at fetching a bunch of paths in parallel
  *
@@ -4154,9 +4159,7 @@ bool MDCache::parallel_fetch_traverse_dir(inodeno_t ino, filepath& path,
   missing.insert(ino);
   return true;
 }
-
-
-
+#endif
 
 /*
  * rejoin_scour_survivor_replica - remove source from replica list on unmentioned objects
@@ -4851,16 +4854,9 @@ void MDCache::rejoin_gather_finish()
   if (open_undef_inodes_dirfrags())
     return;
 
-  // fetch paths?
-  //  do this before ack, since some inodes we may have already gotten
-  //  from surviving MDSs.
-  if (!cap_import_paths.empty()) {
-    if (parallel_fetch(cap_import_paths, cap_imports_missing)) {
-      return;
-    }
-  }
-  
-  process_imported_caps();
+  if (process_imported_caps())
+    return;
+
   choose_lock_states_and_reconnect_caps();
 
   identify_files_to_recover(rejoin_recover_q, rejoin_check_q);
@@ -4878,34 +4874,123 @@ void MDCache::rejoin_gather_finish()
   }
 }
 
-void MDCache::process_imported_caps()
+class C_MDC_RejoinOpenInoFinish: public Context {
+  MDCache *cache;
+  inodeno_t ino;
+public:
+  C_MDC_RejoinOpenInoFinish(MDCache *c, inodeno_t i) : cache(c), ino(i) {}
+  void finish(int r) {
+    cache->rejoin_open_ino_finish(ino, r);
+  }
+};
+
+void MDCache::rejoin_open_ino_finish(inodeno_t ino, int ret)
+{
+  dout(10) << "open_caps_inode_finish ino " << ino << " ret " << ret << dendl;
+
+  if (ret < 0) {
+    cap_imports_missing.insert(ino);
+  } else if (ret == mds->get_nodeid()) {
+    assert(get_inode(ino));
+  } else {
+    map<inodeno_t,map<client_t,map<int,ceph_mds_cap_reconnect> > >::iterator p;
+    p = cap_imports.find(ino);
+    assert(p != cap_imports.end());
+    for (map<client_t,map<int,ceph_mds_cap_reconnect> >::iterator q = p->second.begin();
+	q != p->second.end();
+	++q) {
+      assert(q->second.count(-1));
+      assert(q->second.size() == 1);
+      rejoin_export_caps(p->first, q->first, q->second[-1], ret);
+    }
+    cap_imports.erase(p);
+  }
+
+  assert(cap_imports_num_opening > 0);
+  cap_imports_num_opening--;
+
+  if (cap_imports_num_opening == 0) {
+    if (rejoin_gather.count(mds->get_nodeid()))
+      process_imported_caps();
+    else
+      rejoin_gather_finish();
+  }
+}
+
+bool MDCache::process_imported_caps()
 {
   dout(10) << "process_imported_caps" << dendl;
 
-  // process cap imports
-  //  ino -> client -> frommds -> capex
-  map<inodeno_t,map<client_t, map<int,ceph_mds_cap_reconnect> > >::iterator p = cap_imports.begin();
-  while (p != cap_imports.end()) {
+  map<inodeno_t,map<client_t, map<int,ceph_mds_cap_reconnect> > >::iterator p;
+  for (p = cap_imports.begin(); p != cap_imports.end(); ++p) {
     CInode *in = get_inode(p->first);
-    if (!in) {
-      dout(10) << "process_imported_caps still missing " << p->first
-	       << ", will try again after replayed client requests"
-	       << dendl;
-      ++p;
+    if (in) {
+      assert(in->is_auth());
+      cap_imports_missing.erase(p->first);
       continue;
     }
-    for (map<client_t, map<int,ceph_mds_cap_reconnect> >::iterator q = p->second.begin();
-	 q != p->second.end();
-	 ++q) 
-      for (map<int,ceph_mds_cap_reconnect>::iterator r = q->second.begin();
+    if (cap_imports_missing.count(p->first) > 0)
+      continue;
+
+    cap_imports_num_opening++;
+    dout(10) << "  opening missing ino " << p->first << dendl;
+    open_ino(p->first, (int64_t)-1, new C_MDC_RejoinOpenInoFinish(this, p->first), false);
+  }
+
+  if (cap_imports_num_opening > 0)
+    return true;
+
+  // called by rejoin_gather_finish() ?
+  if (rejoin_gather.count(mds->get_nodeid()) == 0) {
+    // process cap imports
+    //  ino -> client -> frommds -> capex
+    p = cap_imports.begin();
+    while (p != cap_imports.end()) {
+      CInode *in = get_inode(p->first);
+      if (!in) {
+	dout(10) << " still missing ino " << p->first
+	         << ", will try again after replayed client requests" << dendl;
+	++p;
+	continue;
+      }
+      assert(in->is_auth());
+      for (map<client_t,map<int,ceph_mds_cap_reconnect> >::iterator q = p->second.begin();
+	  q != p->second.end();
+	  ++q)
+	for (map<int,ceph_mds_cap_reconnect>::iterator r = q->second.begin();
+	    r != q->second.end();
+	    ++r) {
+	  dout(20) << " add_reconnected_cap " << in->ino() << " client." << q->first << dendl;
+	  add_reconnected_cap(in, q->first, inodeno_t(r->second.snaprealm));
+	  rejoin_import_cap(in, q->first, r->second, r->first);
+	}
+      cap_imports.erase(p++);  // remove and move on
+    }
+  } else {
+    for (map<inodeno_t,map<client_t,ceph_mds_cap_reconnect> >::iterator q = cap_exports.begin();
+	 q != cap_exports.end();
+	 q++) {
+      for (map<client_t,ceph_mds_cap_reconnect>::iterator r = q->second.begin();
 	   r != q->second.end();
 	   ++r) {
-	dout(20) << " add_reconnected_cap " << in->ino() << " client." << q->first << dendl;
-	add_reconnected_cap(in, q->first, inodeno_t(r->second.snaprealm));
-	rejoin_import_cap(in, q->first, r->second, r->first);
+	dout(10) << " exporting caps for client." << r->first << " ino " << q->first << dendl;
+	Session *session = mds->sessionmap.get_session(entity_name_t::CLIENT(r->first.v));
+	assert(session);
+	// mark client caps stale.
+	MClientCaps *m = new MClientCaps(CEPH_CAP_OP_EXPORT, q->first, 0, 0, 0);
+	mds->send_message_client_counted(m, session);
       }
-    cap_imports.erase(p++);  // remove and move on
+    }
+
+    trim_non_auth();
+
+    rejoin_gather.erase(mds->get_nodeid());
+    maybe_send_pending_rejoins();
+
+    if (rejoin_gather.empty() && rejoin_ack_gather.count(mds->get_nodeid()))
+      rejoin_gather_finish();
   }
+  return false;
 }
 
 void MDCache::check_realm_past_parents(SnapRealm *realm)
@@ -5067,9 +5152,12 @@ void MDCache::export_remaining_imported_caps()
 {
   dout(10) << "export_remaining_imported_caps" << dendl;
 
+  stringstream warn_str;
+
   for (map<inodeno_t,map<client_t,map<int,ceph_mds_cap_reconnect> > >::iterator p = cap_imports.begin();
        p != cap_imports.end();
        ++p) {
+    warn_str << " ino " << p->first << "\n";
     for (map<client_t,map<int,ceph_mds_cap_reconnect> >::iterator q = p->second.begin();
 	q != p->second.end();
 	++q) {
@@ -5083,6 +5171,11 @@ void MDCache::export_remaining_imported_caps()
   }
 
   cap_imports.clear();
+
+  if (warn_str.peek() != EOF) {
+    mds->clog.warn() << "failed to reconnect caps for missing inodes:" << "\n";
+    mds->clog.warn(warn_str);
+  }
 }
 
 void MDCache::try_reconnect_cap(CInode *in, Session *session)
@@ -7407,6 +7500,7 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
   return 0;
 }
 
+#if 0
 /**
  * Find out if the MDS is auth for a given path.
  *
@@ -7439,6 +7533,7 @@ bool MDCache::path_is_mine(filepath& path)
 
   return cur->is_auth();
 }
+#endif
 
 CInode *MDCache::cache_traverse(const filepath& fp)
 {
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index cc54376..e599139 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -412,11 +412,12 @@ protected:
   set<int> rejoin_ack_gather;  // nodes from whom i need a rejoin ack
 
   map<inodeno_t,map<client_t,ceph_mds_cap_reconnect> > cap_exports; // ino -> client -> capex
-  map<inodeno_t,filepath> cap_export_paths;
+  map<inodeno_t,int> cap_export_targets; // ino -> auth mds
 
   map<inodeno_t,map<client_t,map<int,ceph_mds_cap_reconnect> > > cap_imports;  // ino -> client -> frommds -> capex
   map<inodeno_t,filepath> cap_import_paths;
   set<inodeno_t> cap_imports_missing;
+  int cap_imports_num_opening;
   
   set<CInode*> rejoin_undef_inodes;
   set<CInode*> rejoin_potential_updated_scatterlocks;
@@ -431,7 +432,6 @@ protected:
   void handle_cache_rejoin_weak(MMDSCacheRejoin *m);
   CInode* rejoin_invent_inode(inodeno_t ino, snapid_t last);
   CDir* rejoin_invent_dirfrag(dirfrag_t df);
-  bool rejoin_fetch_dirfrags(MMDSCacheRejoin *m);
   void handle_cache_rejoin_strong(MMDSCacheRejoin *m);
   void rejoin_scour_survivor_replicas(int from, MMDSCacheRejoin *ack,
 				      set<SimpleLock *>& gather_locks,
@@ -447,11 +447,13 @@ protected:
       rejoin_send_rejoins();
   }
 public:
+  void rejoin_start();
   void rejoin_gather_finish();
   void rejoin_send_rejoins();
-  void rejoin_export_caps(inodeno_t ino, client_t client, cap_reconnect_t& icr) {
-    cap_exports[ino][client] = icr.capinfo;
-    cap_export_paths[ino] = filepath(icr.path, (uint64_t)icr.capinfo.pathbase);
+  void rejoin_export_caps(inodeno_t ino, client_t client, ceph_mds_cap_reconnect& capinfo,
+			  int target=-1) {
+    cap_exports[ino][client] = capinfo;
+    cap_export_targets[ino] = target;
   }
   void rejoin_recovered_caps(inodeno_t ino, client_t client, cap_reconnect_t& icr, 
 			     int frommds=-1) {
@@ -482,7 +484,10 @@ public:
   void add_reconnected_snaprealm(client_t client, inodeno_t ino, snapid_t seq) {
     reconnected_snaprealms[ino][client] = seq;
   }
-  void process_imported_caps();
+
+  friend class C_MDC_RejoinOpenInoFinish;
+  void rejoin_open_ino_finish(inodeno_t ino, int ret);
+  bool process_imported_caps();
   void choose_lock_states_and_reconnect_caps();
   void prepare_realm_split(SnapRealm *realm, client_t client, inodeno_t ino,
 			   map<client_t,MClientSnap*>& splits);
diff --git a/src/mds/MDS.cc b/src/mds/MDS.cc
index a7140c5..9e9a296 100644
--- a/src/mds/MDS.cc
+++ b/src/mds/MDS.cc
@@ -975,6 +975,8 @@ void MDS::handle_mds_map(MMDSMap *m)
         resolve_start();
       } else if (is_reconnect()) {
         reconnect_start();
+      } else if (is_rejoin()) {
+	rejoin_start();
       } else if (is_clientreplay()) {
         clientreplay_start();
       } else if (is_creating()) {
@@ -1465,6 +1467,11 @@ void MDS::rejoin_joint_start()
   dout(1) << "rejoin_joint_start" << dendl;
   mdcache->rejoin_send_rejoins();
 }
+void MDS::rejoin_start()
+{
+  dout(1) << "rejoin_start" << dendl;
+  mdcache->rejoin_start();
+}
 void MDS::rejoin_done()
 {
   dout(1) << "rejoin_done" << dendl;
diff --git a/src/mds/MDS.h b/src/mds/MDS.h
index 88d9fe2..d91274e 100644
--- a/src/mds/MDS.h
+++ b/src/mds/MDS.h
@@ -376,6 +376,7 @@ class MDS : public Dispatcher {
   void reconnect_start();
   void reconnect_done();
   void rejoin_joint_start();
+  void rejoin_start();
   void rejoin_done();
   void recovery_done();
   void clientreplay_start();
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index d89a083..115a14a 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -635,25 +635,16 @@ void Server::handle_client_reconnect(MClientReconnect *m)
       continue;
     }
       
-    filepath path(p->second.path, (uint64_t)p->second.capinfo.pathbase);
     if (in && !in->is_auth()) {
       // not mine.
-      dout(0) << "non-auth " << p->first << " " << path
-	      << ", will pass off to authority" << dendl;
-      
-      // mark client caps stale.
-      MClientCaps *stale = new MClientCaps(CEPH_CAP_OP_EXPORT, p->first, 0, 0, 0);
-      //stale->head.migrate_seq = 0; // FIXME ******
-      mds->send_message_client_counted(stale, session);
-
+      dout(10) << "non-auth " << *in << ", will pass off to authority" << dendl;
       // add to cap export list.
-      mdcache->rejoin_export_caps(p->first, from, p->second);
+      mdcache->rejoin_export_caps(p->first, from, p->second.capinfo,
+				  in->authority().first);
     } else {
       // don't know if the inode is mine
-      dout(0) << "missing " << p->first << " " << path
-	      << " will load or export later" << dendl;
+      dout(10) << "missing ino " << p->first << ", will load later" << dendl;
       mdcache->rejoin_recovered_caps(p->first, from, p->second, -1);
-      mdcache->rejoin_export_caps(p->first, from, p->second);
     }
   }
 
diff --git a/src/messages/MMDSCacheRejoin.h b/src/messages/MMDSCacheRejoin.h
index dc8a1af..3ae8355 100644
--- a/src/messages/MMDSCacheRejoin.h
+++ b/src/messages/MMDSCacheRejoin.h
@@ -167,9 +167,7 @@ class MMDSCacheRejoin : public Message {
   map<vinodeno_t, inode_strong> strong_inodes;
 
   // open
-  bufferlist cap_export_bl;
   map<inodeno_t,map<client_t, ceph_mds_cap_reconnect> > cap_exports;
-  map<inodeno_t,filepath> cap_export_paths;
 
   // full
   bufferlist inode_base;
@@ -258,10 +256,6 @@ public:
     in->encode_lock_state(CEPH_LOCK_IDFT, inode_scatterlocks[in->ino()].dft);
   }
 
-  void copy_cap_exports(bufferlist &bl) {
-    cap_export_bl = bl;
-  }
-  
   // dirfrags
   void add_strong_dirfrag(dirfrag_t df, int n, int dr) {
     strong_dirfrags[df] = dirfrag_strong(n, dr);
@@ -304,7 +298,7 @@ public:
     ::encode(frozen_authpin_inodes, payload);
     ::encode(xlocked_inodes, payload);
     ::encode(wrlocked_inodes, payload);
-    ::encode(cap_export_bl, payload);
+    ::encode(cap_exports, payload);
     ::encode(strong_dirfrags, payload);
     ::encode(dirfrag_bases, payload);
     ::encode(weak, payload);
@@ -325,12 +319,7 @@ public:
     ::decode(frozen_authpin_inodes, p);
     ::decode(xlocked_inodes, p);
     ::decode(wrlocked_inodes, p);
-    ::decode(cap_export_bl, p);
-    if (cap_export_bl.length()) {
-      bufferlist::iterator q = cap_export_bl.begin();
-      ::decode(cap_exports, q);
-      ::decode(cap_export_paths, q);
-    }
+    ::decode(cap_exports, p);
     ::decode(strong_dirfrags, p);
     ::decode(dirfrag_bases, p);
     ::decode(weak, p);
-- 
1.8.1.4

