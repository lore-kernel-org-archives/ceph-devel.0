From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 26/39] mds: issue caps when lock state in replica become SYNC
Date: Sun, 17 Mar 2013 22:51:29 +0800
Message-ID: <1363531902-24909-27-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:5752 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699Ab3CQOxh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:53:37 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

because client can request READ caps from non-auth MDS.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 4d45f99..28920d4 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -4403,6 +4403,8 @@ void Locker::handle_file_lock(ScatterLock *lock, MLock *m)
     lock->set_state(LOCK_SYNC);
 
     lock->get_rdlock();
+    if (caps)
+      issue_caps(in);
     lock->finish_waiters(SimpleLock::WAIT_RD|SimpleLock::WAIT_STABLE);
     lock->put_rdlock();
     break;
-- 
1.7.11.7

