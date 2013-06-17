From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/8] mds: fix frozen check in Server::try_open_auth_dirfrag()
Date: Mon, 17 Jun 2013 20:10:23 +0800
Message-ID: <1371471029-10589-3-git-send-email-zheng.z.yan@intel.com>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50572 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790Ab3FQMLD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 17 Jun 2013 08:11:03 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Server.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 253c56d..c3162e7 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -2204,7 +2204,7 @@ CDir* Server::try_open_auth_dirfrag(CInode *diri, frag_t fg, MDRequest *mdr)
   }
 
   // not open and inode frozen?
-  if (!dir && diri->is_frozen_dir()) {
+  if (!dir && diri->is_frozen()) {
     dout(10) << "try_open_auth_dirfrag: dir inode is frozen, waiting " << *diri << dendl;
     assert(diri->get_parent_dir());
     diri->get_parent_dir()->add_waiter(CDir::WAIT_UNFREEZE, new C_MDS_RetryRequest(mdcache, mdr));
-- 
1.8.1.4

