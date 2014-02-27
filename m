From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: fix ceph_dir_llseek()
Date: Thu, 27 Feb 2014 17:07:27 +0800
Message-ID: <1393492047-18261-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:5255 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbaB0JHz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Feb 2014 04:07:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

Comparing offset with inode->i_sb->s_maxbytes doesn't make sense for
directory. For a fragmented directory, offset (frag_t, off) can be
larger than inode->i_sb->s_maxbytes.

At the very beginning of ceph_dir_llseek(), local variable old_offset
is initialized to parameter offset. This doesn't make sense neither.
Old_offset should be ceph_make_fpos(fi->frag, fi->next_offset).

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c   | 12 ++++++------
 fs/ceph/super.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 45eda6d..a7eaf96 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -190,7 +190,7 @@ more:
 		if (last) {
 			/* remember our position */
 			fi->dentry = last;
-			fi->next_offset = di->offset;
+			fi->next_offset = fpos_off(di->offset);
 		}
 		dput(dentry);
 		return 0;
@@ -369,9 +369,9 @@ more:
 				fi->next_offset = 0;
 			off = fi->next_offset;
 		}
+		fi->frag = frag;
 		fi->offset = fi->next_offset;
 		fi->last_readdir = req;
-		fi->frag = frag;
 
 		if (req->r_reply_info.dir_end) {
 			kfree(fi->last_name);
@@ -474,7 +474,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file->f_mapping->host;
-	loff_t old_offset = offset;
+	loff_t old_offset = ceph_make_fpos(fi->frag, fi->next_offset);
 	loff_t retval;
 
 	mutex_lock(&inode->i_mutex);
@@ -491,7 +491,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 		goto out;
 	}
 
-	if (offset >= 0 && offset <= inode->i_sb->s_maxbytes) {
+	if (offset >= 0) {
 		if (offset != file->f_pos) {
 			file->f_pos = offset;
 			file->f_version = 0;
@@ -504,14 +504,14 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 		 * seek to new frag, or seek prior to current chunk.
 		 */
 		if (offset == 0 ||
-		    fpos_frag(offset) != fpos_frag(old_offset) ||
+		    fpos_frag(offset) != fi->frag ||
 		    fpos_off(offset) < fi->offset) {
 			dout("dir_llseek dropping %p content\n", file);
 			reset_readdir(fi);
 		}
 
 		/* bump dir_release_count if we did a forward seek */
-		if (offset > old_offset)
+		if (fpos_cmp(offset, old_offset) > 0)
 			fi->dir_release_count--;
 	}
 out:
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d8801a9..70bb183 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -577,7 +577,7 @@ struct ceph_file_info {
 
 	/* readdir: position within a frag */
 	unsigned offset;       /* offset of last chunk, adjusted for . and .. */
-	u64 next_offset;       /* offset of next chunk (last_name's + 1) */
+	unsigned next_offset;  /* offset of next chunk (last_name's + 1) */
 	char *last_name;       /* last entry in previous chunk */
 	struct dentry *dentry; /* next dentry (for dcache readdir) */
 	int dir_release_count;
-- 
1.8.5.3

