From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ceph: cleanup: remove dead code
Date: Sat, 20 Mar 2010 16:01:27 +0300
Message-ID: <20100320130127.GA32626@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

"xattr" is never NULL here.  We took care of that in the previous
if statement block.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 37d6ce6..65b0e9b 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -185,12 +185,6 @@ static int __set_xattr(struct ceph_inode_info *ci,
 		ci->i_xattrs.names_size -= xattr->name_len;
 		ci->i_xattrs.vals_size -= xattr->val_len;
 	}
-	if (!xattr) {
-		pr_err("__set_xattr ENOMEM on %p %llx.%llx xattr %s=%s\n",
-		       &ci->vfs_inode, ceph_vinop(&ci->vfs_inode), name,
-		       xattr->val);
-		return -ENOMEM;
-	}
 	ci->i_xattrs.names_size += name_len;
 	ci->i_xattrs.vals_size += val_len;
 	if (val)
