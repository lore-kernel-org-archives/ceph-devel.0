From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: fix reset_readdir()
Date: Fri, 28 Feb 2014 17:13:11 +0800
Message-ID: <1393578791-19917-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26753 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbaB1JNQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 Feb 2014 04:13:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

When changing readdir postion, fi->next_offset should be set to 0
if the new postion is not in the first dirfrag.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a7eaf96..8ce8833 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -454,7 +454,7 @@ more:
 	return 0;
 }
 
-static void reset_readdir(struct ceph_file_info *fi)
+static void reset_readdir(struct ceph_file_info *fi, unsigned frag)
 {
 	if (fi->last_readdir) {
 		ceph_mdsc_put_request(fi->last_readdir);
@@ -462,7 +462,10 @@ static void reset_readdir(struct ceph_file_info *fi)
 	}
 	kfree(fi->last_name);
 	fi->last_name = NULL;
-	fi->next_offset = 2;  /* compensate for . and .. */
+	if (ceph_frag_is_leftmost(frag))
+		fi->next_offset = 2;  /* compensate for . and .. */
+	else
+		fi->next_offset = 0;
 	if (fi->dentry) {
 		dput(fi->dentry);
 		fi->dentry = NULL;
@@ -507,7 +510,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 		    fpos_frag(offset) != fi->frag ||
 		    fpos_off(offset) < fi->offset) {
 			dout("dir_llseek dropping %p content\n", file);
-			reset_readdir(fi);
+			reset_readdir(fi, fpos_frag(offset));
 		}
 
 		/* bump dir_release_count if we did a forward seek */
-- 
1.8.5.3

