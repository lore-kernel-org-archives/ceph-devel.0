From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/3] ceph: remove special ack vs commit behavior
Date: Thu, 23 Feb 2017 21:59:19 +0100
Message-ID: <1487883561-32001-2-git-send-email-idryomov@gmail.com>
References: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35453 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdBWVHx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2017 16:07:53 -0500
Received: by mail-wm0-f65.google.com with SMTP id u63so1932006wmu.2
        for <ceph-devel@vger.kernel.org>; Thu, 23 Feb 2017 13:07:52 -0800 (PST)
In-Reply-To: <1487883561-32001-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>, Zheng Yan <zyan@redhat.com>

- ask for a commit reply instead of an ack reply in
  __ceph_pool_perm_get()
- don't ask for both ack and commit replies in ceph_sync_write()
- since just only one reply is requested now, i_unsafe_writes list
  will always be empty -- kill ceph_sync_write_wait() and go back to
  a standard ->evict_inode()

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/addr.c  |  2 +-
 fs/ceph/caps.c  |  2 --
 fs/ceph/file.c  | 88 +--------------------------------------------------------
 fs/ceph/inode.c |  9 ------
 fs/ceph/super.c |  1 -
 fs/ceph/super.h |  4 +--
 6 files changed, 3 insertions(+), 103 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 4547bbf80e4f..3f0474c55f05 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1872,7 +1872,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out_unlock;
 	}
 
-	wr_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ACK;
+	wr_req->r_flags = CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK;
 	osd_req_op_init(wr_req, 0, CEPH_OSD_OP_CREATE, CEPH_OSD_OP_FLAG_EXCL);
 	ceph_oloc_copy(&wr_req->r_base_oloc, &rd_req->r_base_oloc);
 	ceph_oid_copy(&wr_req->r_base_oid, &rd_req->r_base_oid);
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 3c2dfd72e5b2..cd966f276a8d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2091,8 +2091,6 @@ int ceph_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 	dout("fsync %p%s\n", inode, datasync ? " datasync" : "");
 
-	ceph_sync_write_wait(inode);
-
 	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
 	if (ret < 0)
 		goto out;
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a91a4f1fc837..ae9f8999fc07 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -726,89 +726,6 @@ static void ceph_aio_retry_work(struct work_struct *work)
 	kfree(aio_work);
 }
 
-/*
- * Write commit request unsafe callback, called to tell us when a
- * request is unsafe (that is, in flight--has been handed to the
- * messenger to send to its target osd).  It is called again when
- * we've received a response message indicating the request is
- * "safe" (its CEPH_OSD_FLAG_ONDISK flag is set), or when a request
- * is completed early (and unsuccessfully) due to a timeout or
- * interrupt.
- *
- * This is used if we requested both an ACK and ONDISK commit reply
- * from the OSD.
- */
-static void ceph_sync_write_unsafe(struct ceph_osd_request *req, bool unsafe)
-{
-	struct ceph_inode_info *ci = ceph_inode(req->r_inode);
-
-	dout("%s %p tid %llu %ssafe\n", __func__, req, req->r_tid,
-		unsafe ? "un" : "");
-	if (unsafe) {
-		ceph_get_cap_refs(ci, CEPH_CAP_FILE_WR);
-		spin_lock(&ci->i_unsafe_lock);
-		list_add_tail(&req->r_unsafe_item,
-			      &ci->i_unsafe_writes);
-		spin_unlock(&ci->i_unsafe_lock);
-
-		complete_all(&req->r_completion);
-	} else {
-		spin_lock(&ci->i_unsafe_lock);
-		list_del_init(&req->r_unsafe_item);
-		spin_unlock(&ci->i_unsafe_lock);
-		ceph_put_cap_refs(ci, CEPH_CAP_FILE_WR);
-	}
-}
-
-/*
- * Wait on any unsafe replies for the given inode.  First wait on the
- * newest request, and make that the upper bound.  Then, if there are
- * more requests, keep waiting on the oldest as long as it is still older
- * than the original request.
- */
-void ceph_sync_write_wait(struct inode *inode)
-{
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct list_head *head = &ci->i_unsafe_writes;
-	struct ceph_osd_request *req;
-	u64 last_tid;
-
-	if (!S_ISREG(inode->i_mode))
-		return;
-
-	spin_lock(&ci->i_unsafe_lock);
-	if (list_empty(head))
-		goto out;
-
-	/* set upper bound as _last_ entry in chain */
-
-	req = list_last_entry(head, struct ceph_osd_request,
-			      r_unsafe_item);
-	last_tid = req->r_tid;
-
-	do {
-		ceph_osdc_get_request(req);
-		spin_unlock(&ci->i_unsafe_lock);
-
-		dout("sync_write_wait on tid %llu (until %llu)\n",
-		     req->r_tid, last_tid);
-		wait_for_completion(&req->r_done_completion);
-		ceph_osdc_put_request(req);
-
-		spin_lock(&ci->i_unsafe_lock);
-		/*
-		 * from here on look at first entry in chain, since we
-		 * only want to wait for anything older than last_tid
-		 */
-		if (list_empty(head))
-			break;
-		req = list_first_entry(head, struct ceph_osd_request,
-				       r_unsafe_item);
-	} while (req->r_tid < last_tid);
-out:
-	spin_unlock(&ci->i_unsafe_lock);
-}
-
 static ssize_t
 ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 		       struct ceph_snap_context *snapc,
@@ -1050,8 +967,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 
 	flags = CEPH_OSD_FLAG_ORDERSNAP |
 		CEPH_OSD_FLAG_ONDISK |
-		CEPH_OSD_FLAG_WRITE |
-		CEPH_OSD_FLAG_ACK;
+		CEPH_OSD_FLAG_WRITE;
 
 	while ((len = iov_iter_count(from)) > 0) {
 		size_t left;
@@ -1097,8 +1013,6 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			goto out;
 		}
 
-		/* get a second commit callback */
-		req->r_unsafe_callback = ceph_sync_write_unsafe;
 		req->r_inode = inode;
 
 		osd_req_op_extent_osd_data_pages(req, 0, pages, len, 0,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 68f46132b157..fd8f771f99b7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -499,7 +499,6 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_rdcache_gen = 0;
 	ci->i_rdcache_revoking = 0;
 
-	INIT_LIST_HEAD(&ci->i_unsafe_writes);
 	INIT_LIST_HEAD(&ci->i_unsafe_dirops);
 	INIT_LIST_HEAD(&ci->i_unsafe_iops);
 	spin_lock_init(&ci->i_unsafe_lock);
@@ -583,14 +582,6 @@ int ceph_drop_inode(struct inode *inode)
 	return 1;
 }
 
-void ceph_evict_inode(struct inode *inode)
-{
-	/* wait unsafe sync writes */
-	ceph_sync_write_wait(inode);
-	truncate_inode_pages_final(&inode->i_data);
-	clear_inode(inode);
-}
-
 static inline blkcnt_t calc_inode_blocks(u64 size)
 {
 	return (size + (1<<9) - 1) >> 9;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a0a0b6d02f89..0ec8d0114e57 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -757,7 +757,6 @@ static const struct super_operations ceph_super_ops = {
 	.destroy_inode	= ceph_destroy_inode,
 	.write_inode    = ceph_write_inode,
 	.drop_inode	= ceph_drop_inode,
-	.evict_inode	= ceph_evict_inode,
 	.sync_fs        = ceph_sync_fs,
 	.put_super	= ceph_put_super,
 	.show_options   = ceph_show_options,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 950170136be9..e9410bcf4113 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -343,7 +343,6 @@ struct ceph_inode_info {
 	u32 i_rdcache_gen;      /* incremented each time we get FILE_CACHE. */
 	u32 i_rdcache_revoking; /* RDCACHE gen to async invalidate, if any */
 
-	struct list_head i_unsafe_writes; /* uncommitted sync writes */
 	struct list_head i_unsafe_dirops; /* uncommitted mds dir ops */
 	struct list_head i_unsafe_iops;   /* uncommitted mds inode ops */
 	spinlock_t i_unsafe_lock;
@@ -753,7 +752,6 @@ extern const struct inode_operations ceph_file_iops;
 extern struct inode *ceph_alloc_inode(struct super_block *sb);
 extern void ceph_destroy_inode(struct inode *inode);
 extern int ceph_drop_inode(struct inode *inode);
-extern void ceph_evict_inode(struct inode *inode);
 
 extern struct inode *ceph_get_inode(struct super_block *sb,
 				    struct ceph_vino vino);
@@ -933,7 +931,7 @@ extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 extern int ceph_release(struct inode *inode, struct file *filp);
 extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 				  char *data, size_t len);
-extern void ceph_sync_write_wait(struct inode *inode);
+
 /* dir.c */
 extern const struct file_operations ceph_dir_fops;
 extern const struct file_operations ceph_snapdir_fops;
-- 
2.4.3

