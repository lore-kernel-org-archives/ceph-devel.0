From: Milosz Tanski <milosz@adfin.com>
Subject: Fwd: [PATCH] FS-Cache: Fix handling of an attempt to store a page
 that is now beyond EOF
Date: Mon, 11 Nov 2013 18:32:35 -0500
Message-ID: <CANP1eJF0WKgGxv5zMP-syi7j07j2sW6mQon0PcS2QdytQyOYTg@mail.gmail.com>
References: <20131111221804.23212.30560.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:33537 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3KKXch (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 18:32:37 -0500
Received: by mail-we0-f179.google.com with SMTP id x55so1272678wes.38
        for <ceph-devel@vger.kernel.org>; Mon, 11 Nov 2013 15:32:36 -0800 (PST)
In-Reply-To: <20131111221804.23212.30560.stgit@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

For those of you working on fscache.


---------- Forwarded message ----------
From: David Howells <dhowells@redhat.com>
Date: Mon, Nov 11, 2013 at 5:18 PM
Subject: [PATCH] FS-Cache: Fix handling of an attempt to store a page
that is now beyond EOF
To: torvalds@linux-foundation.org
Cc: linux-cachefs@redhat.com, linux-kernel@vger.kernel.org, Milosz
Tanski <milosz@adfin.com>


Fix the handling of an attempt to store a page that is now beyond EOF.  This
may happen, for example, if the page got pushed for storage before the netfs
file got truncated on the server.  In such a case, we should just remove the
excessive pages from the cookie->stores radix tree and wake up the waiter.

This can be seen in /proc/fs/fscache/stats on this line:

        Stores : ops=350 run=1895 pgs=1545 rxd=1727 olm=9

where olm=N has N > 0.

Reported-by: Milosz Tanski <milosz@adfin.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Milosz Tanski <milosz@adfin.com>
---

 fs/fscache/page.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/fscache/page.c b/fs/fscache/page.c
index 7f5c658af755..b4730cf52aec 100644
--- a/fs/fscache/page.c
+++ b/fs/fscache/page.c
@@ -755,6 +755,7 @@ static void fscache_write_op(struct fscache_operation *_op)
        struct fscache_object *object = op->op.object;
        struct fscache_cookie *cookie;
        struct page *page;
+       pgoff_t index;
        unsigned n;
        void *results[1];
        int ret;
@@ -803,7 +804,7 @@ static void fscache_write_op(struct fscache_operation *_op)
        _debug("gang %d [%lx]", n, page->index);
        if (page->index > op->store_limit) {
                fscache_stat(&fscache_n_store_pages_over_limit);
-               goto superseded;
+               goto page_beyond_limit;
        }

        radix_tree_tag_set(&cookie->stores, page->index,
@@ -829,6 +830,40 @@ static void fscache_write_op(struct fscache_operation *_op)
        _leave("");
        return;

+page_beyond_limit:
+       spin_unlock(&object->lock);
+
+page_beyond_limit_unlocked:
+       /* pages that are now beyond the end of the storage object must have
+        * their pending storage records cleared.
+        */
+       index = page->index;
+       radix_tree_tag_clear(&cookie->stores, page->index,
+                            FSCACHE_COOKIE_PENDING_TAG);
+       if (!radix_tree_tag_get(&cookie->stores, page->index,
+                               FSCACHE_COOKIE_STORING_TAG)) {
+               fscache_stat(&fscache_n_store_radix_deletes);
+               radix_tree_delete(&cookie->stores, page->index);
+               page_cache_release(page);
+       }
+       if (!need_resched()) {
+               n = radix_tree_gang_lookup_tag(&cookie->stores, results,
+                                              index + 1, 1,
+                                              FSCACHE_COOKIE_PENDING_TAG);
+               if (n == 1) {
+                       page = results[0];
+                       goto page_beyond_limit_unlocked;
+               }
+               spin_unlock(&cookie->stores_lock);
+               wake_up_bit(&cookie->flags, 0);
+       } else {
+               spin_unlock(&cookie->stores_lock);
+       }
+
+       fscache_enqueue_operation(&op->op);
+       _leave("");
+       return;
+
 superseded:
        /* this writer is going away and there aren't any more things to
         * write */



-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
