From: Jan Kara <jack@suse.cz>
Subject: [PATCH 08/15] gfs2: Use pagevec_lookup_range_tag()
Date: Thu, 14 Sep 2017 15:18:12 +0200
Message-ID: <20170914131819.26266-9-jack@suse.cz>
References: <20170914131819.26266-1-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20170914131819.26266-1-jack@suse.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org
Cc: cluster-devel@redhat.com, Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net, "Yan, Zheng" <zyan@redhat.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

We want only pages from given range in gfs2_write_cache_jdata(). Use
pagevec_lookup_range_tag() instead of pagevec_lookup_tag() and remove
unnecessary code.

CC: Bob Peterson <rpeterso@redhat.com>
CC: cluster-devel@redhat.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/gfs2/aops.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 68ed06962537..d0848d9623fb 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -280,22 +280,6 @@ static int gfs2_write_jdata_pagevec(struct address_space *mapping,
 	for(i = 0; i < nr_pages; i++) {
 		struct page *page = pvec->pages[i];
 
-		/*
-		 * At this point, the page may be truncated or
-		 * invalidated (changing page->mapping to NULL), or
-		 * even swizzled back from swapper_space to tmpfs file
-		 * mapping. However, page->index will not change
-		 * because we have a reference on the page.
-		 */
-		if (page->index > end) {
-			/*
-			 * can't be range_cyclic (1st pass) because
-			 * end == -1 in that case.
-			 */
-			ret = 1;
-			break;
-		}
-
 		*done_index = page->index;
 
 		lock_page(page);
@@ -413,8 +397,8 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && (index <= end)) {
-		nr_pages = pagevec_lookup_tag(&pvec, mapping, &index, tag,
-			      min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
+		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
+				tag, PAGEVEC_SIZE);
 		if (nr_pages == 0)
 			break;
 
-- 
2.12.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
