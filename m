From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: pass proper mask to CInode::get_caps_issued
Date: Fri, 12 Apr 2013 16:11:09 +0800
Message-ID: <1365754273-14088-2-git-send-email-zheng.z.yan@intel.com>
References: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62108 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701Ab3DLILS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Apr 2013 04:11:18 -0400
In-Reply-To: <1365754273-14088-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: greg@inktank.com, elder@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

There is a total of 22 cap bits and file lock uses 8 cap bits.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CInode.h  | 4 ++--
 src/mds/Locker.cc | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/mds/CInode.h b/src/mds/CInode.h
index 43af9c4..a3fe3cf 100644
--- a/src/mds/CInode.h
+++ b/src/mds/CInode.h
@@ -736,9 +736,9 @@ public:
 
   // caps issued, wanted
   int get_caps_issued(int *ploner = 0, int *pother = 0, int *pxlocker = 0,
-		      int shift = 0, int mask = 0xffff);
+		      int shift = 0, int mask = -1);
   bool is_any_caps_wanted();
-  int get_caps_wanted(int *ploner = 0, int *pother = 0, int shift = 0, int mask = 0xffff);
+  int get_caps_wanted(int *ploner = 0, int *pother = 0, int shift = 0, int mask = -1);
   bool issued_caps_need_gather(SimpleLock *lock);
   void replicate_relax_locks();
 
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 7ba9f44..f86ba88 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -616,7 +616,8 @@ void Locker::eval_gather(SimpleLock *lock, bool first, bool *pneed_issue, list<C
 
   int loner_issued = 0, other_issued = 0, xlocker_issued = 0;
   if (caps && in->is_head()) {
-    in->get_caps_issued(&loner_issued, &other_issued, &xlocker_issued, lock->get_cap_shift(), 3);
+    in->get_caps_issued(&loner_issued, &other_issued, &xlocker_issued,
+			lock->get_cap_shift(), lock->get_cap_mask());
     dout(10) << " next state is " << lock->get_state_name(next) 
 	     << " issued/allows loner " << gcap_string(loner_issued)
 	     << "/" << gcap_string(lock->gcaps_allowed(CAP_LONER, next))
-- 
1.7.11.7

