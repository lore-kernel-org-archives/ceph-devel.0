From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 2/2] ceph: use kmem_cache_zalloc
Date: Sun, 13 Mar 2016 15:26:29 +0800
Message-ID: <49f3c78fbd6b746048e16a7bc5aa2c4cb5722f8c.1457853860.git.geliangtang@163.com>
References: <7073df70fbbebb7c1f658b8d2d616ef84a86ff92.1457853860.git.geliangtang@163.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m12-18.163.com ([220.181.12.18]:56872 "EHLO m12-18.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798AbcCMH0z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 13 Mar 2016 03:26:55 -0400
In-Reply-To: <7073df70fbbebb7c1f658b8d2d616ef84a86ff92.1457853860.git.geliangtang@163.com>
In-Reply-To: <7073df70fbbebb7c1f658b8d2d616ef84a86ff92.1457853860.git.geliangtang@163.com>
References: <7073df70fbbebb7c1f658b8d2d616ef84a86ff92.1457853860.git.geliangtang@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Geliang Tang <geliangtang@163.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

Use kmem_cache_zalloc() instead of kmem_cache_alloc() with flag GFP_ZERO.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 fs/ceph/dir.c  | 2 +-
 fs/ceph/file.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index fd11fb2..ba01851 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -38,7 +38,7 @@ int ceph_init_dentry(struct dentry *dentry)
 	if (dentry->d_fsdata)
 		return 0;
 
-	di = kmem_cache_alloc(ceph_dentry_cachep, GFP_KERNEL | __GFP_ZERO);
+	di = kmem_cache_zalloc(ceph_dentry_cachep, GFP_KERNEL);
 	if (!di)
 		return -ENOMEM;          /* oh well */
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index eb9028e..bb4950a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -157,7 +157,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 	case S_IFDIR:
 		dout("init_file %p %p 0%o (regular)\n", inode, file,
 		     inode->i_mode);
-		cf = kmem_cache_alloc(ceph_file_cachep, GFP_KERNEL | __GFP_ZERO);
+		cf = kmem_cache_zalloc(ceph_file_cachep, GFP_KERNEL);
 		if (cf == NULL) {
 			ceph_put_fmode(ceph_inode(inode), fmode); /* clean up */
 			return -ENOMEM;
-- 
2.5.0


