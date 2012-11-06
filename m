From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 1/2] mds: Don't acquire replica object's versionlock
Date: Tue, 06 Nov 2012 16:22:10 +0800
Message-ID: <5098C8B2.5060404@intel.com>
References: <1351760618-19874-1-git-send-email-zheng.z.yan@intel.com> <1351760618-19874-2-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1211051048520.30301@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17412 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421Ab2KFIWN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 6 Nov 2012 03:22:13 -0500
In-Reply-To: <alpine.DEB.2.00.1211051048520.30301@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11/06/2012 02:52 AM, Sage Weil wrote:
> On Thu, 1 Nov 2012, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> Both CInode and CDentry's versionlocks are of type LocalLock.
>> Acquiring LocalLock in replica object is useless and problematic.
>> For example, if two requests try acquiring a replica object's
>> versionlock, the first request succeeds, the second request
>> is added to wait queue. Later when the first request finishes,
>> MDCache::request_drop_foreign_locks() finds the lock's parent is
>> non-auth, it skips waking requests in the wait queue. So the
>> second request hangs.
> 
> I don't remmeber the details, but the iversion locking on replicas came up 
> while testing renaming and export thrashing.  i.e., running with
> 
> 	mds thrash exports = 1
> 
> and doing some rename workload (fsstress maybe?). 

I saw assertion in Server::handle_slave_rename_prep() was triggered when I applied
a wrong fix. but never see it again with this patch. 

> 
> Maybe the fix is just to wake the requests in the queue?
> 

If I'm not wrong the version locks are used to wait for all rename operation on
the paths to srcdn/destdn to complete. So witness see consistent paths for srcdn
and destdn no matter how many times the OP_RENAMEPREP slave request is dispatched.
I think the main reason we need version lock is that: For an auth dentry, we may
rdlock it even it is already xlocked. But for non-auth dentry, we only can rdlock
it when the lock is sync state, it guarantees the dentry is not xlocked.

I find a bug in previous patch. 'assert(dn->is_auth())' in Locker::acquire_locks
should be if '(!dn->is_auth()) continue'.

Regards
Yan, Zheng

---
From 6683482d9f9517b990d3e4bae18af275f32491e4 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Thu, 1 Nov 2012 13:21:21 +0800
Subject: [PATCH] mds: Don't acquire replica object's versionlock

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
index 7b6d449..a1f957a 100644
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
@@ -3899,6 +3903,7 @@ void Locker::local_wrlock_grab(LocalLock *lock, Mutation *mut)
   dout(7) << "local_wrlock_grab  on " << *lock
 	  << " on " << *lock->get_parent() << dendl;  
   
+  assert(lock->get_parent()->is_auth());
   assert(lock->can_wrlock());
   assert(!mut->wrlocks.count(lock));
   lock->get_wrlock(mut->get_client());
@@ -3911,6 +3916,7 @@ bool Locker::local_wrlock_start(LocalLock *lock, MDRequest *mut)
   dout(7) << "local_wrlock_start  on " << *lock
 	  << " on " << *lock->get_parent() << dendl;  
   
+  assert(lock->get_parent()->is_auth());
   if (lock->can_wrlock()) {
     assert(!mut->wrlocks.count(lock));
     lock->get_wrlock(mut->get_client());
@@ -3942,6 +3948,7 @@ bool Locker::local_xlock_start(LocalLock *lock, MDRequest *mut)
   dout(7) << "local_xlock_start  on " << *lock
 	  << " on " << *lock->get_parent() << dendl;  
   
+  assert(lock->get_parent()->is_auth());
   if (!lock->can_xlock_local()) {
     lock->add_waiter(SimpleLock::WAIT_WR|SimpleLock::WAIT_STABLE, new C_MDS_RetryRequest(mdcache, mut));
     return false;
diff --git a/src/mds/Server.cc b/src/mds/Server.cc
index 4642a13..45c890a 100644
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
+    // take xlock on all projected dentries for srcdn and destdn.  this ensures
+    // that the srcdn and destdn can be traversed to by the witnesses.
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

