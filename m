From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 14/25] mds: split reslove into two sub-stages
Date: Wed, 23 Jan 2013 11:08:50 +0800
Message-ID: <1358910541-15535-15-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51770 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab3AWDJS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:18 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The resolve stage serves to disambiguate the fate of uncommitted slave
updates and resolve subtrees authority. The MDS sends resolve message
that claims subtrees authority immediately when reslove stage is entered,
When receiving a resolve message, the MDS also processes it immediately.
This may cause problem if there are uncommitted slave rename and some of
them need rollback later. It's because slave rename rollback may modify
subtree map.

The fix is split reslove into two sub-stages, the first sub-stage serves
to disambiguate slave updates, do slave commit or rollback. After the
the first sub-stage finishes, the MDS sends resolve messages that claim
subtrees authority to other MDS and processes received resolve messages.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 133 ++++++++++++++++++++++++++++++++++++++---------------
 src/mds/MDCache.h  |  14 ++++--
 src/mds/Server.cc  |  39 +++++++---------
 3 files changed, 123 insertions(+), 63 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5a6d3f2..4374656 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2414,6 +2414,10 @@ void MDCache::resolve_start()
     if (rootdir)
       adjust_subtree_auth(rootdir, CDIR_AUTH_UNKNOWN);
   }
+
+  for (map<int, map<metareqid_t, MDSlaveUpdate*> >::iterator p = uncommitted_slave_updates.begin();
+       p != uncommitted_slave_updates.end(); p++)
+    need_resolve_ack.insert(p->first);
 }
 
 void MDCache::send_resolves()
@@ -2422,6 +2426,16 @@ void MDCache::send_resolves()
   got_resolve.clear();
   other_ambiguous_imports.clear();
 
+  if (!need_resolve_ack.empty()) {
+    for (set<int>::iterator p = need_resolve_ack.begin(); p != need_resolve_ack.end(); ++p)
+      send_slave_resolve(*p);
+    return;
+  }
+  if (!need_resolve_rollback.empty()) {
+    dout(10) << "send_resolves still waiting for rollback to commit on ("
+	     << need_resolve_rollback << ")" << dendl;
+    return;
+  }
   for (set<int>::iterator p = recovery_set.begin(); p != recovery_set.end(); ++p) {
     int who = *p;
     if (who == mds->whoami)
@@ -2473,6 +2487,37 @@ public:
   }
 };
 
+void MDCache::send_slave_resolve(int who)
+{
+  dout(10) << "send_slave_resolve to mds." << who << dendl;
+  MMDSResolve *m = new MMDSResolve;
+
+  // list prepare requests lacking a commit
+  // [active survivor]
+  for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
+      p != active_requests.end();
+      ++p) {
+    if (p->second->is_slave() && p->second->slave_to_mds == who) {
+      dout(10) << " including uncommitted " << *p->second << dendl;
+      m->add_slave_request(p->first);
+    }
+  }
+  // [resolving]
+  if (uncommitted_slave_updates.count(who) &&
+      !uncommitted_slave_updates[who].empty()) {
+    for (map<metareqid_t, MDSlaveUpdate*>::iterator p = uncommitted_slave_updates[who].begin();
+	p != uncommitted_slave_updates[who].end();
+	++p) {
+      dout(10) << " including uncommitted " << p->first << dendl;
+      m->add_slave_request(p->first);
+    }
+  }
+
+  assert(!m->slave_requests.empty());
+  dout(10) << " will need resolve ack from mds." << who << dendl;
+  mds->send_message_mds(m, who);
+}
+
 void MDCache::send_resolve_now(int who)
 {
   dout(10) << "send_resolve_now to mds." << who << dendl;
@@ -2526,30 +2571,6 @@ void MDCache::send_resolve_now(int who)
     m->add_ambiguous_import(p->first, p->second);
     dout(10) << " ambig " << p->first << " " << p->second << dendl;
   }
-  
-
-  // list prepare requests lacking a commit
-  // [active survivor]
-  for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
-       p != active_requests.end();
-       ++p) {
-    if (p->second->is_slave() && p->second->slave_to_mds == who) {
-      dout(10) << " including uncommitted " << *p->second << dendl;
-      m->add_slave_request(p->first);
-    }
-  }
-  // [resolving]
-  if (uncommitted_slave_updates.count(who) &&
-      !uncommitted_slave_updates[who].empty()) {
-    for (map<metareqid_t, MDSlaveUpdate*>::iterator p = uncommitted_slave_updates[who].begin();
-	 p != uncommitted_slave_updates[who].end();
-	 ++p) {
-      dout(10) << " including uncommitted " << p->first << dendl;
-      m->add_slave_request(p->first);
-    }
-    dout(10) << " will need resolve ack from mds." << who << dendl;
-    need_resolve_ack.insert(who);
-  }
 
   // send
   mds->send_message_mds(m, who);
@@ -2568,6 +2589,7 @@ void MDCache::handle_mds_failure(int who)
   // adjust my recovery lists
   wants_resolve.erase(who);   // MDS will ask again
   got_resolve.erase(who);     // i'll get another.
+  discard_delayed_resolve(who);
 
   rejoin_sent.erase(who);        // i need to send another
   rejoin_ack_gather.erase(who);  // i'll need/get another.
@@ -2590,6 +2612,7 @@ void MDCache::handle_mds_failure(int who)
     // slave to the failed node?
     if (p->second->slave_to_mds == who) {
       if (p->second->slave_did_prepare()) {
+	need_resolve_ack.insert(who);
 	dout(10) << " slave request " << *p->second << " uncommitted, will resolve shortly" << dendl;
       } else {
 	dout(10) << " slave request " << *p->second << " has no prepare, finishing up" << dendl;
@@ -2739,6 +2762,15 @@ void MDCache::handle_resolve(MMDSResolve *m)
       }
     }
     mds->send_message(ack, m->get_connection());
+    m->put();
+    return;
+  }
+
+  if (!need_resolve_ack.empty() || !need_resolve_rollback.empty()) {
+    dout(10) << "delay processing subtree resolve" << dendl;
+    discard_delayed_resolve(from);
+    delayed_resolve[from] = m;
+    return;
   }
 
   // am i a surviving ambiguous importer?
@@ -2828,21 +2860,33 @@ void MDCache::handle_resolve(MMDSResolve *m)
   m->put();
 }
 
+void MDCache::process_delayed_resolve()
+{
+  dout(10) << "process_delayed_resolve" << dendl;
+  for (map<int, MMDSResolve *>::iterator p = delayed_resolve.begin();
+       p != delayed_resolve.end(); p++)
+    handle_resolve(p->second);
+  delayed_resolve.clear();
+}
+
+void MDCache::discard_delayed_resolve(int who)
+{
+  if (delayed_resolve.count(who)) {
+      delayed_resolve[who]->put();
+      delayed_resolve.erase(who);
+  }
+}
+
 void MDCache::maybe_resolve_finish()
 {
+  assert(need_resolve_ack.empty());
+  assert(need_resolve_rollback.empty());
+
   if (got_resolve != recovery_set) {
     dout(10) << "maybe_resolve_finish still waiting for more resolves, got (" 
 	     << got_resolve << "), need (" << recovery_set << ")" << dendl;
-  } 
-  else if (!need_resolve_ack.empty()) {
-    dout(10) << "maybe_resolve_finish still waiting for resolve_ack from (" 
-	     << need_resolve_ack << ")" << dendl;
-  }
-  else if (!need_resolve_rollback.empty()) {
-    dout(10) << "maybe_resolve_finish still waiting for rollback to commit on (" 
-	     << need_resolve_rollback << ")" << dendl;
-  } 
-  else {
+    return;
+  } else {
     dout(10) << "maybe_resolve_finish got all resolves+resolve_acks, done." << dendl;
     disambiguate_imports();
     if (mds->is_resolve()) {
@@ -2851,7 +2895,7 @@ void MDCache::maybe_resolve_finish()
       trim_non_auth(); 
       mds->resolve_done();
     }
-  } 
+  }
 }
 
 /* This functions puts the passed message before returning */
@@ -2860,6 +2904,11 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
   dout(10) << "handle_resolve_ack " << *ack << " from " << ack->get_source() << dendl;
   int from = ack->get_source().num();
 
+  if (!need_resolve_ack.count(from)) {
+    ack->put();
+    return;
+  }
+
   for (vector<metareqid_t>::iterator p = ack->commit.begin();
        p != ack->commit.end();
        ++p) {
@@ -2927,10 +2976,20 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
     }
   }
 
+  if (mds->is_resolve()) {
+    assert(uncommitted_slave_updates.count(from) == 0);
+  } else {
+    for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
+	 p != active_requests.end(); ++p)
+      assert(p->second->slave_to_mds != from || !p->second->slave_did_prepare());
+  }
+
   need_resolve_ack.erase(from);
 
-  if (mds->is_resolve()) 
-    maybe_resolve_finish();
+  if (need_resolve_ack.empty() && need_resolve_rollback.empty()) {
+    send_resolves();
+    process_delayed_resolve();
+  }
 
   ack->put();
 }
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index ecf5b29..efb0b38 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -329,12 +329,15 @@ protected:
   friend class ECommitted;
 
   set<int> wants_resolve;   // nodes i need to send my resolve to
-  set<int> got_resolve;     // nodes i got resolves from
-  set<int> need_resolve_ack;   // nodes i need a resolve_ack from
+  set<int> got_resolve;     // nodes i got subtree resolves from
+  set<int> need_resolve_ack;   // nodes i need to send my resolve to
   set<metareqid_t> need_resolve_rollback;  // rollbacks i'm writing to the journal
+  map<int, MMDSResolve*> delayed_resolve;
   
   void handle_resolve(MMDSResolve *m);
   void handle_resolve_ack(MMDSResolveAck *m);
+  void process_delayed_resolve();
+  void discard_delayed_resolve(int who);
   void maybe_resolve_finish();
   void disambiguate_imports();
   void recalc_auth_bits();
@@ -350,8 +353,10 @@ public:
   }
   void finish_rollback(metareqid_t reqid) {
     need_resolve_rollback.erase(reqid);
-    if (need_resolve_rollback.empty())
-      maybe_resolve_finish();
+    if (need_resolve_ack.empty() && need_resolve_rollback.empty()) {
+      send_resolves();
+      process_delayed_resolve();
+    }
   }
 
   // ambiguous imports
@@ -368,6 +373,7 @@ public:
   void finish_ambiguous_import(dirfrag_t dirino);
   void resolve_start();
   void send_resolves();
+  void send_slave_resolve(int who);
   void send_resolve_now(int who);
   void send_resolve_later(int who);
   void maybe_send_pending_resolves();
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 4f2222f..a68b584 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4379,14 +4379,11 @@ void Server::do_link_rollback(bufferlist &rbl, int master, MDRequest *mdr)
 
   assert(g_conf->mds_kill_link_at != 9);
 
-  Mutation *mut = mdr;
-  if (!mut) {
-    assert(mds->is_resolve());
-    mds->mdcache->add_rollback(rollback.reqid);  // need to finish this update before resolve finishes
-    mut = new Mutation(rollback.reqid);
-    mut->ls = mds->mdlog->get_current_segment();
-  }
+  mds->mdcache->add_rollback(rollback.reqid); // need to finish this update before resolve finishes
+  assert(mdr || mds->is_resolve());
 
+  Mutation *mut = new Mutation(rollback.reqid);
+  mut->ls = mds->mdlog->get_current_segment();
 
   CInode *in = mds->mdcache->get_inode(rollback.ino);
   assert(in);
@@ -4438,8 +4435,9 @@ void Server::_link_rollback_finish(Mutation *mut, MDRequest *mdr)
   mut->apply();
   if (mdr)
     mds->mdcache->request_finish(mdr);
-  else
-    mds->mdcache->finish_rollback(mut->reqid);
+
+  mds->mdcache->finish_rollback(mut->reqid);
+
   mut->cleanup();
   delete mut;
 }
@@ -4978,10 +4976,8 @@ void Server::do_rmdir_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   ::decode(rollback, p);
   
   dout(10) << "do_rmdir_rollback on " << rollback.reqid << dendl;
-  if (!mdr) {
-    assert(mds->is_resolve());
-    mds->mdcache->add_rollback(rollback.reqid);  // need to finish this update before resolve finishes
-  }
+  mds->mdcache->add_rollback(rollback.reqid); // need to finish this update before resolve finishes
+  assert(mdr || mds->is_resolve());
 
   CDir *dir = mds->mdcache->get_dirfrag(rollback.src_dir);
   CDentry *dn = dir->lookup(rollback.src_dname);
@@ -5020,8 +5016,8 @@ void Server::_rmdir_rollback_finish(MDRequest *mdr, metareqid_t reqid, CDentry *
 
   if (mdr)
     mds->mdcache->request_finish(mdr);
-  else
-    mds->mdcache->finish_rollback(reqid);
+
+  mds->mdcache->finish_rollback(reqid);
 }
 
 
@@ -6482,10 +6478,10 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   ::decode(rollback, p);
 
   dout(10) << "do_rename_rollback on " << rollback.reqid << dendl;
-  if (!mdr) {
-    assert(mds->is_resolve());
-    mds->mdcache->add_rollback(rollback.reqid);  // need to finish this update before resolve finishes
-  }
+  // need to finish this update before sending resolve to claim the subtree
+  mds->mdcache->add_rollback(rollback.reqid);
+  assert(mdr || mds->is_resolve());
+
   Mutation *mut = new Mutation(rollback.reqid);
   mut->ls = mds->mdlog->get_current_segment();
 
@@ -6717,9 +6713,8 @@ void Server::_rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *src
 
   if (mdr)
     mds->mdcache->request_finish(mdr);
-  else {
-    mds->mdcache->finish_rollback(mut->reqid);
-  }
+
+  mds->mdcache->finish_rollback(mut->reqid);
 
   mut->cleanup();
   delete mut;
-- 
1.7.11.7

