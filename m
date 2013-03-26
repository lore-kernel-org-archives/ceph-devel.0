From: Chris Mason <chris.mason@fusionio.com>
Subject: Re: corruption of active mmapped files in btrfs snapshots
Date: Mon, 25 Mar 2013 20:08:40 -0400
Message-ID: <20130326000840.14340.30047@localhost.localdomain>
References: <orhak8fm0u.fsf@livre.home>
 <20130322180705.27874.96638@localhost.localdomain>
 <20130322203142.27874.84834@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-btrfs-owner@vger.kernel.org>
In-Reply-To: <20130322203142.27874.84834@localhost.localdomain>
Sender: linux-btrfs-owner@vger.kernel.org
To: Chris Mason <chris.mason@fusionio.com>, Alexandre Oliva <oliva@gnu.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Quoting Chris Mason (2013-03-22 16:31:42)
> Going through the code here, when I change the test to truncate once in
> the very beginning, I still get errors.  So, it isn't an interaction
> between mmap and truncate.  It must be a problem between lzo and mmap.

With compression off, we use clear_page_dirty_for_io to create a wall
between applications using mmap and our crc code.  Once we call
clear_page_dirty_for_io, it means we're in the process of writing the
page and anyone using mmap must wait (by calling page_mkwrite) before
they are allowed to change the page.

We use it with compression on as well, but it only ends up protecting
the crcs.  It gets called after the compression is done, which allows
applications to race in and modify the pages while we are compressing
them.

This patch changes our compression code to call clear_page_dirty_for_io
before we compress, and then redirty the pages if the compression fails.

Alexandre, many thanks for tracking this down into a well defined use
case. 

-chris

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f173c5a..cdee391 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1257,6 +1257,39 @@ int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end)
 				GFP_NOFS);
 }
 
+int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
+{
+	unsigned long index = start >> PAGE_CACHE_SHIFT;
+	unsigned long end_index = end >> PAGE_CACHE_SHIFT;
+	struct page *page;
+
+	while (index <= end_index) {
+		page = find_get_page(inode->i_mapping, index);
+		BUG_ON(!page); /* Pages should be in the extent_io_tree */
+		clear_page_dirty_for_io(page);
+		page_cache_release(page);
+		index++;
+	}
+	return 0;
+}
+
+int extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
+{
+	unsigned long index = start >> PAGE_CACHE_SHIFT;
+	unsigned long end_index = end >> PAGE_CACHE_SHIFT;
+	struct page *page;
+
+	while (index <= end_index) {
+		page = find_get_page(inode->i_mapping, index);
+		BUG_ON(!page); /* Pages should be in the extent_io_tree */
+		account_page_redirty(page);
+		__set_page_dirty_nobuffers(page);
+		page_cache_release(page);
+		index++;
+	}
+	return 0;
+}
+
 /*
  * helper function to set both pages and extents in the tree writeback
  */
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6068a19..258c921 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -325,6 +325,8 @@ int map_private_extent_buffer(struct extent_buffer *eb, unsigned long offset,
 		      unsigned long *map_len);
 int extent_range_uptodate(struct extent_io_tree *tree,
 			  u64 start, u64 end);
+int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
+int extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 int extent_clear_unlock_delalloc(struct inode *inode,
 				struct extent_io_tree *tree,
 				u64 start, u64 end, struct page *locked_page,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ca1b767..88d4a18 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -353,6 +353,7 @@ static noinline int compress_file_range(struct inode *inode,
 	int i;
 	int will_compress;
 	int compress_type = root->fs_info->compress_type;
+	int redirty = 0;
 
 	/* if this is a small write inside eof, kick off a defrag */
 	if ((end - start + 1) < 16 * 1024 &&
@@ -415,6 +416,8 @@ again:
 		if (BTRFS_I(inode)->force_compress)
 			compress_type = BTRFS_I(inode)->force_compress;
 
+		extent_range_clear_dirty_for_io(inode, start, end);
+		redirty = 1;
 		ret = btrfs_compress_pages(compress_type,
 					   inode->i_mapping, start,
 					   total_compressed, pages,
@@ -554,6 +557,8 @@ cleanup_and_bail_uncompressed:
 			__set_page_dirty_nobuffers(locked_page);
 			/* unlocked later on in the async handlers */
 		}
+		if (redirty)
+			extent_range_redirty_for_io(inode, start, end);
 		add_async_extent(async_cow, start, end - start + 1,
 				 0, NULL, 0, BTRFS_COMPRESS_NONE);
 		*num_added += 1;
