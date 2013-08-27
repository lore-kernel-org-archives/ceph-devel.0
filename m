From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 2/2] ceph: fscache cleanup
Date: Tue, 27 Aug 2013 19:09:08 -0400
Message-ID: <4c6eda1e6521faf5357383c682beb83f464cef74.1377644443.git.milosz@adfin.com>
References: <cover.1377644443.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:41114 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab3H0XJE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Aug 2013 19:09:04 -0400
Received: by mail-qe0-f48.google.com with SMTP id 1so3010334qec.35
        for <ceph-devel@vger.kernel.org>; Tue, 27 Aug 2013 16:09:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1377644443.git.milosz@adfin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, zheng.z.yan@intel.com

Remove all ifdefs from ceph c source files and push that code into both
cache.[ch] files.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/cache.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 fs/ceph/cache.h | 68 +++++++++++++++++++------------------------
 fs/ceph/inode.c | 61 +-------------------------------------
 fs/ceph/super.c | 23 ++++-----------
 fs/ceph/super.h |  1 -
 5 files changed, 115 insertions(+), 128 deletions(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index a5ad9c3..607fba2 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -54,17 +54,22 @@ static const struct fscache_cookie_def ceph_fscache_fsid_object_def = {
 	.get_key	= ceph_fscache_session_get_key,
 };
 
-void ceph_fscache_register_fsid_cookie(struct ceph_fs_client* fsc)
+int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
 {
 	fsc->fscache = fscache_acquire_cookie(ceph_cache_netfs.primary_index,
 					      &ceph_fscache_fsid_object_def,
 					      fsc);
-}
 
-void ceph_fscache_unregister_fsid_cookie(struct ceph_fs_client* fsc)
-{
-	fscache_relinquish_cookie(fsc->fscache, 0);
-	fsc->fscache = NULL;
+	if (fsc->fscache == NULL) {
+		pr_err("Unable to resgister fsid: %p fscache cookie", fsc);
+		return 0;
+	}
+
+	fsc->revalidate_wq = alloc_workqueue("ceph-revalidate", 0, 1);
+	if (fsc->revalidate_wq == NULL)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static uint16_t ceph_fscache_inode_get_key(const void *cookie_netfs_data,
@@ -234,7 +239,7 @@ static inline int cache_valid(struct ceph_inode_info *ci)
  * This function is called from the readpage_nounlock context. DO NOT attempt to
  * unlock the page here (or in the callback).
  */
-int __ceph_readpage_from_fscache(struct inode *inode, struct page *page)
+int ceph_readpage_from_fscache(struct inode *inode, struct page *page)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int ret;
@@ -260,7 +265,7 @@ int __ceph_readpage_from_fscache(struct inode *inode, struct page *page)
 	}
 }
 
-int __ceph_readpages_from_fscache(struct inode *inode,
+int ceph_readpages_from_fscache(struct inode *inode,
 				  struct address_space *mapping,
 				  struct list_head *pages,
 				  unsigned *nr_pages)
@@ -289,7 +294,7 @@ int __ceph_readpages_from_fscache(struct inode *inode,
 	}
 }
 
-void __ceph_readpage_to_fscache(struct inode *inode, struct page *page)
+void ceph_readpage_to_fscache(struct inode *inode, struct page *page)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int ret;
@@ -302,10 +307,75 @@ void __ceph_readpage_to_fscache(struct inode *inode, struct page *page)
 		 fscache_uncache_page(ci->fscache, page);
 }
 
-void __ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
+void ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	fscache_wait_on_page_write(ci->fscache, page);
 	fscache_uncache_page(ci->fscache, page);
 }
+
+void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
+{
+	if (fsc->revalidate_wq)
+		destroy_workqueue(fsc->revalidate_wq);
+
+	fscache_relinquish_cookie(fsc->fscache, 0);
+	fsc->fscache = NULL;
+}
+
+static void ceph_revalidate_work(struct work_struct *work)
+{
+	int issued;
+	u32 orig_gen;
+	struct ceph_inode_info *ci = container_of(work, struct ceph_inode_info,
+						  i_revalidate_work);
+	struct inode *inode = &ci->vfs_inode;
+
+	spin_lock(&ci->i_ceph_lock);
+	issued = __ceph_caps_issued(ci, NULL);
+	orig_gen = ci->i_rdcache_gen;
+	spin_unlock(&ci->i_ceph_lock);
+
+	if (!(issued & CEPH_CAP_FILE_CACHE)) {
+		dout("revalidate_work lost cache before validation %p\n",
+		     inode);
+		goto out;
+	}
+
+	if (!fscache_check_consistency(ci->fscache))
+		fscache_invalidate(ci->fscache);
+
+	spin_lock(&ci->i_ceph_lock);
+	/* Update the new valid generation (backwards sanity check too) */
+	if (orig_gen > ci->i_fscache_gen) {
+		ci->i_fscache_gen = orig_gen;
+	}
+	spin_unlock(&ci->i_ceph_lock);
+
+out:
+	iput(&ci->vfs_inode);
+}
+
+void ceph_queue_revalidate(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	ihold(inode);
+
+	if (queue_work(ceph_sb_to_client(inode->i_sb)->revalidate_wq,
+		       &ci->i_revalidate_work)) {
+		dout("ceph_queue_revalidate %p\n", inode);
+	} else {
+		dout("ceph_queue_revalidate %p failed\n)", inode);
+		iput(inode);
+	}
+}
+
+void ceph_fscache_inode_init(struct ceph_inode_info *ci)
+{
+	ci->fscache = NULL;
+	/* The first load is verifed cookie open time */
+	ci->i_fscache_gen = 1;
+	INIT_WORK(&ci->i_revalidate_work, ceph_revalidate_work);
+}
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index 7d6041b..385608f 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -29,56 +29,30 @@
 
 extern struct fscache_netfs ceph_cache_netfs;
 
-
-void ceph_fscache_register_fsid_cookie(struct ceph_fs_client* fsc);
-void ceph_fscache_unregister_fsid_cookie(struct ceph_fs_client* fsc);
-
-int __ceph_readpage_from_fscache(struct inode *inode, struct page *page);
-int __ceph_readpages_from_fscache(struct inode *inode,
-				  struct address_space *mapping,
-				  struct list_head *pages,
-				  unsigned *nr_pages);
-void __ceph_readpage_to_fscache(struct inode *inode, struct page *page);
-void __ceph_invalidate_fscache_page(struct inode* inode, struct page *page);
-
 #ifdef CONFIG_CEPH_FSCACHE
 
-void ceph_fscache_register_inode_cookie(struct ceph_fs_client* parent_fsc,
+int ceph_fscache_register_fs(struct ceph_fs_client* fsc);
+void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc);
+
+void ceph_fscache_inode_init(struct ceph_inode_info *ci);
+void ceph_fscache_register_inode_cookie(struct ceph_fs_client* fsc,
 					struct ceph_inode_info* ci);
 void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci);
 
-static inline int ceph_readpage_from_fscache(struct inode* inode,
-					     struct page *page)
-{
-	return __ceph_readpage_from_fscache(inode, page);
-}
-
-static inline int ceph_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	return __ceph_readpages_from_fscache(inode, mapping, pages,
-					     nr_pages);
-}
-
-static inline void ceph_readpage_to_fscache(struct inode *inode,
-					    struct page *page)
-{
-	return __ceph_readpage_to_fscache(inode, page);
-}
+int ceph_readpage_from_fscache(struct inode *inode, struct page *page);
+int ceph_readpages_from_fscache(struct inode *inode,
+				struct address_space *mapping,
+				struct list_head *pages,
+				unsigned *nr_pages);
+void ceph_readpage_to_fscache(struct inode *inode, struct page *page);
+void ceph_invalidate_fscache_page(struct inode* inode, struct page *page);
+void ceph_queue_revalidate(struct inode *inode);
 
 static inline void ceph_fscache_invalidate(struct inode *inode)
 {
 	fscache_invalidate(ceph_inode(inode)->fscache);
 }
 
-static inline void ceph_invalidate_fscache_page(struct inode *inode,
-						struct page *page)
-{
-	return __ceph_invalidate_fscache_page(inode, page);
-}
-
 static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
 {
 	struct inode* inode = page->mapping->host;
@@ -95,6 +69,19 @@ static inline void ceph_fscache_readpages_cancel(struct inode *inode,
 
 #else
 
+static inline int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
+{
+	return 0;
+}
+
+static inline void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc)
+{
+}
+
+static inline void ceph_fscache_inode_init(struct ceph_inode_info *ci)
+{
+}
+
 static inline void ceph_fscache_register_inode_cookie(struct ceph_fs_client* parent_fsc,
 						      struct ceph_inode_info* ci)
 {
@@ -140,7 +127,10 @@ static inline int ceph_release_fscache_page(struct page *page, gfp_t gfp)
 static inline void ceph_fscache_readpages_cancel(struct inode *inode,
 						 struct list_head *pages)
 {
+}
 
+static inline void ceph_queue_revalidate(struct inode *inode)
+{
 }
 
 #endif
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index a091785..eae41cd 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -387,12 +387,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	INIT_WORK(&ci->i_vmtruncate_work, ceph_vmtruncate_work);
 
-#ifdef CONFIG_CEPH_FSCACHE
-	ci->fscache = NULL;
-	/* The first load is verifed cookie open time */
-	ci->i_fscache_gen = 1;
-	INIT_WORK(&ci->i_revalidate_work, ceph_revalidate_work);
-#endif
+	ceph_fscache_inode_init(ci);
 
 	return &ci->vfs_inode;
 }
@@ -1579,60 +1574,6 @@ retry:
 	wake_up_all(&ci->i_cap_wq);
 }
 
-#ifdef CONFIG_CEPH_FSCACHE
-static void ceph_revalidate_work(struct work_struct *work)
-{
-	int issued;
-	u32 orig_gen;
-	struct ceph_inode_info *ci = container_of(work, struct ceph_inode_info,
-						  i_revalidate_work);
-	struct inode *inode = &ci->vfs_inode;
-
-	spin_lock(&ci->i_ceph_lock);
-	issued = __ceph_caps_issued(ci, NULL);
-	orig_gen = ci->i_rdcache_gen;
-	spin_unlock(&ci->i_ceph_lock);
-
-	if (!(issued & CEPH_CAP_FILE_CACHE)) {
-		dout("revalidate_work lost cache before validation %p\n",
-		     inode);
-		goto out;
-	}
-
-	if (!fscache_check_consistency(ci->fscache))
-		fscache_invalidate(ci->fscache);
-
-	spin_lock(&ci->i_ceph_lock);
-	/* Update the new valid generation (backwards sanity check too) */
-	if (orig_gen > ci->i_fscache_gen) {
-		ci->i_fscache_gen = orig_gen;
-	}
-	spin_unlock(&ci->i_ceph_lock);
-
-out:
-	iput(&ci->vfs_inode);
-}
-
-void ceph_queue_revalidate(struct inode *inode)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-
-	ihold(inode);
-
-	if (queue_work(ceph_sb_to_client(inode->i_sb)->revalidate_wq,
-		       &ci->i_revalidate_work)) {
-		dout("ceph_queue_revalidate %p\n", inode);
-	} else {
-		dout("ceph_queue_revalidate %p failed\n)", inode);
-		iput(inode);
-	}
-}
-#else
-void ceph_queue_revalidate(struct inode *inode)
-{
-}
-#endif
-
 /*
  * symlinks
  */
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a14b13a..0c3ab18 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -545,24 +545,18 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	if (!fsc->wb_pagevec_pool)
 		goto fail_trunc_wq;
 
-#ifdef CONFIG_CEPH_FSCACHE
-	if ((fsopt->flags & CEPH_MOUNT_OPT_FSCACHE))
-		ceph_fscache_register_fsid_cookie(fsc);
-
-	fsc->revalidate_wq = alloc_workqueue("ceph-revalidate", 0, 1);
-	if (fsc->revalidate_wq == NULL)
+	/* setup fscache */
+	if ((fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) &&
+	    (ceph_fscache_register_fs(fsc) != 0))
 		goto fail_fscache;
-#endif
 
 	/* caps */
 	fsc->min_caps = fsopt->max_readdir;
 
 	return fsc;
 
-#ifdef CONFIG_CEPH_FSCACHE
 fail_fscache:
-	ceph_fscache_unregister_fsid_cookie(fsc);
-#endif
+	ceph_fscache_unregister_fs(fsc);
 fail_trunc_wq:
 	destroy_workqueue(fsc->trunc_wq);
 fail_pg_inv_wq:
@@ -582,10 +576,7 @@ static void destroy_fs_client(struct ceph_fs_client *fsc)
 {
 	dout("destroy_fs_client %p\n", fsc);
 
-#ifdef CONFIG_CEPH_FSCACHE
-	ceph_fscache_unregister_fsid_cookie(fsc);
-	destroy_workqueue(fsc->revalidate_wq);
-#endif
+	ceph_fscache_unregister_fs(fsc);
 
 	destroy_workqueue(fsc->wb_wq);
 	destroy_workqueue(fsc->pg_inv_wq);
@@ -646,10 +637,8 @@ static int __init init_caches(void)
 	if (ceph_file_cachep == NULL)
 		goto bad_file;
 
-#ifdef CONFIG_CEPH_FSCACHE
 	if ((error = fscache_register_netfs(&ceph_cache_netfs)))
 		goto bad_file;
-#endif
 
 	return 0;
 bad_file:
@@ -674,9 +663,7 @@ static void destroy_caches(void)
 	kmem_cache_destroy(ceph_dentry_cachep);
 	kmem_cache_destroy(ceph_file_cachep);
 
-#ifdef CONFIG_CEPH_FSCACHE
 	fscache_unregister_netfs(&ceph_cache_netfs);
-#endif
 }
 
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 72eac24..bb23ef6 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -716,7 +716,6 @@ extern void ceph_queue_vmtruncate(struct inode *inode);
 
 extern void ceph_queue_invalidate(struct inode *inode);
 extern void ceph_queue_writeback(struct inode *inode);
-extern void ceph_queue_revalidate(struct inode *inode);
 
 extern int ceph_do_getattr(struct inode *inode, int mask);
 extern int ceph_permission(struct inode *inode, int mask);
-- 
1.8.1.2

