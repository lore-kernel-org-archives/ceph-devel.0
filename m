From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/29] mds: use null dentry to find old parent of renamed directory
Date: Fri,  4 Jan 2013 17:01:57 +0800
Message-ID: <1357290140-17044-7-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47205 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab3ADJCd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:33 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When replaying an directory rename operation, MDS need to find old parent of
the renamed directory to adjust auth subtree. Current code searchs the cache
to find the old parent, it does not work if the renamed directory inode is not
in the cache. EMetaBlob for directory rename contains at most one null dentry,
so MDS can use null dentry to find old parent of the renamed directory. If
there is no null dentry in the EMetaBlob, the MDS was witness of the rename
operation and there is not auth subtree underneath the renamed directory.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc  | 11 ++++++-----
 src/mds/journal.cc | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 23739ea..d1984a7 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5616,10 +5616,10 @@ void Server::_rename_prepare(MDRequest *mdr,
   // nested beneath.
   bool force_journal = false;
   while (srci->is_dir()) {
-    // if we are auth for srci and exporting it, have any _any_ open dirfrags, we
-    // will (soon) have auth subtrees here.
-    if (srci->is_auth() && !destdn->is_auth() && srci->has_dirfrags()) {
-      dout(10) << " we are exporting srci, and have open dirfrags, will force journal" << dendl;
+    // if we are auth for srci and exporting it, force journal because we need create
+    // auth subtrees here during journal replay.
+    if (srci->is_auth() && !destdn->is_auth()) {
+      dout(10) << " we are exporting srci, will force journal" << dendl;
       force_journal = true;
       break;
     }
@@ -5720,7 +5720,8 @@ void Server::_rename_prepare(MDRequest *mdr,
 	  srci->get_dirfrags(ls);
 	  for (list<CDir*>::iterator p = ls.begin(); p != ls.end(); ++p) {
 	    CDir *dir = *p;
-	    metablob->renamed_dir_frags.push_back(dir->get_frag());
+	    if (!dir->is_auth())
+	      metablob->renamed_dir_frags.push_back(dir->get_frag());
 	  }
 	  dout(10) << " noting renamed dir open frags " << metablob->renamed_dir_frags << dendl;
 	}
diff --git a/src/mds/journal.cc b/src/mds/journal.cc
index 20bc755..e73b8e7 100644
--- a/src/mds/journal.cc
+++ b/src/mds/journal.cc
@@ -442,6 +442,16 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
       dout(10) << "EMetaBlob.replay renamed inode is " << *renamed_diri << dendl;
     else
       dout(10) << "EMetaBlob.replay don't have renamed ino " << renamed_dirino << dendl;
+
+    int nnull = 0;
+    for (list<dirfrag_t>::iterator lp = lump_order.begin(); lp != lump_order.end(); ++lp) {
+      dirlump &lump = lump_map[*lp];
+      if (lump.nnull) {
+	dout(10) << "EMetaBlob.replay found null dentry in dir " << *lp << dendl;
+	nnull += lump.nnull;
+      }
+    }
+    assert(nnull <= 1);
   }
 
   // keep track of any inodes we unlink and don't relink elsewhere
@@ -622,8 +632,6 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	  dout(10) << "EMetaBlob.replay unlinking " << *dn << dendl;
 	  if (dn->get_linkage()->is_primary())
 	    unlinked.insert(dn->get_linkage()->get_inode());
-	  if (dn->get_linkage()->get_inode() == renamed_diri)
-	    olddir = dir;
 	  dir->unlink_inode(dn);
 	}
 	dn->set_version(p->dnv);
@@ -631,24 +639,34 @@ void EMetaBlob::replay(MDS *mds, LogSegment *logseg)
 	dout(10) << "EMetaBlob.replay had " << *dn << dendl;
 	assert(dn->last == p->dnlast);
       }
+      olddir = dir;
     }
   }
 
   if (renamed_dirino) {
-    if (olddir) {
-      assert(renamed_diri);
+    if (renamed_diri) {
+      assert(olddir);
+    } else {
+      // we imported a diri we haven't seen before
+      renamed_diri = mds->mdcache->get_inode(renamed_dirino);
+      assert(renamed_diri);  // it was in the metablob
+    }
+
+    if (renamed_diri->authority().first != mds->whoami &&
+	olddir && olddir->authority().first == mds->whoami) {
+      list<frag_t> leaves;
+      renamed_diri->dirfragtree.get_leaves(leaves);
+      for (list<frag_t>::iterator p = leaves.begin(); p != leaves.end(); ++p)
+	renamed_diri->get_or_open_dirfrag(mds->mdcache, *p);
+    }
+
+    if (renamed_diri && olddir) {
       mds->mdcache->adjust_subtree_after_rename(renamed_diri, olddir, false);
       
       // see if we can discard the subtree we renamed out of
       CDir *root = mds->mdcache->get_subtree_root(olddir);
       if (root->get_dir_auth() == CDIR_AUTH_UNDEF)
 	mds->mdcache->try_trim_non_auth_subtree(root);
-
-    } else {
-      // we imported a diri we haven't seen before
-      assert(!renamed_diri);
-      renamed_diri = mds->mdcache->get_inode(renamed_dirino);
-      assert(renamed_diri);  // it was in the metablob
     }
 
     // if we are the srci importer, we'll also have some dirfrags we have to open up...
-- 
1.7.11.7

