From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] ceph: remove redundant code for max file size verification
Date: Wed, 17 Sep 2014 17:26:06 +0800
Message-ID: <00fd01cfd259$81ef7530$85ce5f90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: sage@inktank.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Both ceph_update_writeable_page and ceph_setattr will verify file size
with max size ceph supported.
There are two caller for ceph_update_writeable_page, ceph_write_begin and
ceph_page_mkwrite. For ceph_write_begin, we have already verified the size in
generic_write_checks of ceph_write_iter; for ceph_page_mkwrite, we have no
chance to change file size when mmap. Likewise we have already verified the size
in inode_change_ok when we call ceph_setattr.
So let's remove the redundant code for max file size verification.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/ceph/addr.c  | 9 ---------
 fs/ceph/inode.c | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 90b3954..18c06bb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1076,12 +1076,6 @@ retry_locked:
 	/* past end of file? */
 	i_size = inode->i_size;   /* caller holds i_mutex */
 
-	if (i_size + len > inode->i_sb->s_maxbytes) {
-		/* file is too big */
-		r = -EINVAL;
-		goto fail;
-	}
-
 	if (page_off >= i_size ||
 	    (pos_in_page == 0 && (pos+len) >= i_size &&
 	     end_in_page - pos_in_page != PAGE_CACHE_SIZE)) {
@@ -1099,9 +1093,6 @@ retry_locked:
 	if (r < 0)
 		goto fail_nosnap;
 	goto retry_locked;
-
-fail:
-	up_read(&mdsc->snap_rwsem);
 fail_nosnap:
 	unlock_page(page);
 	return r;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 04c89c2..25c242e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1813,10 +1813,6 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (ia_valid & ATTR_SIZE) {
 		dout("setattr %p size %lld -> %lld\n", inode,
 		     inode->i_size, attr->ia_size);
-		if (attr->ia_size > inode->i_sb->s_maxbytes) {
-			err = -EINVAL;
-			goto out;
-		}
 		if ((issued & CEPH_CAP_FILE_EXCL) &&
 		    attr->ia_size > inode->i_size) {
 			inode->i_size = attr->ia_size;
@@ -1896,8 +1892,6 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (mask & CEPH_SETATTR_SIZE)
 		__ceph_do_pending_vmtruncate(inode);
 	return err;
-out:
-	spin_unlock(&ci->i_ceph_lock);
 out_put:
 	ceph_mdsc_put_request(req);
 	return err;
-- 
2.0.1.474.g72c7794
