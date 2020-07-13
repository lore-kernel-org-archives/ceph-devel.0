From: David Howells <dhowells@redhat.com>
Subject: [PATCH 25/32] fscache: Display cache-specific data
 in /proc/fs/fscache/objects
Date: Mon, 13 Jul 2020 17:35:20 +0100
Message-ID: <159465812047.1376674.773368234437370021.stgit@warthog.procyon.org.uk>
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

Allow the cache to add information in /proc/fs/fscache/objects instead of
displaying cookie key and aux data - which can be seen in the cookies file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/content-map.c   |   41 +++++++++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c     |    1 +
 fs/cachefiles/internal.h      |    1 +
 fs/fscache/object-list.c      |   33 +++------------------------------
 include/linux/fscache-cache.h |    4 ++++
 5 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 91c44bb39a93..f2a10e8d8d6d 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -396,3 +396,44 @@ void cachefiles_save_content_map(struct cachefiles_object *object)
 
 	_leave(" = %zd", ret);
 }
+
+/*
+ * Display object information in proc.
+ */
+int cachefiles_display_object(struct seq_file *m, struct fscache_object *_object)
+{
+	struct cachefiles_object *object =
+		container_of(_object, struct cachefiles_object, fscache);
+
+	if (object->fscache.cookie->type == FSCACHE_COOKIE_TYPE_INDEX) {
+		if (object->content_info != CACHEFILES_CONTENT_NO_DATA)
+			seq_printf(m, " ???%u???", object->content_info);
+	} else {
+		switch (object->content_info) {
+		case CACHEFILES_CONTENT_NO_DATA:
+			seq_puts(m, " <n>");
+			break;
+		case CACHEFILES_CONTENT_SINGLE:
+			seq_puts(m, " <s>");
+			break;
+		case CACHEFILES_CONTENT_ALL:
+			seq_puts(m, " <a>");
+			break;
+		case CACHEFILES_CONTENT_MAP:
+			read_lock_bh(&object->content_map_lock);
+			if (object->content_map) {
+				seq_printf(m, " %*phN",
+					   object->content_map_size,
+					   object->content_map);
+			}
+			read_unlock_bh(&object->content_map_lock);
+			break;
+		default:
+			seq_printf(m, " <%u>", object->content_info);
+			break;
+		}
+	}
+
+	seq_putc(m, '\n');
+	return 0;
+}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index e73de62d0e73..78180d269c5f 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -491,4 +491,5 @@ const struct fscache_cache_ops cachefiles_cache_ops = {
 	.shape_request		= cachefiles_shape_request,
 	.read			= cachefiles_read,
 	.write			= cachefiles_write,
+	.display_object		= cachefiles_display_object,
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ea469b77712..c91a9b3c5bd5 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -132,6 +132,7 @@ extern void cachefiles_expand_content_map(struct cachefiles_object *object, loff
 extern void cachefiles_shorten_content_map(struct cachefiles_object *object, loff_t new_size);
 extern bool cachefiles_load_content_map(struct cachefiles_object *object);
 extern void cachefiles_save_content_map(struct cachefiles_object *object);
+extern int cachefiles_display_object(struct seq_file *m, struct fscache_object *object);
 
 /*
  * daemon.c
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index 5777f909d31a..361610e124bd 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -155,7 +155,6 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 	struct fscache_cookie *cookie;
 	unsigned long config = data->config;
 	char _type[3], *type;
-	u8 *p;
 
 	if ((unsigned long) v == 1) {
 		seq_puts(m, "OBJECT   PARENT   USE CHLDN OPS FL  S"
@@ -201,8 +200,6 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 		   obj->stage);
 
 	if (obj->cookie) {
-		uint16_t keylen = 0, auxlen = 0;
-
 		switch (cookie->type) {
 		case 0:
 			type = "IX";
@@ -211,8 +208,7 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 			type = "DT";
 			break;
 		default:
-			snprintf(_type, sizeof(_type), "%02u",
-				 cookie->type);
+			snprintf(_type, sizeof(_type), "%02x", cookie->type);
 			type = _type;
 			break;
 		}
@@ -223,34 +219,11 @@ static int fscache_objlist_show(struct seq_file *m, void *v)
 			   type,
 			   cookie->stage,
 			   cookie->flags);
-
-		if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-			keylen = cookie->key_len;
-
-		if (config & FSCACHE_OBJLIST_CONFIG_AUX)
-			auxlen = cookie->aux_len;
-
-		if (keylen > 0 || auxlen > 0) {
-			seq_puts(m, " ");
-			p = keylen <= sizeof(cookie->inline_key) ?
-				cookie->inline_key : cookie->key;
-			for (; keylen > 0; keylen--)
-				seq_printf(m, "%02x", *p++);
-			if (auxlen > 0) {
-				if (config & FSCACHE_OBJLIST_CONFIG_KEY)
-					seq_puts(m, ", ");
-				p = auxlen <= sizeof(cookie->inline_aux) ?
-					cookie->inline_aux : cookie->aux;
-				for (; auxlen > 0; auxlen--)
-					seq_printf(m, "%02x", *p++);
-			}
-		}
-
-		seq_puts(m, "\n");
 	} else {
 		seq_puts(m, "<no_netfs>\n");
 	}
-	return 0;
+
+	return obj->cache->ops->display_object(m, obj);
 }
 
 static const struct seq_operations fscache_objlist_ops = {
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 81a41e37f07b..1357c44d371b 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -19,6 +19,7 @@
 
 #define NR_MAXCACHES BITS_PER_LONG
 
+struct seq_file;
 struct fscache_cache;
 struct fscache_cache_ops;
 struct fscache_object;
@@ -151,6 +152,9 @@ struct fscache_cache_ops {
 	int (*write)(struct fscache_object *object,
 		     struct fscache_io_request *req,
 		     struct iov_iter *iter);
+
+	/* Display object info in /proc/fs/fscache/objects */
+	int (*display_object)(struct seq_file *m, struct fscache_object *object);
 };
 
 extern struct fscache_cookie fscache_fsdef_index;
