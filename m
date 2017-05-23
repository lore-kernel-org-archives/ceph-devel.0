From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/3] ceph: cleanup writepage_nounlock()
Date: Tue, 23 May 2017 17:54:39 +0800
Message-ID: <20170523095439.63347-3-zyan@redhat.com>
References: <20170523095439.63347-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933487AbdEWJzE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 May 2017 05:55:04 -0400
In-Reply-To: <20170523095439.63347-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, dan.carpenter@oracle.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1880125..777acee 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -530,7 +530,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	long writeback_stat;
 	u64 truncate_size;
 	u32 truncate_seq;
-	int err = 0, len = PAGE_SIZE;
+	int err, len = PAGE_SIZE;
 
 	dout("writepage %p idx %lu\n", page, page->index);
 
@@ -543,7 +543,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	snapc = page_snap_context(page);
 	if (snapc == NULL) {
 		dout("writepage %p page %p not dirty?\n", inode, page);
-		goto out;
+		return 0;
 	}
 	oldest = get_oldest_context(inode, &snap_size,
 				    &truncate_size, &truncate_seq);
@@ -554,7 +554,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
 		redirty_page_for_writepage(wbc, page);
-		goto out;
+		return 0;
 	}
 	ceph_put_snap_context(oldest);
 
@@ -564,8 +564,9 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	/* is this a partial page at end of file? */
 	if (page_off >= snap_size) {
 		dout("%p page eof %llu\n", page, snap_size);
-		goto out;
+		return 0;
 	}
+
 	if (snap_size < page_off + len)
 		len = snap_size - page_off;
 
@@ -592,7 +593,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 			dout("writepage interrupted page %p\n", page);
 			redirty_page_for_writepage(wbc, page);
 			end_page_writeback(page);
-			goto out;
+			return err;
 		}
 		dout("writepage setting page/mapping error %d %p\n",
 		     err, page);
@@ -608,7 +609,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	end_page_writeback(page);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
-out:
 	return err;
 }
 
-- 
2.9.4

