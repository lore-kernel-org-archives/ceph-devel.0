From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/4] mds: Allow evaluating locks in replica object.
Date: Thu, 25 Oct 2012 20:26:52 +0800
Message-ID: <1351168012-4981-4-git-send-email-zheng.z.yan@intel.com>
References: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50693 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758942Ab2JYM1D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Oct 2012 08:27:03 -0400
In-Reply-To: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@inktank.com, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We should allow Locker::try_eval(MDSCacheObject *, int) to evaluate
locks in replica objects. Otherwise the locks in replica objects
may stuck on unstable states forever.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index a03789f..2c840a9 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -834,12 +834,7 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
     return;
   }
 
-  if (!p->is_auth()) {
-    dout(7) << "try_eval not auth for " << *p << dendl;
-    return;
-  }
-
-  if (!p->can_auth_pin()) {
+  if (p->is_auth() && !p->can_auth_pin()) {
     dout(7) << "try_eval can't auth_pin, waiting on " << *p << dendl;
     p->add_waiter(MDSCacheObject::WAIT_UNFREEZE, new C_Locker_Eval(this, p, mask));
     return;
@@ -847,9 +842,11 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
 
   if (mask & CEPH_LOCK_DN) {
     assert(mask == CEPH_LOCK_DN);
-    bool need_issue = false;  // ignore this, no caps on dentries
-    CDentry *dn = (CDentry *)p;
-    simple_eval(&dn->lock, &need_issue);
+    if (p->is_auth()) {
+      bool need_issue = false;  // ignore this, no caps on dentries
+      CDentry *dn = (CDentry *)p;
+      simple_eval(&dn->lock, &need_issue);
+    }
   } else {
     CInode *in = (CInode *)p;
     eval(in, mask);
-- 
1.7.11.7

