From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] mds: Use stray dir as base inode for stray reintegration
Date: Wed,  3 Oct 2012 19:40:12 +0800
Message-ID: <1349264412-31444-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39917 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab2JCLkQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Oct 2012 07:40:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Server::handle_client_rename() only skips common ancestor check
if source path's base inode is stray directory, but source path's
base inode is mdsdir in the stray reintegration case.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 8b02b8b..32c9e36 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8288,8 +8288,7 @@ void MDCache::reintegrate_stray(CDentry *straydn, CDentry *rdn)
   dout(10) << "reintegrate_stray " << *straydn << " into " << *rdn << dendl;
   
   // rename it to another mds.
-  filepath src;
-  straydn->make_path(src);
+  filepath src(straydn->get_name(), straydn->get_dir()->get_inode()->ino());
   filepath dst;
   rdn->make_path(dst);
 
-- 
1.7.11.4

