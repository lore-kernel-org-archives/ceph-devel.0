From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 10/25] mds: force journal straydn for rename if necessary
Date: Wed, 23 Jan 2013 11:08:46 +0800
Message-ID: <1358910541-15535-11-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12218 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab3AWDJO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:14 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

rename may overwrite an empty directory inode and move it into stray
directory. MDS who has auth subtree beneath the overwrited directory
need journal the stray dentry when handling rename slave request.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc  | 31 +++++++++++++++++++++++------
 src/mds/journal.cc | 57 ++++++++++++++++++++++++++++++++++--------------------
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index ce7a5bf..1ec0c81 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5713,17 +5713,25 @@ void Server::_rename_prepare(MDRequest *mdr,
       force_journal = _need_force_journal(srci, false);
   }
 
+  bool force_journal_stray = false;
+  if (oldin && oldin->is_dir() && !straydn->is_auth())
+    force_journal_stray = _need_force_journal(oldin, true);
+
   if (linkmerge)
     dout(10) << " merging remote and primary links to the same inode" << dendl;
   if (silent)
     dout(10) << " reintegrating stray; will avoid changing nlink or dir mtime" << dendl;
   if (force_journal)
     dout(10) << " forcing journal of rename because we (will) have auth subtrees nested beneath it" << dendl;
+  if (force_journal_stray)
+    dout(10) << " forcing journal straydn because we (will) have auth subtrees nested beneath it" << dendl;
 
-  if (srci->is_dir() &&
-      (srcdn->is_auth() || destdn->is_auth() || force_journal)) {
+  if (srci->is_dir() && (destdn->is_auth() || force_journal)) {
     dout(10) << " noting renamed dir ino " << srci->ino() << " in metablob" << dendl;
     metablob->renamed_dirino = srci->ino();
+  } else if (oldin && oldin->is_dir() && force_journal_stray) {
+    dout(10) << " noting rename target dir " << oldin->ino() << " in metablob" << dendl;
+    metablob->renamed_dirino = oldin->ino();
   }
 
   // prepare
@@ -5858,6 +5866,10 @@ void Server::_rename_prepare(MDRequest *mdr,
 	  oldin->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
 	straydn->first = MAX(oldin->first, next_dest_snap);
 	metablob->add_primary_dentry(straydn, true, oldin);
+      } else if (force_journal_stray) {
+	dout(10) << " forced journaling straydn " << *straydn << dendl;
+	metablob->add_dir_context(straydn->get_dir());
+	metablob->add_primary_dentry(straydn, true, oldin);
       }
     } else if (destdnl->is_remote()) {
       if (oldin->is_auth()) {
@@ -5918,6 +5930,11 @@ void Server::_rename_prepare(MDRequest *mdr,
   if (srcdn->is_auth()) {
     dout(10) << " journaling srcdn " << *srcdn << dendl;
     mdcache->journal_cow_dentry(mdr, metablob, srcdn, CEPH_NOSNAP, 0, srcdnl);
+    // also journal the inode in case we need do slave rename rollback. It is Ok to add
+    // both primary and NULL dentries. Because during journal replay, null dentry is
+    // processed after primary dentry.
+    if (srcdnl->is_primary() && !srci->is_dir() && !destdn->is_auth())
+      metablob->add_primary_dentry(srcdn, true, srci);
     metablob->add_null_dentry(srcdn, true);
   } else if (force_journal) {
     dout(10) << " forced journaling srcdn " << *srcdn << dendl;
@@ -5936,6 +5953,8 @@ void Server::_rename_prepare(MDRequest *mdr,
   if (mdr->more()->dst_reanchor_atid)
     metablob->add_table_transaction(TABLE_ANCHOR, mdr->more()->dst_reanchor_atid);
 
+  if (oldin && oldin->is_dir())
+    mdcache->project_subtree_rename(oldin, destdn->get_dir(), straydn->get_dir());
   if (srci->is_dir())
     mdcache->project_subtree_rename(srci, srcdn->get_dir(), destdn->get_dir());
 }
@@ -6079,10 +6098,10 @@ void Server::_rename_apply(MDRequest *mdr, CDentry *srcdn, CDentry *destdn, CDen
 
   // update subtree map?
   if (destdnl->is_primary() && in->is_dir()) 
-    mdcache->adjust_subtree_after_rename(in,
-                                         srcdn->get_dir(),
-					 true,
-                                         imported_inode);
+    mdcache->adjust_subtree_after_rename(in, srcdn->get_dir(), true, imported_inode);
+
+  if (straydn && oldin->is_dir())
+    mdcache->adjust_subtree_after_rename(oldin, destdn->get_dir(), true);
 
   // removing a new dn?
   if (srcdn->is_auth())
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index ae380f3..72a5e5e 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -454,7 +454,8 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
   }
 
   // keep track of any inodes we unlink and don't relink elsewhere
-  set<CInode*> unlinked;
+  map<CInode*, CDir*> unlinked;
+  set<CInode*> linked;
 
   // walk through my dirs (in order!)
   for (list<dirfrag_t>::iterator lp = lump_order.begin();
@@ -545,7 +546,7 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	mds->mdcache->add_inode(in);
 	if (!dn->get_linkage()->is_null()) {
 	  if (dn->get_linkage()->is_primary()) {
-	    unlinked.insert(dn->get_linkage()->get_inode());
+	    unlinked[dn->get_linkage()->get_inode()] = dir;
 	    stringstream ss;
 	    ss << "EMetaBlob.replay FIXME had dentry linked to wrong inode " << *dn
 	       << " " << *dn->get_linkage()->get_inode() << " should be " << p->inode.ino;
@@ -554,16 +555,16 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	  }
 	  dir->unlink_inode(dn);
 	}
-	unlinked.erase(in);
+	if (unlinked.count(in))
+	  linked.insert(in);
 	dir->link_primary_inode(dn, in);
 	if (p->dirty) in->_mark_dirty(logseg);
 	dout(10) << "EMetaBlob.replay added " << *in << dendl;
       } else {
 	if (dn->get_linkage()->get_inode() != in && in->get_parent_dn()) {
 	  dout(10) << "EMetaBlob.replay unlinking " << *in << dendl;
-	  if (in == renamed_diri)
-	    olddir = in->get_parent_dn()->get_dir();
-	  in->get_parent_dn()->get_dir()->unlink_inode(in->get_parent_dn());
+	  unlinked[in] = in->get_parent_dir();
+	  in->get_parent_dir()->unlink_inode(in->get_parent_dn());
 	}
 	if (in->get_parent_dn() && in->inode.anchored != p->inode.anchored)
 	  in->get_parent_dn()->adjust_nested_anchors( (int)p->inode.anchored - (int)in->inode.anchored );
@@ -572,7 +573,7 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	if (dn->get_linkage()->get_inode() != in) {
 	  if (!dn->get_linkage()->is_null()) { // note: might be remote.  as with stray reintegration.
 	    if (dn->get_linkage()->is_primary()) {
-	      unlinked.insert(dn->get_linkage()->get_inode());
+	      unlinked[dn->get_linkage()->get_inode()] = dir;
 	      stringstream ss;
 	      ss << "EMetaBlob.replay FIXME had dentry linked to wrong inode " << *dn
 		 << " " << *dn->get_linkage()->get_inode() << " should be " << p->inode.ino;
@@ -581,7 +582,8 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	    }
 	    dir->unlink_inode(dn);
 	  }
-	  unlinked.erase(in);
+	  if (unlinked.count(in))
+	    linked.insert(in);
 	  dir->link_primary_inode(dn, in);
 	  dout(10) << "EMetaBlob.replay linked " << *in << dendl;
 	} else {
@@ -606,7 +608,7 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	if (!dn->get_linkage()->is_null()) {
 	  dout(10) << "EMetaBlob.replay unlinking " << *dn << dendl;
 	  if (dn->get_linkage()->is_primary()) {
-	    unlinked.insert(dn->get_linkage()->get_inode());
+	    unlinked[dn->get_linkage()->get_inode()] = dir;
 	    stringstream ss;
 	    ss << "EMetaBlob.replay FIXME had dentry linked to wrong inode " << *dn
 	       << " " << *dn->get_linkage()->get_inode() << " should be remote " << p->ino;
@@ -638,7 +640,7 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	if (!dn->get_linkage()->is_null()) {
 	  dout(10) << "EMetaBlob.replay unlinking " << *dn << dendl;
 	  if (dn->get_linkage()->is_primary())
-	    unlinked.insert(dn->get_linkage()->get_inode());
+	    unlinked[dn->get_linkage()->get_inode()] = dir;
 	  dir->unlink_inode(dn);
 	}
 	dn->set_version(p->dnv);
@@ -652,22 +654,24 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 
   if (renamed_dirino) {
     if (renamed_diri) {
-      assert(olddir);
+      assert(unlinked.count(renamed_diri));
+      assert(linked.count(renamed_diri));
+      olddir = unlinked[renamed_diri];
     } else {
       // we imported a diri we haven't seen before
       renamed_diri = mds->mdcache->get_inode(renamed_dirino);
       assert(renamed_diri);  // it was in the metablob
     }
 
-    if (renamed_diri->authority().first != mds->whoami &&
-	olddir && olddir->authority().first == mds->whoami) {
-      list<frag_t> leaves;
-      renamed_diri->dirfragtree.get_leaves(leaves);
-      for (list<frag_t>::iterator p = leaves.begin(); p != leaves.end(); ++p)
-	renamed_diri->get_or_open_dirfrag(mds->mdcache, *p);
-    }
+    if (olddir) {
+      if (olddir->authority() != CDIR_AUTH_UNDEF &&
+	  renamed_diri->authority() == CDIR_AUTH_UNDEF) {
+	list<frag_t> leaves;
+	renamed_diri->dirfragtree.get_leaves(leaves);
+	for (list<frag_t>::iterator p = leaves.begin(); p != leaves.end(); ++p)
+	  renamed_diri->get_or_open_dirfrag(mds->mdcache, *p);
+      }
 
-    if (renamed_diri && olddir) {
       mds->mdcache->adjust_subtree_after_rename(renamed_diri, olddir, false);
       
       // see if we can discard the subtree we renamed out of
@@ -691,12 +695,23 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	mds->mdcache->adjust_subtree_auth(dir, CDIR_AUTH_UNDEF, false);
       }
     }
+
+    // rename may overwrite an empty directory and move it into stray dir.
+    unlinked.erase(renamed_diri);
+    for (map<CInode*, CDir*>::iterator p = unlinked.begin(); p != unlinked.end(); ++p) {
+      if (!linked.count(p->first))
+	continue;
+      assert(p->first->is_dir());
+      mds->mdcache->adjust_subtree_after_rename(p->first, p->second, false);
+    }
   }
 
   if (!unlinked.empty()) {
+    for (set<CInode*>::iterator p = linked.begin(); p != linked.end(); p++)
+      unlinked.erase(*p);
     dout(10) << " unlinked set contains " << unlinked << dendl;
-    for (set<CInode*>::iterator p = unlinked.begin(); p != unlinked.end(); ++p)
-      mds->mdcache->remove_inode_recursive(*p);
+    for (map<CInode*, CDir*>::iterator p = unlinked.begin(); p != unlinked.end(); ++p)
+      mds->mdcache->remove_inode_recursive(p->first);
   }
 
   // table client transactions
-- 
1.7.11.7

