From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] mds: change XLOCK/XLOCKDONE's next state to LOCK
Date: Fri, 12 Apr 2013 16:11:11 +0800
Message-ID: <1365754273-14088-4-git-send-email-zheng.z.yan@intel.com>
References: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55520 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753720Ab3DLILU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Apr 2013 04:11:20 -0400
In-Reply-To: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: greg@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

For simplelock and filelock, XLOCK/XLOCKDONE's next state is SYNC.
But filelock in XLOCK/XLOCKDONE state allow Fb caps, filelock in
SYNC state does not. So filelock can be stuck in XLOCK/XLOCKDONE
state forever if there are Fb caps issued.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 8 ++++++--
 src/mds/locks.c   | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index f86ba88..9f0043c 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -756,13 +756,17 @@ void Locker::eval_gather(SimpleLock *lock, bool first, bool *pneed_issue, list<C
 	(static_cast<ScatterLock *>(lock))->clear_scatter_wanted();
 	break;
 
+      case LOCK_XLOCK:
+      case LOCK_XLOCKDONE:
+	if (next != LOCK_SYNC)
+	  break;
+	// fall-thru
+
 	// to sync
       case LOCK_EXCL_SYNC:
       case LOCK_LOCK_SYNC:
       case LOCK_MIX_SYNC:
       case LOCK_XSYN_SYNC:
-      case LOCK_XLOCK:
-      case LOCK_XLOCKDONE:
 	if (lock->get_parent()->is_replicated()) {
 	  bufferlist softdata;
 	  lock->encode_locked_state(softdata);
diff --git a/src/mds/locks.c b/src/mds/locks.c
index 69b6bd6..c7dd5be 100644
--- a/src/mds/locks.c
+++ b/src/mds/locks.c
@@ -103,8 +103,8 @@ const struct sm_state_t filelock[LOCK_MAX] = {
     [LOCK_MIX_LOCK2] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
 
     [LOCK_PREXLOCK]  = { LOCK_LOCK, false, LOCK_LOCK, 0,    XCL, 0,   0,   0,   0,   ANY, CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
-    [LOCK_XLOCK]     = { LOCK_SYNC, false, LOCK_LOCK, 0,    XCL, 0,   0,   0,   0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
-    [LOCK_XLOCKDONE] = { LOCK_SYNC, false, LOCK_LOCK, XCL,  XCL, XCL, 0,   0,   XCL, 0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,CEPH_CAP_GSHARED,0 },
+    [LOCK_XLOCK]     = { LOCK_LOCK, false, LOCK_LOCK, 0,    XCL, 0,   0,   0,   0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
+    [LOCK_XLOCKDONE] = { LOCK_LOCK, false, LOCK_LOCK, XCL,  XCL, XCL, 0,   0,   XCL, 0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,CEPH_CAP_GSHARED,0 },
     [LOCK_LOCK_XLOCK]= { LOCK_PREXLOCK,false,LOCK_LOCK,0,   XCL, 0,   0,   0,   0,   XCL, CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
 
     [LOCK_MIX]       = { 0,         false, LOCK_MIX,  0,    0,   REQ, ANY, 0,   0,   0,   CEPH_CAP_GRD|CEPH_CAP_GWR|CEPH_CAP_GLAZYIO,0,0,CEPH_CAP_GRD },
-- 
1.7.11.7

