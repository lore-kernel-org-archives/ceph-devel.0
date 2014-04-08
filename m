From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH] ceph: check directory's completeness before emitting directory entry
Date: Tue,  8 Apr 2014 21:50:55 +0800
Message-ID: <1396965055-6334-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10059 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704AbaDHNyH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 8 Apr 2014 09:54:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 766410a..8c7f90b 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -182,9 +182,16 @@ more:
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&parent->d_lock);
 
+	/* make sure a dentry wasn't dropped while we didn't have parent lock */
+	if (!ceph_dir_is_complete(dir)) {
+		dout(" lost dir complete on %p; falling back to mds\n", dir);
+		dput(dentry);
+		err = -EAGAIN;
+		goto out;
+	}
+
 	dout(" %llu (%llu) dentry %p %.*s %p\n", di->offset, ctx->pos,
 	     dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
-	ctx->pos = di->offset;
 	if (!dir_emit(ctx, dentry->d_name.name,
 		      dentry->d_name.len,
 		      ceph_translate_ino(dentry->d_sb, dentry->d_inode->i_ino),
@@ -198,19 +205,12 @@ more:
 		return 0;
 	}
 
+	ctx->pos = di->offset + 1;
+
 	if (last)
 		dput(last);
 	last = dentry;
 
-	ctx->pos++;
-
-	/* make sure a dentry wasn't dropped while we didn't have parent lock */
-	if (!ceph_dir_is_complete(dir)) {
-		dout(" lost dir complete on %p; falling back to mds\n", dir);
-		err = -EAGAIN;
-		goto out;
-	}
-
 	spin_lock(&parent->d_lock);
 	p = p->prev;	/* advance to next dentry */
 	goto more;
@@ -296,6 +296,8 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 		err = __dcache_readdir(file, ctx, shared_gen);
 		if (err != -EAGAIN)
 			return err;
+		frag = fpos_frag(ctx->pos);
+		off = fpos_off(ctx->pos);
 	} else {
 		spin_unlock(&ci->i_ceph_lock);
 	}
-- 
1.8.5.3

