From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 08/14] mds: re-issue caps after importing caps
Date: Tue, 11 Dec 2012 16:30:54 +0800
Message-ID: <1355214660-26354-9-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16602 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519Ab2LKIbM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:12 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

The imported caps may prevent unstable locks from entering stable
states. So we should call Locker::eval_gather() with parameter
"first" set to true after caps are imported.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc   | 16 ++++++++--------
 src/mds/Locker.h    |  6 +++---
 src/mds/Migrator.cc |  3 ++-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index a8ec19f..860577f 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -769,7 +769,7 @@ void Locker::eval_gather(SimpleLock *lock, bool first, bool *pneed_issue, list<C
 
 }
 
-bool Locker::eval(CInode *in, int mask)
+bool Locker::eval(CInode *in, int mask, bool caps_imported)
 {
   bool need_issue = false;
   
@@ -790,19 +790,19 @@ bool Locker::eval(CInode *in, int mask)
 
  retry:
   if (mask & CEPH_LOCK_IFILE)
-    eval_any(&in->filelock, &need_issue);
+    eval_any(&in->filelock, &need_issue, caps_imported);
   if (mask & CEPH_LOCK_IAUTH)
-    eval_any(&in->authlock, &need_issue);
+    eval_any(&in->authlock, &need_issue, caps_imported);
   if (mask & CEPH_LOCK_ILINK)
-    eval_any(&in->linklock, &need_issue);
+    eval_any(&in->linklock, &need_issue,caps_imported);
   if (mask & CEPH_LOCK_IXATTR)
-    eval_any(&in->xattrlock, &need_issue);
+    eval_any(&in->xattrlock, &need_issue, caps_imported);
   if (mask & CEPH_LOCK_INEST)
-    eval_any(&in->nestlock, &need_issue);
+    eval_any(&in->nestlock, &need_issue, caps_imported);
   if (mask & CEPH_LOCK_IFLOCK)
-    eval_any(&in->flocklock, &need_issue);
+    eval_any(&in->flocklock, &need_issue, caps_imported);
   if (mask & CEPH_LOCK_IPOLICY)
-    eval_any(&in->policylock, &need_issue);
+    eval_any(&in->policylock, &need_issue, caps_imported);
 
   // drop loner?
   if (in->is_auth() && in->is_head() && in->get_wanted_loner() != in->get_loner()) {
diff --git a/src/mds/Locker.h b/src/mds/Locker.h
index b3b9919..04a5252 100644
--- a/src/mds/Locker.h
+++ b/src/mds/Locker.h
@@ -99,9 +99,9 @@ public:
 
   void eval_gather(SimpleLock *lock, bool first=false, bool *need_issue=0, list<Context*> *pfinishers=0);
   void eval(SimpleLock *lock, bool *need_issue);
-  void eval_any(SimpleLock *lock, bool *need_issue) {
+  void eval_any(SimpleLock *lock, bool *need_issue, bool first=false) {
     if (!lock->is_stable())
-      eval_gather(lock, false, need_issue);
+      eval_gather(lock, first, need_issue);
     else if (lock->get_parent()->is_auth())
       eval(lock, need_issue);
   }
@@ -122,7 +122,7 @@ public:
 
   void eval_cap_gather(CInode *in, set<CInode*> *issue_set=0);
 
-  bool eval(CInode *in, int mask);
+  bool eval(CInode *in, int mask, bool caps_imported=false);
   void try_eval(MDSCacheObject *p, int mask);
   void try_eval(SimpleLock *lock, bool *pneed_issue);
 
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index cc045b4..c157279 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -2230,7 +2230,7 @@ void Migrator::import_finish(CDir *dir)
        p != cap_imports.end();
        p++)
     if (p->first->is_auth())
-      mds->locker->eval(p->first, CEPH_CAP_LOCKS);
+      mds->locker->eval(p->first, CEPH_CAP_LOCKS, true);
 
   // send pending import_maps?
   mds->mdcache->maybe_send_pending_resolves();
@@ -2614,6 +2614,7 @@ void Migrator::logged_import_caps(CInode *in,
 
   assert(cap_imports.count(in));
   finish_import_inode_caps(in, from, cap_imports[in]);  
+  mds->locker->eval(in, CEPH_CAP_LOCKS, true);
 
   mds->send_message_mds(new MExportCapsAck(in->ino()), from);
 }
-- 
1.7.11.7

