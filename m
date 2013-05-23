From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 26/30] mds: update backtraces when unlinking inodes
Date: Thu, 23 May 2013 16:06:54 +0800
Message-ID: <1369296418-14871-27-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51306 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757151Ab3EWINV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:21 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

unlink moves inodes to stray dir, it's a special form of rename.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 0f8f80a..e88f627 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5104,7 +5104,8 @@ void Server::_unlink_local(MDRequest *mdr, CDentry *dn, CDentry *straydn)
     if (in->snaprealm || follows + 1 > dn->first)
       in->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
 
-    le->metablob.add_primary_dentry(straydn, in, true);
+    pi->update_backtrace();
+    le->metablob.add_primary_dentry(straydn, in, true, true);
   } else {
     // remote link.  update remote inode.
     mdcache->predirty_journal_parents(mdr, &le->metablob, in, dn->get_dir(), PREDIRTY_DIR, -1);
@@ -6171,6 +6172,7 @@ void Server::_rename_prepare(MDRequest *mdr,
       if (destdn->is_auth()) {
 	tpi = oldin->project_inode(); //project_snaprealm
 	tpi->version = straydn->pre_dirty(tpi->version);
+	tpi->update_backtrace();
       }
       straydn->push_projected_linkage(oldin);
     } else if (destdnl->is_remote()) {
@@ -6225,6 +6227,7 @@ void Server::_rename_prepare(MDRequest *mdr,
       pi = srci->project_inode(); // project snaprealm if srcdnl->is_primary
                                                  // & srcdnl->snaprealm
       pi->version = mdr->more()->pvmap[destdn] = destdn->pre_dirty(oldpv);
+      pi->update_backtrace();
     }
     destdn->push_projected_linkage(srci);
   }
@@ -6289,7 +6292,7 @@ void Server::_rename_prepare(MDRequest *mdr,
 	if (oldin->snaprealm || src_realm->get_newest_seq() + 1 > srcdn->first)
 	  oldin->project_past_snaprealm_parent(straydn->get_dir()->inode->find_snaprealm());
 	straydn->first = MAX(oldin->first, next_dest_snap);
-	metablob->add_primary_dentry(straydn, oldin, true);
+	metablob->add_primary_dentry(straydn, oldin, true, true);
       } else if (force_journal_stray) {
 	dout(10) << " forced journaling straydn " << *straydn << dendl;
 	metablob->add_dir_context(straydn->get_dir());
@@ -6328,7 +6331,7 @@ void Server::_rename_prepare(MDRequest *mdr,
 	destdn->first = MAX(destdn->first, next_dest_snap);
 
       if (destdn->is_auth())
-        metablob->add_primary_dentry(destdn, destdnl->get_inode(), true);
+        metablob->add_primary_dentry(destdn, destdnl->get_inode(), true, true);
     }
   } else if (srcdnl->is_primary()) {
     // project snap parent update?
@@ -6342,7 +6345,7 @@ void Server::_rename_prepare(MDRequest *mdr,
       destdn->first = MAX(destdn->first, next_dest_snap);
 
     if (destdn->is_auth())
-      metablob->add_primary_dentry(destdn, srci, true);
+      metablob->add_primary_dentry(destdn, srci, true, true);
     else if (force_journal_dest) {
       dout(10) << " forced journaling destdn " << *destdn << dendl;
       metablob->add_dir_context(destdn->get_dir());
-- 
1.8.1.4

