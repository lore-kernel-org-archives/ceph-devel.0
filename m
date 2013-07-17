From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/6] mds: revoke GSHARED cap when finishing xlock
Date: Wed, 17 Jul 2013 16:28:39 +0800
Message-ID: <1374049723-19274-3-git-send-email-zheng.z.yan@intel.com>
References: <1374049723-19274-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:14679 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752513Ab3GQI2t (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jul 2013 04:28:49 -0400
In-Reply-To: <1374049723-19274-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If lock state is LOCK_XLOCKDONE, the xlocker can have GSHARED cap.
So when finishing xlock, we may need to revoke the GSHARED cap.

In most cases Locker::_finish_xlock() directly set lock state to
LOCK_LOCK or LOCK_EXCL, which hides the issue. If 'num_rdlock > 0'
or 'num_wrlock > 0' when finishing xlock, the issue reveals.
(lock get stuck in LOCK_XLOCKDONE forever)

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 42 +++++++++++++++---------------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 30e014a..afaac1c 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -547,8 +547,6 @@ void Locker::cancel_locking(Mutation *mut, set<CInode*> *pneed_issue)
       bool need_issue = false;
       if (lock->get_state() == LOCK_PREXLOCK)
 	_finish_xlock(lock, &need_issue);
-      if (lock->is_stable())
-	eval(lock, &need_issue);
       if (need_issue)
 	pneed_issue->insert(static_cast<CInode *>(lock->get_parent()));
     }
@@ -1461,16 +1459,21 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
 void Locker::_finish_xlock(SimpleLock *lock, bool *pneed_issue)
 {
   assert(!lock->is_stable());
-  if (lock->get_type() != CEPH_LOCK_DN && (static_cast<CInode*>(lock->get_parent())->get_loner()) >= 0)
+  if (lock->get_num_rdlocks() == 0 &&
+      lock->get_num_wrlocks() == 0 &&
+      lock->get_num_client_lease() == 0 &&
+      lock->get_type() != CEPH_LOCK_DN &&
+      (static_cast<CInode*>(lock->get_parent())->get_loner()) >= 0) {
     lock->set_state(LOCK_EXCL);
-  else
-    lock->set_state(LOCK_LOCK);
-  if (lock->get_type() == CEPH_LOCK_DN && lock->get_parent()->is_replicated() &&
-      !lock->is_waiter_for(SimpleLock::WAIT_WR))
-    simple_sync(lock, pneed_issue);
-  if (lock->get_cap_shift())
-    *pneed_issue = true;
-  lock->get_parent()->auth_unpin(lock);
+    lock->get_parent()->auth_unpin(lock);
+    lock->finish_waiters(SimpleLock::WAIT_STABLE|SimpleLock::WAIT_WR|SimpleLock::WAIT_RD);
+    if (lock->get_cap_shift())
+      *pneed_issue = true;
+  } else {
+    // the xlocker may have CEPH_CAP_GSHARED, need to revoke it
+    // if next state is LOCK_LOCK
+    eval_gather(lock, true, pneed_issue);
+  }
 }
 
 void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
@@ -1508,24 +1511,9 @@ void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
 			 SimpleLock::WAIT_WR | 
 			 SimpleLock::WAIT_RD, 0); 
   } else {
-    if (lock->get_num_xlocks() == 0 &&
-	lock->get_num_rdlocks() == 0 &&
-	lock->get_num_wrlocks() == 0 &&
-	lock->get_num_client_lease() == 0) {
+    if (lock->get_num_xlocks() == 0)
       _finish_xlock(lock, &do_issue);
-    }
-
-    // others waiting?
-    lock->finish_waiters(SimpleLock::WAIT_STABLE |
-			 SimpleLock::WAIT_WR | 
-			 SimpleLock::WAIT_RD, 0); 
   }
-    
-  // eval?
-  if (!lock->is_stable())
-    eval_gather(lock, false, &do_issue);
-  else if (lock->get_parent()->is_auth())
-    try_eval(lock, &do_issue);
   
   if (do_issue) {
     CInode *in = static_cast<CInode*>(lock->get_parent());
-- 
1.8.1.4

