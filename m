From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 08/61] fscache: Procfile to display cookies
Date: Mon, 04 May 2020 18:08:38 +0100
Message-ID: <158861211871.340223.7223853943667440807.stgit@warthog.procyon.org.uk>
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

Add /proc/fs/fscache/cookies to display active cookies.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c     |  103 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fscache/internal.h   |    1 
 fs/fscache/proc.c       |    7 +++
 include/linux/fscache.h |    1 
 4 files changed, 112 insertions(+)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index b94e3995011e..477c5fb349ee 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -19,6 +19,8 @@ static atomic_t fscache_object_debug_id = ATOMIC_INIT(0);
 
 #define fscache_cookie_hash_shift 15
 static struct hlist_bl_head fscache_cookie_hash[1 << fscache_cookie_hash_shift];
+static LIST_HEAD(fscache_cookies);
+static DEFINE_RWLOCK(fscache_cookies_lock);
 
 static int fscache_acquire_non_index_cookie(struct fscache_cookie *cookie,
 					    loff_t object_size);
@@ -65,6 +67,9 @@ void fscache_free_cookie(struct fscache_cookie *cookie)
 {
 	if (cookie) {
 		BUG_ON(!hlist_empty(&cookie->backing_objects));
+		write_lock(&fscache_cookies_lock);
+		list_del(&cookie->proc_link);
+		write_unlock(&fscache_cookies_lock);
 		if (cookie->aux_len > sizeof(cookie->inline_aux))
 			kfree(cookie->aux);
 		if (cookie->key_len > sizeof(cookie->inline_key))
@@ -192,6 +197,10 @@ struct fscache_cookie *fscache_alloc_cookie(
 	/* radix tree insertion won't use the preallocation pool unless it's
 	 * told it may not wait */
 	INIT_RADIX_TREE(&cookie->stores, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
+
+	write_lock(&fscache_cookies_lock);
+	list_add_tail(&cookie->proc_link, &fscache_cookies);
+	write_unlock(&fscache_cookies_lock);
 	return cookie;
 
 nomem:
@@ -969,3 +978,97 @@ int __fscache_check_consistency(struct fscache_cookie *cookie,
 	return -ESTALE;
 }
 EXPORT_SYMBOL(__fscache_check_consistency);
+
+/*
+ * Generate a list of extant cookies in /proc/fs/fscache/cookies
+ */
+static int fscache_cookies_seq_show(struct seq_file *m, void *v)
+{
+	struct fscache_cookie *cookie;
+	unsigned int keylen = 0, auxlen = 0;
+	char _type[3], *type;
+	u8 *p;
+
+	if (v == &fscache_cookies) {
+		seq_puts(m,
+			 "COOKIE   PARENT   USAGE CHILD ACT TY FL  DEF              NETFS_DATA\n"
+			 "======== ======== ===== ===== === == === ================ ==========\n"
+			 );
+		return 0;
+	}
+
+	cookie = list_entry(v, struct fscache_cookie, proc_link);
+
+	switch (cookie->type) {
+	case 0:
+		type = "IX";
+		break;
+	case 1:
+		type = "DT";
+		break;
+	default:
+		snprintf(_type, sizeof(_type), "%02u",
+			 cookie->type);
+		type = _type;
+		break;
+	}
+
+	seq_printf(m,
+		   "%08x %08x %5u %5u %3u %s %03lx %-16s %px",
+		   cookie->debug_id,
+		   cookie->parent ? cookie->parent->debug_id : 0,
+		   atomic_read(&cookie->usage),
+		   atomic_read(&cookie->n_children),
+		   atomic_read(&cookie->n_active),
+		   type,
+		   cookie->flags,
+		   cookie->def->name,
+		   cookie->netfs_data);
+
+	keylen = cookie->key_len;
+	auxlen = cookie->aux_len;
+
+	if (keylen > 0 || auxlen > 0) {
+		seq_puts(m, " ");
+		p = keylen <= sizeof(cookie->inline_key) ?
+			cookie->inline_key : cookie->key;
+		for (; keylen > 0; keylen--)
+			seq_printf(m, "%02x", *p++);
+		if (auxlen > 0) {
+			seq_puts(m, ", ");
+			p = auxlen <= sizeof(cookie->inline_aux) ?
+				cookie->inline_aux : cookie->aux;
+			for (; auxlen > 0; auxlen--)
+				seq_printf(m, "%02x", *p++);
+		}
+	}
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static void *fscache_cookies_seq_start(struct seq_file *m, loff_t *_pos)
+	__acquires(fscache_cookies_lock)
+{
+	read_lock(&fscache_cookies_lock);
+	return seq_list_start_head(&fscache_cookies, *_pos);
+}
+
+static void *fscache_cookies_seq_next(struct seq_file *m, void *v, loff_t *_pos)
+{
+	return seq_list_next(v, &fscache_cookies, _pos);
+}
+
+static void fscache_cookies_seq_stop(struct seq_file *m, void *v)
+	__releases(rcu)
+{
+	read_unlock(&fscache_cookies_lock);
+}
+
+
+const struct seq_operations fscache_cookies_seq_ops = {
+	.start  = fscache_cookies_seq_start,
+	.next   = fscache_cookies_seq_next,
+	.stop   = fscache_cookies_seq_stop,
+	.show   = fscache_cookies_seq_show,
+};
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 08e91efbce53..4b535c2dae4a 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -45,6 +45,7 @@ extern struct fscache_cache *fscache_select_cache_for_object(
  * cookie.c
  */
 extern struct kmem_cache *fscache_cookie_jar;
+extern const struct seq_operations fscache_cookies_seq_ops;
 
 extern void fscache_free_cookie(struct fscache_cookie *);
 extern struct fscache_cookie *fscache_alloc_cookie(struct fscache_cookie *,
diff --git a/fs/fscache/proc.c b/fs/fscache/proc.c
index 90a7bc22f7e1..da51fdfc8641 100644
--- a/fs/fscache/proc.c
+++ b/fs/fscache/proc.c
@@ -21,6 +21,10 @@ int __init fscache_proc_init(void)
 	if (!proc_mkdir("fs/fscache", NULL))
 		goto error_dir;
 
+	if (!proc_create_seq("fs/fscache/cookies", S_IFREG | 0444, NULL,
+			     &fscache_cookies_seq_ops))
+		goto error_cookies;
+
 #ifdef CONFIG_FSCACHE_STATS
 	if (!proc_create_single("fs/fscache/stats", S_IFREG | 0444, NULL,
 			fscache_stats_show))
@@ -53,6 +57,8 @@ int __init fscache_proc_init(void)
 	remove_proc_entry("fs/fscache/stats", NULL);
 error_stats:
 #endif
+	remove_proc_entry("fs/fscache/cookies", NULL);
+error_cookies:
 	remove_proc_entry("fs/fscache", NULL);
 error_dir:
 	_leave(" = -ENOMEM");
@@ -73,5 +79,6 @@ void fscache_proc_cleanup(void)
 #ifdef CONFIG_FSCACHE_STATS
 	remove_proc_entry("fs/fscache/stats", NULL);
 #endif
+	remove_proc_entry("fs/fscache/cookies", NULL);
 	remove_proc_entry("fs/fscache", NULL);
 }
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 0229bb80b73c..38ec80217899 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -141,6 +141,7 @@ struct fscache_cookie {
 	const struct fscache_cookie_def	*def;		/* definition */
 	struct fscache_cookie		*parent;	/* parent of this entry */
 	struct hlist_bl_node		hash_link;	/* Link in hash table */
+	struct list_head		proc_link;	/* Link in proc list */
 	void				*netfs_data;	/* back pointer to netfs */
 	struct radix_tree_root		stores;		/* pages to be stored on this cookie */
 #define FSCACHE_COOKIE_PENDING_TAG	0		/* pages tag: pending write to cache */
