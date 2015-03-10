From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ceph: match wait_for_completion_timeout return type
Date: Tue, 10 Mar 2015 11:18:15 -0400
Message-ID: <1426000695-348-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yan Zheng <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: ceph-devel.vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. An
appropriately named unsigned long is added and the assignment fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

This was only compile tested for x86_64_defconfig + CONFIG_CEPH_FS=m

Patch is against 4.0-rc2 linux-next (localversion-next is -next-20150306)

 fs/ceph/dir.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 83e9976..4bee6b7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1218,6 +1218,7 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
 	struct ceph_mds_request *req;
 	u64 last_tid;
 	int ret = 0;
+	unsigned long time_left;
 
 	dout("dir_fsync %p\n", inode);
 	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
@@ -1240,11 +1241,11 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
 		dout("dir_fsync %p wait on tid %llu (until %llu)\n",
 		     inode, req->r_tid, last_tid);
 		if (req->r_timeout) {
-			ret = wait_for_completion_timeout(
+			time_left = wait_for_completion_timeout(
 				&req->r_safe_completion, req->r_timeout);
-			if (ret > 0)
+			if (time_left > 0)
 				ret = 0;
-			else if (ret == 0)
+			else if (!time_left)
 				ret = -EIO;  /* timed out */
 		} else {
 			wait_for_completion(&req->r_safe_completion);
-- 
1.7.10.4
