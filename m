From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 57/61] afs: Invoke fscache_resize_cookie() when handling
 ATTR_SIZE for setattr
Date: Mon, 04 May 2020 18:16:07 +0100
Message-ID: <158861256762.340223.10583346645344676649.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Invoke fscache_resize_cookie() to adjust the size of the backing cache
object when setattr is called with ATTR_SIZE.  This discards any data that
then lies beyond the revised EOF and frees up space.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 59dc179b40cb..21a48ab74d2b 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -838,6 +838,8 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!scb)
 		goto error;
 
+	fscache_use_cookie(afs_vnode_cache(vnode), true);
+
 	/* flush any dirty data outstanding on a regular file */
 	if (S_ISREG(vnode->vfs_inode.i_mode))
 		filemap_write_and_wait(vnode->vfs_inode.i_mapping);
@@ -848,7 +850,7 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 		key = afs_request_key(vnode->volume->cell);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
-			goto error_scb;
+			goto error_unuse;
 		}
 	}
 
@@ -873,7 +875,11 @@ int afs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!(attr->ia_valid & ATTR_FILE))
 		key_put(key);
 
-error_scb:
+	if ((attr->ia_valid & ATTR_SIZE) && ret == 0)
+		fscache_resize_cookie(afs_vnode_cache(vnode), scb->status.size);
+
+error_unuse:
+	fscache_unuse_cookie(afs_vnode_cache(vnode), NULL, NULL);
 	kfree(scb);
 error:
 	_leave(" = %d", ret);
