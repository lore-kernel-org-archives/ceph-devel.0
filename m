From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: invalidate pages that beyond EOF in ceph_writepages_start()
Date: Wed,  1 Nov 2017 21:43:54 +0800
Message-ID: <20171101134354.1556-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdKANoB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Nov 2017 09:44:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

It's possible there are several pending ceph_cap_snap, and they have
different i_size. For a given dirty page, value of EOF depends on which
snap context it's associated. calling truncate_pagecache() in
__ceph_do_pending_vmtruncate() can not handle such complex situation.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/addr.c  | 32 +++++++++++++++++++-------------
 fs/ceph/inode.c | 14 +-------------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e57e9d37bf2d..938acb15b4d3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -892,16 +892,30 @@ static int ceph_writepages_start(struct address_space *mapping,
 				unlock_page(page);
 				continue;
 			}
-			if (strip_unit_end && (page->index > strip_unit_end)) {
-				dout("end of strip unit %p\n", page);
+			/* only if matching snap context */
+			pgsnapc = page_snap_context(page);
+			if (pgsnapc != snapc) {
+				dout("page snapc %p %lld != oldest %p %lld\n",
+				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
 				unlock_page(page);
-				break;
+				continue;
 			}
 			if (page_offset(page) >= ceph_wbc.i_size) {
 				dout("%p page eof %llu\n",
 				     page, ceph_wbc.i_size);
-				/* not done if range_cyclic */
-				stop = true;
+				if (ceph_wbc.size_stable) {
+					mapping->a_ops->invalidatepage(page,
+								0, PAGE_SIZE);
+				} else {
+					stop = true;
+				}
+				unlock_page(page);
+				if (stop)
+					break;
+				continue;
+			}
+			if (strip_unit_end && (page->index > strip_unit_end)) {
+				dout("end of strip unit %p\n", page);
 				unlock_page(page);
 				break;
 			}
@@ -915,14 +929,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 				wait_on_page_writeback(page);
 			}
 
-			/* only if matching snap context */
-			pgsnapc = page_snap_context(page);
-			if (pgsnapc != snapc) {
-				dout("page snapc %p %lld != oldest %p %lld\n",
-				     pgsnapc, pgsnapc->seq, snapc, snapc->seq);
-				unlock_page(page);
-				continue;
-			}
 
 			if (!clear_page_dirty_for_io(page)) {
 				dout("%p !clear_page_dirty_for_io\n", page);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8100f8a1a12d..e3515f759998 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1838,22 +1838,10 @@ void __ceph_do_pending_vmtruncate(struct inode *inode)
 	 * possibly truncate them.. so write AND block!
 	 */
 	if (ci->i_wrbuffer_ref_head < ci->i_wrbuffer_ref) {
-		struct ceph_cap_snap *capsnap;
-		to = ci->i_truncate_size;
-		list_for_each_entry(capsnap, &ci->i_cap_snaps, ci_item) {
-			// MDS should have revoked Frw caps
-			WARN_ON_ONCE(capsnap->writing);
-			if (capsnap->dirty_pages && capsnap->size > to)
-				to = capsnap->size;
-		}
 		spin_unlock(&ci->i_ceph_lock);
 		dout("__do_pending_vmtruncate %p flushing snaps first\n",
 		     inode);
-
-		truncate_pagecache(inode, to);
-
-		filemap_write_and_wait_range(&inode->i_data, 0,
-					     inode->i_sb->s_maxbytes);
+		filemap_write_and_wait_range(&inode->i_data, 0, LLONG_MAX);
 		goto retry;
 	}
 
-- 
2.13.6

