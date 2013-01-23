From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 20/25] mds: journal inode's projected parent when doing link rollback
Date: Wed, 23 Jan 2013 11:08:56 +0800
Message-ID: <1358910541-15535-21-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60962 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101Ab3AWDJW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:22 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Otherwise the journal entry will revert the effect of any on-going
rename operation for the inode.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index de73a8c..4ea6d0e 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -4399,7 +4399,7 @@ void Server::do_link_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   mut->add_projected_inode(in);
 
   // parent dir rctime
-  CDir *parent = in->get_parent_dn()->get_dir();
+  CDir *parent = in->get_projected_parent_dn()->get_dir();
   fnode_t *pf = parent->project_fnode();
   mut->add_projected_fnode(parent);
   pf->version = parent->pre_dirty();
@@ -4424,7 +4424,7 @@ void Server::do_link_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   mdlog->start_entry(le);
   le->commit.add_dir_context(parent);
   le->commit.add_dir(parent, true);
-  le->commit.add_primary_dentry(in->get_parent_dn(), true, 0);
+  le->commit.add_primary_dentry(in->get_projected_parent_dn(), true, 0);
   
   mdlog->submit_entry(le, new C_MDS_LoggedLinkRollback(this, mut, mdr));
   mdlog->flush();
-- 
1.7.11.7

