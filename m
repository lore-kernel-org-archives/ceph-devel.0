From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 08/10] fs: ceph: replace CURRENT_TIME by current_fs_time()
Date: Tue,  2 Feb 2016 22:07:48 -0800
Message-ID: <1454479670-8204-9-git-send-email-deepa.kernel@gmail.com>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

CURRENT_TIME macro is not appropriate for filesystems as it
doesn't use the right granularity for filesystem timestamps.
Use current_fs_time() instead.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/file.c  | 4 ++--
 fs/ceph/inode.c | 2 +-
 fs/ceph/xattr.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 86a9c38..9b338ff 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -783,7 +783,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	int num_pages = 0;
 	int flags;
 	int ret;
-	struct timespec mtime = CURRENT_TIME;
+	struct timespec mtime = current_fs_time(inode->i_sb);
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
@@ -988,7 +988,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	int flags;
 	int check_caps = 0;
 	int ret;
-	struct timespec mtime = CURRENT_TIME;
+	struct timespec mtime = current_fs_time(inode->i_sb);
 	size_t count = iov_iter_count(from);
 
 	if (ceph_snap(file_inode(file)) != CEPH_NOSNAP)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fb4ba2e..63d0198 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1959,7 +1959,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (dirtied) {
 		inode_dirty_flags = __ceph_mark_dirty_caps(ci, dirtied,
 							   &prealloc_cf);
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = current_fs_time(inode->i_sb);
 	}
 
 	release &= issued;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 819163d..1e1c00a 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -999,7 +999,7 @@ retry:
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL,
 					       &prealloc_cf);
 		ci->i_xattrs.dirty = true;
-		inode->i_ctime = CURRENT_TIME;
+		inode->i_ctime = current_fs_time(inode->i_sb);
 	}
 
 	spin_unlock(&ci->i_ceph_lock);
@@ -1136,7 +1136,7 @@ retry:
 	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL,
 				       &prealloc_cf);
 	ci->i_xattrs.dirty = true;
-	inode->i_ctime = CURRENT_TIME;
+	inode->i_ctime = current_fs_time(inode->i_sb);
 	spin_unlock(&ci->i_ceph_lock);
 	if (lock_snap_rwsem)
 		up_read(&mdsc->snap_rwsem);
-- 
1.9.1
