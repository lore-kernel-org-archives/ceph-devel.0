From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/6] mds: handle "state == LOCK_LOCK_XLOCK" when cancelling xlock
Date: Mon,  5 Aug 2013 14:10:25 +0800
Message-ID: <1375683030-28305-5-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46271 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab3HEGKi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:38 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If we find lock state is LOCK_LOCK_XLOCK when cancelling xlock,
set lock state to LOCK_XLOCK_DONE and call Locker::eval_gather().
This makes sure the lock will eventually transit to a stable state.
(LOCK_XLOCK_DONE's next state is stable)

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index d2d47fb..efb5a74 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -544,8 +544,13 @@ void Locker::cancel_locking(Mutation *mut, set<CInode*> *pneed_issue)
 
   if (lock->get_parent()->is_auth()) {
     bool need_issue = false;
-    if (lock->get_state() == LOCK_PREXLOCK)
+    if (lock->get_state() == LOCK_PREXLOCK) {
       _finish_xlock(lock, -1, &need_issue);
+    } else if (lock->get_state() == LOCK_LOCK_XLOCK &&
+	       lock->get_num_xlocks() == 0) {
+      lock->set_state(LOCK_XLOCKDONE);
+      eval_gather(lock, true, &need_issue);
+    }
     if (need_issue)
       pneed_issue->insert(static_cast<CInode *>(lock->get_parent()));
   }
@@ -1516,8 +1521,11 @@ void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
 			 SimpleLock::WAIT_WR | 
 			 SimpleLock::WAIT_RD, 0); 
   } else {
-    if (lock->get_num_xlocks() == 0)
+    if (lock->get_num_xlocks() == 0) {
+      if (lock->get_state() == LOCK_LOCK_XLOCK)
+	lock->set_state(LOCK_XLOCKDONE);
       _finish_xlock(lock, xlocker, &do_issue);
+    }
   }
   
   if (do_issue) {
-- 
1.8.1.4

