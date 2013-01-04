From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/29] mds: fix Locker::simple_eval()
Date: Fri,  4 Jan 2013 17:01:53 +0800
Message-ID: <1357290140-17044-3-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:51114 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab3ADJC1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:27 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Locker::simple_eval() checks if the loner wants CEPH_CAP_GEXCL to
decide if it should change the lock to EXCL state, but it checks
if CEPH_CAP_GEXCL is issued to the loner to decide if it should
change the lock to SYNC state. So if the loner wants CEPH_CAP_GEXCL,
but doesn't have CEPH_CAP_GEXCL, Locker::simple_eval() will keep
switching the lock state.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index c8cd236..98eaba8 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -3250,11 +3250,10 @@ void Locker::simple_eval(SimpleLock *lock, bool *need_issue)
     return;
 
   CInode *in = 0;
-  int wanted = 0, issued = 0;
+  int wanted = 0;
   if (lock->get_type() != CEPH_LOCK_DN) {
     in = (CInode*)lock->get_parent();
-    wanted = in->get_caps_wanted(NULL, NULL, lock->get_cap_shift());
-    issued = in->get_caps_issued(NULL, NULL, NULL, lock->get_cap_shift());
+    in->get_caps_wanted(&wanted, NULL, lock->get_cap_shift());
   }
   
   // -> excl?
@@ -3270,8 +3269,7 @@ void Locker::simple_eval(SimpleLock *lock, bool *need_issue)
   else if (lock->get_state() != LOCK_SYNC &&
 	   !lock->is_xlocked() &&
 	   !lock->is_wrlocked() &&
-	   ((!(issued & CEPH_CAP_GEXCL) &&
-	     !lock->is_waiter_for(SimpleLock::WAIT_WR)) ||
+	   ((!(wanted & CEPH_CAP_GEXCL) && !lock->is_waiter_for(SimpleLock::WAIT_WR)) ||
 	    (lock->get_state() == LOCK_EXCL && in && in->get_target_loner() < 0))) {
     dout(7) << "simple_eval stable, syncing " << *lock 
 	    << " on " << *lock->get_parent() << dendl;
-- 
1.7.11.7

