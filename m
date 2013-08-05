From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/6] mds: change LOCK_SCAN to unstable state
Date: Mon,  5 Aug 2013 14:10:26 +0800
Message-ID: <1375683030-28305-6-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:46271 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab3HEGKk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:40 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

commit 0071b8e75b (mds: stay in SCAN state in file_eval) makes
Locker::file_eval() ignore lock in LOCK_SCAN state. If there
is no request changes the lock state, the lock can be stuck in
LOCK_SCAN state forever. This can cause client read/write hang
because lock in LOCK_SCAN state does not allow Frw caps.

The fix is change LOCK_SCAN to a unstable state. Thank to the
CInode::STATE_RECOVERING check in Locker::eval_gather(), the
lock stays in the SCAN state while file is being recovering.
The lock will transit to a stable state once the recovery
finishes.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc  | 18 +++++-------------
 src/mds/MDCache.cc |  1 +
 src/mds/locks.c    |  3 +--
 src/mds/locks.h    |  1 -
 4 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index efb5a74..084d64a 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -3441,7 +3441,6 @@ bool Locker::simple_sync(SimpleLock *lock, bool *need_issue)
 
     switch (lock->get_state()) {
     case LOCK_MIX: lock->set_state(LOCK_MIX_SYNC); break;
-    case LOCK_SCAN:
     case LOCK_LOCK: lock->set_state(LOCK_LOCK_SYNC); break;
     case LOCK_XSYN: lock->set_state(LOCK_XSYN_SYNC); break;
     case LOCK_EXCL: lock->set_state(LOCK_EXCL_SYNC); break;
@@ -3518,7 +3517,6 @@ void Locker::simple_excl(SimpleLock *lock, bool *need_issue)
     in = static_cast<CInode *>(lock->get_parent());
 
   switch (lock->get_state()) {
-  case LOCK_SCAN:
   case LOCK_LOCK: lock->set_state(LOCK_LOCK_EXCL); break;
   case LOCK_SYNC: lock->set_state(LOCK_SYNC_EXCL); break;
   case LOCK_XSYN: lock->set_state(LOCK_XSYN_EXCL); break;
@@ -3577,7 +3575,6 @@ void Locker::simple_lock(SimpleLock *lock, bool *need_issue)
   int old_state = lock->get_state();
 
   switch (lock->get_state()) {
-  case LOCK_SCAN: lock->set_state(LOCK_SCAN_LOCK); break;
   case LOCK_SYNC: lock->set_state(LOCK_SYNC_LOCK); break;
   case LOCK_XSYN:
     file_excl(static_cast<ScatterLock*>(lock), need_issue);
@@ -4163,10 +4160,6 @@ void Locker::file_eval(ScatterLock *lock, bool *need_issue)
   if (lock->get_parent()->is_freezing_or_frozen())
     return;
 
-  // wait for scan
-  if (lock->get_state() == LOCK_SCAN)
-    return;
-
   // excl -> *?
   if (lock->get_state() == LOCK_EXCL) {
     dout(20) << " is excl" << dendl;
@@ -4353,7 +4346,6 @@ void Locker::file_excl(ScatterLock *lock, bool *need_issue)
   switch (lock->get_state()) {
   case LOCK_SYNC: lock->set_state(LOCK_SYNC_EXCL); break;
   case LOCK_MIX: lock->set_state(LOCK_MIX_EXCL); break;
-  case LOCK_SCAN:
   case LOCK_LOCK: lock->set_state(LOCK_LOCK_EXCL); break;
   case LOCK_XSYN: lock->set_state(LOCK_XSYN_EXCL); break;
   default: assert(0);
@@ -4464,12 +4456,12 @@ void Locker::file_recover(ScatterLock *lock)
     issue_caps(in);
     gather++;
   }
-  if (gather) {
-    lock->get_parent()->auth_pin(lock);
-  } else {
-    lock->set_state(LOCK_SCAN);
+
+  lock->set_state(LOCK_SCAN);
+  if (gather)
+    in->state_set(CInode::STATE_NEEDSRECOVER);
+  else
     mds->mdcache->queue_file_recover(in);
-  }
 }
 
 
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 77d3d8b..898dcd3 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5718,6 +5718,7 @@ void MDCache::identify_files_to_recover(vector<CInode*>& recover_q, vector<CInod
     }
 
     if (recover) {
+      in->auth_pin(&in->filelock);
       in->filelock.set_state(LOCK_PRE_SCAN);
       recover_q.push_back(in);
       
diff --git a/src/mds/locks.c b/src/mds/locks.c
index 9031087..37e3f5e 100644
--- a/src/mds/locks.c
+++ b/src/mds/locks.c
@@ -122,8 +122,7 @@ const struct sm_state_t filelock[LOCK_MAX] = {
     [LOCK_EXCL_XSYN] = { LOCK_XSYN, false, LOCK_LOCK, 0,    0,   XCL, 0,   0,   0,   0,   0,CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0 },
 
     [LOCK_PRE_SCAN]  = { LOCK_SCAN, false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
-    [LOCK_SCAN]      = { 0,         false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
-    [LOCK_SCAN_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
+    [LOCK_SCAN]      = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   0,   0,   0,   0,0,0,0 },
 };
 
 const struct sm_t sm_filelock = {
diff --git a/src/mds/locks.h b/src/mds/locks.h
index 2adcbf2..d1585ce 100644
--- a/src/mds/locks.h
+++ b/src/mds/locks.h
@@ -86,7 +86,6 @@ enum {
 
   LOCK_PRE_SCAN,
   LOCK_SCAN,
-  LOCK_SCAN_LOCK,
 
   LOCK_SNAP_SYNC,
 
-- 
1.8.1.4

