From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/32] fscache: Keep track of size of a file
 last set independently on the server
Date: Mon, 13 Jul 2020 17:32:42 +0100
Message-ID: <159465796283.1376674.15372489386955555864.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org
List-Id: ceph-devel.vger.kernel.org

Keep track of the size of a file that we're caching as last set
independently on the server by another client.  As long as this does not
change, we can make the assumption that anything over that boundary, if not
represented in the local cache, will not be represented on the server
either and can be just cleared rather than being read, thereby saving a
trip to the server.

This only works if we make space in the cache by zapping whole files and
not just punching bits out of them as if we write to the server but don't
keep a copy in the cache, the assumption mentioned above no longer holds
true.

We also need to update this size when invalidation occurs.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/inode.c          |    2 +-
 fs/fscache/cookie.c     |    8 +++++++-
 include/linux/fscache.h |    8 +++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 49d897437998..b0772e64a844 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -569,7 +569,7 @@ static void afs_zap_data(struct afs_vnode *vnode)
 	_enter("{%llx:%llu}", vnode->fid.vid, vnode->fid.vnode);
 
 #ifdef CONFIG_AFS_FSCACHE
-	fscache_invalidate(vnode->cache);
+	fscache_invalidate(vnode->cache, i_size_read(&vnode->vfs_inode));
 #endif
 
 	/* nuke all the non-dirty pages that aren't locked, mapped or being
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index a1eba3be9ce8..5c53027d3f53 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -159,6 +159,7 @@ struct fscache_cookie *fscache_alloc_cookie(
 	cookie->key_len = index_key_len;
 	cookie->aux_len = aux_data_len;
 	cookie->object_size = object_size;
+	cookie->zero_point = object_size;
 	strlcpy(cookie->type_name, type_name, sizeof(cookie->type_name));
 
 	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
@@ -473,7 +474,7 @@ void fscache_set_cookie_stage(struct fscache_cookie *cookie,
 /*
  * Invalidate an object.  Callable with spinlocks held.
  */
-void __fscache_invalidate(struct fscache_cookie *cookie)
+void __fscache_invalidate(struct fscache_cookie *cookie, loff_t new_size)
 {
 	_enter("{%s}", cookie->type_name);
 
@@ -486,6 +487,11 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 	 */
 	ASSERTCMP(cookie->type, ==, FSCACHE_COOKIE_TYPE_DATAFILE);
 
+	spin_lock(&cookie->lock);
+	cookie->object_size = new_size;
+	cookie->zero_point = new_size;
+	spin_unlock(&cookie->lock);
+
 	if (!hlist_empty(&cookie->backing_objects) &&
 	    test_and_set_bit(FSCACHE_COOKIE_INVALIDATING, &cookie->flags))
 		fscache_dispatch(cookie, NULL, 0, fscache_invalidate_object);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 56fdd0e74a88..bfb28cebfcfd 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -102,6 +102,7 @@ struct fscache_cookie {
 	struct list_head		proc_link;	/* Link in proc list */
 	char				type_name[8];	/* Cookie type name */
 	loff_t				object_size;	/* Size of the netfs object */
+	loff_t				zero_point;	/* Size after which no data on server */
 
 	unsigned long			flags;
 #define FSCACHE_COOKIE_INVALIDATING	4	/* T if cookie is being invalidated */
@@ -216,8 +217,8 @@ extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
-extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_shape_request(struct fscache_cookie *, struct fscache_request_shape *);
+extern void __fscache_invalidate(struct fscache_cookie *, loff_t);
 extern void __fscache_init_io_request(struct fscache_io_request *,
 				      struct fscache_cookie *);
 extern void __fscache_free_io_request(struct fscache_io_request *);
@@ -448,6 +449,7 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
+ * @size: The revised size of the object.
  *
  * Notify the cache that an object is needs to be invalidated and that it
  * should abort any retrievals or stores it is doing on the cache.  The object
@@ -459,10 +461,10 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
  * description.
  */
 static inline
-void fscache_invalidate(struct fscache_cookie *cookie)
+void fscache_invalidate(struct fscache_cookie *cookie, loff_t size)
 {
 	if (fscache_cookie_valid(cookie))
-		__fscache_invalidate(cookie);
+		__fscache_invalidate(cookie, size);
 }
 
 /**
