From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 14/16] mds: fix freeze inode deadlock
Date: Mon, 19 Nov 2012 10:43:46 +0800
Message-ID: <1353293028-15238-15-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57821 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab2KSCoG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:06 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

CInode::freeze_inode() is used in the case of cross authority rename.
Server::handle_slave_rename_prep() calls it to wait for all other
operations on source inode to complete. This happens after all locks
for the rename operation are acquired. But to acquire locks, we need
auth pin locks' parent objects first. So there is an ABBA deadlock
if someone auth pins the source inode after locks for rename are
acquired and before Server::handle_slave_rename_prep() is called.
The fix is freeze and auth pin the source inode at the same time.

This patch introduces CInode::freeze_auth_pin(), it waits for all
other MDRequests to release auth pins, then change the inode to
FROZENAUTHPIN state, this state prevents other MDRequests from
getting new auth pins.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.cc               | 36 +++++++++++++++++++++++++++----
 src/mds/CInode.h                |  5 +++++
 src/mds/Locker.cc               |  7 ++++--
 src/mds/Locker.h                |  3 ++-
 src/mds/Mutation.cc             | 31 +++++++++++++++++++++++++++
 src/mds/Mutation.h              |  6 ++++++
 src/mds/Server.cc               | 47 ++++++++++++++++++++++++++++++-----------
 src/mds/mdstypes.h              |  7 ++++++
 src/messages/MMDSSlaveRequest.h |  1 +
 9 files changed, 124 insertions(+), 19 deletions(-)

diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
index c129308..af70b68 100644
--- a/src/mds/CInode.cc
+++ b/src/mds/CInode.cc
@@ -130,6 +130,7 @@ ostream& operator<<(ostream& out, CInode& in)
   if (in.state_test(CInode::STATE_DIRTYPARENT)) out << " dirtyparent";
   if (in.is_freezing_inode()) out << " FREEZING=" << in.auth_pin_freeze_allowance;
   if (in.is_frozen_inode()) out << " FROZEN";
+  if (in.is_frozen_auth_pin()) out << " FROZEN_AUTHPIN";
 
   inode_t *pi = in.get_projected_inode();
   if (pi->is_truncating())
@@ -1862,7 +1863,8 @@ void CInode::add_waiter(uint64_t tag, Context *c)
   // wait on the directory?
   //  make sure its not the inode that is explicitly ambiguous|freezing|frozen
   if (((tag & WAIT_SINGLEAUTH) && !state_test(STATE_AMBIGUOUSAUTH)) ||
-      ((tag & WAIT_UNFREEZE) && !is_frozen_inode() && !is_freezing_inode())) {
+      ((tag & WAIT_UNFREEZE) &&
+       !is_frozen_inode() && !is_freezing_inode() && !is_frozen_auth_pin())) {
     dout(15) << "passing waiter up tree" << dendl;
     parent->dir->add_waiter(tag, c);
     return;
@@ -1885,8 +1887,10 @@ bool CInode::freeze_inode(int auth_pin_allowance)
 
   dout(10) << "freeze_inode - frozen" << dendl;
   assert(auth_pins == auth_pin_allowance);
-  get(PIN_FROZEN);
-  state_set(STATE_FROZEN);
+  if (!state_test(STATE_FROZEN)) {
+    get(PIN_FROZEN);
+    state_set(STATE_FROZEN);
+  }
   return true;
 }
 
@@ -1904,10 +1908,34 @@ void CInode::unfreeze_inode(list<Context*>& finished)
   take_waiting(WAIT_UNFREEZE, finished);
 }
 
+void CInode::unfreeze_inode()
+{
+    list<Context*> finished;
+    unfreeze_inode(finished);
+    mdcache->mds->queue_waiters(finished);
+}
+
+void CInode::freeze_auth_pin()
+{
+  assert(state_test(CInode::STATE_FROZEN));
+  state_set(CInode::STATE_FROZENAUTHPIN);
+}
+
+void CInode::unfreeze_auth_pin()
+{
+  assert(state_test(CInode::STATE_FROZENAUTHPIN));
+  state_clear(CInode::STATE_FROZENAUTHPIN);
+  if (!state_test(STATE_FREEZING|STATE_FROZEN)) {
+    list<Context*> finished;
+    take_waiting(WAIT_UNFREEZE, finished);
+    mdcache->mds->queue_waiters(finished);
+  }
+}
 
 // auth_pins
 bool CInode::can_auth_pin() {
-  if (is_freezing_inode() || is_frozen_inode()) return false;
+  if (is_freezing_inode() || is_frozen_inode() || is_frozen_auth_pin())
+    return false;
   if (parent)
     return parent->can_auth_pin();
   return true;
diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index b76b524..e43ecf5 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -181,6 +181,7 @@ public:
   static const int STATE_DIRTYPARENT =  (1<<14);
   static const int STATE_DIRTYRSTAT =  (1<<15);
   static const int STATE_STRAYPINNED = (1<<16);
+  static const int STATE_FROZENAUTHPIN = (1<<17);
 
   // -- waiters --
   static const uint64_t WAIT_DIR         = (1<<0);
@@ -856,6 +857,7 @@ public:
   // -- freeze --
   bool is_freezing_inode() { return state_test(STATE_FREEZING); }
   bool is_frozen_inode() { return state_test(STATE_FROZEN); }
+  bool is_frozen_auth_pin() { return state_test(STATE_FROZENAUTHPIN); }
   bool is_frozen();
   bool is_frozen_dir();
   bool is_freezing();
@@ -864,7 +866,10 @@ public:
    * auth_pins it is itself holding/responsible for. */
   bool freeze_inode(int auth_pin_allowance=0);
   void unfreeze_inode(list<Context*>& finished);
+  void unfreeze_inode();
 
+  void freeze_auth_pin();
+  void unfreeze_auth_pin();
 
   // -- reference counting --
   void bad_put(int by) {
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 63f8311..ee4799e 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -174,7 +174,8 @@ bool Locker::acquire_locks(MDRequest *mdr,
 			   set<SimpleLock*> &rdlocks,
 			   set<SimpleLock*> &wrlocks,
 			   set<SimpleLock*> &xlocks,
-			   map<SimpleLock*,int> *remote_wrlocks)
+			   map<SimpleLock*,int> *remote_wrlocks,
+			   CInode *auth_pin_freeze)
 {
   if (mdr->done_locking &&
       !mdr->is_slave()) {  // not on slaves!  master requests locks piecemeal.
@@ -336,7 +337,9 @@ bool Locker::acquire_locks(MDRequest *mdr,
 	dout(10) << " req remote auth_pin of " << **q << dendl;
 	MDSCacheObjectInfo info;
 	(*q)->set_object_info(info);
-	req->get_authpins().push_back(info);      
+	req->get_authpins().push_back(info);
+	if (*q == auth_pin_freeze)
+	  (*q)->set_object_info(req->get_authpin_freeze());
 	mdr->pin(*q);
       }
       mds->send_message_mds(req, p->first);
diff --git a/src/mds/Locker.h b/src/mds/Locker.h
index a1cf59e..b3b9919 100644
--- a/src/mds/Locker.h
+++ b/src/mds/Locker.h
@@ -88,7 +88,8 @@ public:
 		     set<SimpleLock*> &rdlocks,
 		     set<SimpleLock*> &wrlocks,
 		     set<SimpleLock*> &xlocks,
-		     map<SimpleLock*,int> *remote_wrlocks=NULL);
+		     map<SimpleLock*,int> *remote_wrlocks=NULL,
+		     CInode *auth_pin_freeze=NULL);
 
   void cancel_locking(Mutation *mut, set<CInode*> *pneed_issue);
   void drop_locks(Mutation *mut, set<CInode*> *pneed_issue=0);
diff --git a/src/mds/Mutation.cc b/src/mds/Mutation.cc
index 6321ffc..a9c3513 100644
--- a/src/mds/Mutation.cc
+++ b/src/mds/Mutation.cc
@@ -82,8 +82,39 @@ void Mutation::auth_unpin(MDSCacheObject *object)
   auth_pins.erase(object);
 }
 
+bool Mutation::freeze_auth_pin(CInode *inode)
+{
+  assert(!auth_pin_freeze || auth_pin_freeze == inode);
+  auth_pin_freeze = inode;
+  auth_pin(inode);
+  if (!inode->freeze_inode(1))
+    return false;
+
+  inode->freeze_auth_pin();
+  inode->unfreeze_inode();
+  return true;
+}
+
+void Mutation::unfreeze_auth_pin(CInode *inode)
+{
+  assert(auth_pin_freeze == inode);
+  assert(is_auth_pinned(inode));
+  if (inode->is_frozen_auth_pin())
+    inode->unfreeze_auth_pin();
+  else
+    inode->unfreeze_inode();
+  auth_pin_freeze = NULL;
+}
+
+bool Mutation::can_auth_pin(MDSCacheObject *object)
+{
+  return object->can_auth_pin() || (is_auth_pinned(object) && object == auth_pin_freeze);
+}
+
 void Mutation::drop_local_auth_pins()
 {
+  if (auth_pin_freeze)
+    unfreeze_auth_pin(auth_pin_freeze);
   for (set<MDSCacheObject*>::iterator it = auth_pins.begin();
        it != auth_pins.end();
        it++) {
diff --git a/src/mds/Mutation.h b/src/mds/Mutation.h
index ca5ee96..d05d0ee 100644
--- a/src/mds/Mutation.h
+++ b/src/mds/Mutation.h
@@ -50,6 +50,7 @@ struct Mutation {
   // auth pins
   set< MDSCacheObject* > remote_auth_pins;
   set< MDSCacheObject* > auth_pins;
+  CInode *auth_pin_freeze;
   
   // held locks
   set< SimpleLock* > rdlocks;  // always local.
@@ -80,12 +81,14 @@ struct Mutation {
     : attempt(0),
       ls(0),
       slave_to_mds(-1),
+      auth_pin_freeze(NULL),
       locking(NULL),
       done_locking(false), committing(false), aborted(false) { }
   Mutation(metareqid_t ri, __u32 att=0, int slave_to=-1)
     : reqid(ri), attempt(att),
       ls(0),
       slave_to_mds(slave_to), 
+      auth_pin_freeze(NULL),
       locking(NULL),
       done_locking(false), committing(false), aborted(false) { }
   virtual ~Mutation() {
@@ -119,6 +122,9 @@ struct Mutation {
   bool is_auth_pinned(MDSCacheObject *object);
   void auth_pin(MDSCacheObject *object);
   void auth_unpin(MDSCacheObject *object);
+  bool freeze_auth_pin(CInode *inode);
+  void unfreeze_auth_pin(CInode *inode);
+  bool can_auth_pin(MDSCacheObject *object);
   void drop_local_auth_pins();
   void add_projected_inode(CInode *in);
   void pop_and_dirty_projected_inodes();
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index f8d6666..5cee949 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -1486,6 +1486,7 @@ void Server::handle_slave_auth_pin(MDRequest *mdr)
 
   // build list of objects
   list<MDSCacheObject*> objects;
+  CInode *auth_pin_freeze = NULL;
   bool fail = false;
 
   for (vector<MDSCacheObjectInfo>::iterator p = mdr->slave_request->get_authpins().begin();
@@ -1499,6 +1500,8 @@ void Server::handle_slave_auth_pin(MDRequest *mdr)
     }
 
     objects.push_back(object);
+    if (*p == mdr->slave_request->get_authpin_freeze())
+      auth_pin_freeze = dynamic_cast<CInode*>(object);
   }
   
   // can we auth pin them?
@@ -1511,8 +1514,7 @@ void Server::handle_slave_auth_pin(MDRequest *mdr)
 	fail = true;
 	break;
       }
-      if (!mdr->is_auth_pinned(*p) &&
-	  !(*p)->can_auth_pin()) {
+      if (!mdr->can_auth_pin(*p)) {
 	// wait
 	dout(10) << " waiting for authpinnable on " << **p << dendl;
 	(*p)->add_waiter(CDir::WAIT_UNFREEZE, new C_MDS_RetryRequest(mdcache, mdr));
@@ -1526,6 +1528,22 @@ void Server::handle_slave_auth_pin(MDRequest *mdr)
   if (fail) {
     mdr->drop_local_auth_pins();  // just in case
   } else {
+    /* handle_slave_rename_prep() call freeze_inode() to wait for all other operations
+     * on the source inode to complete. This happens after all locks for the rename
+     * operation are acquired. But to acquire locks, we need auth pin locks' parent
+     * objects first. So there is an ABBA deadlock if someone auth pins the source inode
+     * after locks are acquired and before Server::handle_slave_rename_prep() is called.
+     * The solution is freeze the inode and prevent other MDRequests from getting new
+     * auth pins.
+     */
+    if (auth_pin_freeze) {
+      dout(10) << " freezing auth pin on " << *auth_pin_freeze << dendl;
+      if (!mdr->freeze_auth_pin(auth_pin_freeze)) {
+	auth_pin_freeze->add_waiter(CInode::WAIT_FROZEN, new C_MDS_RetryRequest(mdcache, mdr));
+	mds->mdlog->flush();
+	return;
+      }
+    }
     for (list<MDSCacheObject*>::iterator p = objects.begin();
 	 p != objects.end();
 	 ++p) {
@@ -1922,7 +1940,8 @@ CInode* Server::rdlock_path_pin_ref(MDRequest *mdr, int n,
     //   do NOT proceed if freezing, as cap release may defer in that case, and
     //   we could deadlock when we try to lock @ref.
     // if we're already auth_pinned, continue; the release has already been processed.
-    if (ref->is_frozen() || (ref->is_freezing() && !mdr->is_auth_pinned(ref))) {
+    if (ref->is_frozen() || ref->is_frozen_auth_pin() ||
+	(ref->is_freezing() && !mdr->is_auth_pinned(ref))) {
       dout(7) << "waiting for !frozen/authpinnable on " << *ref << dendl;
       ref->add_waiter(CInode::WAIT_UNFREEZE, new C_MDS_RetryRequest(mdcache, mdr));
       /* If we have any auth pins, this will deadlock.
@@ -5241,7 +5260,9 @@ void Server::handle_client_rename(MDRequest *mdr)
   // take any locks needed for anchor creation/verification
   mds->mdcache->anchor_create_prep_locks(mdr, srci, rdlocks, xlocks);
 
-  if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks, &remote_wrlocks))
+  CInode *auth_pin_freeze = !srcdn->is_auth() && srcdnl->is_primary() ? srci : NULL;
+  if (!mds->locker->acquire_locks(mdr, rdlocks, wrlocks, xlocks,
+				  &remote_wrlocks, auth_pin_freeze))
     return;
 
   if (oldin &&
@@ -5991,9 +6012,7 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
 
   // am i srcdn auth?
   if (srcdn->is_auth()) {
-    if (srcdnl->is_primary() && 
-	!srcdnl->get_inode()->is_freezing_inode() &&
-	!srcdnl->get_inode()->is_frozen_inode()) {
+    if (srcdnl->is_primary()) {
       // set ambiguous auth for srci
       /*
        * NOTE: we don't worry about ambiguous cache expire as we do
@@ -6010,7 +6029,13 @@ void Server::handle_slave_rename_prep(MDRequest *mdr)
       int allowance = 2; // 1 for the mdr auth_pin, 1 for the link lock
       allowance += srcdnl->get_inode()->is_dir(); // for the snap lock
       dout(10) << " freezing srci " << *srcdnl->get_inode() << " with allowance " << allowance << dendl;
-      if (!srcdnl->get_inode()->freeze_inode(allowance)) {
+      bool frozen_inode = srcdnl->get_inode()->freeze_inode(allowance);
+
+      // unfreeze auth pin after freezing the inode to avoid queueing waiters
+      if (srcdnl->get_inode()->is_frozen_auth_pin())
+	mdr->unfreeze_auth_pin(srcdnl->get_inode());
+
+      if (!frozen_inode) {
 	srcdnl->get_inode()->add_waiter(CInode::WAIT_FROZEN, new C_MDS_RetryRequest(mdcache, mdr));
 	return;
       }
@@ -6178,8 +6203,7 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
       destdnl->get_inode()->take_waiting(CInode::WAIT_SINGLEAUTH, finished);
 
       // unfreeze
-      assert(destdnl->get_inode()->is_frozen_inode() ||
-             destdnl->get_inode()->is_freezing_inode());
+      assert(destdnl->get_inode()->is_frozen_inode());
       destdnl->get_inode()->unfreeze_inode(finished);
 
       mds->queue_waiters(finished);
@@ -6202,8 +6226,7 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
       destdnl->get_inode()->take_waiting(CInode::WAIT_SINGLEAUTH, finished);
       
       // unfreeze
-      assert(destdnl->get_inode()->is_frozen_inode() ||
-	     destdnl->get_inode()->is_freezing_inode());
+      assert(destdnl->get_inode()->is_frozen_inode());
       destdnl->get_inode()->unfreeze_inode(finished);
       
       mds->queue_waiters(finished);
diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
index db4dbf1..22e754e 100644
--- a/src/mds/mdstypes.h
+++ b/src/mds/mdstypes.h
@@ -1250,6 +1250,13 @@ public:
   }
 };
 
+inline bool operator==(const MDSCacheObjectInfo& l, const MDSCacheObjectInfo& r) {
+  if (l.ino || r.ino)
+    return l.ino == r.ino && l.snapid == r.snapid;
+  else
+    return l.dirfrag == r.dirfrag && l.dname == r.dname;
+}
+
 WRITE_CLASS_ENCODER(MDSCacheObjectInfo)
 
 
diff --git a/src/messages/MMDSSlaveRequest.h b/src/messages/MMDSSlaveRequest.h
index 4f2bb59..03ec582 100644
--- a/src/messages/MMDSSlaveRequest.h
+++ b/src/messages/MMDSSlaveRequest.h
@@ -112,6 +112,7 @@ public:
 
   int get_lock_type() { return lock_type; }
   MDSCacheObjectInfo &get_object_info() { return object_info; }
+  MDSCacheObjectInfo &get_authpin_freeze() { return object_info; }
 
   vector<MDSCacheObjectInfo>& get_authpins() { return authpins; }
 
-- 
1.7.11.7

