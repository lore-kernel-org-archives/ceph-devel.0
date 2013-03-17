From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 38/39] mds: don't replicate purging dentry
Date: Sun, 17 Mar 2013 22:51:41 +0800
Message-ID: <1363531902-24909-39-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:30053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932755Ab3CQOyK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:54:10 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

open_remote_ino is racy, it's possible someone deletes the inode's
last linkage while the MDS is discovering the inode.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 24f1109..d730ff1 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -9225,8 +9225,15 @@ void MDCache::handle_discover(MDiscover *dis)
     if (dis->get_want_ino()) {
       // lookup by ino
       CInode *in = get_inode(dis->get_want_ino(), snapid);
-      if (in && in->is_auth() && in->get_parent_dn()->get_dir() == curdir)
+      if (in && in->is_auth() && in->get_parent_dn()->get_dir() == curdir) {
 	dn = in->get_parent_dn();
+	if (dn->state_test(CDentry::STATE_PURGING)) {
+	  // set error flag in reply
+	  dout(7) << "dentry " << *dn << " is purging, flagging error ino" << dendl;
+	  reply->set_flag_error_ino();
+	  break;
+	}
+      }
     } else if (dis->get_want().depth() > 0) {
       // lookup dentry
       dn = curdir->lookup(dis->get_dentry(i), snapid);
-- 
1.7.11.7

