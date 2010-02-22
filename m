From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ceph: move dereference after NULL test
Date: Mon, 22 Feb 2010 17:17:44 +0300
Message-ID: <1266848264-26723-1-git-send-email-a.beregalov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sf.net
Cc: Alexander Beregalov <a.beregalov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 fs/ceph/addr.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f82d611..292f852 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -143,7 +143,7 @@ static int ceph_set_page_dirty(struct page *page)
  */
 static void ceph_invalidatepage(struct page *page, unsigned long offset)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode;
 	struct ceph_inode_info *ci;
 	struct ceph_snap_context *snapc = (void *)page->private;
 
@@ -152,6 +152,8 @@ static void ceph_invalidatepage(struct page *page, unsigned long offset)
 	BUG_ON(!PagePrivate(page));
 	BUG_ON(!page->mapping);
 
+	inode = page->mapping->host;
+
 	/*
 	 * We can get non-dirty pages here due to races between
 	 * set_page_dirty and truncate_complete_page; just spit out a
-- 
1.7.0


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
