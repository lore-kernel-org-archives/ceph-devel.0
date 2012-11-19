From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/16] mds: clear lock flushed if replica is waiting for AC_LOCKFLUSHED
Date: Mon, 19 Nov 2012 10:43:38 +0800
Message-ID: <1353293028-15238-7-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17039 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894Ab2KSCn6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:58 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

So eval_gather() will not skip calling scatter_writebehind(),
otherwise the replica lock may be in flushing state forever.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index b67b3ee..c500be5 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -4404,8 +4404,12 @@ void Locker::handle_file_lock(ScatterLock *lock, MLock *m)
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

