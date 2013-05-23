From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/30] mds: unfreeze inode when after rename rollback finishes
Date: Thu, 23 May 2013 16:06:39 +0800
Message-ID: <1369296418-14871-12-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756392Ab3EWINK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:10 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

we should not wake up the unfreeze waiter while the inode is still
linked to a non-auth dirfrag.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 61 +++++++++++++++++++++++++++++++++----------------------
 src/mds/Server.h  |  6 +++---
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index e9f9706..c070160 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -6806,23 +6806,10 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
     mdlog->flush();
   } else {
     if (srcdn->is_auth() && destdnl->is_primary()) {
-
       dout(10) << " reversing inode export of " << *destdnl->get_inode() << dendl;
       destdnl->get_inode()->abort_export();
-    
-      // unfreeze
-      assert(destdnl->get_inode()->is_frozen_inode());
-      destdnl->get_inode()->unfreeze_inode(finished);
-    }
-
-    // singleauth
-    if (mdr->more()->is_ambiguous_auth) {
-      mdr->more()->rename_inode->clear_ambiguous_auth(finished);
-      mdr->more()->is_ambiguous_auth = false;
     }
 
-    mds->queue_waiters(finished);
-
     // abort
     //  rollback_bl may be empty if we froze the inode but had to provide an expanded
     // witness list from the master, and they failed before we tried prep again.
@@ -6830,11 +6817,20 @@ void Server::_commit_slave_rename(MDRequest *mdr, int r,
       if (mdcache->is_ambiguous_slave_update(mdr->reqid, mdr->slave_to_mds)) {
 	mdcache->remove_ambiguous_slave_update(mdr->reqid, mdr->slave_to_mds);
 	// rollback but preserve the slave request
-	do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_mds, NULL);
+	do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_mds, mdr, false);
       } else
-	do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_mds, mdr);
+	do_rename_rollback(mdr->more()->rollback_bl, mdr->slave_to_mds, mdr, true);
     } else {
       dout(10) << " rollback_bl empty, not rollback back rename (master failed after getting extra witnesses?)" << dendl;
+      // singleauth
+      if (mdr->more()->is_ambiguous_auth) {
+	if (srcdn->is_auth())
+	  mdr->more()->rename_inode->unfreeze_inode(finished);
+
+	mdr->more()->rename_inode->clear_ambiguous_auth(finished);
+	mdr->more()->is_ambiguous_auth = false;
+      }
+      mds->queue_waiters(finished);
       mds->mdcache->request_finish(mdr);
     }
   }
@@ -6879,15 +6875,20 @@ struct C_MDS_LoggedRenameRollback : public Context {
   version_t srcdnpv;
   CDentry *destdn;
   CDentry *straydn;
+  bool finish_mdr;
   C_MDS_LoggedRenameRollback(Server *s, Mutation *m, MDRequest *r,
-			     CDentry *sd, version_t pv, CDentry *dd, CDentry *st) :
-    server(s), mut(m), mdr(r), srcdn(sd), srcdnpv(pv), destdn(dd), straydn(st) {}
+			     CDentry *sd, version_t pv, CDentry *dd,
+			    CDentry *st, bool f) :
+    server(s), mut(m), mdr(r), srcdn(sd), srcdnpv(pv), destdn(dd),
+    straydn(st), finish_mdr(f) {}
   void finish(int r) {
-    server->_rename_rollback_finish(mut, mdr, srcdn, srcdnpv, destdn, straydn);
+    server->_rename_rollback_finish(mut, mdr, srcdn, srcdnpv,
+				    destdn, straydn, finish_mdr);
   }
 };
 
-void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
+void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr,
+				bool finish_mdr)
 {
   rename_rollback rollback;
   bufferlist::iterator p = rbl.begin();
@@ -7086,13 +7087,14 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
     mdcache->project_subtree_rename(in, destdir, srcdir);
   }
 
-  mdlog->submit_entry(le, new C_MDS_LoggedRenameRollback(this, mut, mdr,
-							 srcdn, srcdnpv, destdn, straydn));
+  mdlog->submit_entry(le, new C_MDS_LoggedRenameRollback(this, mut, mdr, srcdn, srcdnpv,
+							 destdn, straydn, finish_mdr));
   mdlog->flush();
 }
 
 void Server::_rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *srcdn,
-				     version_t srcdnpv, CDentry *destdn, CDentry *straydn)
+				     version_t srcdnpv, CDentry *destdn,
+				     CDentry *straydn, bool finish_mdr)
 {
   dout(10) << "_rename_rollback_finish " << mut->reqid << dendl;
 
@@ -7140,8 +7142,19 @@ void Server::_rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *src
       mdcache->try_trim_non_auth_subtree(root);
   }
 
-  if (mdr)
-    mds->mdcache->request_finish(mdr);
+  if (mdr) {
+    list<Context*> finished;
+    if (mdr->more()->is_ambiguous_auth) {
+      if (srcdn->is_auth())
+	mdr->more()->rename_inode->unfreeze_inode(finished);
+
+      mdr->more()->rename_inode->clear_ambiguous_auth(finished);
+      mdr->more()->is_ambiguous_auth = false;
+    }
+    mds->queue_waiters(finished);
+    if (finish_mdr)
+      mds->mdcache->request_finish(mdr);
+  }
 
   mds->mdcache->finish_rollback(mut->reqid);
 
diff --git a/src/mds/Server.h b/src/mds/Server.h
index ffe9256..f879392 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -244,9 +244,9 @@ public:
   void handle_slave_rename_prep_ack(MDRequest *mdr, MMDSSlaveRequest *m);
   void _logged_slave_rename(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   void _commit_slave_rename(MDRequest *mdr, int r, CDentry *srcdn, CDentry *destdn, CDentry *straydn);
-  void do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr);
-  void _rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *srcdn,
-			       version_t srcdnpv, CDentry *destdn, CDentry *staydn);
+  void do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr, bool finish_mdr=false);
+  void _rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *srcdn, version_t srcdnpv,
+			       CDentry *destdn, CDentry *staydn, bool finish_mdr);
 
 };
 
-- 
1.8.1.4

