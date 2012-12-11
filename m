From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 07/14] mds: always send discover if want_xlocked is true
Date: Tue, 11 Dec 2012 16:30:53 +0800
Message-ID: <1355214660-26354-8-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2LKIbL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:11 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If want_xlocked is true, we can not rely on previously sent discover
because it's likely the previous discover is blocking on the xlocked
dentry.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/MDCache.cc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index eb18eeb..326e9d7 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -8449,7 +8449,8 @@ void MDCache::discover_path(CInode *base,
     return;
   } 
 
-  if (!base->is_waiter_for(CInode::WAIT_DIR) || !onfinish) { // FIXME: weak!
+  if ((want_xlocked && want_path.depth() == 1) ||
+      !base->is_waiter_for(CInode::WAIT_DIR) || !onfinish) { // FIXME: weak!
     discover_info_t& d = _create_discover(from);
     d.ino = base->ino();
     d.snap = snap;
@@ -8496,7 +8497,8 @@ void MDCache::discover_path(CDir *base,
     return;
   }
 
-  if (!base->is_waiting_for_dentry(want_path[0].c_str(), snap) || !onfinish) {
+  if ((want_xlocked && want_path.depth() == 1) ||
+      !base->is_waiting_for_dentry(want_path[0].c_str(), snap) || !onfinish) {
     discover_info_t& d = _create_discover(from);
     d.ino = base->ino();
     d.frag = base->get_frag();
@@ -8542,7 +8544,7 @@ void MDCache::discover_ino(CDir *base,
     return;
   } 
 
-  if (!base->is_waiting_for_ino(want_ino)) {
+  if (want_xlocked || !base->is_waiting_for_ino(want_ino) || !onfinish) {
     discover_info_t& d = _create_discover(from);
     d.ino = base->ino();
     d.frag = base->get_frag();
@@ -8801,11 +8803,14 @@ void MDCache::handle_discover(MDiscover *dis)
       // is this the last (tail) item in the discover traversal?
       if (tailitem && dis->wants_xlocked()) {
 	dout(7) << "handle_discover allowing discovery of xlocked tail " << *dn << dendl;
-      } else {
+      } else if (reply->is_empty()) {
 	dout(7) << "handle_discover blocking on xlocked " << *dn << dendl;
 	dn->lock.add_waiter(SimpleLock::WAIT_RD, new C_MDS_RetryMessage(mds, dis));
 	reply->put();
 	return;
+      } else {
+	dout(7) << "handle_discover non-empty reply, xlocked tail " << *dn << dendl;
+	break;
       }
     }
 
-- 
1.7.11.7

