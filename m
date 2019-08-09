From: john.hubbard@gmail.com
Subject: [PATCH] fs/ceph: use release_pages() directly
Date: Thu,  8 Aug 2019 20:56:47 -0700
Message-ID: <20190809035647.18866-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

release_pages() has been available to modules since Oct, 2010,
when commit 0be8557bcd34 ("fuse: use release_pages()") added
EXPORT_SYMBOL(release_pages). However, this ceph code was still
using a workaround.

Remove the workaround, and call release_pages() directly.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

I noticed this while I trying to understand mlock.c's use of
pagevec_release(). So I was looking around for examples, and stumbled
across this, which seems worth cleaning up.

thanks,
John Hubbard
NVIDIA

 fs/ceph/addr.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e078cc55b989..22ed45d143be 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -679,23 +679,6 @@ static int ceph_writepage(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-/*
- * lame release_pages helper.  release_pages() isn't exported to
- * modules.
- */
-static void ceph_release_pages(struct page **pages, int num)
-{
-	struct pagevec pvec;
-	int i;
-
-	pagevec_init(&pvec);
-	for (i = 0; i < num; i++) {
-		if (pagevec_add(&pvec, pages[i]) == 0)
-			pagevec_release(&pvec);
-	}
-	pagevec_release(&pvec);
-}
-
 /*
  * async writeback completion handler.
  *
@@ -769,7 +752,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 		dout("writepages_finish %p wrote %llu bytes cleaned %d pages\n",
 		     inode, osd_data->length, rc >= 0 ? num_pages : 0);
 
-		ceph_release_pages(osd_data->pages, num_pages);
+		release_pages(osd_data->pages, num_pages);
 	}
 
 	ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
-- 
2.22.0
