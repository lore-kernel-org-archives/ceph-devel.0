From: Hongyi Jia <milosz@adfin.com>
Subject: [PATCH 2/3] new fscache interface to check cache
	consistency
Date: Wed, 7 Aug 2013 19:15:58 -0400
Message-ID: <0a5d5f8c27e1f6f1c52ce762d34b4f2d80dd08de.1375645743.git.milosz@adfin.com>
References: <cover.1375645743.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
Content-Disposition: inline
In-Reply-To: <cover.1375645743.git.milosz@adfin.com>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, zheng.z.yan@intel.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Signed-off-by: Hongyi Jia <jiayisuse@gmail.com>
Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/fscache/cookie.c           | 22 ++++++++++++++++++++++
 include/linux/fscache-cache.h |  4 ++++
 include/linux/fscache.h       | 17 +++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 0e91a3c..bfa1d3b 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -533,6 +533,28 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie, int retire)
 EXPORT_SYMBOL(__fscache_relinquish_cookie);
 
 /*
+ * check the consistency between the netfs inode and the backing cache
+ *
+ * NOTE: it only serves no-index type
+ */
+bool __fscache_check_consistency(struct fscache_cookie *cookie)
+{
+	struct fscache_object *object;
+
+	if (cookie->def->type != FSCACHE_COOKIE_TYPE_DATAFILE)
+		return false;
+
+	if (hlist_empty(&cookie->backing_objects))
+		return false;
+
+	object = hlist_entry(cookie->backing_objects.first,
+			struct fscache_object, cookie_link);
+
+	return object->cache->ops->check_consistency(object);
+}
+EXPORT_SYMBOL(__fscache_check_consistency);
+
+/*
  * destroy a cookie
  */
 void __fscache_cookie_put(struct fscache_cookie *cookie)
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index a9ff9a3..5513342 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -302,6 +302,10 @@ struct fscache_cache_ops {
 
 	/* dissociate a cache from all the pages it was backing */
 	void (*dissociate_pages)(struct fscache_cache *cache);
+
+	/* check the consistency between the backing cache and the FS-Cache
+	 * cookie */
+	bool (*check_consistency)(struct fscache_object *object);
 };
 
 /*
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 7a08623..7a49e8f 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -183,6 +183,7 @@ extern struct fscache_cookie *__fscache_acquire_cookie(
 	const struct fscache_cookie_def *,
 	void *);
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, int);
+extern bool __fscache_check_consistency(struct fscache_cookie *);
 extern void __fscache_update_cookie(struct fscache_cookie *);
 extern int __fscache_attr_changed(struct fscache_cookie *);
 extern void __fscache_invalidate(struct fscache_cookie *);
@@ -326,6 +327,22 @@ void fscache_relinquish_cookie(struct fscache_cookie *cookie, int retire)
 }
 
 /**
+ * fscache_check_consistency - Request that if the cache is updated
+ * @cookie: The cookie representing the cache object
+ *
+ * Request an consistency check from fscache, which resorts to backing
+ * cache.
+ */
+static inline
+bool fscache_check_consistency(struct fscache_cookie *cookie)
+{
+	if (fscache_cookie_valid(cookie))
+		return __fscache_check_consistency(cookie);
+	else
+		return false;
+}
+
+/**
  * fscache_update_cookie - Request that a cache object be updated
  * @cookie: The cookie representing the cache object
  *
-- 
1.8.1.2
