From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 09/29] mds: mark rename inode as ambiguous auth on all involved MDS
Date: Fri,  4 Jan 2013 17:02:00 +0800
Message-ID: <1357290140-17044-10-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17477 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab3ADJCi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:38 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When handling cross authority rename, the master first sends OP_RENAMEPREP
slave requests to witness MDS, then sends OP_RENAMEPREP slave request to
the rename inode's auth MDS after getting all witness MDS' acknowledgments.
Before receiving the OP_RENAMEPREP slave request, the rename inode's auth
MDS may change lock state of the rename inode and send lock messages to
witness MDS. But the witness MDS may already received the OP_RENAMEPREP
slave request and changed the source inode's authority. So the witness MDS
send lock acknowledgment message to wrong MDS and trigger assertion.

The fix is, firstly the master marks rename inode as ambiguous and send a
message to ask the rename inode's auth MDS to mark the inode as ambiguous,
then send OP_RENAMEPREP slave requests to the witness MDS, finally send
OP_RENAMEPREP slave request to the rename inode's auth MDS after getting
all witness MDS' acknowledgments.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc   | 14 ++++++++
 src/mds/CInode.h    |  6 +++-
 src/mds/MDCache.cc  |  6 ++++
 src/mds/Mutation.cc | 16 +++++++++
 src/mds/Mutation.h  |  8 ++++-
 src/mds/Server.cc   | 98 +++++++++++++++++++++++++++++++++--------------------
 src/mds/Server.h    |  2 +-
 7 files changed, 110 insertions(+), 40 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index 595892e..9d29b46 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -1932,6 +1932,20 @@ void CInode::unfreeze_auth_pin()
   }
 }
 
+void CInode::clear_ambiguous_auth(list<Context*>& finished)
+{
+  assert(state_test(CInode::STATE_AMBIGUOUSAUTH));
+  state_clear(CInode::STATE_AMBIGUOUSAUTH);
+  take_waiting(CInode::WAIT_SINGLEAUTH, finished);
+}
+
+void CInode::clear_ambiguous_auth()
+{
+  list<Context*> finished;
+  clear_ambiguous_auth(finished);
+  mdcache->mds->queue_waiters(finished);
+}
+
 // auth_pins
 bool CInode::can_auth_pin() {
   if (is_freezing_inode() || is_frozen_inode() || is_frozen_auth_pin())
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index e43ecf5..a627a4f 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -525,7 +525,11 @@ private:
     return state_test(STATE_AMBIGUOUSAUTH) ||
       MDSCacheObject::is_ambiguous_auth();
   }
-
+  void set_ambiguous_auth() {
+    state_set(STATE_AMBIGUOUSAUTH);
+  }
+  void clear_ambiguous_auth(list<Context*>& finished);
+  void clear_ambiguous_auth();
 
   inodeno_t ino() const { return inode.ino; }
   vinodeno_t vino() const { return vinodeno_t(inode.ino, last); }
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index da0c7f1..3410b0f 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -2616,6 +2616,9 @@ void MDCache::handle_mds_failure(int who)
 	p->second->more()->waiting_on_slave.erase(who);
 	mds->wait_for_active_peer(who, new C_MDS_RetryRequest(this, p->second));
       }
+
+      if (p->second->more()->prepared_inode_exporter == who)
+	p->second->more()->prepared_inode_exporter = -1;
     }
   }
 
@@ -7607,6 +7610,9 @@ void MDCache::request_cleanup(MDRequest *mdr)
   // drop (local) auth pins
   mdr->drop_local_auth_pins();
 
+  if (mdr->ambiguous_auth_inode)
+    mdr->clear_ambiguous_auth(mdr->ambiguous_auth_inode);
+
   // drop stickydirs
   for (set<CInode*>::iterator p = mdr->stickydirs.begin();
        p != mdr->stickydirs.end();
diff --git a/src/mds/Mutation.cc b/src/mds/Mutation.cc
index a9c3513..1c4cd13 100644
--- a/src/mds/Mutation.cc
+++ b/src/mds/Mutation.cc
@@ -106,6 +106,22 @@ void Mutation::unfreeze_auth_pin(CInode *inode)
   auth_pin_freeze = NULL;
 }
 
+void Mutation::set_ambiguous_auth(CInode *inode)
+{
+  if (!ambiguous_auth_inode) {
+    inode->set_ambiguous_auth();
+    ambiguous_auth_inode = inode;
+  } else
+    assert(ambiguous_auth_inode == inode);
+}
+
+void Mutation::clear_ambiguous_auth(CInode *inode)
+{
+  assert(ambiguous_auth_inode == inode);
+  ambiguous_auth_inode->clear_ambiguous_auth();
+  ambiguous_auth_inode = NULL;
+}
+
 bool Mutation::can_auth_pin(MDSCacheObject *object)
 {
   return object->can_auth_pin() || (is_auth_pinned(object) && object == auth_pin_freeze);
diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index 83a1196..bf59dba 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -51,6 +51,7 @@ struct Mutation {
   set< MDSCacheObject* > remote_auth_pins;
   set< MDSCacheObject* > auth_pins;
   CInode *auth_pin_freeze;
+  CInode* ambiguous_auth_inode;
   
   // held locks
   set< SimpleLock* > rdlocks;  // always local.
@@ -83,6 +84,7 @@ struct Mutation {
       ls(0),
       slave_to_mds(-1),
       auth_pin_freeze(NULL),
+      ambiguous_auth_inode(NULL),
       locking(NULL),
       done_locking(false), committing(false), aborted(false), killed(false) { }
   Mutation(metareqid_t ri, __u32 att=0, int slave_to=-1)
@@ -90,6 +92,7 @@ struct Mutation {
       ls(0),
       slave_to_mds(slave_to), 
       auth_pin_freeze(NULL),
+      ambiguous_auth_inode(NULL),
       locking(NULL),
       done_locking(false), committing(false), aborted(false), killed(false) { }
   virtual ~Mutation() {
@@ -127,6 +130,8 @@ struct Mutation {
   void unfreeze_auth_pin(CInode *inode);
   bool can_auth_pin(MDSCacheObject *object);
   void drop_local_auth_pins();
+  void set_ambiguous_auth(CInode *inode);
+  void clear_ambiguous_auth(CInode *inode);
   void add_projected_inode(CInode *in);
   void pop_and_dirty_projected_inodes();
   void add_projected_fnode(CDir *dir);
@@ -209,6 +214,7 @@ struct MDRequest : public Mutation {
     version_t inode_import_v;
     CInode* destdn_was_remote_inode;
     bool was_link_merge;
+    int prepared_inode_exporter; // has asked auth of srci to mark srci as ambiguous auth
 
     map<client_t,entity_inst_t> imported_client_map;
     map<client_t,uint64_t> sseq_map;
@@ -228,7 +234,7 @@ struct MDRequest : public Mutation {
     More() : 
       src_reanchor_atid(0), dst_reanchor_atid(0), inode_import_v(0),
       destdn_was_remote_inode(0), was_link_merge(false),
-      flock_was_waiting(false),
+      prepared_inode_exporter(-1), flock_was_waiting(false),
       stid(0),
       slave_commit(0) { }
   } *_more;
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index d1984a7..e17f826 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5406,8 +5406,19 @@ void Server::handle_client_rename(MDRequest *mdr)
 
   // do srcdn auth last
   int last = -1;
-  if (!srcdn->is_auth())
+  if (!srcdn->is_auth()) {
     last = srcdn->authority().first;
+    // set ambiguous auth for srci
+    mdr->set_ambiguous_auth(srci);
+    // Ask auth of srci to mark srci as ambiguous auth if more than two MDS
+    // are involved in the rename operation
+    if (srcdnl->is_primary() && mdr->more()->prepared_inode_exporter == -1) {
+      dout(10) << " preparing ambiguous auth for srci" << dendl;
+      mdr->more()->prepared_inode_exporter = last;
+      _rename_prepare_witness(mdr, last, witnesses, srcdn, destdn, straydn);
+      return;
+    }
+  }
   
   for (set<int>::iterator p = witnesses.begin();
        p != witnesses.end();
@@ -5418,7 +5429,7 @@ void Server::handle_client_rename(MDRequest *mdr)
     } else if (mdr->more()->waiting_on_slave.count(*p)) {
       dout(10) << " already waiting on witness mds." << *p << dendl;      
     } else {
-      _rename_prepare_witness(mdr, *p, srcdn, destdn, straydn);
+      _rename_prepare_witness(mdr, *p, witnesses, srcdn, destdn, straydn);
     }
   }
   if (!mdr->more()->waiting_on_slave.empty())
@@ -5428,7 +5439,7 @@ void Server::handle_client_rename(MDRequest *mdr)
       mdr->more()->witnessed.count(last) == 0 &&
       mdr->more()->waiting_on_slave.count(last) == 0) {
     dout(10) << " preparing last witness (srcdn auth)" << dendl;
-    _rename_prepare_witness(mdr, last, srcdn, destdn, straydn);
+    _rename_prepare_witness(mdr, last, witnesses, srcdn, destdn, straydn);
     return;
   }
 
@@ -5544,7 +5555,8 @@ void Server::_rename_finish(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDe
 
 // helpers
 
-void Server::_rename_prepare_witness(MDRequest *mdr, int who, CDentry *srcdn, CDentry *destdn, CDentry *straydn)
+void Server::_rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse,
+				     CDentry *srcdn, CDentry *destdn, CDentry *straydn)
 {
   dout(10) << "_rename_prepare_witness mds." << who << dendl;
   MMDSSlaveRequest *req = new MMDSSlaveRequest(mdr->reqid, mdr->attempt,
@@ -5557,7 +5569,7 @@ void Server::_rename_prepare_witness(MDRequest *mdr, int who, CDentry *srcdn, CD
     mdcache->replicate_stray(straydn, who, req->stray);
   
   // srcdn auth will verify our current witness list is sufficient
-  req->witnesses = mdr->more()->witnessed;
+  req->witnesses = witnesse;
 
   mds->send_message_mds(req, who);
   
@@ -5974,6 +5986,8 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
       // hack: fix auth bit
       in->state_set(CInode::STATE_AUTH);
       imported_inode = true;
+
+      mdr->clear_ambiguous_auth(in);
     }
 
     if (destdn->is_auth()) {
@@ -6100,15 +6114,8 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
 
   // am i srcdn auth?
   if (srcdn->is_auth()) {
-    if (srcdnl->is_primary()) {
-      // set ambiguous auth for srci
-      /*
-       * NOTE: we don't worry about ambiguous cache expire as we do
-       * with subtree migrations because all slaves will pin
-       * srcdn->get_inode() for duration of this rename.
-       */
-      srcdnl->get_inode()->state_set(CInode::STATE_AMBIGUOUSAUTH);
-
+    bool reply_witness = false;
+    if (srcdnl->is_primary() && !srcdnl->get_inode()->state_test(CInode::STATE_AMBIGUOUSAUTH)) {
       // freeze?
       // we need this to
       //  - avoid conflicting lock state changes
@@ -6127,17 +6134,36 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
 	srcdnl->get_inode()->add_waiter(CInode::WAIT_FROZEN, new C_MDS_RetryRequest(mdcache, mdr));
 	return;
       }
+
+      /*
+       * set ambiguous auth for srci
+       * NOTE: we don't worry about ambiguous cache expire as we do
+       * with subtree migrations because all slaves will pin
+       * srcdn->get_inode() for duration of this rename.
+       */
+      srcdnl->get_inode()->set_ambiguous_auth();
+
+      // just mark the source inode as ambiguous auth if more than two MDS are involved.
+      // the master will send another OP_RENAMEPREP slave request later.
+      if (mdr->slave_request->witnesses.size() > 1) {
+	dout(10) << " set srci ambiguous auth; providing srcdn replica list" << dendl;
+	reply_witness = true;
+      }
     }
 
     // is witness list sufficient?
     set<int> srcdnrep;
     srcdn->list_replicas(srcdnrep);
-    for (set<int>::iterator p = srcdnrep.begin();
-	 p != srcdnrep.end();
-	 ++p) {
+    for (set<int>::iterator p = srcdnrep.begin(); p != srcdnrep.end(); ++p) {
       if (*p == mdr->slave_to_mds ||
 	  mdr->slave_request->witnesses.count(*p)) continue;
       dout(10) << " witness list insufficient; providing srcdn replica list" << dendl;
+      reply_witness = true;
+      break;
+    }
+
+    if (reply_witness) {
+      assert(srcdnrep.size());
       MMDSSlaveRequest *reply = new MMDSSlaveRequest(mdr->reqid, mdr->attempt,
 						     MMDSSlaveRequest::OP_RENAMEPREPACK);
       reply->witnesses.swap(srcdnrep);
@@ -6147,6 +6173,9 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
       return;	
     }
     dout(10) << " witness list sufficient: includes all srcdn replicas" << dendl;
+  } else if (srcdnl->is_primary() && srcdn->authority() != destdn->authority()) {
+    // set ambiguous auth for srci on witnesses
+    srcdnl->get_inode()->set_ambiguous_auth();
   }
 
   // encode everything we'd need to roll this back... basically, just the original state.
@@ -6255,6 +6284,7 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
   CDentry::linkage_t *destdnl = destdn->get_linkage();
 
   ESlaveUpdate *le;
+  list<Context*> finished;
   if (r == 0) {
     // write a commit to the journal
     le = new ESlaveUpdate(mdlog, "slave_rename_commit", mdr->reqid, mdr->slave_to_mds,
@@ -6263,9 +6293,7 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
 
     // unfreeze+singleauth inode
     //  hmm, do i really need to delay this?
-    if (srcdn->is_auth() && destdnl->is_primary() &&
-	destdnl->get_inode()->state_test(CInode::STATE_AMBIGUOUSAUTH)) {
-      list<Context*> finished;
+    if (srcdn->is_auth() && destdnl->is_primary()) {
 
       CInode *in = destdnl->get_inode();
 
@@ -6285,41 +6313,37 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
       mdcache->migrator->finish_export_inode(destdnl->get_inode(), mdr->now, finished);
       mds->queue_waiters(finished);   // this includes SINGLEAUTH waiters.
 
-      // singleauth
-      assert(destdnl->get_inode()->state_test(CInode::STATE_AMBIGUOUSAUTH));
-      destdnl->get_inode()->state_clear(CInode::STATE_AMBIGUOUSAUTH);
-      destdnl->get_inode()->take_waiting(CInode::WAIT_SINGLEAUTH, finished);
-
       // unfreeze
       assert(destdnl->get_inode()->is_frozen_inode());
       destdnl->get_inode()->unfreeze_inode(finished);
-
-      mds->queue_waiters(finished);
     }
+
+    // singleauth
+    if (destdnl->is_primary() && srcdn->authority() != destdn->authority())
+      destdnl->get_inode()->clear_ambiguous_auth(finished);
+
+    mds->queue_waiters(finished);
     mdr->cleanup();
 
     mdlog->submit_entry(le, new C_MDS_CommittedSlave(this, mdr));
     mdlog->flush();
   } else {
-    if (srcdn->is_auth() && destdnl->is_primary() &&
-	destdnl->get_inode()->state_test(CInode::STATE_AMBIGUOUSAUTH)) {
-         list<Context*> finished;
+    if (srcdn->is_auth() && destdnl->is_primary()) {
 
       dout(10) << " reversing inode export of " << *destdnl->get_inode() << dendl;
       destdnl->get_inode()->abort_export();
     
-      // singleauth
-      assert(destdnl->get_inode()->state_test(CInode::STATE_AMBIGUOUSAUTH));
-      destdnl->get_inode()->state_clear(CInode::STATE_AMBIGUOUSAUTH);
-      destdnl->get_inode()->take_waiting(CInode::WAIT_SINGLEAUTH, finished);
-      
       // unfreeze
       assert(destdnl->get_inode()->is_frozen_inode());
       destdnl->get_inode()->unfreeze_inode(finished);
-      
-      mds->queue_waiters(finished);
     }
 
+    // singleauth
+    if (destdnl->is_primary() && srcdn->authority() != destdn->authority())
+      destdnl->get_inode()->clear_ambiguous_auth(finished);
+
+    mds->queue_waiters(finished);
+
     // abort
     //  rollback_bl may be empty if we froze the inode but had to provide an expanded
     // witness list from the master, and they failed before we tried prep again.
diff --git a/src/mds/Server.h b/src/mds/Server.h
index 0611e3b..f9d51f5 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -214,7 +214,7 @@ public:
   void _rmsnap_finish(MDRequest *mdr, CInode *diri, snapid_t snapid);
 
   // helpers
-  void _rename_prepare_witness(MDRequest *mdr, int who,
+  void _rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse,
 			       CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   version_t _rename_prepare_import(MDRequest *mdr, CDentry *srcdn, bufferlist *client_map_bl);
   void _rename_prepare(MDRequest *mdr,
-- 
1.7.11.7

