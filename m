From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] mds: Clear lock flushed if replica is waiting for AC_LOCKFLUSHED
Date: Thu,  8 Nov 2012 20:54:15 +0800
Message-ID: <1352379255-5621-2-git-send-email-zheng.z.yan@intel.com>
References: <1352379255-5621-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:60715 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755497Ab2KHMy2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 8 Nov 2012 07:54:28 -0500
In-Reply-To: <1352379255-5621-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

So eval_gather() will not skip calling scatter_writebehind(),
otherwise the replica lock may be in flushing state forever.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index a1f957a..e2b1ff4 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -4383,8 +4383,12 @@ void Locker::handle_file_lock(ScatterLock *lock, MLock *m)
     if (lock->get_state() == LOCK_MIX_LOCK ||
 	lock->get_state() == LOCK_MIX_LOCK2 ||
 	lock->get_state() == LOCK_MIX_EXCL ||
-	lock->get_state() == LOCK_MIX_TSYN)
+	lock->get_state() == LOCK_MIX_TSYN) {
       lock->decode_locked_state(m->get_data());
+      // replica is waiting for AC_LOCKFLUSHED, eval_gather() should not
+      // delay calling scatter_writebehind().
+      lock->clear_flushed();
+    }
 
     if (lock->is_gathering()) {
       dout(7) << "handle_file_lock " << *in << " from " << from
-- 
1.7.11.7

