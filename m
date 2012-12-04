From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] mds: journal remote inode's projected parent
Date: Tue,  4 Dec 2012 16:09:48 +0800
Message-ID: <1354608588-25840-3-git-send-email-zheng.z.yan@intel.com>
References: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5684 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab2LDIJx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Dec 2012 03:09:53 -0500
In-Reply-To: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Server::_rename_prepare() adds remote inode's parent instead of
projected parent to the journal. So during journal replay, the
journal entry for the rename operation will wrongly revert the
remote inode's projected rename. This issue can be reproduced by:

 touch file1
 ln file1 file2
 rm file1
 mv file2 file3

After journal replay, file1 reappears and directory's fragstat
gets corrupted.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 34f40ec..7e099ab 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5719,9 +5719,10 @@ void Server::_rename_prepare(MDRequest *mdr,
     } else if (destdnl->is_remote()) {
       if (oldin->is_auth()) {
 	// auth for targeti
-	metablob->add_dir_context(oldin->get_parent_dir());
-	mdcache->journal_cow_dentry(mdr, metablob, oldin->parent, CEPH_NOSNAP, 0, destdnl);
-	metablob->add_primary_dentry(oldin->parent, true, oldin);
+	metablob->add_dir_context(oldin->get_projected_parent_dir());
+	mdcache->journal_cow_dentry(mdr, metablob, oldin->get_projected_parent_dn(),
+				    CEPH_NOSNAP, 0, destdnl);
+	metablob->add_primary_dentry(oldin->get_projected_parent_dn(), true, oldin);
       }
       if (destdn->is_auth()) {
 	// auth for dn, not targeti
@@ -5740,10 +5741,10 @@ void Server::_rename_prepare(MDRequest *mdr,
 
       if (destdn->is_auth())
         metablob->add_remote_dentry(destdn, true, srcdnl->get_remote_ino(), srcdnl->get_remote_d_type());
-      if (srci->get_parent_dn()->is_auth()) { // it's remote
-	metablob->add_dir_context(srci->get_parent_dir());
-        mdcache->journal_cow_dentry(mdr, metablob, srci->get_parent_dn(), CEPH_NOSNAP, 0, srcdnl);
-	metablob->add_primary_dentry(srci->get_parent_dn(), true, srci);
+      if (srci->get_projected_parent_dn()->is_auth()) { // it's remote
+	metablob->add_dir_context(srci->get_projected_parent_dir());
+        mdcache->journal_cow_dentry(mdr, metablob, srci->get_projected_parent_dn(), CEPH_NOSNAP, 0, srcdnl);
+	metablob->add_primary_dentry(srci->get_projected_parent_dn(), true, srci);
       }
     } else {
       if (destdn->is_auth() && !destdnl->is_null())
-- 
1.7.11.7

