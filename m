From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 11/25] mds: don't journal non-auth rename source directory
Date: Wed, 23 Jan 2013 11:08:47 +0800
Message-ID: <1358910541-15535-12-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51770 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab3AWDJO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:14 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

After replaying a slave rename, non-auth directory that we rename out of will
be trimmed. So there is no need to journal it.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 1ec0c81..fedd4c2 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4868,10 +4868,9 @@ void Server::handle_slave_rmdir_prep(MDRequest *mdr)
   mdlog->start_entry(le);
   le->rollback = mdr->more()->rollback_bl;
 
-  le->commit.add_dir_context(dn->get_dir());
   le->commit.add_dir_context(straydn->get_dir());
   le->commit.add_primary_dentry(straydn, true, in);
-  le->commit.add_null_dentry(dn, true);
+  // slave: no need to journal original dentry
 
   dout(10) << " noting renamed (unlinked) dir ino " << in->ino() << " in metablob" << dendl;
   le->commit.renamed_dirino = in->ino();
@@ -4997,9 +4996,8 @@ void Server::do_rmdir_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   mdlog->start_entry(le);
   
   le->commit.add_dir_context(dn->get_dir());
-  le->commit.add_dir_context(straydn->get_dir());
   le->commit.add_primary_dentry(dn, true, in);
-  le->commit.add_null_dentry(straydn, true);
+  // slave: no need to journal straydn
   
   dout(10) << " noting renamed (unlinked) dir ino " << in->ino() << " in metablob" << dendl;
   le->commit.renamed_dirino = in->ino();
@@ -5702,15 +5700,15 @@ void Server::_rename_prepare(MDRequest *mdr,
 		    (srcdnl->is_primary() || destdnl->is_primary()));
   bool silent = srcdn->get_dir()->inode->is_stray();
 
-  bool force_journal = false;
+  bool force_journal_dest = false;
   if (srci->is_dir() && !destdn->is_auth()) {
     if (srci->is_auth()) {
       // if we are auth for srci and exporting it, force journal because journal replay needs
       // the source inode to create auth subtrees.
-      dout(10) << " we are exporting srci, will force journal" << dendl;
-      force_journal = true;
+      dout(10) << " we are exporting srci, will force journal destdn" << dendl;
+      force_journal_dest = true;
     } else
-      force_journal = _need_force_journal(srci, false);
+      force_journal_dest = _need_force_journal(srci, false);
   }
 
   bool force_journal_stray = false;
@@ -5721,12 +5719,12 @@ void Server::_rename_prepare(MDRequest *mdr,
     dout(10) << " merging remote and primary links to the same inode" << dendl;
   if (silent)
     dout(10) << " reintegrating stray; will avoid changing nlink or dir mtime" << dendl;
-  if (force_journal)
-    dout(10) << " forcing journal of rename because we (will) have auth subtrees nested beneath it" << dendl;
+  if (force_journal_dest)
+    dout(10) << " forcing journal destdn because we (will) have auth subtrees nested beneath it" << dendl;
   if (force_journal_stray)
     dout(10) << " forcing journal straydn because we (will) have auth subtrees nested beneath it" << dendl;
 
-  if (srci->is_dir() && (destdn->is_auth() || force_journal)) {
+  if (srci->is_dir() && (destdn->is_auth() || force_journal_dest)) {
     dout(10) << " noting renamed dir ino " << srci->ino() << " in metablob" << dendl;
     metablob->renamed_dirino = srci->ino();
   } else if (oldin && oldin->is_dir() && force_journal_stray) {
@@ -5919,7 +5917,7 @@ void Server::_rename_prepare(MDRequest *mdr,
 
     if (destdn->is_auth())
       metablob->add_primary_dentry(destdn, true, srci);
-    else if (force_journal) {
+    else if (force_journal_dest) {
       dout(10) << " forced journaling destdn " << *destdn << dendl;
       metablob->add_dir_context(destdn->get_dir());
       metablob->add_primary_dentry(destdn, true, srci);
@@ -5936,10 +5934,6 @@ void Server::_rename_prepare(MDRequest *mdr,
     if (srcdnl->is_primary() && !srci->is_dir() && !destdn->is_auth())
       metablob->add_primary_dentry(srcdn, true, srci);
     metablob->add_null_dentry(srcdn, true);
-  } else if (force_journal) {
-    dout(10) << " forced journaling srcdn " << *srcdn << dendl;
-    metablob->add_dir_context(srcdn->get_dir());
-    metablob->add_null_dentry(srcdn, true);
   } else
     dout(10) << " NOT journaling srcdn " << *srcdn << dendl;
 
-- 
1.7.11.7

