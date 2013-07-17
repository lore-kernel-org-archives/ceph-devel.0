From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 5/6] mds: wake xlock waiter when xlock is done
Date: Wed, 17 Jul 2013 16:28:42 +0800
Message-ID: <1374049723-19274-6-git-send-email-zheng.z.yan@intel.com>
References: <1374049723-19274-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:50906 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055Ab3GQI2x (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jul 2013 04:28:53 -0400
In-Reply-To: <1374049723-19274-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Once a lock is in LOCK_XLOCKDONE state, client already holds xlock
can acquire extra xlock. So wake up xlock waiter when we set lock
state to LOCK_XLOCKDONE.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 47ea6fc..a4b50db 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -477,6 +477,7 @@ void Locker::set_xlocks_done(Mutation *mut, bool skip_dentry)
       continue;
     dout(10) << "set_xlocks_done on " << **p << " " << *(*p)->get_parent() << dendl;
     (*p)->set_xlock_done();
+    (*p)->finish_waiters(ScatterLock::WAIT_XLOCK);
   }
 }
 
@@ -1419,7 +1420,7 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
       }
     }
     
-    lock->add_waiter(SimpleLock::WAIT_WR|SimpleLock::WAIT_STABLE, new C_MDS_RetryRequest(mdcache, mut));
+    lock->add_waiter(SimpleLock::WAIT_XLOCK|SimpleLock::WAIT_STABLE, new C_MDS_RetryRequest(mdcache, mut));
     nudge_log(lock);
     return false;
   } else {
-- 
1.8.1.4

