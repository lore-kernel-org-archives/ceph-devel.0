From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 44/61] fscache: Provide resize operation
Date: Mon, 04 May 2020 18:14:08 +0100
Message-ID: <158861244798.340223.6974262825556909616.stgit@warthog.procyon.org.uk>
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

Provide a cache operation to resize an object.  This is intended to be run
synchronously rather than being deferred as it really needs to run inside
the inode lock on the netfs inode from ->setattr() to correctly order with
respect to other truncates and writes.

Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 fs/cachefiles/interface.c     |   24 ++++++++++++++++++++++++
 fs/fscache/internal.h         |    3 +++
 fs/fscache/io.c               |   27 +++++++++++++++++++++++++++
 fs/fscache/stats.c            |    9 +++++++--
 include/linux/fscache-cache.h |    2 ++
 include/linux/fscache.h       |   18 ++++++++++++++++++
 6 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 457adfca5931..f9c2c09e1713 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -248,6 +248,29 @@ static bool cachefiles_shorten_object(struct cachefiles_object *object, loff_t n
 	return true;
 }
 
+/*
+ * Resize the backing object.
+ */
+static void cachefiles_resize_object(struct fscache_object *_object, loff_t new_size)
+{
+	struct cachefiles_object *object =
+		container_of(_object, struct cachefiles_object, fscache);
+	loff_t old_size = object->fscache.cookie->object_size;
+
+	_enter("%llu->%llu", old_size, new_size);
+
+	if (new_size < old_size) {
+		cachefiles_shorten_content_map(object, new_size);
+		cachefiles_shorten_object(object, new_size);
+		return;
+	}
+
+	/* The file is being expanded.  We don't need to do anything
+	 * particularly.  cookie->initial_size doesn't change and so the point
+	 * at which we have to download before doesn't change.
+	 */
+}
+
 /*
  * Trim excess stored data off of an object.
  */
@@ -633,6 +656,7 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.free_lookup_data	= cachefiles_free_lookup_data,
 	.grab_object		= cachefiles_grab_object,
 	.update_object		= cachefiles_update_object,
+	.resize_object		= cachefiles_resize_object,
 	.invalidate_object	= cachefiles_invalidate_object,
 	.drop_object		= cachefiles_drop_object,
 	.put_object		= cachefiles_put_object,
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 0b370d059bdf..7a0b36a49457 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -176,6 +176,9 @@ extern atomic_t fscache_n_updates;
 extern atomic_t fscache_n_updates_null;
 extern atomic_t fscache_n_updates_run;
 
+extern atomic_t fscache_n_resizes;
+extern atomic_t fscache_n_resizes_null;
+
 extern atomic_t fscache_n_relinquishes;
 extern atomic_t fscache_n_relinquishes_null;
 extern atomic_t fscache_n_relinquishes_retire;
diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index b6ec15588334..8c95679203e7 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -175,3 +175,30 @@ int __fscache_write(struct fscache_io_request *req, struct iov_iter *iter)
 	}
 }
 EXPORT_SYMBOL(__fscache_write);
+
+/*
+ * Change the size of a backing object.
+ */
+void __fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
+{
+	struct fscache_object *object;
+
+	ASSERT(cookie->type != FSCACHE_COOKIE_TYPE_INDEX);
+
+	object = fscache_begin_io_operation(cookie, FSCACHE_WANT_WRITE, NULL);
+	if (!IS_ERR(object)) {
+		fscache_stat(&fscache_n_resizes);
+		set_bit(FSCACHE_OBJECT_NEEDS_UPDATE, &object->flags);
+
+		/* We cannot defer a resize as we need to do it inside the
+		 * netfs's inode lock so that we're serialised with respect to
+		 * writes.
+		 */
+		object->cache->ops->resize_object(object, new_size);
+		object->cache->ops->put_object(object, fscache_obj_put_ioreq);
+		fscache_end_io_operation(cookie);
+	} else {
+		fscache_stat(&fscache_n_resizes_null);
+	}
+}
+EXPORT_SYMBOL(__fscache_resize_cookie);
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index fdea31ff8e69..3b262af57625 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -26,6 +26,9 @@ atomic_t fscache_n_updates;
 atomic_t fscache_n_updates_null;
 atomic_t fscache_n_updates_run;
 
+atomic_t fscache_n_resizes;
+atomic_t fscache_n_resizes_null;
+
 atomic_t fscache_n_relinquishes;
 atomic_t fscache_n_relinquishes_null;
 atomic_t fscache_n_relinquishes_retire;
@@ -117,10 +120,12 @@ int fscache_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "Invals : n=%u\n",
 		   atomic_read(&fscache_n_invalidates));
 
-	seq_printf(m, "Updates: n=%u nul=%u run=%u\n",
+	seq_printf(m, "Updates: n=%u nul=%u run=%u rsz=%u rsn=%u\n",
 		   atomic_read(&fscache_n_updates),
 		   atomic_read(&fscache_n_updates_null),
-		   atomic_read(&fscache_n_updates_run));
+		   atomic_read(&fscache_n_updates_run),
+		   atomic_read(&fscache_n_resizes),
+		   atomic_read(&fscache_n_resizes_null));
 
 	seq_printf(m, "Relinqs: n=%u nul=%u rtr=%u\n",
 		   atomic_read(&fscache_n_relinquishes),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 848ced13c4ae..adb899448f6e 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -118,6 +118,8 @@ struct fscache_cache_ops {
 
 	/* store the updated auxiliary data on an object */
 	void (*update_object)(struct fscache_object *object);
+	/* Change the size of a data object */
+	void (*resize_object)(struct fscache_object *object, loff_t new_size);
 
 	/* Invalidate an object */
 	bool (*invalidate_object)(struct fscache_object *object,
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 2390af45d751..a5fd1e365fd9 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -199,6 +199,7 @@ extern void __fscache_use_cookie(struct fscache_cookie *, bool);
 extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
+extern void __fscache_resize_cookie(struct fscache_cookie *, loff_t);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern unsigned int __fscache_shape_extent(struct fscache_cookie *,
 					   struct fscache_extent *,
@@ -401,6 +402,23 @@ void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
 		__fscache_update_cookie(cookie, aux_data, object_size);
 }
 
+/**
+ * fscache_resize_cookie - Request that a cache object be resized
+ * @cookie: The cookie representing the cache object
+ * @new_size: The new size of the object (may be NULL)
+ *
+ * Request that the size of an object be changed.
+ *
+ * See Documentation/filesystems/caching/netfs-api.txt for a complete
+ * description.
+ */
+static inline
+void fscache_resize_cookie(struct fscache_cookie *cookie, loff_t new_size)
+{
+	if (fscache_cookie_valid(cookie))
+		__fscache_resize_cookie(cookie, new_size);
+}
+
 /**
  * fscache_pin_cookie - Pin a data-storage cache object in its cache
  * @cookie: The cookie representing the cache object
