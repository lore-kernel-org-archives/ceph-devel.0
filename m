From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 05/16] mds: Don't acquire replica object's versionlock
Date: Mon, 19 Nov 2012 10:43:37 +0800
Message-ID: <1353293028-15238-6-git-send-email-zheng.z.yan@intel.com>
References: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17039 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab2KSCn6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:43:58 -0500
In-Reply-To: <1353293028-15238-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Both CInode and CDentry's versionlocks are of type LocalLock.
Acquiring LocalLock in replica object is useless and problematic.
For example, if two requests try acquiring a replica object's
versionlock, the first request succeeds, the second request
is added to wait queue. Later when the first request finishes,
MDCache::request_drop_foreign_locks() finds the lock's parent is
non-auth, it skips waking requests in the wait queue. So the
second request hangs.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/Locker.cc |  7 +++++++
 src/mds/Server.cc | 25 ++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index 7d55940..b67b3ee 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -196,6 +196,8 @@ bool Locker::acquire_locks(MDRequest *mdr,
     // augment xlock with a versionlock?
     if ((*p)->get_type() == CEPH_LOCK_DN) {
       CDentry *dn = (CDentry*)(*p)->get_parent();
+      if (!dn->is_auth())
+	continue;
 
       if (xlocks.count(&dn->versionlock))
 	continue;  // we're xlocking the versionlock too; don't wrlock it!
@@ -213,6 +215,8 @@ bool Locker::acquire_locks(MDRequest *mdr,
     if ((*p)->get_type() > CEPH_LOCK_IVERSION) {
       // inode version lock?
       CInode *in = (CInode*)(*p)->get_parent();
+      if (!in->is_auth())
+	continue;
       if (mdr->is_master()) {
 	// master.  wrlock versionlock so we can pipeline inode updates to journal.
 	wrlocks.insert(&in->versionlock);
@@ -3920,6 +3924,7 @@ void Locker::local_wrlock_grab(LocalLock *lock, Mutation *mut)
   dout(7) << "local_wrlock_grab  on " << *lock
 	  << " on " << *lock->get_parent() << dendl;  
   
+  assert(lock->get_parent()->is_auth());
   assert(lock->can_wrlock());
   assert(!mut->wrlocks.count(lock));
   lock->get_wrlock(mut->get_client());
@@ -3932,6 +3937,7 @@ bool Locker::local_wrlock_start(LocalLock *lock, MDRequest *mut)
   dout(7) << "local_wrlock_start  on " << *lock
 	  << " on " << *lock->get_parent() << dendl;  
   
+  assert(lock->get_parent()->is_auth());
   if (lock->can_wrlock()) {
     assert(!mut->wrlocks.count(lock));
     lock->get_wrlock(mut->get_client());
@@ -3963,6 +3969,7 @@ bool Locker::local_xlock_start(LocalLock *lock, MDRequest *mut)
   dout(7) << "local_xlock_start  on " << *lock
 	  << " on " << *lock->get_parent() << dendl;  
   
+  assert(lock->get_parent()->is_auth());
   if (!lock->can_xlock_local()) {
     lock->add_waiter(SimpleLock::WAIT_WR|SimpleLock::WAIT_STABLE, new C_MDS_RetryRequest(mdcache, mut));
     return false;
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 4642a13..f8d6666 100644
--- a/src/mds/Server.cc
+++ b/src/mds/Server.cc
@@ -5204,25 +5204,20 @@ void Server::handle_client_rename(MDRequest *mdr)
     wrlocks.insert(&straydn->get_dir()->inode->nestlock);
   }
 
-  // xlock versionlock on srci if remote?
-  //  this ensures it gets safely remotely auth_pinned, avoiding deadlock;
-  //  strictly speaking, having the slave node freeze the inode is 
-  //  otherwise sufficient for avoiding conflicts with inode locks, etc.
-  if (!srcdn->is_auth() && srcdnl->is_primary())  // xlock versionlock on srci if there are any witnesses
-    xlocks.insert(&srci->versionlock);
-
   // xlock versionlock on dentries if there are witnesses.
   //  replicas can't see projected dentry linkages, and will get
   //  confused if we try to pipeline things.
   if (!witnesses.empty()) {
-    if (srcdn->is_projected())
-      xlocks.insert(&srcdn->versionlock);
-    if (destdn->is_projected())
-      xlocks.insert(&destdn->versionlock);
-    // also take rdlock on all ancestor dentries for destdn.  this ensures that the
-    // destdn can be traversed to by the witnesses.
-    for (int i=0; i<(int)desttrace.size(); i++) 
-      xlocks.insert(&desttrace[i]->versionlock);
+    // take xlock on all projected ancestor dentries for srcdn and destdn.
+    // this ensures the srcdn and destdn can be traversed to by the witnesses.
+    for (int i= 0; i<(int)srctrace.size(); i++) {
+      if (srctrace[i]->is_auth() && srctrace[i]->is_projected())
+	  xlocks.insert(&srctrace[i]->versionlock);
+    }
+    for (int i=0; i<(int)desttrace.size(); i++) {
+      if (desttrace[i]->is_auth() && desttrace[i]->is_projected())
+	  xlocks.insert(&desttrace[i]->versionlock);
+    }
   }
 
   // we need to update srci's ctime.  xlock its least contended lock to do that...
-- 
1.7.11.7

