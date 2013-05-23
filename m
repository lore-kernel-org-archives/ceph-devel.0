From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 12/30] mds: send slave request after target MDS is active
Date: Thu, 23 May 2013 16:06:40 +0800
Message-ID: <1369296418-14871-13-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51287 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab3EWINL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:11 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

when failure of peer is detected, MDCache::handle_mds_failure()
checks if there are requests waiting for slave replies from the
failed peer, and adds them to the "wait for active peer" list.
The "retry request" logical only covers slave requests sent before
MDCache::handle_mds_failure() is called. If a slave request was
sent while peer isn't up, we wait for its reply forever.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 27 ++++++++++++++++++++++-----
 src/mds/Server.cc | 35 +++++++++++++++++++++++++++++------
 src/mds/Server.h  |  4 ++--
 3 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index c5ddb92..63862f8 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -327,6 +327,14 @@ bool Locker::acquire_locks(MDRequest *mdr,
 	 p != mustpin_remote.end();
 	 ++p) {
       dout(10) << "requesting remote auth_pins from mds." << p->first << dendl;
+
+      // wait for active auth
+      if (!mds->mdsmap->is_clientreplay_or_active_or_stopping(p->first)) {
+	dout(10) << " mds." << p->first << " is not active" << dendl;
+	if (mdr->more()->waiting_on_slave.empty())
+	  mds->wait_for_active_peer(p->first, new C_MDS_RetryRequest(mdcache, mdr));
+	return false;
+      }
       
       MMDSSlaveRequest *req = new MMDSSlaveRequest(mdr->reqid, mdr->attempt,
 						   MMDSSlaveRequest::OP_AUTHPIN);
@@ -1332,10 +1340,11 @@ void Locker::remote_wrlock_start(SimpleLock *lock, int target, MDRequest *mut)
 {
   dout(7) << "remote_wrlock_start mds." << target << " on " << *lock << " on " << *lock->get_parent() << dendl;
 
-  // wait for single auth
-  if (lock->get_parent()->is_ambiguous_auth()) {
-    lock->get_parent()->add_waiter(MDSCacheObject::WAIT_SINGLEAUTH, 
-				   new C_MDS_RetryRequest(mdcache, mut));
+  // wait for active target
+  if (!mds->mdsmap->is_clientreplay_or_active_or_stopping(target)) {
+    dout(7) << " mds." << target << " is not active" << dendl;
+    if (mut->more()->waiting_on_slave.empty())
+      mds->wait_for_active_peer(target, new C_MDS_RetryRequest(mdcache, mut));
     return;
   }
 
@@ -1422,8 +1431,16 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
       return false;
     }
     
-    // send lock request
+    // wait for active auth
     int auth = lock->get_parent()->authority().first;
+    if (!mds->mdsmap->is_clientreplay_or_active_or_stopping(auth)) {
+      dout(7) << " mds." << auth << " is not active" << dendl;
+      if (mut->more()->waiting_on_slave.empty())
+	mds->wait_for_active_peer(auth, new C_MDS_RetryRequest(mdcache, mut));
+      return false;
+    }
+
+    // send lock request
     mut->more()->slaves.insert(auth);
     mut->start_locking(lock, auth);
     MMDSSlaveRequest *r = new MMDSSlaveRequest(mut->reqid, mut->attempt,
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index c070160..69f1869 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4453,8 +4453,14 @@ void Server::_link_remote(MDRequest *mdr, bool inc, CDentry *dn, CInode *targeti
   // 1. send LinkPrepare to dest (journal nlink++ prepare)
   int linkauth = targeti->authority().first;
   if (mdr->more()->witnessed.count(linkauth) == 0) {
-    dout(10) << " targeti auth must prepare nlink++/--" << dendl;
+    if (!mds->mdsmap->is_clientreplay_or_active_or_stopping(linkauth)) {
+      dout(10) << " targeti auth mds." << linkauth << " is not active" << dendl;
+      if (mdr->more()->waiting_on_slave.empty())
+	mds->wait_for_active_peer(linkauth, new C_MDS_RetryRequest(mdcache, mdr));
+      return;
+    }
 
+    dout(10) << " targeti auth must prepare nlink++/--" << dendl;
     int op;
     if (inc)
       op = MMDSSlaveRequest::OP_LINKPREP;
@@ -5010,7 +5016,8 @@ void Server::handle_client_unlink(MDRequest *mdr)
       } else if (mdr->more()->waiting_on_slave.count(*p)) {
 	dout(10) << " already waiting on witness mds." << *p << dendl;      
       } else {
-	_rmdir_prepare_witness(mdr, *p, dn, straydn);
+	if (!_rmdir_prepare_witness(mdr, *p, dn, straydn))
+	  return;
       }
     }
     if (!mdr->more()->waiting_on_slave.empty())
@@ -5172,10 +5179,16 @@ void Server::_unlink_local_finish(MDRequest *mdr,
   dn->get_dir()->try_remove_unlinked_dn(dn);
 }
 
-void Server::_rmdir_prepare_witness(MDRequest *mdr, int who, CDentry *dn, CDentry *straydn)
+bool Server::_rmdir_prepare_witness(MDRequest *mdr, int who, CDentry *dn, CDentry *straydn)
 {
-  dout(10) << "_rmdir_prepare_witness mds." << who << " for " << *mdr << dendl;
+  if (!mds->mdsmap->is_clientreplay_or_active_or_stopping(who)) {
+    dout(10) << "_rmdir_prepare_witness mds." << who << " is not active" << dendl;
+    if (mdr->more()->waiting_on_slave.empty())
+      mds->wait_for_active_peer(who, new C_MDS_RetryRequest(mdcache, mdr));
+    return false;
+  }
   
+  dout(10) << "_rmdir_prepare_witness mds." << who << dendl;
   MMDSSlaveRequest *req = new MMDSSlaveRequest(mdr->reqid, mdr->attempt,
 					       MMDSSlaveRequest::OP_RMDIRPREP);
   dn->make_path(req->srcdnpath);
@@ -5188,6 +5201,7 @@ void Server::_rmdir_prepare_witness(MDRequest *mdr, int who, CDentry *dn, CDentr
   
   assert(mdr->more()->waiting_on_slave.count(who) == 0);
   mdr->more()->waiting_on_slave.insert(who);
+  return true;
 }
 
 struct C_MDS_SlaveRmdirPrep : public Context {
@@ -5880,7 +5894,8 @@ void Server::handle_client_rename(MDRequest *mdr)
     } else if (mdr->more()->waiting_on_slave.count(*p)) {
       dout(10) << " already waiting on witness mds." << *p << dendl;      
     } else {
-      _rename_prepare_witness(mdr, *p, witnesses, srcdn, destdn, straydn);
+      if (!_rename_prepare_witness(mdr, *p, witnesses, srcdn, destdn, straydn))
+	return;
     }
   }
   if (!mdr->more()->waiting_on_slave.empty())
@@ -5986,9 +6001,16 @@ void Server::_rename_finish(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDe
 
 // helpers
 
-void Server::_rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse,
+bool Server::_rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse,
 				     CDentry *srcdn, CDentry *destdn, CDentry *straydn)
 {
+  if (!mds->mdsmap->is_clientreplay_or_active_or_stopping(who)) {
+    dout(10) << "_rename_prepare_witness mds." << who << " is not active" << dendl;
+    if (mdr->more()->waiting_on_slave.empty())
+      mds->wait_for_active_peer(who, new C_MDS_RetryRequest(mdcache, mdr));
+    return false;
+  }
+
   dout(10) << "_rename_prepare_witness mds." << who << dendl;
   MMDSSlaveRequest *req = new MMDSSlaveRequest(mdr->reqid, mdr->attempt,
 					       MMDSSlaveRequest::OP_RENAMEPREP);
@@ -6006,6 +6028,7 @@ void Server::_rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse
   
   assert(mdr->more()->waiting_on_slave.count(who) == 0);
   mdr->more()->waiting_on_slave.insert(who);
+  return true;
 }
 
 version_t Server::_rename_prepare_import(MDRequest *mdr, CDentry *srcdn, bufferlist *client_map_bl)
diff --git a/src/mds/Server.h b/src/mds/Server.h
index f879392..35a405b 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -207,7 +207,7 @@ public:
   void _unlink_local_finish(MDRequest *mdr, 
 			    CDentry *dn, CDentry *straydn,
 			    version_t);
-  void _rmdir_prepare_witness(MDRequest *mdr, int who, CDentry *dn, CDentry *straydn);
+  bool _rmdir_prepare_witness(MDRequest *mdr, int who, CDentry *dn, CDentry *straydn);
   void handle_slave_rmdir_prep(MDRequest *mdr);
   void _logged_slave_rmdir(MDRequest *mdr, CDentry *srcdn, CDentry *straydn);
   void _commit_slave_rmdir(MDRequest *mdr, int r);
@@ -227,7 +227,7 @@ public:
   void _rmsnap_finish(MDRequest *mdr, CInode *diri, snapid_t snapid);
 
   // helpers
-  void _rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse,
+  bool _rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse,
 			       CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   version_t _rename_prepare_import(MDRequest *mdr, CDentry *srcdn, bufferlist *client_map_bl);
   bool _need_force_journal(CInode *diri, bool empty);
-- 
1.8.1.4

