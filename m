From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 18/39] mds: fix MDS recovery involving cross authority rename
Date: Sun, 17 Mar 2013 22:51:21 +0800
Message-ID: <1363531902-24909-19-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3CQOww (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:52 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

For mds cluster, rename operation may involve multiple MDS. If the
rename source's auth MDS crashes after some witness MDS have prepared
the rename but before the rename is committing. Later when the MDS
recovers, its subtree map and linkages are different from the prepared
MDS'. This causes problems for both subtree resolve and cache rejoin.
The solution is, if the rename source's auth MDS fails, the prepared
witness MDS query the master MDS if the operation is committing. If
it's not, rollback the rename, then send resolve message to the
recovering MDS.

Another similar case is a prepared witness MDS crashes when the
rename source's auth MDS has prepared or is preparing the operation.
when the witness recovers, the master just delay sending the resolve
ack message until the it commits the operation.

This patch also updates Server::handle_client_rename(). Make preparing
the rename source's auth MDS be the final step before committing the
rename.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc |  75 +++++++++++++++++++++++++++++-----------
 src/mds/MDCache.h  |  17 +++++++--
 src/mds/Mutation.h |   2 ++
 src/mds/Server.cc  | 100 ++++++++++++++++++++++++++++-------------------------
 4 files changed, 124 insertions(+), 70 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 9b37b1e..d934020 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2491,7 +2491,7 @@ void MDCache::send_slave_resolves()
       if (!p->second->is_slave() || !p->second->slave_did_prepare())
 	continue;
       int master = p->second->slave_to_mds;
-      if (resolve_set.count(master)) {
+      if (resolve_set.count(master) || is_ambiguous_slave_update(p->first, master)) {
 	dout(10) << " including uncommitted " << *p->second << dendl;
 	if (!resolves.count(master))
 	  resolves[master] = new MMDSResolve;
@@ -2610,6 +2610,7 @@ void MDCache::handle_mds_failure(int who)
 
   resolve_gather.insert(who);
   discard_delayed_resolve(who);
+  ambiguous_slave_updates.erase(who);
 
   rejoin_gather.insert(who);
   rejoin_sent.erase(who);        // i need to send another
@@ -2642,14 +2643,46 @@ void MDCache::handle_mds_failure(int who)
 	  finish.push_back(p->second);
       }
     }
+
+    if (p->second->is_slave() &&
+	p->second->slave_did_prepare() && p->second->more()->srcdn_auth_mds == who &&
+	mds->mdsmap->is_clientreplay_or_active_or_stopping(p->second->slave_to_mds)) {
+      // rename srcdn's auth mds failed, resolve even I'm a survivor.
+      dout(10) << " slave request " << *p->second << " uncommitted, will resolve shortly" << dendl;
+      add_ambiguous_slave_update(p->first, p->second->slave_to_mds);
+    }
     
     // failed node is slave?
     if (p->second->is_master() && !p->second->committing) {
+      if (p->second->more()->srcdn_auth_mds == who) {
+	dout(10) << " master request " << *p->second << " waiting for rename srcdn's auth mds."
+		 << who << " to recover" << dendl;
+	assert(p->second->more()->witnessed.count(who) == 0);
+	if (p->second->more()->is_ambiguous_auth)
+	  p->second->clear_ambiguous_auth();
+	// rename srcdn's auth mds failed, all witnesses will rollback
+	p->second->more()->witnessed.clear();
+	pending_masters.erase(p->first);
+      }
+
       if (p->second->more()->witnessed.count(who)) {
-	dout(10) << " master request " << *p->second << " no longer witnessed by slave mds." << who
-		 << dendl;
-	// discard this peer's prepare (if any)
-	p->second->more()->witnessed.erase(who);
+	int srcdn_auth = p->second->more()->srcdn_auth_mds;
+	if (srcdn_auth >= 0 && p->second->more()->waiting_on_slave.count(srcdn_auth)) {
+	  dout(10) << " master request " << *p->second << " waiting for rename srcdn's auth mds."
+		   << p->second->more()->srcdn_auth_mds << " to reply" << dendl;
+	  // waiting for the last slave (rename srcdn's auth mds), delay sending resolve ack
+	  // until either the request is committing or the last slave also fails.
+	  assert(p->second->more()->waiting_on_slave.size() == 1);
+	  pending_masters.insert(p->first);
+	} else {
+	  dout(10) << " master request " << *p->second << " no longer witnessed by slave mds."
+		   << who << " to recover" << dendl;
+	  if (srcdn_auth >= 0)
+	    assert(p->second->more()->witnessed.count(srcdn_auth) == 0);
+
+	  // discard this peer's prepare (if any)
+	  p->second->more()->witnessed.erase(who);
+	}
       }
       
       if (p->second->more()->waiting_on_slave.count(who)) {
@@ -2657,14 +2690,8 @@ void MDCache::handle_mds_failure(int who)
 		 << " to recover" << dendl;
 	// retry request when peer recovers
 	p->second->more()->waiting_on_slave.erase(who);
-	mds->wait_for_active_peer(who, new C_MDS_RetryRequest(this, p->second));
-      }
-
-      if (p->second->has_more() && p->second->more()->is_ambiguous_auth &&
-	  p->second->more()->rename_inode->authority().first == who) {
-	dout(10) << " master request " << *p->second << " waiting for renamed inode's auth mds." << who
-		 << " to recover" << dendl;
-	p->second->clear_ambiguous_auth();
+	if (p->second->more()->waiting_on_slave.empty())
+	  mds->wait_for_active_peer(who, new C_MDS_RetryRequest(this, p->second));
       }
 
       if (p->second->locking && p->second->locking_target_mds == who)
@@ -2951,16 +2978,27 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
   dout(10) << "handle_resolve_ack " << *ack << " from " << ack->get_source() << dendl;
   int from = ack->get_source().num();
 
-  if (!resolve_ack_gather.count(from)) {
+  if (!resolve_ack_gather.count(from) ||
+      mds->mdsmap->get_state(from) < MDSMap::STATE_RESOLVE) {
     ack->put();
     return;
   }
 
+  if (ambiguous_slave_updates.count(from)) {
+    assert(mds->mdsmap->is_clientreplay_or_active_or_stopping(from));
+    assert(mds->is_clientreplay() || mds->is_active() || mds->is_stopping());
+  }
+
   for (vector<metareqid_t>::iterator p = ack->commit.begin();
        p != ack->commit.end();
        ++p) {
     dout(10) << " commit on slave " << *p << dendl;
     
+    if (ambiguous_slave_updates.count(from)) {
+      remove_ambiguous_slave_update(*p, from);
+      continue;
+    }
+
     if (mds->is_resolve()) {
       // replay
       MDSlaveUpdate *su = get_uncommitted_slave_update(*p, from);
@@ -3020,13 +3058,8 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
     }
   }
 
-  if (!mds->is_resolve()) {
-    for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
-	p != active_requests.end(); ++p)
-      assert(p->second->slave_to_mds != from);
-  }
-
-  resolve_ack_gather.erase(from);
+  if (!ambiguous_slave_updates.count(from))
+    resolve_ack_gather.erase(from);
   if (resolve_ack_gather.empty() && need_resolve_rollback.empty()) {
     send_subtree_resolves();
     process_delayed_resolve();
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 8f262b9..a05ced7 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -327,9 +327,8 @@ protected:
   map<metareqid_t, umaster>                 uncommitted_masters;         // master: req -> slave set
 
   set<metareqid_t>		pending_masters;
+  map<int, set<metareqid_t> >	ambiguous_slave_updates;
 
-  //map<metareqid_t, bool>     ambiguous_slave_updates;         // for log trimming.
-  //map<metareqid_t, Context*> waiting_for_slave_update_commit;
   friend class ESlaveUpdate;
   friend class ECommitted;
 
@@ -353,6 +352,20 @@ protected:
 public:
   void remove_inode_recursive(CInode *in);
 
+  bool is_ambiguous_slave_update(metareqid_t reqid, int master) {
+    return ambiguous_slave_updates.count(master) &&
+	   ambiguous_slave_updates[master].count(reqid);
+  }
+  void add_ambiguous_slave_update(metareqid_t reqid, int master) {
+    ambiguous_slave_updates[master].insert(reqid);
+  }
+  void remove_ambiguous_slave_update(metareqid_t reqid, int master) {
+    assert(ambiguous_slave_updates[master].count(reqid));
+    ambiguous_slave_updates[master].erase(reqid);
+    if (ambiguous_slave_updates[master].empty())
+      ambiguous_slave_updates.erase(master);
+  }
+
   void add_rollback(metareqid_t reqid, int master) {
     need_resolve_rollback[reqid] = master;
   }
diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index 5013f04..de122a5 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -207,6 +207,7 @@ struct MDRequest : public Mutation {
     
     // for rename
     set<int> extra_witnesses; // replica list from srcdn auth (rename)
+    int srcdn_auth_mds;
     version_t src_reanchor_atid;  // src->dst
     version_t dst_reanchor_atid;  // dst->stray
     bufferlist inode_import;
@@ -233,6 +234,7 @@ struct MDRequest : public Mutation {
     bufferlist rollback_bl;
 
     More() : 
+      srcdn_auth_mds(-1),
       src_reanchor_atid(0), dst_reanchor_atid(0), inode_import_v(0),
       rename_inode(0), is_freeze_authpin(false), is_ambiguous_auth(false),
       is_remote_frozen_authpin(false), is_inode_exporter(false),
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 1330f11..b6e5665 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5772,12 +5772,52 @@ void Server::handle_client_rename(MDRequest *mdr)
   if (mdr->now == utime_t())
     mdr->now = ceph_clock_now(g_ceph_context);
 
+  // -- prepare anchor updates --
+  if (!linkmerge || srcdnl->is_primary()) {
+    C_GatherBuilder anchorgather(g_ceph_context);
+
+    if (srcdnl->is_primary() &&
+      (srcdnl->get_inode()->is_anchored() ||
+       (srcdnl->get_inode()->is_dir() && (srcdnl->get_inode()->inode.rstat.ranchors ||
+                                          srcdnl->get_inode()->nested_anchors ||
+                                          !mdcache->is_leaf_subtree(mdcache->get_projected_subtree_root(srcdn->get_dir()))))) &&
+      !mdr->more()->src_reanchor_atid) {
+      dout(10) << "reanchoring src->dst " << *srcdnl->get_inode() << dendl;
+      vector<Anchor> trace;
+      destdn->make_anchor_trace(trace, srcdnl->get_inode());
+      mds->anchorclient->prepare_update(srcdnl->get_inode()->ino(),
+					trace, &mdr->more()->src_reanchor_atid,
+					anchorgather.new_sub());
+    }
+    if (destdnl->is_primary() &&
+	destdnl->get_inode()->is_anchored() &&
+	!mdr->more()->dst_reanchor_atid) {
+      dout(10) << "reanchoring dst->stray " << *destdnl->get_inode() << dendl;
+
+      assert(straydn);
+      vector<Anchor> trace;
+      straydn->make_anchor_trace(trace, destdnl->get_inode());
+
+      mds->anchorclient->prepare_update(destdnl->get_inode()->ino(), trace,
+		  &mdr->more()->dst_reanchor_atid, anchorgather.new_sub());
+    }
+
+    if (anchorgather.has_subs())  {
+      anchorgather.set_finisher(new C_MDS_RetryRequest(mdcache, mdr));
+      anchorgather.activate();
+      return;  // waiting for anchor prepares
+    }
+
+    assert(g_conf->mds_kill_rename_at != 2);
+  }
+
   // -- prepare witnesses --
 
   // do srcdn auth last
   int last = -1;
   if (!srcdn->is_auth()) {
     last = srcdn->authority().first;
+    mdr->more()->srcdn_auth_mds = last;
     // ask auth of srci to mark srci as ambiguous auth if more than two MDS
     // are involved in the rename operation.
     if (srcdnl->is_primary() && !mdr->more()->is_ambiguous_auth) {
@@ -5803,58 +5843,18 @@ void Server::handle_client_rename(MDRequest *mdr)
   if (!mdr->more()->waiting_on_slave.empty())
     return;  // we're waiting for a witness.
 
-  if (last >= 0 &&
-      mdr->more()->witnessed.count(last) == 0 &&
-      mdr->more()->waiting_on_slave.count(last) == 0) {
+  if (last >= 0 && mdr->more()->witnessed.count(last) == 0) {
     dout(10) << " preparing last witness (srcdn auth)" << dendl;
+    assert(mdr->more()->waiting_on_slave.count(last) == 0);
     _rename_prepare_witness(mdr, last, witnesses, srcdn, destdn, straydn);
     return;
   }
 
   // test hack: bail after slave does prepare, so we can verify it's _live_ rollback.
   if (!mdr->more()->slaves.empty() && !srci->is_dir())
-    assert(g_conf->mds_kill_rename_at != 2);
+    assert(g_conf->mds_kill_rename_at != 3);
   if (!mdr->more()->slaves.empty() && srci->is_dir())
-    assert(g_conf->mds_kill_rename_at != 3);    
-  
-  // -- prepare anchor updates -- 
-  if (!linkmerge || srcdnl->is_primary()) {
-    C_GatherBuilder anchorgather(g_ceph_context);
-
-    if (srcdnl->is_primary() &&
-	(srcdnl->get_inode()->is_anchored() || 
-	 (srcdnl->get_inode()->is_dir() && (srcdnl->get_inode()->inode.rstat.ranchors ||
-					    srcdnl->get_inode()->nested_anchors ||
-					    !mdcache->is_leaf_subtree(mdcache->get_projected_subtree_root(srcdn->get_dir()))))) &&
-	!mdr->more()->src_reanchor_atid) {
-      dout(10) << "reanchoring src->dst " << *srcdnl->get_inode() << dendl;
-      vector<Anchor> trace;
-      destdn->make_anchor_trace(trace, srcdnl->get_inode());
-      mds->anchorclient->prepare_update(srcdnl->get_inode()->ino(),
-					trace, &mdr->more()->src_reanchor_atid,
-					anchorgather.new_sub());
-    }
-    if (destdnl->is_primary() &&
-	destdnl->get_inode()->is_anchored() &&
-	!mdr->more()->dst_reanchor_atid) {
-      dout(10) << "reanchoring dst->stray " << *destdnl->get_inode() << dendl;
-
-      assert(straydn);
-      vector<Anchor> trace;
-      straydn->make_anchor_trace(trace, destdnl->get_inode());
-      
-      mds->anchorclient->prepare_update(destdnl->get_inode()->ino(), trace,
-		  &mdr->more()->dst_reanchor_atid, anchorgather.new_sub());
-    }
-
-    if (anchorgather.has_subs())  {
-      anchorgather.set_finisher(new C_MDS_RetryRequest(mdcache, mdr));
-      anchorgather.activate();
-      return;  // waiting for anchor prepares
-    }
-
     assert(g_conf->mds_kill_rename_at != 4);
-  }
 
   // -- prepare journal entry --
   mdr->ls = mdlog->get_current_segment();
@@ -6762,10 +6762,17 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
     // abort
     //  rollback_bl may be empty if we froze the inode but had to provide an expanded
     // witness list from the master, and they failed before we tried prep again.
-    if (mdr->more()->rollback_bl.length())
-      do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_mds, mdr);
-    else
+    if (mdr->more()->rollback_bl.length()) {
+      if (mdcache->is_ambiguous_slave_update(mdr->reqid, mdr->slave_to_mds)) {
+	mdcache->remove_ambiguous_slave_update(mdr->reqid, mdr->slave_to_mds);
+	// rollback but preserve the slave request
+	do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_mds, NULL);
+      } else
+	do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_mds, mdr);
+    } else {
       dout(10) << " rollback_bl empty, not rollback back rename (master failed after getting extra witnesses?)" << dendl;
+      mds->mdcache->request_finish(mdr);
+    }
   }
 }
 
@@ -6825,7 +6832,6 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   dout(10) << "do_rename_rollback on " << rollback.reqid << dendl;
   // need to finish this update before sending resolve to claim the subtree
   mds->mdcache->add_rollback(rollback.reqid, master);
-  assert(mdr || mds->is_resolve());
 
   Mutation *mut = new Mutation(rollback.reqid);
   mut->ls = mds->mdlog->get_current_segment();
-- 
1.7.11.7

