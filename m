From: Cyril Roelandt <tipecaml@gmail.com>
Subject: [PATCH 3/3] ceph: fix dentry reference leak in ceph_encode_fh().
Date: Sun, 11 Nov 2012 21:49:31 +0100
Message-ID: <1352666971-13551-4-git-send-email-tipecaml@gmail.com>
References: <1352666971-13551-1-git-send-email-tipecaml@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352666971-13551-1-git-send-email-tipecaml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Cyril Roelandt <tipecaml@gmail.com>, sage@inktank.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

dput() was not called in the error path.

Signed-off-by: Cyril Roelandt <tipecaml@gmail.com>
---
 fs/ceph/export.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 9349bb3..ca3ab3f 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -56,13 +56,15 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 	struct ceph_nfs_confh *cfh = (void *)rawfh;
 	int connected_handle_length = sizeof(*cfh)/4;
 	int handle_length = sizeof(*fh)/4;
-	struct dentry *dentry = d_find_alias(inode);
+	struct dentry *dentry;
 	struct dentry *parent;
 
 	/* don't re-export snaps */
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EINVAL;
 
+	dentry = d_find_alias(inode);
+
 	/* if we found an alias, generate a connectable fh */
 	if (*max_len >= connected_handle_length && dentry) {
 		dout("encode_fh %p connectable\n", dentry);
-- 
1.7.10.4
