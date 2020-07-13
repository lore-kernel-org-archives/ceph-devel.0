From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/32] fscache,
	cachefiles: Fix disabled histogram warnings
Date: Mon, 13 Jul 2020 17:32:54 +0100
Message-ID: <159465797497.1376674.14328755555295693847.stgit@warthog.procyon.org.uk>
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

Fix variable unused warnings due to disabled histogram stuff.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/internal.h |    7 +++++--
 fs/fscache/internal.h    |    6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b89f76a03546..16d15291a629 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -143,11 +143,11 @@ extern int cachefiles_check_in_use(struct cachefiles_cache *cache,
 /*
  * proc.c
  */
-#ifdef CONFIG_CACHEFILES_HISTOGRAM
 extern atomic_t cachefiles_lookup_histogram[HZ];
 extern atomic_t cachefiles_mkdir_histogram[HZ];
 extern atomic_t cachefiles_create_histogram[HZ];
 
+#ifdef CONFIG_CACHEFILES_HISTOGRAM
 extern int __init cachefiles_proc_init(void);
 extern void cachefiles_proc_cleanup(void);
 static inline
@@ -162,7 +162,10 @@ void cachefiles_hist(atomic_t histogram[], unsigned long start_jif)
 #else
 #define cachefiles_proc_init()		(0)
 #define cachefiles_proc_cleanup()	do {} while (0)
-#define cachefiles_hist(hist, start_jif) do {} while (0)
+static inline
+void cachefiles_hist(atomic_t histogram[], unsigned long start_jif)
+{
+}
 #endif
 
 /*
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index 443671310e31..a70c1a612309 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -95,13 +95,13 @@ extern struct fscache_cookie fscache_fsdef_index;
 /*
  * histogram.c
  */
-#ifdef CONFIG_FSCACHE_HISTOGRAM
 extern atomic_t fscache_obj_instantiate_histogram[HZ];
 extern atomic_t fscache_objs_histogram[HZ];
 extern atomic_t fscache_ops_histogram[HZ];
 extern atomic_t fscache_retrieval_delay_histogram[HZ];
 extern atomic_t fscache_retrieval_histogram[HZ];
 
+#ifdef CONFIG_FSCACHE_HISTOGRAM
 static inline void fscache_hist(atomic_t histogram[], unsigned long start_jif)
 {
 	unsigned long jif = jiffies - start_jif;
@@ -113,7 +113,9 @@ static inline void fscache_hist(atomic_t histogram[], unsigned long start_jif)
 extern const struct seq_operations fscache_histogram_ops;
 
 #else
-#define fscache_hist(hist, start_jif) do {} while (0)
+static inline void fscache_hist(atomic_t histogram[], unsigned long start_jif)
+{
+}
 #endif
 
 /*
