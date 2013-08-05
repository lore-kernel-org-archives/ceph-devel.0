From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/6] mds: remove "type != CEPH_LOCK_DN" check in Locker::cancel_locking()
Date: Mon,  5 Aug 2013 14:10:24 +0800
Message-ID: <1375683030-28305-4-git-send-email-zheng.z.yan@intel.com>
References: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33765 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695Ab3HEGKh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Aug 2013 02:10:37 -0400
In-Reply-To: <1375683030-28305-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

For acquiring/cancelling xlock, the lock state transitions for
dentry lock and other types of locks are the same. So I think
the "type != CEPH_LOCK_DN" check doesn't make sense.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 254bbb2..d2d47fb 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -543,13 +543,11 @@ void Locker::cancel_locking(Mutation *mut, set<CInode*> *pneed_issue)
   dout(10) << "cancel_locking " << *lock << " on " << *mut << dendl;
 
   if (lock->get_parent()->is_auth()) {
-    if (lock->get_type() != CEPH_LOCK_DN) {
-      bool need_issue = false;
-      if (lock->get_state() == LOCK_PREXLOCK)
-	_finish_xlock(lock, -1, &need_issue);
-      if (need_issue)
-	pneed_issue->insert(static_cast<CInode *>(lock->get_parent()));
-    }
+    bool need_issue = false;
+    if (lock->get_state() == LOCK_PREXLOCK)
+      _finish_xlock(lock, -1, &need_issue);
+    if (need_issue)
+      pneed_issue->insert(static_cast<CInode *>(lock->get_parent()));
   }
   mut->finish_locking(lock);
 }
-- 
1.8.1.4

