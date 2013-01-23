From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 23/25] mds: move variables special to rename into MDRequest::more
Date: Wed, 23 Jan 2013 11:08:59 +0800
Message-ID: <1358910541-15535-24-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36351 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab3AWDJZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:25 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

My previous patches add two pointers (ambiguous_auth_inode and
auth_pin_freeze) to class Mutation. They are both used by cross
authority rename, both point to the renamed inode. Later patches
need add more rename special state to MDRequest, So just move them
into MDRequest::more

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc  |  16 +++++---
 src/mds/Mutation.cc | 110 ++++++++++++++++++++++++++++++----------------------
 src/mds/Mutation.h  |  32 +++++++--------
 src/mds/Server.cc   |  34 ++++++++--------
 4 files changed, 105 insertions(+), 87 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 14d1fcb..499b4e0 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2626,7 +2626,7 @@ void MDCache::handle_mds_failure(int who)
     }
     
     // failed node is slave?
-    if (!p->second->committing) {
+    if (p->second->is_master() && !p->second->committing) {
       if (p->second->more()->witnessed.count(who)) {
 	dout(10) << " master request " << *p->second << " no longer witnessed by slave mds." << who
 		 << dendl;
@@ -2642,8 +2642,12 @@ void MDCache::handle_mds_failure(int who)
 	mds->wait_for_active_peer(who, new C_MDS_RetryRequest(this, p->second));
       }
 
-      if (p->second->more()->prepared_inode_exporter == who)
-	p->second->more()->prepared_inode_exporter = -1;
+      if (p->second->has_more() && p->second->more()->is_ambiguous_auth &&
+	  p->second->more()->rename_inode->authority().first == who) {
+	dout(10) << " master request " << *p->second << " waiting for renamed inode's auth mds." << who
+		 << " to recover" << dendl;
+	p->second->clear_ambiguous_auth();
+      }
     }
   }
 
@@ -7733,14 +7737,14 @@ void MDCache::request_cleanup(MDRequest *mdr)
 {
   dout(15) << "request_cleanup " << *mdr << dendl;
 
+  if (mdr->has_more() && mdr->more()->is_ambiguous_auth)
+    mdr->clear_ambiguous_auth();
+
   request_drop_locks(mdr);
 
   // drop (local) auth pins
   mdr->drop_local_auth_pins();
 
-  if (mdr->ambiguous_auth_inode)
-    mdr->clear_ambiguous_auth(mdr->ambiguous_auth_inode);
-
   // drop stickydirs
   for (set<CInode*>::iterator p = mdr->stickydirs.begin();
        p != mdr->stickydirs.end();
diff --git a/src/mds/Mutation.cc b/src/mds/Mutation.cc
index 1c4cd13..367181c 100644
--- a/src/mds/Mutation.cc
+++ b/src/mds/Mutation.cc
@@ -82,55 +82,8 @@ void Mutation::auth_unpin(MDSCacheObject *object)
   auth_pins.erase(object);
 }
 
-bool Mutation::freeze_auth_pin(CInode *inode)
-{
-  assert(!auth_pin_freeze || auth_pin_freeze == inode);
-  auth_pin_freeze = inode;
-  auth_pin(inode);
-  if (!inode->freeze_inode(1))
-    return false;
-
-  inode->freeze_auth_pin();
-  inode->unfreeze_inode();
-  return true;
-}
-
-void Mutation::unfreeze_auth_pin(CInode *inode)
-{
-  assert(auth_pin_freeze == inode);
-  assert(is_auth_pinned(inode));
-  if (inode->is_frozen_auth_pin())
-    inode->unfreeze_auth_pin();
-  else
-    inode->unfreeze_inode();
-  auth_pin_freeze = NULL;
-}
-
-void Mutation::set_ambiguous_auth(CInode *inode)
-{
-  if (!ambiguous_auth_inode) {
-    inode->set_ambiguous_auth();
-    ambiguous_auth_inode = inode;
-  } else
-    assert(ambiguous_auth_inode == inode);
-}
-
-void Mutation::clear_ambiguous_auth(CInode *inode)
-{
-  assert(ambiguous_auth_inode == inode);
-  ambiguous_auth_inode->clear_ambiguous_auth();
-  ambiguous_auth_inode = NULL;
-}
-
-bool Mutation::can_auth_pin(MDSCacheObject *object)
-{
-  return object->can_auth_pin() || (is_auth_pinned(object) && object == auth_pin_freeze);
-}
-
 void Mutation::drop_local_auth_pins()
 {
-  if (auth_pin_freeze)
-    unfreeze_auth_pin(auth_pin_freeze);
   for (set<MDSCacheObject*>::iterator it = auth_pins.begin();
        it != auth_pins.end();
        it++) {
@@ -230,6 +183,11 @@ MDRequest::More* MDRequest::more()
   return _more;
 }
 
+bool MDRequest::has_more()
+{
+  return _more;
+}
+
 bool MDRequest::are_slaves()
 {
   return _more && !_more->slaves.empty();
@@ -245,6 +203,64 @@ bool MDRequest::did_ino_allocation()
   return alloc_ino || used_prealloc_ino || prealloc_inos.size();
 }      
 
+bool MDRequest::freeze_auth_pin(CInode *inode)
+{
+  assert(!more()->rename_inode || more()->rename_inode == inode);
+  more()->rename_inode = inode;
+  more()->is_freeze_authpin = true;
+  auth_pin(inode);
+  if (!inode->freeze_inode(1)) {
+    return false;
+  }
+  inode->freeze_auth_pin();
+  inode->unfreeze_inode();
+  return true;
+}
+
+void MDRequest::unfreeze_auth_pin()
+{
+  assert(more()->is_freeze_authpin);
+  CInode *inode = more()->rename_inode;
+  if (inode->is_frozen_auth_pin())
+    inode->unfreeze_auth_pin();
+  else
+    inode->unfreeze_inode();
+  more()->is_freeze_authpin = false;
+}
+
+void MDRequest::set_ambiguous_auth(CInode *inode)
+{
+  assert(!more()->rename_inode || more()->rename_inode == inode);
+  assert(!more()->is_ambiguous_auth);
+
+  inode->set_ambiguous_auth();
+  more()->rename_inode = inode;
+  more()->is_ambiguous_auth = true;
+}
+
+void MDRequest::clear_ambiguous_auth()
+{
+  CInode *inode = more()->rename_inode;
+  assert(inode && more()->is_ambiguous_auth);
+  inode->clear_ambiguous_auth();
+  more()->is_ambiguous_auth = false;
+}
+
+bool MDRequest::can_auth_pin(MDSCacheObject *object)
+{
+  return object->can_auth_pin() ||
+         (is_auth_pinned(object) && has_more() &&
+	  more()->is_freeze_authpin &&
+	  more()->rename_inode == object);
+}
+
+void MDRequest::drop_local_auth_pins()
+{
+  if (has_more() && more()->is_freeze_authpin)
+    unfreeze_auth_pin();
+  Mutation::drop_local_auth_pins();
+}
+
 void MDRequest::print(ostream &out)
 {
   out << "request(" << reqid;
diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index 36d62a7..c64657f 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -50,8 +50,6 @@ struct Mutation {
   // auth pins
   set< MDSCacheObject* > remote_auth_pins;
   set< MDSCacheObject* > auth_pins;
-  CInode *auth_pin_freeze;
-  CInode* ambiguous_auth_inode;
   
   // held locks
   set< SimpleLock* > rdlocks;  // always local.
@@ -83,16 +81,12 @@ struct Mutation {
     : attempt(0),
       ls(0),
       slave_to_mds(-1),
-      auth_pin_freeze(NULL),
-      ambiguous_auth_inode(NULL),
       locking(NULL),
       done_locking(false), committing(false), aborted(false), killed(false) { }
   Mutation(metareqid_t ri, __u32 att=0, int slave_to=-1)
     : reqid(ri), attempt(att),
       ls(0),
       slave_to_mds(slave_to), 
-      auth_pin_freeze(NULL),
-      ambiguous_auth_inode(NULL),
       locking(NULL),
       done_locking(false), committing(false), aborted(false), killed(false) { }
   virtual ~Mutation() {
@@ -126,12 +120,7 @@ struct Mutation {
   bool is_auth_pinned(MDSCacheObject *object);
   void auth_pin(MDSCacheObject *object);
   void auth_unpin(MDSCacheObject *object);
-  bool freeze_auth_pin(CInode *inode);
-  void unfreeze_auth_pin(CInode *inode);
-  bool can_auth_pin(MDSCacheObject *object);
   void drop_local_auth_pins();
-  void set_ambiguous_auth(CInode *inode);
-  void clear_ambiguous_auth(CInode *inode);
   void add_projected_inode(CInode *in);
   void pop_and_dirty_projected_inodes();
   void add_projected_fnode(CDir *dir);
@@ -212,9 +201,10 @@ struct MDRequest : public Mutation {
     version_t dst_reanchor_atid;  // dst->stray
     bufferlist inode_import;
     version_t inode_import_v;
-    CInode* destdn_was_remote_inode;
-    bool was_inode_exportor;
-    int prepared_inode_exporter; // has asked auth of srci to mark srci as ambiguous auth
+    CInode* rename_inode;
+    bool is_freeze_authpin;
+    bool is_ambiguous_auth;
+    bool is_inode_exporter;
 
     map<client_t,entity_inst_t> imported_client_map;
     map<client_t,uint64_t> sseq_map;
@@ -233,10 +223,9 @@ struct MDRequest : public Mutation {
 
     More() : 
       src_reanchor_atid(0), dst_reanchor_atid(0), inode_import_v(0),
-      destdn_was_remote_inode(0), was_inode_exportor(false),
-      prepared_inode_exporter(-1), flock_was_waiting(false),
-      stid(0),
-      slave_commit(0) { }
+      rename_inode(0), is_freeze_authpin(false), is_ambiguous_auth(false),
+      is_inode_exporter(false), flock_was_waiting(false),
+      stid(0), slave_commit(0) { }
   } *_more;
 
 
@@ -285,9 +274,16 @@ struct MDRequest : public Mutation {
   }
   
   More* more();
+  bool has_more();
   bool are_slaves();
   bool slave_did_prepare();
   bool did_ino_allocation();
+  bool freeze_auth_pin(CInode *inode);
+  void unfreeze_auth_pin();
+  bool can_auth_pin(MDSCacheObject *object);
+  void drop_local_auth_pins();
+  void set_ambiguous_auth(CInode *inode);
+  void clear_ambiguous_auth();
 
   void print(ostream &out);
 };
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 5f3119d..ad28750 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5452,13 +5452,11 @@ void Server::handle_client_rename(MDRequest *mdr)
   int last = -1;
   if (!srcdn->is_auth()) {
     last = srcdn->authority().first;
-    // set ambiguous auth for srci
-    mdr->set_ambiguous_auth(srci);
-    // Ask auth of srci to mark srci as ambiguous auth if more than two MDS
-    // are involved in the rename operation
-    if (srcdnl->is_primary() && mdr->more()->prepared_inode_exporter == -1) {
+    // ask auth of srci to mark srci as ambiguous auth if more than two MDS
+    // are involved in the rename operation.
+    if (srcdnl->is_primary() && !mdr->more()->is_ambiguous_auth) {
       dout(10) << " preparing ambiguous auth for srci" << dendl;
-      mdr->more()->prepared_inode_exporter = last;
+      mdr->set_ambiguous_auth(srci);
       _rename_prepare_witness(mdr, last, witnesses, srcdn, destdn, straydn);
       return;
     }
@@ -6057,7 +6055,7 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
       in->state_set(CInode::STATE_AUTH);
       imported_inode = true;
 
-      mdr->clear_ambiguous_auth(in);
+      mdr->clear_ambiguous_auth();
     }
 
     if (destdn->is_auth()) {
@@ -6197,7 +6195,7 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
 
       // unfreeze auth pin after freezing the inode to avoid queueing waiters
       if (srcdnl->get_inode()->is_frozen_auth_pin())
-	mdr->unfreeze_auth_pin(srcdnl->get_inode());
+	mdr->unfreeze_auth_pin();
 
       if (!frozen_inode) {
 	srcdnl->get_inode()->add_waiter(CInode::WAIT_FROZEN, new C_MDS_RetryRequest(mdcache, mdr));
@@ -6210,7 +6208,7 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
        * with subtree migrations because all slaves will pin
        * srcdn->get_inode() for duration of this rename.
        */
-      srcdnl->get_inode()->set_ambiguous_auth();
+      mdr->set_ambiguous_auth(srcdnl->get_inode());
 
       // just mark the source inode as ambiguous auth if more than two MDS are involved.
       // the master will send another OP_RENAMEPREP slave request later.
@@ -6244,7 +6242,7 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
     dout(10) << " witness list sufficient: includes all srcdn replicas" << dendl;
   } else if (srcdnl->is_primary() && srcdn->authority() != destdn->authority()) {
     // set ambiguous auth for srci on witnesses
-    srcdnl->get_inode()->set_ambiguous_auth();
+    mdr->set_ambiguous_auth(srcdnl->get_inode());
   }
 
   // encode everything we'd need to roll this back... basically, just the original state.
@@ -6324,7 +6322,7 @@ void Server::_logged_slave_rename(MDRequest *mdr,
 
     // remove mdr auth pin
     mdr->auth_unpin(srcdnl->get_inode());
-    mdr->more()->was_inode_exportor = true;
+    mdr->more()->is_inode_exporter = true;
     
     dout(10) << " exported srci " << *srcdnl->get_inode() << dendl;
   }
@@ -6363,7 +6361,7 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
 
     // unfreeze+singleauth inode
     //  hmm, do i really need to delay this?
-    if (mdr->more()->was_inode_exportor) {
+    if (mdr->more()->is_inode_exporter) {
 
       CInode *in = destdnl->get_inode();
 
@@ -6389,8 +6387,10 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
     }
 
     // singleauth
-    if (destdnl->is_primary() && srcdn->authority() != destdn->authority())
-      destdnl->get_inode()->clear_ambiguous_auth(finished);
+    if (mdr->more()->is_ambiguous_auth) {
+      mdr->more()->rename_inode->clear_ambiguous_auth(finished);
+      mdr->more()->is_ambiguous_auth = false;
+    }
 
     mds->queue_waiters(finished);
     mdr->cleanup();
@@ -6409,8 +6409,10 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
     }
 
     // singleauth
-    if (destdnl->is_primary() && srcdn->authority() != destdn->authority())
-      destdnl->get_inode()->clear_ambiguous_auth(finished);
+    if (mdr->more()->is_ambiguous_auth) {
+      mdr->more()->rename_inode->clear_ambiguous_auth(finished);
+      mdr->more()->is_ambiguous_auth = false;
+    }
 
     mds->queue_waiters(finished);
 
-- 
1.7.11.7

