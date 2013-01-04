From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 21/29] mds: keep dentry lock in sync state as much as possible
Date: Fri,  4 Jan 2013 17:02:12 +0800
Message-ID: <1357290140-17044-22-git-send-email-zheng.z.yan@intel.com>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:57521 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859Ab3ADJCu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 04:02:50 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Unlike locks of other types, dentry lock in unreadable state can block path
traverse, so it should be in sync state as much as possible. there are two
rare cases that dentry lock is not set to sync state: the dentry becomes
replicated; finishing xlock but the dentry is freezing.

In commit efbca31d, I tried fixing the issue that unreadable replica dentry
blocks path traverse by modifying MDCache::path_traverse(), but it does not
work. This patch also reverts that change.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDentry.h   | 3 +++
 src/mds/Locker.cc   | 5 ++++-
 src/mds/MDCache.cc  | 6 +-----
 src/mds/Migrator.cc | 3 +++
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/mds/CDentry.h b/src/mds/CDentry.h
index 480e562..aa10bf9 100644
--- a/src/mds/CDentry.h
+++ b/src/mds/CDentry.h
@@ -301,6 +301,9 @@ public:
   
   // -- replication
   void encode_replica(int mds, bufferlist& bl) {
+    if (!is_replicated())
+      lock.replicate_relax();
+
     __u32 nonce = add_replica(mds);
     ::encode(nonce, bl);
     ::encode(first, bl);
diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index cba894b..9b3bfe3 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -1425,13 +1425,16 @@ bool Locker::xlock_start(SimpleLock *lock, MDRequest *mut)
 void Locker::_finish_xlock(SimpleLock *lock, bool *pneed_issue)
 {
   assert(!lock->is_stable());
-  lock->get_parent()->auth_unpin(lock);
   if (lock->get_type() != CEPH_LOCK_DN && ((CInode*)lock->get_parent())->get_loner() >= 0)
     lock->set_state(LOCK_EXCL);
   else
     lock->set_state(LOCK_LOCK);
+  if (lock->get_type() == CEPH_LOCK_DN && lock->get_parent()->is_replicated() &&
+      !lock->is_waiter_for(SimpleLock::WAIT_WR))
+    simple_sync(lock, pneed_issue);
   if (lock->get_cap_shift())
     *pneed_issue = true;
+  lock->get_parent()->auth_unpin(lock);
 }
 
 void Locker::xlock_finish(SimpleLock *lock, Mutation *mut, bool *pneed_issue)
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 5adf4b7..236a0b9 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -6735,14 +6735,10 @@ int MDCache::path_traverse(MDRequest *mdr, Message *req, Context *fin,     // wh
 	  (dn->lock.is_xlocked() && dn->lock.get_xlock_by() == mdr)) {
         dout(10) << "traverse: miss on null+readable dentry " << path[depth] << " " << *dn << dendl;
         return -ENOENT;
-      } else if (curdir->is_auth()) {
+      } else {
         dout(10) << "miss on dentry " << *dn << ", can't read due to lock" << dendl;
         dn->lock.add_waiter(SimpleLock::WAIT_RD, _get_waiter(mdr, req, fin));
         return 1;
-      } else {
-	// non-auth and can not read, treat this as no dentry
-	dn = NULL;
-	dnl = NULL;
       }
     }
 
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index 8686c86..bda8035 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1135,6 +1135,9 @@ int Migrator::encode_export_dir(bufferlist& exportbl,
     CDentry *dn = it->second;
     CInode *in = dn->get_linkage()->get_inode();
     
+    if (!dn->is_replicated())
+      dn->lock.replicate_relax();
+
     num_exported++;
     
     // -- dentry
-- 
1.7.11.7

