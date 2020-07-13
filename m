From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/13] afs: Invoke fscache_resize_cookie() when handling
 ATTR_SIZE for setattr
Date: Mon, 13 Jul 2020 17:39:18 +0100
Message-ID: <159465835897.1377938.1598226019201611820.stgit@warthog.procyon.org.uk>
References: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: Jeff Layton <jlayton@redhat.com>, Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com, linux-cachefs@redhat.com, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Invoke fscache_resize_cookie() to adjust the size of the backing cache
object when setattr is called with ATTR_SIZE.  This discards any data that
then lies beyond the revised EOF and frees up space.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index eab191b9c01d..baaaa5e55f95 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -815,14 +815,19 @@ void afs_evict_inode(struct inode *inode)
 
 static void afs_setattr_success(struct afs_operation *op)
 {
-	struct inode *inode = &op->file[0].vnode->vfs_inode;
+	struct afs_vnode_param *vp = &op->file[0];
+	struct inode *inode = &vp->vnode->vfs_inode;
 
-	afs_vnode_commit_status(op, &op->file[0]);
+	afs_vnode_commit_status(op, vp);
 	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
 		loff_t i_size = inode->i_size, size = op->setattr.attr->ia_size;
+
 		if (size > i_size)
 			pagecache_isize_extended(inode, i_size, size);
 		truncate_pagecache(inode, size);
+
+		fscache_resize_cookie(afs_vnode_cache(vp->vnode),
+				      vp->scb.status.size);
 	}
 }
 
@@ -864,6 +869,8 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
+	fscache_use_cookie(afs_vnode_cache(vnode), true);
+
 	/* flush any dirty data outstanding on a regular file */
 	if (S_ISREG(vnode->vfs_inode.i_mode))
 		filemap_write_and_wait(vnode->vfs_inode.i_mapping);
@@ -871,8 +878,10 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	op = afs_alloc_operation(((attr->ia_valid & ATTR_FILE) ?
 				  afs_file_key(attr->ia_file) : NULL),
 				 vnode->volume);
-	if (IS_ERR(op))
-		return PTR_ERR(op);
+	if (IS_ERR(op)) {
+		ret = PTR_ERR(op);
+		goto error_unuse;
+	}
 
 	afs_op_set_vnode(op, 0, vnode);
 	op->setattr.attr = attr;
@@ -885,5 +894,10 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	op->file[0].update_ctime = 1;
 
 	op->ops = &afs_setattr_operation;
-	return afs_do_sync_operation(op);
+	ret = afs_do_sync_operation(op);
+
+error_unuse:
+	fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
+	_leave(" = %d", ret);
+	return ret;
 }
