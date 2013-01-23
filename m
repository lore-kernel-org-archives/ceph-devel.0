From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 16/25] mds: Always use {push,pop}_projected_linkage to change linkage
Date: Wed, 23 Jan 2013 11:08:52 +0800
Message-ID: <1358910541-15535-17-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11370 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753059Ab3AWDJT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:19 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Current code skips using {push,pop}_projected_linkage to modify replica
dentry's linkage. This confuses EMetaBlob::add_dir_context() and makes
it record out-of-date path when TO_ROOT mode is used. This patch changes
the code to always use {push,pop}_projected_linkage to modify dentry's
linkage. It makes sure MDCache::create_subtree_map() record correct and
up-to-date subtree map.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc  | 53 ++++++++++++++++++++++++-----------------------------
 src/mds/journal.cc |  4 +++-
 2 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index a68b584..90b0120 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4861,6 +4861,9 @@ void Server::handle_slave_rmdir_prep(MDRequest *mdr)
   ::encode(rollback, mdr->more()->rollback_bl);
   dout(20) << " rollback is " << mdr->more()->rollback_bl.length() << " bytes" << dendl;
 
+  straydn->push_projected_linkage(in);
+  dn->push_projected_linkage();
+
   ESlaveUpdate *le =  new ESlaveUpdate(mdlog, "slave_rmdir", mdr->reqid, mdr->slave_to_mds,
 				       ESlaveUpdate::OP_PREPARE, ESlaveUpdate::RMDIR);
   mdlog->start_entry(le);
@@ -4897,7 +4900,8 @@ void Server::_logged_slave_rmdir(MDRequest *mdr, CDentry *dn, CDentry *straydn)
   // when we journal a subtree map
   CInode *in = dn->get_linkage()->get_inode();
   dn->get_dir()->unlink_inode(dn);
-  straydn->get_dir()->link_primary_inode(straydn, in);
+  straydn->pop_projected_linkage();
+  dn->pop_projected_linkage();
   mdcache->adjust_subtree_after_rename(in, dn->get_dir(), true);
 
   MMDSSlaveRequest *reply = new MMDSSlaveRequest(mdr->reqid, mdr->attempt,
@@ -4987,6 +4991,9 @@ void Server::do_rmdir_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   dout(10) << " straydn " << *dn << dendl;
   CInode *in = straydn->get_linkage()->get_inode();
 
+  dn->push_projected_linkage(in);
+  straydn->push_projected_linkage();
+
   ESlaveUpdate *le = new ESlaveUpdate(mdlog, "slave_rmdir_rollback", rollback.reqid, master,
 				      ESlaveUpdate::OP_ROLLBACK, ESlaveUpdate::RMDIR);
   mdlog->start_entry(le);
@@ -5008,10 +5015,11 @@ void Server::_rmdir_rollback_finish(MDRequest *mdr, metareqid_t reqid, CDentry *
 {
   dout(10) << "_rmdir_rollback_finish " << reqid << dendl;
 
-  CInode *in = straydn->get_linkage()->get_inode();
-  straydn->get_dir()->unlink_inode(dn);
-  dn->get_dir()->link_primary_inode(dn, in);
+  straydn->get_dir()->unlink_inode(straydn);
+  dn->pop_projected_linkage();
+  straydn->pop_projected_linkage();
 
+  CInode *in = dn->get_linkage()->get_inode();
   mdcache->adjust_subtree_after_rename(in, straydn->get_dir(), true);
 
   if (mdr)
@@ -5741,8 +5749,7 @@ void Server::_rename_prepare(MDRequest *mdr,
 	tpi = oldin->project_inode(); //project_snaprealm
 	tpi->version = straydn->pre_dirty(tpi->version);
       }
-      if (straydn->is_auth())
-	straydn->push_projected_linkage(oldin);
+      straydn->push_projected_linkage(oldin);
     } else if (destdnl->is_remote()) {
       // nlink-- targeti
       if (oldin->is_auth()) {
@@ -5756,10 +5763,9 @@ void Server::_rename_prepare(MDRequest *mdr,
   if (srcdnl->is_remote()) {
     if (!linkmerge) {
       // destdn
-      if (destdn->is_auth()) {
+      if (destdn->is_auth())
 	mdr->more()->pvmap[destdn] = destdn->pre_dirty();
-        destdn->push_projected_linkage(srcdnl->get_remote_ino(), srcdnl->get_remote_d_type());
-      }
+      destdn->push_projected_linkage(srcdnl->get_remote_ino(), srcdnl->get_remote_d_type());
       // srci
       if (srci->is_auth()) {
 	pi = srci->project_inode();
@@ -5796,15 +5802,14 @@ void Server::_rename_prepare(MDRequest *mdr,
       pi = srci->project_inode(); // project snaprealm if srcdnl->is_primary
                                                  // & srcdnl->snaprealm
       pi->version = mdr->more()->pvmap[destdn] = destdn->pre_dirty(oldpv);
-      destdn->push_projected_linkage(srci);
     }
+    destdn->push_projected_linkage(srci);
   }
 
   // src
-  if (srcdn->is_auth()) {
+  if (srcdn->is_auth())
     mdr->more()->pvmap[srcdn] = srcdn->pre_dirty();
-    srcdn->push_projected_linkage();  // push null linkage
-  }
+  srcdn->push_projected_linkage();  // push null linkage
 
   if (!silent) {
     if (pi) {
@@ -5973,11 +5978,7 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
       dout(10) << "straydn is " << *straydn << dendl;
       destdn->get_dir()->unlink_inode(destdn);
 
-      if (straydn->is_auth())
-	straydn->pop_projected_linkage();
-      else
-	straydn->get_dir()->link_primary_inode(straydn, oldin);
-
+      straydn->pop_projected_linkage();
       mdcache->touch_dentry_bottom(straydn);  // drop dn as quickly as possible.
 
       // nlink-- targeti
@@ -6008,10 +6009,8 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
   if (srcdn_was_remote) {
     if (!linkmerge) {
       // destdn
-      if (destdn->is_auth())
-	destdnl = destdn->pop_projected_linkage();
-      else
-	destdn->get_dir()->link_remote_inode(destdn, in);
+      destdnl = destdn->pop_projected_linkage();
+
       destdn->link_remote(destdnl, in);
       if (destdn->is_auth())
 	destdn->mark_dirty(mdr->more()->pvmap[destdn], mdr->ls);
@@ -6027,10 +6026,7 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
       dout(10) << "merging primary onto remote link" << dendl;
       destdn->get_dir()->unlink_inode(destdn);
     }
-    if (destdn->is_auth())
-      destdnl = destdn->pop_projected_linkage();
-    else
-      destdn->get_dir()->link_primary_inode(destdn, in);
+    destdnl = destdn->pop_projected_linkage();
 
     // srcdn inode import?
     if (!srcdn->is_auth() && destdn->is_auth()) {
@@ -6078,10 +6074,9 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
   }
 
   // src
-  if (srcdn->is_auth()) {
+  if (srcdn->is_auth())
     srcdn->mark_dirty(mdr->more()->pvmap[srcdn], mdr->ls);
-    srcdnl = srcdn->pop_projected_linkage();
-  }
+  srcdn->pop_projected_linkage();
   
   // apply remaining projected inodes (nested)
   mdr->apply();
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 3e7e0fa..111a0f3 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -359,8 +359,10 @@ void EMetaBlob::add_dir_context(CDir *dir, int mode)
   parents.splice(parents.begin(), maybe);
 
   dout(20) << "EMetaBlob::add_dir_context final: " << parents << dendl;
-  for (list<CDentry*>::iterator p = parents.begin(); p != parents.end(); p++)
+  for (list<CDentry*>::iterator p = parents.begin(); p != parents.end(); p++) {
+    assert((*p)->get_projected_linkage()->is_primary());
     add_dentry(*p, false);
+  }
 }
 
 void EMetaBlob::update_segment(LogSegment *ls)
-- 
1.7.11.7

