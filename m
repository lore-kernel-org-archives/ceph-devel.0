From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 19/30] mds: fix check for base inode discovery
Date: Thu, 23 May 2013 16:06:47 +0800
Message-ID: <1369296418-14871-20-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756450Ab3EWINO (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:14 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If a MDiscover message is for discovering base inode, want_base_dir
should be false, path should be empty.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5e8f2a5..5c2732b 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -9175,7 +9175,8 @@ void MDCache::handle_discover(MDiscover *dis)
   snapid_t snapid = dis->get_snapid();
 
   // get started.
-  if (MDS_INO_IS_BASE(dis->get_base_ino())) {
+  if (MDS_INO_IS_BASE(dis->get_base_ino()) &&
+      !dis->wants_base_dir() && dis->get_want().depth() == 0) {
     // wants root
     dout(7) << "handle_discover from mds." << from
 	    << " wants base + " << dis->get_want().get_path()
-- 
1.8.1.4

