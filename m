From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 06/16] ceph: use is_xxx_kiocb instead of filp->fl_flags
Date: Sat,  4 Apr 2015 23:13:15 +0400
Message-ID: <1428174805-853-7-git-send-email-dmonakhov@openvz.org>
References: <1428174805-853-1-git-send-email-dmonakhov@openvz.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428174805-853-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, Dmitry Monakhov <dmonakhov@openvz.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Cc: ceph-devel@vger.kernel.org
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 fs/ceph/file.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 139f2fe..3ac67bf 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -442,7 +442,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *i,
 
 	dout("sync_read on file %p %llu~%u %s\n", file, off,
 	     (unsigned)len,
-	     (file->f_flags & O_DIRECT) ? "O_DIRECT" : "");
+	     (is_direct_kiocb(iocb)) ? "O_DIRECT" : "");
 
 	if (!len)
 		return 0;
@@ -457,7 +457,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *i,
 	if (ret < 0)
 		return ret;
 
-	if (file->f_flags & O_DIRECT) {
+	if (is_direct_kiocb(iocb)) {
 		while (iov_iter_count(i)) {
 			size_t start;
 			ssize_t n;
@@ -828,8 +828,7 @@ again:
 		return ret;
 
 	if ((got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) == 0 ||
-	    (iocb->ki_filp->f_flags & O_DIRECT) ||
-	    (fi->flags & CEPH_F_SYNC)) {
+	    is_direct_kiocb(iocb) || (fi->flags & CEPH_F_SYNC)) {
 
 		dout("aio_sync_read %p %llx.%llx %llu~%u got cap refs on %s\n",
 		     inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
@@ -953,7 +952,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* We can write back this queue in page reclaim */
 	current->backing_dev_info = inode_to_bdi(inode);
 
-	err = generic_write_checks(file, &pos, &count, S_ISBLK(inode->i_mode));
+	err = generic_write_checks(iocb, &pos, &count, S_ISBLK(inode->i_mode));
 	if (err)
 		goto out;
 
@@ -997,12 +996,12 @@ retry_snap:
 	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
-	    (file->f_flags & O_DIRECT) || (fi->flags & CEPH_F_SYNC)) {
+	    is_direct_kiocb(iocb) || (fi->flags & CEPH_F_SYNC)) {
 		struct iov_iter data;
 		mutex_unlock(&inode->i_mutex);
 		/* we might need to revert back to that point */
 		data = *from;
-		if (file->f_flags & O_DIRECT)
+		if (is_direct_kiocb(iocb))
 			written = ceph_sync_direct_write(iocb, &data, pos);
 		else
 			written = ceph_sync_write(iocb, &data, pos);
-- 
1.7.1
