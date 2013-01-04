From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 15/29] mds: remove unnecessary is_xlocked check
Date: Fri,  4 Jan 2013 17:02:06 +0800
Message-ID: <1357290140-17044-16-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:28255 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab3ADJCn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:43 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Locker::foo_eval() is always called for stable locks, so no need to
check if the lock is xlocked.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index e826321..ee2d4cc 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -3291,7 +3291,6 @@ void Locker::simple_eval(SimpleLock *lock, bool *need_issue)
 
   // stable -> sync?
   else if (lock->get_state() != LOCK_SYNC &&
-	   !lock->is_xlocked() &&
 	   !lock->is_wrlocked() &&
 	   ((!(wanted & CEPH_CAP_GEXCL) && !lock->is_waiter_for(SimpleLock::WAIT_WR)) ||
 	    (lock->get_state() == LOCK_EXCL && in && in->get_target_loner() < 0))) {
@@ -3334,8 +3333,6 @@ bool Locker::simple_sync(SimpleLock *lock, bool *need_issue)
     int gather = 0;
     if (lock->is_wrlocked())
       gather++;
-    if (lock->is_xlocked())
-      gather++;
     
     if (lock->get_parent()->is_replicated() && old_state == LOCK_MIX) {
       send_lock_message(lock, LOCK_AC_SYNC);
@@ -3412,9 +3409,7 @@ void Locker::simple_excl(SimpleLock *lock, bool *need_issue)
     gather++;
   if (lock->is_wrlocked())
     gather++;
-  if (lock->is_xlocked())
-    gather++;
-  
+
   if (lock->get_parent()->is_replicated() && 
       lock->get_state() != LOCK_LOCK_EXCL &&
       lock->get_state() != LOCK_XSYN_EXCL) {
@@ -3695,7 +3690,6 @@ void Locker::scatter_eval(ScatterLock *lock, bool *need_issue)
   }
   
   if (!lock->is_rdlocked() &&
-      !lock->is_xlocked() &&
       lock->get_state() != LOCK_MIX &&
       lock->get_scatter_wanted()) {
     dout(10) << "scatter_eval scatter_wanted, bump to mix " << *lock
@@ -3706,8 +3700,7 @@ void Locker::scatter_eval(ScatterLock *lock, bool *need_issue)
 
   if (lock->get_type() == CEPH_LOCK_INEST) {
     // in general, we want to keep INEST writable at all times.
-    if (!lock->is_rdlocked() &&
-	!lock->is_xlocked()) {
+    if (!lock->is_rdlocked()) {
       if (lock->get_parent()->is_replicated()) {
 	if (lock->get_state() != LOCK_MIX)
 	  scatter_mix(lock, need_issue);
@@ -3723,7 +3716,6 @@ void Locker::scatter_eval(ScatterLock *lock, bool *need_issue)
   if (!in->has_subtree_root_dirfrag() || in->is_base()) {
     // i _should_ be sync.
     if (!lock->is_wrlocked() &&
-	!lock->is_xlocked() &&
 	lock->get_state() != LOCK_SYNC) {
       dout(10) << "scatter_eval no wrlocks|xlocks, not subtree root inode, syncing" << dendl;
       simple_sync(lock, need_issue);
@@ -3909,8 +3901,6 @@ void Locker::scatter_tempsync(ScatterLock *lock, bool *need_issue)
   int gather = 0;
   if (lock->is_wrlocked())
     gather++;
-  if (lock->is_xlocked())
-    gather++;
 
   if (lock->get_cap_shift() &&
       in->is_head() &&
@@ -4044,8 +4034,7 @@ void Locker::file_eval(ScatterLock *lock, bool *need_issue)
   assert(lock->get_parent()->is_auth());
   assert(lock->is_stable());
 
-  if (lock->is_xlocked() || 
-      lock->get_parent()->is_freezing_or_frozen())
+  if (lock->get_parent()->is_freezing_or_frozen())
     return;
 
   // excl -> *?
@@ -4297,9 +4286,7 @@ void Locker::file_xsyn(SimpleLock *lock, bool *need_issue)
   int gather = 0;
   if (lock->is_wrlocked())
     gather++;
-  if (lock->is_xlocked())
-    gather++;
-  
+
   if (in->is_head() &&
       in->issued_caps_need_gather(lock)) {
     if (need_issue)
-- 
1.7.11.7

