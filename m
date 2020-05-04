From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 30/61] cachefiles: Split cachefiles_drop_object() up a bit
Date: Mon, 04 May 2020 18:12:00 +0100
Message-ID: <158861232027.340223.4423626519002421674.stgit@warthog.procyon.org.uk>
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

Split cachefiles_drop_object() up a bit to make it easier to modify later.

Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 fs/cachefiles/interface.c |   58 ++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index daa4f316d104..47596b58c2da 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -192,6 +192,42 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	_leave("");
 }
 
+/*
+ * Commit changes to the object as we drop it.
+ */
+static void cachefiles_commit_object(struct cachefiles_object *object,
+				     struct cachefiles_cache *cache)
+{
+}
+
+/*
+ * Finalise and object and close the VFS structs that we have.
+ */
+static void cachefiles_clean_up_object(struct cachefiles_object *object,
+				       struct cachefiles_cache *cache,
+				       bool invalidate)
+{
+	if (invalidate && &object->fscache != cache->cache.fsdef) {
+		_debug("- inval object OBJ%x", object->fscache.debug_id);
+		cachefiles_delete_object(cache, object);
+	} else {
+		cachefiles_commit_object(object, cache);
+ 	}
+
+	/* close the filesystem stuff attached to the object */
+	if (object->backing_file)
+		fput(object->backing_file);
+	object->backing_file = NULL;
+
+	if (object->backer != object->dentry)
+		dput(object->backer);
+	object->backer = NULL;
+
+	cachefiles_unmark_inode_in_use(object, object->dentry);
+	dput(object->dentry);
+	object->dentry = NULL;
+}
+
 /*
  * discard the resources pinned by an object and effect retirement if
  * requested
@@ -223,25 +259,9 @@ static void cachefiles_drop_object(struct fscache_object *_object,
 	 * before we set it up.
 	 */
 	if (object->dentry) {
-		if (invalidate && _object != cache->cache.fsdef) {
-			_debug("- inval object OBJ%x", object->fscache.debug_id);
-			cachefiles_begin_secure(cache, &saved_cred);
-			cachefiles_delete_object(cache, object);
-			cachefiles_end_secure(cache, saved_cred);
-		}
-
-		/* close the filesystem stuff attached to the object */
-		if (object->backing_file)
-			fput(object->backing_file);
-		object->backing_file = NULL;
-
-		if (object->backer != object->dentry)
-			dput(object->backer);
-		object->backer = NULL;
-
-		cachefiles_unmark_inode_in_use(object, object->dentry);
-		dput(object->dentry);
-		object->dentry = NULL;
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_clean_up_object(object, cache, invalidate);
+		cachefiles_end_secure(cache, saved_cred);
 	}
 
 	_leave("");
