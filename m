From: Sage Weil <sage@inktank.com>
Subject: [PATCH 1/4] ceph: hung on ceph fscache invalidate in some cases
Date: Mon, 30 Dec 2013 16:13:48 -0800
Message-ID: <1388448831-10324-2-git-send-email-sage@inktank.com>
References: <1388448831-10324-1-git-send-email-sage@inktank.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1388448831-10324-1-git-send-email-sage@inktank.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: ceph-devel@vger.kernel.org, Milosz Tanski <milosz@adfin.com>
List-Id: ceph-devel.vger.kernel.org

From: Milosz Tanski <milosz@adfin.com>

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
Reviewed-by: Sage Weil <sage@inktank.com>
(cherry picked from commit ffc79664d15841025d90afdd902c4112ffe168d6)
---
 fs/ceph/cache.c | 3 +++
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
1.8.5.1
