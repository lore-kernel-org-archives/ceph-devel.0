From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 15/61] fscache: Remove fscache_attr_changed()
Date: Mon, 04 May 2020 18:09:39 +0100
Message-ID: <158861217939.340223.10943744136296299477.stgit@warthog.procyon.org.uk>
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

Remove fscache_attr_changed() as it's unused.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c     |   13 ++---
 fs/fscache/Makefile           |    3 -
 fs/fscache/page.c             |   98 -----------------------------------------
 include/linux/fscache-cache.h |    4 --
 include/linux/fscache.h       |   21 ---------
 5 files changed, 6 insertions(+), 133 deletions(-)
 delete mode 100644 fs/fscache/page.c

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a3837ed090a8..81322e3acadd 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -10,7 +10,7 @@
 #include <linux/xattr.h>
 #include "internal.h"
 
-static int cachefiles_attr_changed(struct fscache_object *_object);
+static int cachefiles_attr_changed(struct cachefiles_object *object);
 
 /*
  * allocate an object record for a cookie lookup and prepare the lookup data
@@ -110,7 +110,7 @@ static int cachefiles_lookup_object(struct fscache_object *_object)
 	/* polish off by setting the attributes of non-index files */
 	if (ret == 0 &&
 	    object->fscache.cookie->type != FSCACHE_COOKIE_TYPE_INDEX)
-		cachefiles_attr_changed(&object->fscache);
+		cachefiles_attr_changed(object);
 
 	if (ret < 0 && ret != -ETIMEDOUT) {
 		if (ret != -ENOBUFS)
@@ -324,9 +324,8 @@ static void cachefiles_sync_cache(struct fscache_cache *_cache)
  * notification the attributes on an object have changed
  * - called with reads/writes excluded by FS-Cache
  */
-static int cachefiles_attr_changed(struct fscache_object *_object)
+static int cachefiles_attr_changed(struct cachefiles_object *object)
 {
-	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	const struct cred *saved_cred;
 	struct iattr newattrs;
@@ -334,12 +333,11 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 	loff_t oi_size;
 	int ret;
 
-	ni_size = _object->cookie->object_size;
+	ni_size = object->fscache.cookie->object_size;
 
 	_enter("{OBJ%x},[%llu]",
-	       _object->debug_id, (unsigned long long) ni_size);
+	       object->fscache.debug_id, (unsigned long long) ni_size);
 
-	object = container_of(_object, struct cachefiles_object, fscache);
 	cache = container_of(object->fscache.cache,
 			     struct cachefiles_cache, cache);
 
@@ -442,5 +440,4 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.drop_object		= cachefiles_drop_object,
 	.put_object		= cachefiles_put_object,
 	.sync_cache		= cachefiles_sync_cache,
-	.attr_changed		= cachefiles_attr_changed,
 };
diff --git a/fs/fscache/Makefile b/fs/fscache/Makefile
index 79e08e05ef84..565a3441d31d 100644
--- a/fs/fscache/Makefile
+++ b/fs/fscache/Makefile
@@ -10,8 +10,7 @@ fscache-y := \
 	main.o \
 	netfs.o \
 	object.o \
-	operation.o \
-	page.o
+	operation.o
 
 fscache-$(CONFIG_PROC_FS) += proc.o
 fscache-$(CONFIG_FSCACHE_STATS) += stats.o
diff --git a/fs/fscache/page.c b/fs/fscache/page.c
deleted file mode 100644
index 73636e9d652d..000000000000
--- a/fs/fscache/page.c
+++ /dev/null
@@ -1,98 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Cache page management and data I/O routines
- *
- * Copyright (C) 2004-2008 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#define FSCACHE_DEBUG_LEVEL PAGE
-#include <linux/module.h>
-#include <linux/fscache-cache.h>
-#include <linux/buffer_head.h>
-#include <linux/pagevec.h>
-#include <linux/slab.h>
-#include "internal.h"
-
-/*
- * actually apply the changed attributes to a cache object
- */
-static void fscache_attr_changed_op(struct fscache_operation *op)
-{
-	struct fscache_object *object = op->object;
-	int ret;
-
-	_enter("{OBJ%x OP%x}", object->debug_id, op->debug_id);
-
-	fscache_stat(&fscache_n_attr_changed_calls);
-
-	if (fscache_object_is_active(object)) {
-		fscache_stat(&fscache_n_cop_attr_changed);
-		ret = object->cache->ops->attr_changed(object);
-		fscache_stat_d(&fscache_n_cop_attr_changed);
-		if (ret < 0)
-			fscache_abort_object(object);
-		fscache_op_complete(op, ret < 0);
-	} else {
-		fscache_op_complete(op, true);
-	}
-
-	_leave("");
-}
-
-/*
- * notification that the attributes on an object have changed
- */
-int __fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	struct fscache_operation *op;
-	struct fscache_object *object;
-	bool wake_cookie = false;
-
-	_enter("%p", cookie);
-
-	ASSERTCMP(cookie->type, !=, FSCACHE_COOKIE_TYPE_INDEX);
-
-	fscache_stat(&fscache_n_attr_changed);
-
-	op = kzalloc(sizeof(*op), GFP_KERNEL);
-	if (!op) {
-		fscache_stat(&fscache_n_attr_changed_nomem);
-		_leave(" = -ENOMEM");
-		return -ENOMEM;
-	}
-
-	fscache_operation_init(cookie, op, fscache_attr_changed_op, NULL, NULL);
-	trace_fscache_page_op(cookie, NULL, op, fscache_page_op_attr_changed);
-	op->flags = FSCACHE_OP_ASYNC |
-		(1 << FSCACHE_OP_EXCLUSIVE) |
-		(1 << FSCACHE_OP_UNUSE_COOKIE);
-
-	spin_lock(&cookie->lock);
-
-	if (!fscache_cookie_enabled(cookie) ||
-	    hlist_empty(&cookie->backing_objects))
-		goto nobufs;
-	object = hlist_entry(cookie->backing_objects.first,
-			     struct fscache_object, cookie_link);
-
-	__fscache_use_cookie(cookie);
-	if (fscache_submit_exclusive_op(object, op) < 0)
-		goto nobufs_dec;
-	spin_unlock(&cookie->lock);
-	fscache_stat(&fscache_n_attr_changed_ok);
-	fscache_put_operation(op);
-	_leave(" = 0");
-	return 0;
-
-nobufs_dec:
-	wake_cookie = __fscache_unuse_cookie(cookie);
-nobufs:
-	spin_unlock(&cookie->lock);
-	fscache_put_operation(op);
-	if (wake_cookie)
-		__fscache_wake_unused_cookie(cookie);
-	fscache_stat(&fscache_n_attr_changed_nobufs);
-	_leave(" = %d", -ENOBUFS);
-	return -ENOBUFS;
-}
-EXPORT_SYMBOL(__fscache_attr_changed);
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 3a78e41d2338..627e1ab7123d 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -184,10 +184,6 @@ struct fscache_cache_ops {
 	/* sync a cache */
 	void (*sync_cache)(struct fscache_cache *cache);
 
-	/* notification that the attributes of a non-index object (such as
-	 * i_size) have changed */
-	int (*attr_changed)(struct fscache_object *object);
-
 	/* reserve space for an object's data and associated metadata */
 	int (*reserve_space)(struct fscache_object *object, loff_t i_size);
 };
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 82e871a3dc6a..5eb2ac5f2bf1 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -140,7 +140,6 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	loff_t, bool);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, const void *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *);
-extern int __fscache_attr_changed(struct fscache_cookie *);
 extern void __fscache_invalidate(struct fscache_cookie *);
 extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 extern void __fscache_disable_cookie(struct fscache_cookie *, const void *, bool);
@@ -337,26 +336,6 @@ void fscache_unpin_cookie(struct fscache_cookie *cookie)
 {
 }
 
-/**
- * fscache_attr_changed - Notify cache that an object's attributes changed
- * @cookie: The cookie representing the cache object
- *
- * Send a notification to the cache indicating that an object's attributes have
- * changed.  This includes the data size.  These attributes will be obtained
- * through the get_attr() cookie definition op.
- *
- * See Documentation/filesystems/caching/netfs-api.txt for a complete
- * description.
- */
-static inline
-int fscache_attr_changed(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
-		return __fscache_attr_changed(cookie);
-	else
-		return -ENOBUFS;
-}
-
 /**
  * fscache_invalidate - Notify cache that an object needs invalidation
  * @cookie: The cookie representing the cache object
