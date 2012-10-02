From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/12] mds: Set metablob.renamed_dirino in do_rename_rollback()
Date: Tue,  2 Oct 2012 16:55:46 +0800
Message-ID: <1349168152-13281-6-git-send-email-zheng.z.yan@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:51424 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab2JBI4M (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Oct 2012 04:56:12 -0400
In-Reply-To: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 7659b23..e16800e 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -6395,8 +6395,11 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
     le->commit.add_null_dentry(straydn, true);
   }
 
-  if (in->is_dir())
+  if (in->is_dir()) {
+    dout(10) << " noting renamed dir ino " << in->ino() << " in metablob" << dendl;
+    le->commit.renamed_dirino = in->ino();
     mdcache->project_subtree_rename(in, destdir, srcdir);
+  }
   
   mdlog->submit_entry(le, new C_MDS_LoggedRenameRollback(this, mut, mdr,
 							 srcdnl->get_inode(), destdir));
-- 
1.7.11.4

