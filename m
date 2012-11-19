From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/16] mds: allow try_eval to eval unstable locks in freezing object
Date: Mon, 19 Nov 2012 10:43:36 +0800
Message-ID: <1353293028-15238-5-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17039 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab2KSCnz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:55 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
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
index c29ac34..7d55940 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -845,8 +845,8 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
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

