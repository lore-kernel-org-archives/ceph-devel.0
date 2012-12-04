From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 1/2] mds: don't create bloom filter for incomplete dir
Date: Tue,  4 Dec 2012 16:09:47 +0800
Message-ID: <1354608588-25840-2-git-send-email-zheng.z.yan@intel.com>
References: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5684 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438Ab2LDIJv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Dec 2012 03:09:51 -0500
In-Reply-To: <1354608588-25840-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Creating bloom filter for incomplete dir that was added by log
replay will confuse subsequent dir lookup and can create null
dentry for existing file. The erroneous null dentry confuses the
fragstat accounting and causes undeletable empty directory.

The fix is check if the dir is complete before creating the bloom
filter. For the MDCache::trim_non_auth{,_subtree} cases, just do
not call CDir::add_to_bloom because bloom filter is useless for
replica.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 src/mds/CDir.cc    |  6 +++++-
 src/mds/MDCache.cc | 12 +++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index c5220ed..835a0e9 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -615,8 +615,12 @@ void CDir::unlink_inode_work( CDentry *dn )
 
 void CDir::add_to_bloom(CDentry *dn)
 {
-  if (!bloom)
+  if (!bloom) {
+    /* not create bloom filter for incomplete dir that was added by log replay */
+    if (!is_complete())
+      return;
     bloom = new bloom_filter(100, 0.05, 0);
+  }
   /* This size and false positive probability is completely random.*/
   bloom->insert(dn->name.c_str(), dn->name.size());
 }
diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 7152b5e..fcc1ecd 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -5498,9 +5498,10 @@ void MDCache::trim_dentry(CDentry *dn, map<int, MCacheExpire*>& expiremap)
   // adjust the dir state
   // NOTE: we can safely remove a clean, null dentry without effecting
   //       directory completeness.
-  // (do this _before_ we unlink the inode, below!)
+  // (check this _before_ we unlink the inode, below!)
+  bool clear_complete = false;
   if (!(dnl->is_null() && dn->is_clean())) 
-    dir->state_clear(CDir::STATE_COMPLETE); 
+    clear_complete = true;
   
   // unlink the dentry
   if (dnl->is_remote()) {
@@ -5520,6 +5521,9 @@ void MDCache::trim_dentry(CDentry *dn, map<int, MCacheExpire*>& expiremap)
   // remove dentry
   dir->add_to_bloom(dn);
   dir->remove_dentry(dn);
+
+  if (clear_complete)
+    dir->state_clear(CDir::STATE_COMPLETE);
   
   // reexport?
   if (dir->get_num_head_items() == 0 && dir->is_subtree_root())
@@ -5708,9 +5712,8 @@ void MDCache::trim_non_auth()
       else {
 	assert(dnl->is_null());
       }
-      dir->add_to_bloom(dn);
+
       dir->remove_dentry(dn);
-      
       // adjust the dir state
       dir->state_clear(CDir::STATE_COMPLETE);  // dir incomplete!
     }
@@ -5811,7 +5814,6 @@ bool MDCache::trim_non_auth_subtree(CDir *dir)
         dout(20) << "trim_non_auth_subtree(" << dir << ") removing inode " << in << " with dentry" << dn << dendl;
         dir->unlink_inode(dn);
         remove_inode(in);
-        dir->add_to_bloom(dn);
         dir->remove_dentry(dn);
       } else {
         dout(20) << "trim_non_auth_subtree(" << dir << ") keeping inode " << in << " with dentry " << dn <<dendl;
-- 
1.7.11.7

