From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 35/61] cachefiles: Round the cachefile size up to DIO
 block size
Date: Mon, 04 May 2020 18:12:45 +0100
Message-ID: <158861236514.340223.3729118853361763383.stgit@warthog.procyon.org.uk>
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

Round the size of a cachefile up to DIO block size so that we can always
read back the last partial page of a file using direct I/O.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index d820051a9960..aa063857272a 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -184,6 +184,17 @@ static void cachefiles_update_object(struct fscache_object *_object)
 			cachefiles_remove_object_xattr(cache, object->dentry);
 			goto out;
 		}
+
+		object_size = round_up(object_size, CACHEFILES_DIO_BLOCK_SIZE);
+		_debug("trunc %llx -> %llx", i_size_read(d_inode(object->dentry)), object_size);
+		if (i_size_read(d_inode(object->dentry)) < object_size) {
+			ret = vfs_truncate(&path, object_size);
+			if (ret < 0) {
+				cachefiles_io_error_obj(object, "Trunc-to-dio-size failed");
+				cachefiles_remove_object_xattr(cache, object->dentry);
+				goto out;
+			}
+		}
 	}
 
 	cachefiles_set_object_xattr(object, XATTR_REPLACE);
@@ -358,6 +369,7 @@ static int cachefiles_attr_changed(struct cachefiles_object *object)
 	int ret;
 
 	ni_size = object->fscache.cookie->object_size;
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
 	_enter("{OBJ%x},[%llu]",
 	       object->fscache.debug_id, (unsigned long long) ni_size);
@@ -426,6 +438,7 @@ static void cachefiles_invalidate_object(struct fscache_object *_object)
 			     struct cachefiles_cache, cache);
 
 	ni_size = object->fscache.cookie->object_size;
+	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
 
 	_enter("{OBJ%x},[%llu]",
 	       object->fscache.debug_id, (unsigned long long)ni_size);
