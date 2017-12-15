From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/3] ceph: fix un-balanced fsc->writeback_count update
Date: Fri, 15 Dec 2017 17:24:20 +0800
Message-ID: <20171215092420.7950-3-zyan@redhat.com>
References: <20171215092420.7950-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755539AbdLOJYg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 15 Dec 2017 04:24:36 -0500
In-Reply-To: <20171215092420.7950-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, idryomov@gmail.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 78a1208b878e..b4336b42ce3b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -578,7 +578,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	struct ceph_fs_client *fsc;
 	struct ceph_snap_context *snapc, *oldest;
 	loff_t page_off = page_offset(page);
-	long writeback_stat;
 	int err, len = PAGE_SIZE;
 	struct ceph_writeback_ctl ceph_wbc;
 
@@ -619,8 +618,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	dout("writepage %p page %p index %lu on %llu~%u snapc %p seq %lld\n",
 	     inode, page, page->index, page_off, len, snapc, snapc->seq);
 
-	writeback_stat = atomic_long_inc_return(&fsc->writeback_count);
-	if (writeback_stat >
+	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
 		set_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
 
@@ -655,6 +653,11 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	end_page_writeback(page);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
+
+	if (atomic_long_dec_return(&fsc->writeback_count) <
+	    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
+		clear_bdi_congested(inode_to_bdi(inode), BLK_RW_ASYNC);
+
 	return err;
 }
 
-- 
2.13.6

