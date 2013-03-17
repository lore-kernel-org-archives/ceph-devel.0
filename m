From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 12/39] mds: compose and send resolve messages in batch
Date: Sun, 17 Mar 2013 22:51:15 +0800
Message-ID: <1363531902-24909-13-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3CQOwb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:52:31 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Resolve messages for all MDS are the same, so we can compose and
send them in batch.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 181 +++++++++++++++++++++++++----------------------------
 src/mds/MDCache.h  |  11 ++--
 2 files changed, 93 insertions(+), 99 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index b668842..c455a20 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2432,10 +2432,6 @@ void MDCache::resolve_start()
     if (rootdir)
       adjust_subtree_auth(rootdir, CDIR_AUTH_UNKNOWN);
   }
-
-  for (map<int, map<metareqid_t, MDSlaveUpdate*> >::iterator p = uncommitted_slave_updates.begin();
-       p != uncommitted_slave_updates.end(); ++p)
-    need_resolve_ack.insert(p->first);
 }
 
 void MDCache::send_resolves()
@@ -2444,9 +2440,10 @@ void MDCache::send_resolves()
   got_resolve.clear();
   other_ambiguous_imports.clear();
 
-  if (!need_resolve_ack.empty()) {
-    for (set<int>::iterator p = need_resolve_ack.begin(); p != need_resolve_ack.end(); ++p)
-      send_slave_resolve(*p);
+  send_slave_resolves();
+  if (!resolve_ack_gather.empty()) {
+    dout(10) << "send_resolves still waiting for resolve ack from ("
+             << need_resolve_ack << ")" << dendl;
     return;
   }
   if (!need_resolve_rollback.empty()) {
@@ -2454,95 +2451,74 @@ void MDCache::send_resolves()
 	     << need_resolve_rollback << ")" << dendl;
     return;
   }
-  assert(uncommitted_slave_updates.empty());
-  for (set<int>::iterator p = recovery_set.begin(); p != recovery_set.end(); ++p) {
-    int who = *p;
-    if (who == mds->whoami)
-      continue;
-    if (migrator->is_importing() ||
-	migrator->is_exporting())
-      send_resolve_later(who);
-    else
-      send_resolve_now(who);
-  }
-}
-
-void MDCache::send_resolve_later(int who)
-{
-  dout(10) << "send_resolve_later to mds." << who << dendl;
-  wants_resolve.insert(who);
+  send_subtree_resolves();
 }
 
-void MDCache::maybe_send_pending_resolves()
+void MDCache::send_slave_resolves()
 {
-  if (wants_resolve.empty())
-    return;  // nothing to send.
-
-  // only if it's appropriate!
-  if (migrator->is_exporting() ||
-      migrator->is_importing()) {
-    dout(7) << "maybe_send_pending_resolves waiting, imports/exports still in progress" << dendl;
-    migrator->show_importing();
-    migrator->show_exporting();
-    return;  // not now
-  }
-  
-  // ok, send them.
-  for (set<int>::iterator p = wants_resolve.begin();
-       p != wants_resolve.end();
-       ++p) 
-    send_resolve_now(*p);
-  wants_resolve.clear();
-}
+  dout(10) << "send_slave_resolves" << dendl;
 
+  map<int, MMDSResolve*> resolves;
 
-class C_MDC_SendResolve : public Context {
-  MDCache *mdc;
-  int who;
-public:
-  C_MDC_SendResolve(MDCache *c, int w) : mdc(c), who(w) { }
-  void finish(int r) {
-    mdc->send_resolve_now(who);
-  }
-};
-
-void MDCache::send_slave_resolve(int who)
-{
-  dout(10) << "send_slave_resolve to mds." << who << dendl;
-  MMDSResolve *m = new MMDSResolve;
-
-  // list prepare requests lacking a commit
-  // [active survivor]
-  for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
-      p != active_requests.end();
-      ++p) {
-    if (p->second->is_slave() && p->second->slave_to_mds == who) {
-      dout(10) << " including uncommitted " << *p->second << dendl;
-      m->add_slave_request(p->first);
+  if (mds->is_resolve()) {
+    for (map<int, map<metareqid_t, MDSlaveUpdate*> >::iterator p = uncommitted_slave_updates.begin();
+	 p != uncommitted_slave_updates.end();
+	 ++p) {
+      resolves[p->first] = new MMDSResolve;
+      for (map<metareqid_t, MDSlaveUpdate*>::iterator q = p->second.begin();
+	   q != p->second.end();
+	   ++q) {
+	dout(10) << " including uncommitted " << q->first << dendl;
+	resolves[p->first]->add_slave_request(q->first);
+      }
     }
-  }
-  // [resolving]
-  if (uncommitted_slave_updates.count(who) &&
-      !uncommitted_slave_updates[who].empty()) {
-    for (map<metareqid_t, MDSlaveUpdate*>::iterator p = uncommitted_slave_updates[who].begin();
-	p != uncommitted_slave_updates[who].end();
-	++p) {
-      dout(10) << " including uncommitted " << p->first << dendl;
-      m->add_slave_request(p->first);
+  } else {
+    set<int> resolve_set;
+    mds->mdsmap->get_mds_set(resolve_set, MDSMap::STATE_RESOLVE);
+    for (hash_map<metareqid_t, MDRequest*>::iterator p = active_requests.begin();
+	 p != active_requests.end();
+	 ++p) {
+      if (!p->second->is_slave() || !p->second->slave_did_prepare())
+	continue;
+      int master = p->second->slave_to_mds;
+      if (resolve_set.count(master)) {
+	dout(10) << " including uncommitted " << *p->second << dendl;
+	if (!resolves.count(master))
+	  resolves[master] = new MMDSResolve;
+	resolves[master]->add_slave_request(p->first);
+      }
     }
   }
 
-  assert(!m->slave_requests.empty());
-  dout(10) << " will need resolve ack from mds." << who << dendl;
-  mds->send_message_mds(m, who);
+  for (map<int, MMDSResolve*>::iterator p = resolves.begin();
+       p != resolves.end();
+       ++p) {
+    dout(10) << "sending slave resolve to mds." << p->first << dendl;
+    mds->send_message_mds(p->second, p->first);
+    need_resolve_ack.insert(p->first);
+  }
 }
 
-void MDCache::send_resolve_now(int who)
+void MDCache::send_subtree_resolves()
 {
-  dout(10) << "send_resolve_now to mds." << who << dendl;
-  MMDSResolve *m = new MMDSResolve;
+  dout(10) << "send_subtree_resolves" << dendl;
 
-  show_subtrees();
+  if (migrator->is_exporting() || migrator->is_importing()) {
+    dout(7) << "send_subtree_resolves waiting, imports/exports still in progress" << dendl;
+    migrator->show_importing();
+    migrator->show_exporting();
+    resolves_pending = true;
+    return;  // not now
+  }
+
+  map<int, MMDSResolve*> resolves;
+  for (set<int>::iterator p = recovery_set.begin();
+       p != recovery_set.end();
+       ++p) {
+    if (*p == mds->whoami)
+      continue;
+    resolves[*p] = new MMDSResolve;
+  }
 
   // known
   for (map<CDir*,set<CDir*> >::iterator p = subtrees.begin();
@@ -2562,22 +2538,30 @@ void MDCache::send_resolve_now(int who)
       set<CDir*> bounds;
       get_subtree_bounds(dir, bounds);
       vector<dirfrag_t> dfls;
-      for (set<CDir*>::iterator p = bounds.begin(); p != bounds.end(); ++p)
-	dfls.push_back((*p)->dirfrag());
-      m->add_ambiguous_import(dir->dirfrag(), dfls);
+      for (set<CDir*>::iterator q = bounds.begin(); q != bounds.end(); ++q)
+	dfls.push_back((*q)->dirfrag());
+      for (map<int, MMDSResolve*>::iterator q = resolves.begin();
+	   q != resolves.end();
+	   ++q)
+	resolves[q->first]->add_ambiguous_import(dir->dirfrag(), dfls);
       dout(10) << " ambig " << dir->dirfrag() << " " << dfls << dendl;
     } else {
       // not ambiguous.
-      m->add_subtree(dir->dirfrag());
-      
+      for (map<int, MMDSResolve*>::iterator q = resolves.begin();
+	   q != resolves.end();
+	   ++q)
+	resolves[q->first]->add_subtree(dir->dirfrag());
       // bounds too
       vector<dirfrag_t> dfls;
       for (set<CDir*>::iterator q = subtrees[dir].begin();
 	   q != subtrees[dir].end();
 	   ++q) {
 	CDir *bound = *q;
-	m->add_subtree_bound(dir->dirfrag(), bound->dirfrag());
 	dfls.push_back(bound->dirfrag());
+	for (map<int, MMDSResolve*>::iterator r = resolves.begin();
+	     r != resolves.end();
+	     ++r)
+	  resolves[r->first]->add_subtree_bound(dir->dirfrag(), bound->dirfrag());
       }
       dout(10) << " claim " << dir->dirfrag() << " " << dfls << dendl;
     }
@@ -2587,15 +2571,23 @@ void MDCache::send_resolve_now(int who)
   for (map<dirfrag_t, vector<dirfrag_t> >::iterator p = my_ambiguous_imports.begin();
        p != my_ambiguous_imports.end();
        ++p) {
-    m->add_ambiguous_import(p->first, p->second);
+    for (map<int, MMDSResolve*>::iterator q = resolves.begin();
+	 q != resolves.end();
+	 ++q)
+      resolves[q->first]->add_ambiguous_import(p->first, p->second);
     dout(10) << " ambig " << p->first << " " << p->second << dendl;
   }
 
   // send
-  mds->send_message_mds(m, who);
+  for (map<int, MMDSResolve*>::iterator p = resolves.begin();
+       p != resolves.end();
+       ++p) {
+    dout(10) << "sending subtee resolve to mds." << p->first << dendl;
+    mds->send_message_mds(p->second, p->first);
+  }
+  resolves_pending = false;
 }
 
-
 void MDCache::handle_mds_failure(int who)
 {
   dout(7) << "handle_mds_failure mds." << who << dendl;
@@ -2631,7 +2623,6 @@ void MDCache::handle_mds_failure(int who)
     // slave to the failed node?
     if (p->second->slave_to_mds == who) {
       if (p->second->slave_did_prepare()) {
-	need_resolve_ack.insert(who);
 	dout(10) << " slave request " << *p->second << " uncommitted, will resolve shortly" << dendl;
       } else {
 	dout(10) << " slave request " << *p->second << " has no prepare, finishing up" << dendl;
@@ -3011,7 +3002,7 @@ void MDCache::handle_resolve_ack(MMDSResolveAck *ack)
 
   need_resolve_ack.erase(from);
   if (need_resolve_ack.empty() && need_resolve_rollback.empty()) {
-    send_resolves();
+    send_subtree_resolves();
     process_delayed_resolve();
   }
 
@@ -3078,7 +3069,7 @@ void MDCache::finish_rollback(metareqid_t reqid) {
     finish_uncommitted_slave_update(reqid, need_resolve_rollback[reqid]);
   need_resolve_rollback.erase(reqid);
   if (need_resolve_ack.empty() && need_resolve_rollback.empty()) {
-    send_resolves();
+    send_subtree_resolves();
     process_delayed_resolve();
   }
 }
diff --git a/src/mds/MDCache.h b/src/mds/MDCache.h
index 4634121..10e3dd7 100644
--- a/src/mds/MDCache.h
+++ b/src/mds/MDCache.h
@@ -328,6 +328,7 @@ protected:
   friend class ESlaveUpdate;
   friend class ECommitted;
 
+  bool resolves_pending;
   set<int> wants_resolve;   // nodes i need to send my resolve to
   set<int> got_resolve;     // nodes i got resolves from
   set<int> need_resolve_ack;   // nodes i need a resolve_ack from
@@ -367,10 +368,12 @@ public:
   void finish_ambiguous_import(dirfrag_t dirino);
   void resolve_start();
   void send_resolves();
-  void send_slave_resolve(int who);
-  void send_resolve_now(int who);
-  void send_resolve_later(int who);
-  void maybe_send_pending_resolves();
+  void send_slave_resolves();
+  void send_subtree_resolves();
+  void maybe_send_pending_resolves() {
+    if (resolves_pending)
+      send_subtree_resolves();
+  }
   
   void _move_subtree_map_bound(dirfrag_t df, dirfrag_t oldparent, dirfrag_t newparent,
 			       map<dirfrag_t,vector<dirfrag_t> >& subtrees);
-- 
1.7.11.7

