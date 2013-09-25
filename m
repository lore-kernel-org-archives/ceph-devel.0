From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH] ceph: hung on ceph fscache invalidate in some cases
Date: Wed, 25 Sep 2013 11:18:14 -0400
Message-ID: <20130925151811.GA32800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, zheng.z.yan@intel.com, dhowells@redhat.com, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

In some cases I'm on my ceph client cluster I'm seeing hunk kernel tasks in
the invalidate page code path. This is due to the fact that we don't check if
the page is marked as cache before calling fscache_wait_on_page_write().

This is the log from the hang

INFO: task XXXXXX:12034 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 ...
Call Trace:
[<ffffffff81568d09>] schedule+0x29/0x70
[<ffffffffa01d4cbd>] __fscache_wait_on_page_write+0x6d/0xb0 [fscache]
[<ffffffff81083520>] ? add_wait_queue+0x60/0x60
[<ffffffffa029a3e9>] ceph_invalidate_fscache_page+0x29/0x50 [ceph]
[<ffffffffa027df00>] ceph_invalidatepage+0x70/0x190 [ceph]
[<ffffffff8112656f>] ? delete_from_page_cache+0x5f/0x70
[<ffffffff81133cab>] truncate_inode_page+0x8b/0x90
[<ffffffff81133ded>] truncate_inode_pages_range.part.12+0x13d/0x620
[<ffffffff8113431d>] truncate_inode_pages_range+0x4d/0x60
[<ffffffff811343b5>] truncate_inode_pages+0x15/0x20
[<ffffffff8119bbf6>] evict+0x1a6/0x1b0
[<ffffffff8119c3f3>] iput+0x103/0x190
 ...

Signed-off-by: Milosz Tanski <milosz@adfin.com>
---
 fs/ceph/cache.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 6bfe65e..360b622 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -324,6 +324,9 @@ void ceph_invalidate_fscache_page(struct inode* inode, struct page *page)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
+	if (!PageFsCache(page))
+		return;
+
 	fscache_wait_on_page_write(ci->fscache, page);
 	fscache_uncache_page(ci->fscache, page);
 }
-- 
1.7.9.5
