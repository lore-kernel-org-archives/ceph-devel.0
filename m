From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 2/2] mds: Allow try_eval to eval unstable locks in freezing object
Date: Thu,  1 Nov 2012 17:03:38 +0800
Message-ID: <1351760618-19874-4-git-send-email-zheng.z.yan@intel.com>
References: <1351760618-19874-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13445 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758572Ab2KAJDr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Nov 2012 05:03:47 -0400
In-Reply-To: <1351760618-19874-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Unstable locks hold auth_pins on the object, it prevents the freezing
object become frozen and then unfreeze. So try_eval() should not wait
for freezing object

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 6474743..68ecc16 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -837,8 +837,8 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
     return;
   }
 
-  if (p->is_auth() && !p->can_auth_pin()) {
-    dout(7) << "try_eval can't auth_pin, waiting on " << *p << dendl;
+  if (p->is_auth() && p->is_frozen()) {
+    dout(7) << "try_eval frozen, waiting on " << *p << dendl;
     p->add_waiter(MDSCacheObject::WAIT_UNFREEZE, new C_Locker_Eval(this, p, mask));
     return;
   }
-- 
1.7.11.7

