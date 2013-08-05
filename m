From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/6] mds: revoke GSHARED cap when finishing xlock
Date: Mon,  5 Aug 2013 14:10:23 +0800
Message-ID: <1375683030-28305-3-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33765 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab3HEGKg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:36 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
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

The fix is always call Locker::_finish_xlock() when xlock count
reaches zero. _finish_xlock() checks if it can change lock state
to LOCK_EXCL immediately. If not, it uses Locker::eval_gather()
to transit lock state.

Another change of this patch is avoid changing lock state to
LOCK_LOCK directly. because lock in LOCK_XLOCK_DONE state allows
GSHARED cap, lock in LOCK_LOCK state does not.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 57 +++++++++++++++++++++++++------------------------------
 src/mds/Locker.h  |  2 +-
 2 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 30e014a..254bbb2 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -546,9 +546,7 @@ void Locker::cancel_locking(Mutation *mut, set<CInode*> *pneed_issue)
     if (lock->get_type() != CEPH_LOCK_DN) {
       bool need_issue = false;
       if (lock->get_state() == LOCK_PREXLOCK)
-	_finish_xlock(lock, &need_issue);
-      if (lock->is_stable())
-	eval(lock, &need_issue);
+	_finish_xlock(lock, -1, &need_issue);
       if (need_issue)
 	pneed_issue->insert(static_cast<CInode *>(lock->get_parent()));
     }
@@ -1458,19 +1456,29 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
   }
 }
 
-void Locker::_finish_xlock(SimpleLock *lock, bool *pneed_issue)
+void Locker::_finish_xlock(SimpleLock *lock, client_t xlocker, bool *pneed_issue)
 {
   assert(!lock->is_stable());
-  if (lock->get_type() != CEPH_LOCK_DN && (static_cast<CInode*>(lock->get_parent())->get_loner()) >= 0)
-    lock->set_state(LOCK_EXCL);
-  else
-    lock->set_state(LOCK_LOCK);
-  if (lock->get_type() == CEPH_LOCK_DN && lock->get_parent()->is_replicated() &&
-      !lock->is_waiter_for(SimpleLock::WAIT_WR))
-    simple_sync(lock, pneed_issue);
-  if (lock->get_cap_shift())
-    *pneed_issue = true;
-  lock->get_parent()->auth_unpin(lock);
+  if (lock->get_num_rdlocks() == 0 &&
+      lock->get_num_wrlocks() == 0 &&
+      lock->get_num_client_lease() == 0 &&
+      lock->get_type() != CEPH_LOCK_DN) {
+    CInode *in = static_cast<CInode*>(lock->get_parent());
+    client_t loner = in->get_target_loner();
+    if (loner >= 0 && (xlocker < 0 || xlocker == loner)) {
+      lock->set_state(LOCK_EXCL);
+      lock->get_parent()->auth_unpin(lock);
+      lock->finish_waiters(SimpleLock::WAIT_STABLE|SimpleLock::WAIT_WR|SimpleLock::WAIT_RD);
+      if (lock->get_cap_shift())
+	*pneed_issue = true;
+      if (lock->get_parent()->is_auth() &&
+	  lock->is_stable())
+	try_eval(lock, pneed_issue);
+      return;
+    }
+  }
+  // the xlocker may have CEPH_CAP_GSHARED, need to revoke it if next state is LOCK_LOCK
+  eval_gather(lock, true, pneed_issue);
 }
 
 void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
@@ -1481,6 +1489,8 @@ void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
 
   dout(10) << "xlock_finish on " << *lock << " " << *lock->get_parent() << dendl;
 
+  client_t xlocker = lock->get_xlock_by_client();
+
   // drop ref
   lock->put_xlock();
   assert(mut);
@@ -1508,24 +1518,9 @@ void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
 			 SimpleLock::WAIT_WR | 
 			 SimpleLock::WAIT_RD, 0); 
   } else {
-    if (lock->get_num_xlocks() == 0 &&
-	lock->get_num_rdlocks() == 0 &&
-	lock->get_num_wrlocks() == 0 &&
-	lock->get_num_client_lease() == 0) {
-      _finish_xlock(lock, &do_issue);
-    }
-
-    // others waiting?
-    lock->finish_waiters(SimpleLock::WAIT_STABLE |
-			 SimpleLock::WAIT_WR | 
-			 SimpleLock::WAIT_RD, 0); 
+    if (lock->get_num_xlocks() == 0)
+      _finish_xlock(lock, xlocker, &do_issue);
   }
-    
-  // eval?
-  if (!lock->is_stable())
-    eval_gather(lock, false, &do_issue);
-  else if (lock->get_parent()->is_auth())
-    try_eval(lock, &do_issue);
   
   if (do_issue) {
     CInode *in = static_cast<CInode*>(lock->get_parent());
diff --git a/src/mds/Locker.h b/src/mds/Locker.h
index b97307d..b39eff1 100644
--- a/src/mds/Locker.h
+++ b/src/mds/Locker.h
@@ -143,7 +143,7 @@ public:
   void remote_wrlock_finish(SimpleLock *lock, int target, Mutation *mut);
 
   bool xlock_start(SimpleLock *lock, MDRequest *mut);
-  void _finish_xlock(SimpleLock *lock, bool *pneed_issue);
+  void _finish_xlock(SimpleLock *lock, client_t xlocker, bool *pneed_issue);
   void xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue);
 
   void xlock_export(SimpleLock *lock, Mutation *mut);
-- 
1.8.1.4

