From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH 2/2] ceph: cleanup the logic in ceph_invalidatepage
Date: Fri, 9 Aug 2013 12:59:55 -0400
Message-ID: <7fab98ccc1aa5b3808530077bae291663e411fe7.1375686804.git.milosz@adfin.com>
References: <cover.1375686804.git.milosz@adfin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1375686804.git.milosz@adfin.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, sage@inktank.com, zheng.z.yan@intel.com
List-Id: ceph-devel.vger.kernel.org

The invalidatepage code bails if it encounters a non-zero page offset. The
current logic that does is non-obvious with multiple if statements.

This should be logically and functionally equivalent.

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/addr.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f1d6c60..341f998 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -150,6 +150,13 @@ static void ceph_invalidatepage(struct page *page, unsigned long offset)
 	struct ceph_snap_context *snapc = page_snap_context(page);
 
 	inode = page->mapping->host;
+	ci = ceph_inode(inode);
+
+	if (offset != 0) {
+		dout("%p invalidatepage %p idx %lu partial dirty page\n",
+		     inode, page, page->index);
+		return;
+	}
 
 	/*
 	 * We can get non-dirty pages here due to races between
@@ -159,21 +166,15 @@ static void ceph_invalidatepage(struct page *page, unsigned long offset)
 	if (!PageDirty(page))
 		pr_err("%p invalidatepage %p page not dirty\n", inode, page);
 
-	if (offset == 0)
-		ClearPageChecked(page);
+	ClearPageChecked(page);
 
-	ci = ceph_inode(inode);
-	if (offset == 0) {
-		dout("%p invalidatepage %p idx %lu full dirty page %lu\n",
-		     inode, page, page->index, offset);
-		ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
-		ceph_put_snap_context(snapc);
-		page->private = 0;
-		ClearPagePrivate(page);
-	} else {
-		dout("%p invalidatepage %p idx %lu partial dirty page\n",
-		     inode, page, page->index);
-	}
+	dout("%p invalidatepage %p idx %lu full dirty page %lu\n",
+	     inode, page, page->index, offset);
+
+	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
+	ceph_put_snap_context(snapc);
+	page->private = 0;
+	ClearPagePrivate(page);
 }
 
 /* just a sanity check */
-- 
1.8.1.2

