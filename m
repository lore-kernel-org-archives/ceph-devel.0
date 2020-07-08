From: Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] fs: ceph: Remove unnecessary cast in kfree()
Date: Wed,  8 Jul 2020 07:03:22 +0000
Message-ID: <20200708070322.30695-1-vulab@iscas.ac.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org, idryomov@gmail.com, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
List-Id: ceph-devel.vger.kernel.org

Remove unnecassary casts in the argument to kfree.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 fs/ceph/xattr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 71ee34d160c3..3a733ac33d9b 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -497,10 +497,10 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		kfree(*newxattr);
 		*newxattr = NULL;
 		if (xattr->should_free_val)
-			kfree((void *)xattr->val);
+			kfree(xattr->val);
 
 		if (update_xattr) {
-			kfree((void *)name);
+			kfree(name);
 			name = xattr->name;
 		}
 		ci->i_xattrs.names_size -= xattr->name_len;
@@ -566,9 +566,9 @@ static void __free_xattr(struct ceph_inode_xattr *xattr)
 	BUG_ON(!xattr);
 
 	if (xattr->should_free_name)
-		kfree((void *)xattr->name);
+		kfree(xattr->name);
 	if (xattr->should_free_val)
-		kfree((void *)xattr->val);
+		kfree(xattr->val);
 
 	kfree(xattr);
 }
@@ -582,9 +582,9 @@ static int __remove_xattr(struct ceph_inode_info *ci,
 	rb_erase(&xattr->node, &ci->i_xattrs.index);
 
 	if (xattr->should_free_name)
-		kfree((void *)xattr->name);
+		kfree(xattr->name);
 	if (xattr->should_free_val)
-		kfree((void *)xattr->val);
+		kfree(xattr->val);
 
 	ci->i_xattrs.names_size -= xattr->name_len;
 	ci->i_xattrs.vals_size -= xattr->val_len;
-- 
2.17.1
