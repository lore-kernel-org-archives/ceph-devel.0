From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 10/16] mds: drop locks if requiring auth pinning new objects.
Date: Mon, 19 Nov 2012 10:43:42 +0800
Message-ID: <1353293028-15238-11-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17039 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752932Ab2KSCoD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:44:03 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Locker::acquire_locks() skip auth pinning replica object if we only
request a rdlock and the lock is read-lockable. To get all locks,
we may call Locker::acquire_locks() several times, locks in replca
objects may become not read-lockable between calls. So it is
possible we need auth pin new objects after already take some locks.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index c500be5..63f8311 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -286,11 +286,12 @@ bool Locker::acquire_locks(MDRequest *mdr,
       continue;
     
     if (!object->is_auth()) {
+      if (!mdr->locks.empty())
+	mds->locker->drop_locks(mdr);
       if (object->is_ambiguous_auth()) {
 	// wait
 	dout(10) << " ambiguous auth, waiting to authpin " << *object << dendl;
 	object->add_waiter(MDSCacheObject::WAIT_SINGLEAUTH, new C_MDS_RetryRequest(mdcache, mdr));
-	mds->locker->drop_locks(mdr);
 	mdr->drop_local_auth_pins();
 	return false;
       }
-- 
1.7.11.7

