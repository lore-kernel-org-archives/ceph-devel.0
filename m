From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 04/14] mds: no bloom filter for replica dir
Date: Tue, 11 Dec 2012 16:30:50 +0800
Message-ID: <1355214660-26354-5-git-send-email-zheng.z.yan@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40747 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab2LKIbI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:31:08 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

We should delete dir fragment's bloom filter after exporting the dir
fragment to other MDS. Otherwise the residual bloom filter may cause
problem if the MDS imports dir fragment later.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc     | 9 +++++++--
 src/mds/CDir.h      | 1 +
 src/mds/MDCache.cc  | 5 ++++-
 src/mds/Migrator.cc | 2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 4b1d3ef..cbda038 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -632,6 +632,12 @@ bool CDir::is_in_bloom(const string& name)
   return bloom->contains(name.c_str(), name.size());
 }
 
+void CDir::remove_bloom()
+{
+  delete bloom;
+  bloom = NULL;
+}
+
 void CDir::remove_null_dentries() {
   dout(12) << "remove_null_dentries " << *this << dendl;
 
@@ -1287,8 +1293,7 @@ void CDir::log_mark_dirty()
 
 void CDir::mark_complete() {
   state_set(STATE_COMPLETE);
-  delete bloom;
-  bloom = NULL;
+  remove_bloom();
 }
 
 void CDir::first_get()
diff --git a/src/mds/CDir.h b/src/mds/CDir.h
index 2222418..91e53d2 100644
--- a/src/mds/CDir.h
+++ b/src/mds/CDir.h
@@ -349,6 +349,7 @@ protected:
   void add_to_bloom(CDentry *dn);
   bool is_in_bloom(const string& name);
   bool has_bloom() { return (bloom ? true : false); }
+  void remove_bloom();
 private:
   void link_inode_work( CDentry *dn, CInode *in );
   void unlink_inode_work( CDentry *dn );
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index c8055ea..7733d0d 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5524,7 +5524,8 @@ void MDCache::trim_dentry(CDentry *dn, map<int, MCacheExpire*>& expiremap)
   }
     
   // remove dentry
-  dir->add_to_bloom(dn);
+  if (dir->is_auth())
+    dir->add_to_bloom(dn);
   dir->remove_dentry(dn);
 
   if (clear_complete)
@@ -5718,6 +5719,7 @@ void MDCache::trim_non_auth()
 	assert(dnl->is_null());
       }
 
+      assert(!dir->has_bloom());
       dir->remove_dentry(dn);
       // adjust the dir state
       dir->state_clear(CDir::STATE_COMPLETE);  // dir incomplete!
@@ -5819,6 +5821,7 @@ bool MDCache::trim_non_auth_subtree(CDir *dir)
         dout(20) << "trim_non_auth_subtree(" << dir << ") removing inode " << in << " with dentry" << dn << dendl;
         dir->unlink_inode(dn);
         remove_inode(in);
+	assert(!dir->has_bloom());
         dir->remove_dentry(dn);
       } else {
         dout(20) << "trim_non_auth_subtree(" << dir << ") keeping inode " << in << " with dentry " << dn <<dendl;
diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
index a804eab..cc045b4 100644
--- a/src/mds/Migrator.cc
+++ b/src/mds/Migrator.cc
@@ -1196,6 +1196,7 @@ void Migrator::finish_export_dir(CDir *dir, list<Context*>& finished, utime_t no
   // mark
   assert(dir->is_auth());
   dir->state_clear(CDir::STATE_AUTH);
+  dir->remove_bloom();
   dir->replica_nonce = CDir::NONCE_EXPORT;
 
   if (dir->is_dirty())
@@ -2006,6 +2007,7 @@ void Migrator::import_reverse(CDir *dir)
     // dir
     assert(cur->is_auth());
     cur->state_clear(CDir::STATE_AUTH);
+    cur->remove_bloom();
     cur->clear_replica_map();
     if (cur->is_dirty())
       cur->mark_clean();
-- 
1.7.11.7

