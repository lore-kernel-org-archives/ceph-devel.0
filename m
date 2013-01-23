From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 05/25] mds: introduce XSYN to SYNC lock state transition
Date: Wed, 23 Jan 2013 11:08:41 +0800
Message-ID: <1358910541-15535-6-git-send-email-zheng.z.yan@intel.com>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60335 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab3AWDJJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 22:09:09 -0500
In-Reply-To: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If lock is in XSYN state, Locker::simple_sync() firstly try changing
lock state to EXCL. If it fail to change lock state to EXCL, it just
returns. So Locker::simple_sync() does not guarantee the lock state
eventually changes to SYNC. This issue can cause replica that requests
read lock hang. The fix is introduce an intermediate state for XSYN
to SYNC transition.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc    | 7 ++-----
 src/mds/SimpleLock.h | 1 +
 src/mds/locks.c      | 1 +
 src/mds/locks.h      | 1 +
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 9b3bfe3..e0c149f 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -744,6 +744,7 @@ void Locker::eval_gather(SimpleLock *lock, bool first, bool *pneed_issue, list<C
       case LOCK_EXCL_SYNC:
       case LOCK_LOCK_SYNC:
       case LOCK_MIX_SYNC:
+      case LOCK_XSYN_SYNC:
       case LOCK_XLOCK:
       case LOCK_XLOCKDONE:
 	if (lock->get_parent()->is_replicated()) {
@@ -3333,11 +3334,7 @@ bool Locker::simple_sync(SimpleLock *lock, bool *need_issue)
     case LOCK_MIX: lock->set_state(LOCK_MIX_SYNC); break;
     case LOCK_SCAN:
     case LOCK_LOCK: lock->set_state(LOCK_LOCK_SYNC); break;
-    case LOCK_XSYN:
-      file_excl((ScatterLock*)lock, need_issue);
-      if (lock->get_state() != LOCK_EXCL)
-	return false;
-      // fall-thru
+    case LOCK_XSYN: lock->set_state(LOCK_XSYN_SYNC); break;
     case LOCK_EXCL: lock->set_state(LOCK_EXCL_SYNC); break;
     default: assert(0);
     }
diff --git a/src/mds/SimpleLock.h b/src/mds/SimpleLock.h
index bfd0e1f..8eb8134 100644
--- a/src/mds/SimpleLock.h
+++ b/src/mds/SimpleLock.h
@@ -110,6 +110,7 @@ public:
     case LOCK_XSYN: return "xsyn";
     case LOCK_XSYN_EXCL: return "xsyn->excl";
     case LOCK_EXCL_XSYN: return "excl->xsyn";
+    case LOCK_XSYN_SYNC: return "xsyn->sync";
 
     case LOCK_SYNC_MIX: return "sync->mix";
     case LOCK_SYNC_MIX2: return "sync->mix(2)";
diff --git a/src/mds/locks.c b/src/mds/locks.c
index 73b99fb..69b6bd6 100644
--- a/src/mds/locks.c
+++ b/src/mds/locks.c
@@ -94,6 +94,7 @@ const struct sm_state_t filelock[LOCK_MAX] = {
     [LOCK_MIX_SYNC]  = { LOCK_SYNC, false, LOCK_MIX_SYNC2,0,0,   0,   0,   0,   0,   0,   CEPH_CAP_GRD|CEPH_CAP_GLAZYIO,0,0,CEPH_CAP_GRD },
     [LOCK_MIX_SYNC2] = { LOCK_SYNC, false, 0,         0,    0,   0,   0,   0,   0,   0,   CEPH_CAP_GRD|CEPH_CAP_GLAZYIO,0,0,CEPH_CAP_GRD },
     [LOCK_SNAP_SYNC] = { LOCK_SYNC, false, LOCK_LOCK, 0,    0,   0,   0,   AUTH,0,   0,   0,0,0,0 },
+    [LOCK_XSYN_SYNC] = { LOCK_SYNC, true,  LOCK_LOCK, AUTH, 0,   AUTH,0,   0,   0,   0,   0,CEPH_CAP_GCACHE,0,0 },
   
     [LOCK_LOCK]      = { 0,         false, LOCK_LOCK, AUTH, 0,   REQ, AUTH,0,   0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
     [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,CEPH_CAP_GCACHE },
diff --git a/src/mds/locks.h b/src/mds/locks.h
index 9e09cf2..2adcbf2 100644
--- a/src/mds/locks.h
+++ b/src/mds/locks.h
@@ -93,6 +93,7 @@ enum {
   LOCK_XSYN,
   LOCK_XSYN_EXCL,
   LOCK_EXCL_XSYN,
+  LOCK_XSYN_SYNC,
 
   LOCK_MAX,
 };
-- 
1.7.11.7

