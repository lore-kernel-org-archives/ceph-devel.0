From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 46/61] cachefiles: Shape write requests
Date: Mon, 04 May 2020 18:14:26 +0100
Message-ID: <158861246621.340223.9118210695394840507.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Jeff Layton <jlayton@redhat.com>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

In cachefiles_shape_extent(), shape a write request to always write to the
cache.  The assumption is made that the caller has read the entire cache
granule beforehand if necessary.

Possibly this should be amended so that writes will only take place to
granules that are marked present and granules that lie beyond the EOF.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/content-map.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 13632c097248..2c45092465b6 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -71,7 +71,8 @@ static unsigned int cachefiles_shape_single(struct fscache_object *obj,
 
 	extent->dio_block_size = CACHEFILES_DIO_BLOCK_SIZE;
 
-	if (object->content_info == CACHEFILES_CONTENT_SINGLE) {
+	if (!for_write &&
+	    object->content_info == CACHEFILES_CONTENT_SINGLE) {
 		ret = FSCACHE_READ_FROM_CACHE;
 	} else {
 		eof = (i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -128,13 +129,20 @@ unsigned int cachefiles_shape_extent(struct fscache_object *obj,
 
 	granule = start / CACHEFILES_GRAN_PAGES;
 
-	/* If the content map didn't get expanded for some reason - simply
-	 * ignore this granule.
-	 */
-	if (granule / 8 >= object->content_map_size)
-		return 0;
+	if (granule / 8 >= object->content_map_size) {
+		cachefiles_expand_content_map(object, i_size);
+		if (granule / 8 >= object->content_map_size)
+			return 0;
+	}
 
-	if (cachefiles_granule_is_present(object, granule)) {
+	if (for_write) {
+		/* Assume that the preparation to write involved preloading any
+		 * bits of the cache that weren't to be written and filling any
+		 * gaps that didn't end up being written.
+		 */
+		bend = end;
+		ret = FSCACHE_WRITE_TO_CACHE;
+	} else if (cachefiles_granule_is_present(object, granule)) {
 		/* The start of the requested extent is present in the cache -
 		 * restrict the returned extent to the maximum length of what's
 		 * available.
