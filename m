From: Nikolay Borisov <kernel@kyup.com>
Subject: [PATCH] ceph: Fix error handling in ceph_read_iter
Date: Mon, 10 Oct 2016 15:38:18 +0300
Message-ID: <1476103098-2925-1-git-send-email-kernel@kyup.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Nikolay Borisov <kernel@kyup.com>
List-Id: ceph-devel.vger.kernel.org

In case __ceph_do_getattr returns an error and the retry_op in
ceph_read_iter is not READ_INLINE, then it's possible to invoke
__free_page on a page which is NULL, this naturally leads to a crash.
This can happen when, for example, a process waiting on a MDS reply
receives sigterm.

Fix this by explicitly checking whether the page is set or not.

Signed-off-by: Nikolay Borisov <kernel@kyup.com>
Link: http://www.spinics.net/lists/ceph-users/msg31592.html
---
 fs/ceph/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3c68e6aee2f0..7413313ae6c8 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -929,7 +929,8 @@ again:
 		statret = __ceph_do_getattr(inode, page,
 					    CEPH_STAT_CAP_INLINE_DATA, !!page);
 		if (statret < 0) {
-			 __free_page(page);
+			if (!page)
+				__free_page(page);
 			if (statret == -ENODATA) {
 				BUG_ON(retry_op != READ_INLINE);
 				goto again;
-- 
2.5.0
