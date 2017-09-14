From: Jan Kara <jack@suse.cz>
Subject: [PATCH 06/15] f2fs: Simplify page iteration loops
Date: Thu, 14 Sep 2017 15:18:10 +0200
Message-ID: <20170914131819.26266-7-jack@suse.cz>
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
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net, "Yan,
 Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

In several places we want to iterate over all tagged pages in a mapping.
However the code was apparently copied from places that iterate only
over a limited range and thus it checks for index <= end, optimizes the
case where we are coming close to range end which is all pointless when
end == ULONG_MAX. So just remove this dead code.

CC: Jaegeuk Kim <jaegeuk@kernel.org>
CC: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/f2fs/checkpoint.c | 13 ++++-------
 fs/f2fs/node.c       | 65 +++++++++++++++++++---------------------------------
 2 files changed, 28 insertions(+), 50 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 04fe1df052b2..54ccf5ba8191 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -305,9 +305,10 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 				long nr_to_write, enum iostat_type io_type)
 {
 	struct address_space *mapping = META_MAPPING(sbi);
-	pgoff_t index = 0, end = ULONG_MAX, prev = ULONG_MAX;
+	pgoff_t index = 0, prev = ULONG_MAX;
 	struct pagevec pvec;
 	long nwritten = 0;
+	int nr_pages;
 	struct writeback_control wbc = {
 		.for_reclaim = 0,
 	};
@@ -317,13 +318,9 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 
 	blk_start_plug(&plug);
 
-	while (index <= end) {
-		int i, nr_pages;
-		nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
-				PAGECACHE_TAG_DIRTY,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
-		if (unlikely(nr_pages == 0))
-			break;
+	while (nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
+				PAGECACHE_TAG_DIRTY, PAGEVEC_SIZE)) {
+		int i;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fca87835a1da..f9ccbda73ea9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1277,21 +1277,17 @@ void move_node_page(struct page *node_page, int gc_type)
 
 static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	pgoff_t index, end;
+	pgoff_t index;
 	struct pagevec pvec;
 	struct page *last_page = NULL;
+	int nr_pages;
 
 	pagevec_init(&pvec, 0);
 	index = 0;
-	end = ULONG_MAX;
-
-	while (index <= end) {
-		int i, nr_pages;
-		nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
-		if (nr_pages == 0)
-			break;
+
+	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_DIRTY, PAGEVEC_SIZE)) {
+		int i;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
@@ -1425,13 +1421,14 @@ static int f2fs_write_node_page(struct page *page,
 int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic)
 {
-	pgoff_t index, end;
+	pgoff_t index;
 	pgoff_t last_idx = ULONG_MAX;
 	struct pagevec pvec;
 	int ret = 0;
 	struct page *last_page = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
+	int nr_pages;
 
 	if (atomic) {
 		last_page = last_fsync_dnode(sbi, ino);
@@ -1441,15 +1438,10 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 retry:
 	pagevec_init(&pvec, 0);
 	index = 0;
-	end = ULONG_MAX;
-
-	while (index <= end) {
-		int i, nr_pages;
-		nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
-		if (nr_pages == 0)
-			break;
+
+	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_DIRTY, PAGEVEC_SIZE)) {
+		int i;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
@@ -1548,25 +1540,21 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 				bool do_balance, enum iostat_type io_type)
 {
-	pgoff_t index, end;
+	pgoff_t index;
 	struct pagevec pvec;
 	int step = 0;
 	int nwritten = 0;
 	int ret = 0;
+	int nr_pages;
 
 	pagevec_init(&pvec, 0);
 
 next_step:
 	index = 0;
-	end = ULONG_MAX;
-
-	while (index <= end) {
-		int i, nr_pages;
-		nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_DIRTY,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
-		if (nr_pages == 0)
-			break;
+
+	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_DIRTY, PAGEVEC_SIZE)) {
+		int i;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
@@ -1655,27 +1643,20 @@ int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc,
 
 int wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	pgoff_t index = 0, end = ULONG_MAX;
+	pgoff_t index = 0;
 	struct pagevec pvec;
 	int ret2, ret = 0;
+	int nr_pages;
 
 	pagevec_init(&pvec, 0);
 
-	while (index <= end) {
-		int i, nr_pages;
-		nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
-				PAGECACHE_TAG_WRITEBACK,
-				min(end - index, (pgoff_t)PAGEVEC_SIZE-1) + 1);
-		if (nr_pages == 0)
-			break;
+	while (nr_pages = pagevec_lookup_tag(&pvec, NODE_MAPPING(sbi), &index,
+				PAGECACHE_TAG_WRITEBACK, PAGEVEC_SIZE)) {
+		int i;
 
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			/* until radix tree lookup accepts end_index */
-			if (unlikely(page->index > end))
-				continue;
-
 			if (ino && ino_of_node(page) == ino) {
 				f2fs_wait_on_page_writeback(page, NODE, true);
 				if (TestClearPageError(page))
-- 
2.12.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
