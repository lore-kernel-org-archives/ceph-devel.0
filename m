From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 45/61] fscache: Remove the update operation
Date: Mon, 04 May 2020 18:14:16 +0100
Message-ID: <158861245670.340223.11283691470830647768.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trond Myklebust <trondmy-F/q8l9xzQnoyLce1RVWEUA@public.gmane.org>, Anna Schumaker <anna.schumaker-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, Steve French <sfrench-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Remove the cache-side of the object update operation as it doesn't
serialise with other setattr, O_TRUNC and write operations.

Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 fs/cachefiles/interface.c     |   59 -----------------------------------------
 fs/fscache/internal.h         |    1 -
 fs/fscache/obj.c              |   14 ----------
 fs/fscache/stats.c            |    4 +--
 include/linux/fscache-cache.h |    2 -
 5 files changed, 1 insertion(+), 79 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index f9c2c09e1713..59910433f2a3 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -152,64 +152,6 @@ struct fscache_object *cachefiles_grab_object(struct fscache_object *_object,
 	return &object->fscache;
 }
 
-/*
- * update the auxiliary data for an object object on disk
- */
-static void cachefiles_update_object(struct fscache_object *_object)
-{
-	struct cachefiles_object *object;
-	struct cachefiles_cache *cache;
-	const struct cred *saved_cred;
-	struct inode *inode;
-	loff_t object_size, i_size;
-	int ret;
-
-	_enter("{OBJ%x}", _object->debug_id);
-
-	object = container_of(_object, struct cachefiles_object, fscache);
-	cache = container_of(object->fscache.cache, struct cachefiles_cache,
-			     cache);
-
-	cachefiles_begin_secure(cache, &saved_cred);
-
-	object_size = object->fscache.cookie->object_size;
-	inode = d_inode(object->dentry);
-	i_size = i_size_read(inode);
-	if (i_size > object_size) {
-		struct path path = {
-			.mnt	= cache->mnt,
-			.dentry	= object->dentry
-		};
-		_debug("trunc %llx -> %llx", i_size, object_size);
-		trace_cachefiles_trunc(object, inode, i_size, object_size);
-		ret = vfs_truncate(&path, object_size);
-		if (ret < 0) {
-			cachefiles_io_error_obj(object, "Trunc-to-size failed");
-			cachefiles_remove_object_xattr(cache, object->dentry);
-			goto out;
-		}
-
-		object_size = round_up(object_size, CACHEFILES_DIO_BLOCK_SIZE);
-		i_size = i_size_read(inode);
-		_debug("trunc %llx -> %llx", i_size, object_size);
-		if (i_size < object_size) {
-			trace_cachefiles_trunc(object, inode, i_size, object_size);
-			ret = vfs_truncate(&path, object_size);
-			if (ret < 0) {
-				cachefiles_io_error_obj(object, "Trunc-to-dio-size failed");
-				cachefiles_remove_object_xattr(cache, object->dentry);
-				goto out;
-			}
-		}
-	}
-
-	cachefiles_set_object_xattr(object);
-
-out:
-	cachefiles_end_secure(cache, saved_cred);
-	_leave("");
-}
-
 /*
  * Shorten the backing object to discard any dirty data and free up
  * any unused granules.
@@ -655,7 +597,6 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.lookup_object		= cachefiles_lookup_object,
 	.free_lookup_data	= cachefiles_free_lookup_data,
 	.grab_object		= cachefiles_grab_object,
-	.update_object		= cachefiles_update_object,
 	.resize_object		= cachefiles_resize_object,
 	.invalidate_object	= cachefiles_invalidate_object,
 	.drop_object		= cachefiles_drop_object,
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 7a0b36a49457..2670c821e1c9 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -200,7 +200,6 @@ extern atomic_t fscache_n_cop_alloc_object;
 extern atomic_t fscache_n_cop_lookup_object;
 extern atomic_t fscache_n_cop_create_object;
 extern atomic_t fscache_n_cop_invalidate_object;
-extern atomic_t fscache_n_cop_update_object;
 extern atomic_t fscache_n_cop_drop_object;
 extern atomic_t fscache_n_cop_put_object;
 extern atomic_t fscache_n_cop_sync_cache;
diff --git a/fs/fscache/obj.c b/fs/fscache/obj.c
index 332ba132413d..b2e7675a80c1 100644
--- a/fs/fscache/obj.c
+++ b/fs/fscache/obj.c
@@ -54,14 +54,6 @@ static int fscache_do_create_object(struct fscache_object *object, void *data)
 	return ret;
 }
 
-static void fscache_do_update_object(struct fscache_object *object)
-{
-	fscache_stat(&fscache_n_updates_run);
-	fscache_stat(&fscache_n_cop_update_object);
-	object->cache->ops->update_object(object);
-	fscache_stat_d(&fscache_n_cop_update_object);
-}
-
 static void fscache_do_drop_object(struct fscache_cache *cache,
 				   struct fscache_object *object,
 				   bool invalidate)
@@ -279,12 +271,6 @@ void fscache_drop_object(struct fscache_cookie *cookie,
 	_enter("{OBJ%x,%d},%u",
 	       object->debug_id, object->n_children, invalidate);
 
-	if (!invalidate &&
-	    test_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->flags)) {
-		_debug("final update");
-		fscache_do_update_object(object);
-	}
-
 	spin_lock(&cache->object_list_lock);
 	list_del_init(&object->cache_link);
 	spin_unlock(&cache->object_list_lock);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index 3b262af57625..cf71c8b2a22a 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -50,7 +50,6 @@ atomic_t fscache_n_cop_alloc_object;
 atomic_t fscache_n_cop_lookup_object;
 atomic_t fscache_n_cop_create_object;
 atomic_t fscache_n_cop_invalidate_object;
-atomic_t fscache_n_cop_update_object;
 atomic_t fscache_n_cop_drop_object;
 atomic_t fscache_n_cop_put_object;
 atomic_t fscache_n_cop_sync_cache;
@@ -135,9 +134,8 @@ int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "CacheOp: alo=%d luo=%d\n",
 		   atomic_read(&fscache_n_cop_alloc_object),
 		   atomic_read(&fscache_n_cop_lookup_object));
-	seq_printf(m, "CacheOp: inv=%d upo=%d dro=%d pto=%d atc=%d syn=%d\n",
+	seq_printf(m, "CacheOp: inv=%d dro=%d pto=%d atc=%d syn=%d\n",
 		   atomic_read(&fscache_n_cop_invalidate_object),
-		   atomic_read(&fscache_n_cop_update_object),
 		   atomic_read(&fscache_n_cop_drop_object),
 		   atomic_read(&fscache_n_cop_put_object),
 		   atomic_read(&fscache_n_cop_attr_changed),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index adb899448f6e..95f7c60b9092 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -116,8 +116,6 @@ struct fscache_cache_ops {
 	/* unpin an object in the cache */
 	void (*unpin_object)(struct fscache_object *object);
 
-	/* store the updated auxiliary data on an object */
-	void (*update_object)(struct fscache_object *object);
 	/* Change the size of a data object */
 	void (*resize_object)(struct fscache_object *object, loff_t new_size);
 
