From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 13/61] fscache: Remove store_limit* from struct
 fscache_object
Date: Mon, 04 May 2020 18:09:21 +0100
Message-ID: <158861216191.340223.5826773540368508104.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Remove the store_limit values from struct fscache_object and store the
object size in the cookie.  The netfs can update this at will, and we don't
want to call back into the netfs to fetch it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   10 ++--------
 fs/fscache/cookie.c           |   14 ++++++--------
 fs/fscache/object.c           |    2 --
 include/linux/fscache-cache.h |   22 ----------------------
 include/linux/fscache.h       |    1 +
 5 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index b7aa5c733cb7..a5d348581bcc 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -359,7 +359,7 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	loff_t oi_size;
 	int ret;
 
-	ni_size = _object->store_limit_l;
+	ni_size = _object->cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
 	       _object->debug_id, (unsigned long long) ni_size);
@@ -376,8 +376,6 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 
 	ASSERT(d_is_reg(object->backer));
 
-	fscache_set_store_limit(&object->fscache, ni_size);
-
 	oi_size = i_size_read(d_backing_inode(object->backer));
 	if (oi_size == ni_size)
 		return 0;
@@ -406,7 +404,6 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	cachefiles_end_secure(cache, saved_cred);
 
 	if (ret == -EIO) {
-		fscache_set_store_limit(&object->fscache, 0);
 		cachefiles_io_error_obj(object, "Size set failed");
 		ret = -ENOBUFS;
 	}
@@ -431,7 +428,7 @@ static void cachefiles_invalidate_object(struct fscache_operation *op)
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
-	ni_size = op->object->store_limit_l;
+	ni_size = op->object->cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
 	       op->object->debug_id, (unsigned long long)ni_size);
@@ -439,8 +436,6 @@ static void cachefiles_invalidate_object(struct fscache_operation *op)
 	if (object->backer) {
 		ASSERT(d_is_reg(object->backer));
 
-		fscache_set_store_limit(&object->fscache, ni_size);
-
 		path.dentry = object->backer;
 		path.mnt = cache->mnt;
 
@@ -451,7 +446,6 @@ static void cachefiles_invalidate_object(struct fscache_operation *op)
 		cachefiles_end_secure(cache, saved_cred);
 
 		if (ret != 0) {
-			fscache_set_store_limit(&object->fscache, 0);
 			if (ret == -EIO)
 				cachefiles_io_error_obj(object,
 							"Invalidate failed");
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 0ffccb238e69..bcaadbcaa0b2 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -22,8 +22,7 @@ static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
 static LIST_HEAD(fscache_cookies);
 static DEFINE_RWLOCK(fscache_cookies_lock);
 
-static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
-					    loff_t object_size);
+static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie);
 static int fscache_alloc_object(struct fscache_cache *cache,
 				struct fscache_cookie *cookie);
 static int fscache_attach_object(struct fscache_cookie *cookie,
@@ -167,6 +166,7 @@ struct fscache_cookie *fscache_alloc_cookie(
 	cookie->advice = advice;
 	cookie->key_len = index_key_len;
 	cookie->aux_len = aux_data_len;
+	cookie->object_size = object_size;
 	strlcpy(cookie->type_name, type_name, sizeof(cookie->type_name));
 
 	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
@@ -337,7 +337,7 @@ struct fscache_cookie *__fscache_acquire_cookie(
 		 * - we create indices on disk when we need them as an index
 		 * may exist in multiple caches */
 		if (cookie->type != FSCACHE_COOKIE_TYPE_INDEX) {
-			if (fscache_acquire_non_index_cookie(cookie, object_size) == 0) {
+			if (fscache_acquire_non_index_cookie(cookie) == 0) {
 				set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
 			} else {
 				atomic_dec(&parent->n_children);
@@ -376,6 +376,7 @@ void __fscache_enable_cookie(struct fscache_cookie *cookie,
 	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
 			 TASK_UNINTERRUPTIBLE);
 
+	cookie->object_size = object_size;
 	fscache_update_aux(cookie, aux_data);
 
 	if (test_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
@@ -387,7 +388,7 @@ void __fscache_enable_cookie(struct fscache_cookie *cookie,
 		/* Wait for outstanding disablement to complete */
 		__fscache_wait_on_invalidate(cookie);
 
-		if (fscache_acquire_non_index_cookie(cookie, object_size) == 0)
+		if (fscache_acquire_non_index_cookie(cookie) == 0)
 			set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
 	} else {
 		set_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags);
@@ -404,8 +405,7 @@ EXPORT_SYMBOL(__fscache_enable_cookie);
  * - this must make sure the index chain is instantiated and instantiate the
  *   object representation too
  */
-static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
-					    loff_t object_size)
+static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie)
 {
 	struct fscache_object *object;
 	struct fscache_cache *cache;
@@ -456,8 +456,6 @@ static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
 	object = hlist_entry(cookie->backing_objects.first,
 			     struct fscache_object, cookie_link);
 
-	fscache_set_store_limit(object, object_size);
-
 	/* initiate the process of looking up all the objects in the chain
 	 * (done by fscache_initialise_object()) */
 	fscache_raise_event(object, FSCACHE_OBJECT_EV_NEW_CHILD);
diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index fa74b3c94f88..ede38bd4774a 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -319,8 +319,6 @@ void fscache_object_init(struct fscache_object *object,
 	object->n_children = 0;
 	object->n_ops = object->n_in_progress = object->n_exclusive = 0;
 	object->events = 0;
-	object->store_limit = 0;
-	object->store_limit_l = 0;
 	object->cache = cache;
 	object->cookie = cookie;
 	fscache_cookie_get(cookie, fscache_cookie_get_attach_object);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 0a87e82a1657..81418056f43f 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -274,8 +274,6 @@ struct fscache_object {
 #ifdef CONFIG_FSCACHE_OBJECT_LIST
 	struct rb_node		objlist_link;	/* link in global object list */
 #endif
-	pgoff_t			store_limit;	/* current storage limit */
-	loff_t			store_limit_l;	/* current storage limit */
 };
 
 extern void fscache_object_init(struct fscache_object *, struct fscache_cookie *,
@@ -336,26 +334,6 @@ static inline void fscache_object_lookup_error(struct fscache_object *object)
 	set_bit(FSCACHE_OBJECT_EV_ERROR, &object->events);
 }
 
-/**
- * fscache_set_store_limit - Set the maximum size to be stored in an object
- * @object: The object to set the maximum on
- * @i_size: The limit to set in bytes
- *
- * Set the maximum size an object is permitted to reach, implying the highest
- * byte that may be written.  Intended to be called by the attr_changed() op.
- *
- * See Documentation/filesystems/caching/backend-api.txt for a complete
- * description.
- */
-static inline
-void fscache_set_store_limit(struct fscache_object *object, loff_t i_size)
-{
-	object->store_limit_l = i_size;
-	object->store_limit = i_size >> PAGE_SHIFT;
-	if (i_size & ~PAGE_MASK)
-		object->store_limit++;
-}
-
 static inline void __fscache_use_cookie(struct fscache_cookie *cookie)
 {
 	atomic_inc(&cookie->n_active);
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 85f9cb4ac826..64d9ef34da49 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -83,6 +83,7 @@ struct fscache_cookie {
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
 	struct list_head		proc_link;	/* Link in proc list */
 	char				type_name[8];	/* Cookie type name */
+	loff_t				object_size;	/* Size of the netfs object */
 
 	unsigned long			flags;
 #define FSCACHE_COOKIE_LOOKING_UP	0	/* T if non-index cookie being looked up still */
