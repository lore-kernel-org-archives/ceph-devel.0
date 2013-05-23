From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 09/30] mds: fix typo in Server::do_rename_rollback
Date: Thu, 23 May 2013 16:06:37 +0800
Message-ID: <1369296418-14871-10-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39281 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127Ab3EWINJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:09 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index fac7a56..e9f9706 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -7017,7 +7017,7 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
   }
 
   if (straydn)
-    destdn->push_projected_linkage();
+    straydn->push_projected_linkage();
 
   if (target) {
     inode_t *ti = NULL;
@@ -7094,7 +7094,7 @@ void Server::do_rename_rollback(bufferlist &rbl, int master, MDRequest *mdr)
 void Server::_rename_rollback_finish(Mutation *mut, MDRequest *mdr, CDentry *srcdn,
 				     version_t srcdnpv, CDentry *destdn, CDentry *straydn)
 {
-  dout(10) << "_rename_rollback_finish" << mut->reqid << dendl;
+  dout(10) << "_rename_rollback_finish " << mut->reqid << dendl;
 
   if (straydn) {
     straydn->get_dir()->unlink_inode(straydn);
-- 
1.8.1.4

