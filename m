From: Jan Kara <jack@suse.cz>
Subject: [PATCH 15/15] afs: Use find_get_pages_range_tag()
Date: Thu, 14 Sep 2017 15:18:19 +0200
Message-ID: <20170914131819.26266-16-jack@suse.cz>
References: <20170914131819.26266-1-jack@suse.cz>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170914131819.26266-1-jack@suse.cz>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
List-Id: ceph-devel.vger.kernel.org

Use find_get_pages_range_tag() in afs_writepages_region() as we are
interested only in pages from given range. Remove unnecessary code after
this conversion.

CC: David Howells <dhowells@redhat.com>
CC: linux-afs@lists.infradead.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/afs/write.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 106e43db1115..d62a6b54152d 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -497,20 +497,13 @@ static int afs_writepages_region(struct address_space *mapping,
 	_enter(",,%lx,%lx,", index, end);
 
 	do {
-		n = find_get_pages_tag(mapping, &index, PAGECACHE_TAG_DIRTY,
-				       1, &page);
+		n = find_get_pages_range_tag(mapping, &index, end,
+					PAGECACHE_TAG_DIRTY, 1, &page);
 		if (!n)
 			break;
 
 		_debug("wback %lx", page->index);
 
-		if (page->index > end) {
-			*_next = index;
-			put_page(page);
-			_leave(" = 0 [%lx]", *_next);
-			return 0;
-		}
-
 		/* at this point we hold neither mapping->tree_lock nor lock on
 		 * the page itself: the page may be truncated or invalidated
 		 * (changing page->mapping to NULL), or even swizzled back from
-- 
2.12.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
