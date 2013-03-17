From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 02/39] mds: process finished contexts in batch
Date: Sun, 17 Mar 2013 22:51:05 +0800
Message-ID: <1363531902-24909-3-git-send-email-zheng.z.yan@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:34328 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299Ab3CQOvz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Mar 2013 10:51:55 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, greg@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

If there are several unstable locks in an inode, current Locker::eval(CInode*,)
processes each lock's finished contexts seperately. This may cause very deep
call stack if finished contexts also call Locker::eval() on the same inode.
An extreme example is:

Locker::eval() wakes an open request(). Server::handle_client_open() starts
a log entry, then call Locker::issue_new_caps(). Locker::issue_new_caps()
calls Locker::eval() and wakes another request. The later request also tries
starting a log entry.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 17 ++++++++++-------
 src/mds/Locker.h  |  4 ++--
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index b61fb14..d06a9cc 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -803,6 +803,7 @@ void Locker::eval_gather(SimpleLock *lock, bool first, bool *pneed_issue, list<C
 bool Locker::eval(CInode *in, int mask, bool caps_imported)
 {
   bool need_issue = false;
+  list<Context*> finishers;
   
   dout(10) << "eval " << mask << " " << *in << dendl;
 
@@ -821,19 +822,19 @@ bool Locker::eval(CInode *in, int mask, bool caps_imported)
 
  retry:
   if (mask & CEPH_LOCK_IFILE)
-    eval_any(&in->filelock, &need_issue, caps_imported);
+    eval_any(&in->filelock, &need_issue, &finishers, caps_imported);
   if (mask & CEPH_LOCK_IAUTH)
-    eval_any(&in->authlock, &need_issue, caps_imported);
+    eval_any(&in->authlock, &need_issue, &finishers, caps_imported);
   if (mask & CEPH_LOCK_ILINK)
-    eval_any(&in->linklock, &need_issue,caps_imported);
+    eval_any(&in->linklock, &need_issue, &finishers, caps_imported);
   if (mask & CEPH_LOCK_IXATTR)
-    eval_any(&in->xattrlock, &need_issue, caps_imported);
+    eval_any(&in->xattrlock, &need_issue, &finishers, caps_imported);
   if (mask & CEPH_LOCK_INEST)
-    eval_any(&in->nestlock, &need_issue, caps_imported);
+    eval_any(&in->nestlock, &need_issue, &finishers, caps_imported);
   if (mask & CEPH_LOCK_IFLOCK)
-    eval_any(&in->flocklock, &need_issue, caps_imported);
+    eval_any(&in->flocklock, &need_issue, &finishers, caps_imported);
   if (mask & CEPH_LOCK_IPOLICY)
-    eval_any(&in->policylock, &need_issue, caps_imported);
+    eval_any(&in->policylock, &need_issue, &finishers, caps_imported);
 
   // drop loner?
   if (in->is_auth() && in->is_head() && in->get_wanted_loner() != in->get_loner()) {
@@ -854,6 +855,8 @@ bool Locker::eval(CInode *in, int mask, bool caps_imported)
     }
   }
 
+  finish_contexts(g_ceph_context, finishers);
+
   if (need_issue && in->is_head())
     issue_caps(in);
 
diff --git a/src/mds/Locker.h b/src/mds/Locker.h
index f005925..3f79996 100644
--- a/src/mds/Locker.h
+++ b/src/mds/Locker.h
@@ -99,9 +99,9 @@ public:
 
   void eval_gather(SimpleLock *lock, bool first=false, bool *need_issue=0, list<Context*> *pfinishers=0);
   void eval(SimpleLock *lock, bool *need_issue);
-  void eval_any(SimpleLock *lock, bool *need_issue, bool first=false) {
+  void eval_any(SimpleLock *lock, bool *need_issue, list<Context*> *pfinishers=0, bool first=false) {
     if (!lock->is_stable())
-      eval_gather(lock, first, need_issue);
+      eval_gather(lock, first, need_issue, pfinishers);
     else if (lock->get_parent()->is_auth())
       eval(lock, need_issue);
   }
-- 
1.7.11.7

