From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/3] ceph: track read contexts in ceph_file_info
Date: Fri, 15 Dec 2017 17:24:19 +0800
Message-ID: <20171215092420.7950-2-zyan@redhat.com>
References: <20171215092420.7950-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755168AbdLOJYc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 15 Dec 2017 04:24:32 -0500
In-Reply-To: <20171215092420.7950-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Previously ceph_read_iter() uses current->journal to pass context info
to ceph_readpages(), so that ceph_readpages() can distinguish read(2)
from readahead(2)/fadvise(2)/madvise(2). The problem is that page fault
can happen when copying data to userspace memory. Page fault may call
other filesystem's page_mkwrite() if the userspace memory is mapped to a
file. The later filesystem may also want to use current->journal.

The fix is define a on-stack data structure in ceph_read_iter(), add it
to context list in ceph_file_info. ceph_readpages() searchs the list,
find if there is a context belongs to current thread.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c  | 15 ++++++++++-----
 fs/ceph/file.c  | 10 ++++++++--
 fs/ceph/super.h | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6f7f00a35190..78a1208b878e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -299,7 +299,8 @@ static void finish_read(struct ceph_osd_request *req)
  * start an async read(ahead) operation.  return nr_pages we submitted
  * a read for on success, or negative error code.
  */
-static int start_read(struct inode *inode, struct list_head *page_list, int max)
+static int start_read(struct inode *inode, struct ceph_rw_context *rw_ctx,
+		      struct list_head *page_list, int max)
 {
 	struct ceph_osd_client *osdc =
 		&ceph_inode_to_client(inode)->client->osdc;
@@ -316,7 +317,7 @@ static int start_read(struct inode *inode, struct list_head *page_list, int max)
 	int got = 0;
 	int ret = 0;
 
-	if (!current->journal_info) {
+	if (!rw_ctx) {
 		/* caller of readpages does not hold buffer and read caps
 		 * (fadvise, madvise and readahead cases) */
 		int want = CEPH_CAP_FILE_CACHE;
@@ -437,6 +438,8 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = file_inode(file);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_file_info *ci = file->private_data;
+	struct ceph_rw_context *rw_ctx;
 	int rc = 0;
 	int max = 0;
 
@@ -449,11 +452,12 @@ static int ceph_readpages(struct file *file, struct address_space *mapping,
 	if (rc == 0)
 		goto out;
 
+	rw_ctx = ceph_find_rw_context(ci);
 	max = fsc->mount_options->rsize >> PAGE_SHIFT;
 	dout("readpages %p file %p ctx %p nr_pages %d max %d\n",
 	     inode, file, rw_ctx, nr_pages, max);
 	while (!list_empty(page_list)) {
-		rc = start_read(inode, page_list, max);
+		rc = start_read(inode, rw_ctx, page_list, max);
 		if (rc < 0)
 			goto out;
 	}
@@ -1450,9 +1454,10 @@ static int ceph_filemap_fault(struct vm_fault *vmf)
 
 	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) ||
 	    ci->i_inline_version == CEPH_INLINE_NONE) {
-		current->journal_info = vma->vm_file;
+		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
+		ceph_add_rw_context(fi, &rw_ctx);
 		ret = filemap_fault(vmf);
-		current->journal_info = NULL;
+		ceph_del_rw_context(fi, &rw_ctx);
 	} else
 		ret = -EAGAIN;
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 14b26c2537a9..3c8b5ec4991a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -115,6 +115,10 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 			return -ENOMEM;
 		}
 		cf->fmode = fmode;
+
+		spin_lock_init(&cf->rw_contexts_lock);
+		INIT_LIST_HEAD(&cf->rw_contexts);
+
 		cf->next_offset = 2;
 		cf->readdir_cache_idx = -1;
 		file->private_data = cf;
@@ -398,6 +402,7 @@ int ceph_release(struct inode *inode, struct file *file)
 		ceph_mdsc_put_request(cf->last_readdir);
 	kfree(cf->last_name);
 	kfree(cf->dir_info);
+	WARN_ON(!list_empty(&cf->rw_contexts));
 	kmem_cache_free(ceph_file_cachep, cf);
 
 	/* wake up anyone waiting for caps on this inode */
@@ -1133,12 +1138,13 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			retry_op = READ_INLINE;
 		}
 	} else {
+		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
 		dout("aio_read %p %llx.%llx %llu~%u got cap refs on %s\n",
 		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
 		     ceph_cap_string(got));
-		current->journal_info = filp;
+		ceph_add_rw_context(fi, &rw_ctx);
 		ret = generic_file_read_iter(iocb, to);
-		current->journal_info = NULL;
+		ceph_del_rw_context(fi, &rw_ctx);
 	}
 	dout("aio_read %p %llx.%llx dropping cap refs on %s = %d\n",
 	     inode, ceph_vinop(inode), ceph_cap_string(got), (int)ret);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 453edca41a37..5e134bc69d96 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -672,6 +672,9 @@ struct ceph_file_info {
 	short fmode;     /* initialized on open */
 	short flags;     /* CEPH_F_* */
 
+	spinlock_t rw_contexts_lock;
+	struct list_head rw_contexts;
+
 	/* readdir: position within the dir */
 	u32 frag;
 	struct ceph_mds_request *last_readdir;
@@ -688,6 +691,49 @@ struct ceph_file_info {
 	int dir_info_len;
 };
 
+struct ceph_rw_context {
+	struct list_head list;
+	struct task_struct *thread;
+	int caps;
+};
+
+#define CEPH_DEFINE_RW_CONTEXT(_name, _caps)	\
+	struct ceph_rw_context _name = {	\
+		.thread = current,		\
+		.caps = _caps,			\
+	}
+
+static inline void ceph_add_rw_context(struct ceph_file_info *cf,
+				       struct ceph_rw_context *ctx)
+{
+	spin_lock(&cf->rw_contexts_lock);
+	list_add(&ctx->list, &cf->rw_contexts);
+	spin_unlock(&cf->rw_contexts_lock);
+}
+
+static inline void ceph_del_rw_context(struct ceph_file_info *cf,
+				       struct ceph_rw_context *ctx)
+{
+	spin_lock(&cf->rw_contexts_lock);
+	list_del(&ctx->list);
+	spin_unlock(&cf->rw_contexts_lock);
+}
+
+static inline struct ceph_rw_context*
+ceph_find_rw_context(struct ceph_file_info *cf)
+{
+	struct ceph_rw_context *ctx, *found = NULL;
+	spin_lock(&cf->rw_contexts_lock);
+	list_for_each_entry(ctx, &cf->rw_contexts, list) {
+		if (ctx->thread == current) {
+			found = ctx;
+			break;
+		}
+	}
+	spin_unlock(&cf->rw_contexts_lock);
+	return found;
+}
+
 struct ceph_readdir_cache_control {
 	struct page  *page;
 	struct dentry **dentries;
-- 
2.13.6

