From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 09/25] mds: splits rename force journal check into separate function
Date: Wed, 23 Jan 2013 11:08:45 +0800
Message-ID: <1358910541-15535-10-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12218 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818Ab3AWDJM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:12 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

the function will be used by later patch that fixes rename rollback

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 74 +++++++++++++++++++++++++++++++++----------------------
 src/mds/Server.h  |  1 +
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 157f6ac..ce7a5bf 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5643,41 +5643,25 @@ version_t Server::_rename_prepare_import(MDRequest *mdr, CDentry *srcdn, bufferl
   return oldpv;
 }
 
-void Server::_rename_prepare(MDRequest *mdr,
-			     EMetaBlob *metablob, bufferlist *client_map_bl,
-			     CDentry *srcdn, CDentry *destdn, CDentry *straydn)
+bool Server::_need_force_journal(CInode *diri, bool empty)
 {
-  dout(10) << "_rename_prepare " << *mdr << " " << *srcdn << " " << *destdn << dendl;
-  if (straydn)
-    dout(10) << " straydn " << *straydn << dendl;
-
-  CDentry::linkage_t *srcdnl = srcdn->get_projected_linkage();
-  CDentry::linkage_t *destdnl = destdn->get_projected_linkage();
-  CInode *srci = srcdnl->get_inode();
-  CInode *oldin = destdnl->get_inode();
-
-  // primary+remote link merge?
-  bool linkmerge = (srci == destdnl->get_inode() &&
-		    (srcdnl->is_primary() || destdnl->is_primary()));
-  bool silent = srcdn->get_dir()->inode->is_stray();
+  list<CDir*> ls;
+  diri->get_dirfrags(ls);
 
-  // we need to force journaling of this event if we (will) have any subtrees
-  // nested beneath.
   bool force_journal = false;
-  while (srci->is_dir()) {
-    // if we are auth for srci and exporting it, force journal because we need create
-    // auth subtrees here during journal replay.
-    if (srci->is_auth() && !destdn->is_auth()) {
-      dout(10) << " we are exporting srci, will force journal" << dendl;
-      force_journal = true;
-      break;
+  if (empty) {
+    for (list<CDir*>::iterator p = ls.begin(); p != ls.end(); ++p) {
+      if ((*p)->is_subtree_root() && (*p)->get_dir_auth().first == mds->whoami) {
+	dout(10) << " frag " << (*p)->get_frag() << " is auth subtree dirfrag, will force journal" << dendl;
+	force_journal = true;
+	break;
+      } else
+	dout(20) << " frag " << (*p)->get_frag() << " is not auth subtree dirfrag" << dendl;
     }
-
+  } else {
     // see if any children of our frags are auth subtrees.
     list<CDir*> subtrees;
     mds->mdcache->list_subtrees(subtrees);
-    list<CDir*> ls;
-    srci->get_dirfrags(ls);
     dout(10) << " subtrees " << subtrees << " frags " << ls << dendl;
     for (list<CDir*>::iterator p = ls.begin(); p != ls.end(); ++p) {
       CDir *dir = *p;
@@ -5693,8 +5677,40 @@ void Server::_rename_prepare(MDRequest *mdr,
 	} else
 	  dout(20) << " frag " << (*p)->get_frag() << " does not contain " << **q << dendl;
       }
+      if (force_journal)
+	break;
     }
-    break;
+  }
+  return force_journal;
+}
+
+void Server::_rename_prepare(MDRequest *mdr,
+			     EMetaBlob *metablob, bufferlist *client_map_bl,
+			     CDentry *srcdn, CDentry *destdn, CDentry *straydn)
+{
+  dout(10) << "_rename_prepare " << *mdr << " " << *srcdn << " " << *destdn << dendl;
+  if (straydn)
+    dout(10) << " straydn " << *straydn << dendl;
+
+  CDentry::linkage_t *srcdnl = srcdn->get_projected_linkage();
+  CDentry::linkage_t *destdnl = destdn->get_projected_linkage();
+  CInode *srci = srcdnl->get_inode();
+  CInode *oldin = destdnl->get_inode();
+
+  // primary+remote link merge?
+  bool linkmerge = (srci == destdnl->get_inode() &&
+		    (srcdnl->is_primary() || destdnl->is_primary()));
+  bool silent = srcdn->get_dir()->inode->is_stray();
+
+  bool force_journal = false;
+  if (srci->is_dir() && !destdn->is_auth()) {
+    if (srci->is_auth()) {
+      // if we are auth for srci and exporting it, force journal because journal replay needs
+      // the source inode to create auth subtrees.
+      dout(10) << " we are exporting srci, will force journal" << dendl;
+      force_journal = true;
+    } else
+      force_journal = _need_force_journal(srci, false);
   }
 
   if (linkmerge)
diff --git a/src/mds/Server.h b/src/mds/Server.h
index f9d51f5..e028912 100644
--- a/src/mds/Server.h
+++ b/src/mds/Server.h
@@ -217,6 +217,7 @@ public:
   void _rename_prepare_witness(MDRequest *mdr, int who, set<int> &witnesse,
 			       CDentry *srcdn, CDentry *destdn, CDentry *straydn);
   version_t _rename_prepare_import(MDRequest *mdr, CDentry *srcdn, bufferlist *client_map_bl);
+  bool _need_force_journal(CInode *diri, bool empty);
   void _rename_prepare(MDRequest *mdr,
 		       EMetaBlob *metablob, bufferlist *client_map_bl,
 		       CDentry *srcdn, CDentry *destdn, CDentry *straydn);
-- 
1.7.11.7

