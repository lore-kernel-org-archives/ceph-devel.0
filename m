From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 16/30] mds: fix Locker::request_inode_file_caps()
Date: Thu, 23 May 2013 16:06:44 +0800
Message-ID: <1369296418-14871-17-git-send-email-zheng.z.yan@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab3EWINN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 23 May 2013 04:13:13 -0400
In-Reply-To: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, sam.lang@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

After sending cache rejoin message, replica need notify auth MDS when
cap_wanted changes. But it can send MInodeFileCaps message only after
receiving auth MDS' rejoin ack. Locker::request_inode_file_caps() has
correct wait logical, but it skips sending MInodeFileCaps message if
the auth MDS is still in rejoin state.

The fix is defer sending MInodeFileCaps message until the auth MDS
is active. It makes the function's wait logical less tricky.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 781704c..7e3e9fd 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -1932,8 +1932,7 @@ void Locker::request_inode_file_caps(CInode *in)
     }
 
     int auth = in->authority().first;
-    if (in->is_rejoining() &&
-	mds->mdsmap->get_state(auth) == MDSMap::STATE_REJOIN) {
+    if (mds->mdsmap->get_state(auth) == MDSMap::STATE_REJOIN) {
       mds->wait_for_active_peer(auth, new C_MDL_RequestInodeFileCaps(this, in));
       return;
     }
@@ -1954,7 +1953,7 @@ void Locker::request_inode_file_caps(CInode *in)
 void Locker::handle_inode_file_caps(MInodeFileCaps *m)
 {
   // nobody should be talking to us during recovery.
-  assert(mds->is_rejoin() || mds->is_clientreplay() || mds->is_active() || mds->is_stopping());
+  assert(mds->is_clientreplay() || mds->is_active() || mds->is_stopping());
 
   // ok
   CInode *in = mdcache->get_inode(m->get_ino());
-- 
1.8.1.4

