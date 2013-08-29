From: Joe Perches <joe@perches.com>
Subject: [PATCH 5/6] ceph: Convert kmem_cache_alloc(...GFP_ZERO) to kmem_cache_zalloc
Date: Thu, 29 Aug 2013 13:11:09 -0700
Message-ID: <a67358bbb2f7d191cac51493a9207ba301439f4b.1377806578.git.joe@perches.com>
References: <cover.1377806578.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1377806578.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The helper exists, might as well use it instead of __GFP_ZERO.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/ceph/dir.c  | 2 +-
 fs/ceph/file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 868b61d..c10bc70 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -40,7 +40,7 @@ int ceph_init_dentry(struct dentry *dentry)
 	if (dentry->d_fsdata)
 		return 0;
 
-	di = kmem_cache_alloc(ceph_dentry_cachep, GFP_NOFS | __GFP_ZERO);
+	di = kmem_cache_zalloc(ceph_dentry_cachep, GFP_NOFS);
 	if (!di)
 		return -ENOMEM;          /* oh well */
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 20d0222..1b5f8ec 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -75,7 +75,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 	case S_IFDIR:
 		dout("init_file %p %p 0%o (regular)\n", inode, file,
 		     inode->i_mode);
-		cf = kmem_cache_alloc(ceph_file_cachep, GFP_NOFS | __GFP_ZERO);
+		cf = kmem_cache_zalloc(ceph_file_cachep, GFP_NOFS);
 		if (cf == NULL) {
 			ceph_put_fmode(ceph_inode(inode), fmode); /* clean up */
 			return -ENOMEM;
-- 
1.8.1.2.459.gbcd45b4.dirty
