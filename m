From: David Howells <dhowells@redhat.com>
Subject: [PATCH 10/32] fscache: Remove
	fscache_wait_on_invalidate()
Date: Mon, 13 Jul 2020 17:32:31 +0100
Message-ID: <159465795136.1376674.599056208279354471.stgit@warthog.procyon.org.uk>
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

Remove fscache_wait_on_invalidate() as the invalidation wait is now built into
the I/O path.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cookie.c     |   14 --------------
 include/linux/fscache.h |   17 -----------------
 2 files changed, 31 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index a8aa1639e93b..a1eba3be9ce8 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -492,20 +492,6 @@ void __fscache_invalidate(struct fscache_cookie *cookie)
 }
 EXPORT_SYMBOL(__fscache_invalidate);
 
-/*
- * Wait for object invalidation to complete.
- */
-void __fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	_enter("%p", cookie);
-
-	wait_on_bit(&cookie->flags, FSCACHE_COOKIE_INVALIDATING,
-		    TASK_UNINTERRUPTIBLE);
-
-	_leave("");
-}
-EXPORT_SYMBOL(__fscache_wait_on_invalidate);
-
 /*
  * Update the index entries backing a cookie.  The writeback is done lazily.
  */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index aec75fc0d297..56fdd0e74a88 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -217,7 +217,6 @@ extern void __fscache_unuse_cookie(struct fscache_cookie *, const void *, const
 extern void __fscache_relinquish_cookie(struct fscache_cookie *, bool);
 extern void __fscache_update_cookie(struct fscache_cookie *, const void *, const loff_t *);
 extern void __fscache_invalidate(struct fscache_cookie *);
-extern void __fscache_wait_on_invalidate(struct fscache_cookie *);
 extern void __fscache_shape_request(struct fscache_cookie *, struct fscache_request_shape *);
 extern void __fscache_init_io_request(struct fscache_io_request *,
 				      struct fscache_cookie *);
@@ -466,22 +465,6 @@ void fscache_invalidate(struct fscache_cookie *cookie)
 		__fscache_invalidate(cookie);
 }
 
-/**
- * fscache_wait_on_invalidate - Wait for invalidation to complete
- * @cookie: The cookie representing the cache object
- *
- * Wait for the invalidation of an object to complete.
- *
- * See Documentation/filesystems/caching/netfs-api.rst for a complete
- * description.
- */
-static inline
-void fscache_wait_on_invalidate(struct fscache_cookie *cookie)
-{
-	if (fscache_cookie_valid(cookie))
-		__fscache_wait_on_invalidate(cookie);
-}
-
 /**
  * fscache_init_io_request - Initialise an I/O request
  * @req: The I/O request to initialise
