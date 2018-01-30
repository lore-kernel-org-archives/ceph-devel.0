From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] ceph: improving efficiency of syncfs
Date: Tue, 30 Jan 2018 10:02:30 +0800
Message-ID: <1517277750-144449-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp004.me.com ([17.110.69.135]:19171 "EHLO
        mr11p00im-asmtp004.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbeA3CDN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jan 2018 21:03:13 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp004.me.com by
 mr11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3C00A00IY8UH00@mr11p00im-asmtp004.me.com> for
 ceph-devel@vger.kernel.org; Tue, 30 Jan 2018 02:02:43 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zyan@redhat.com, idryomov@gmail.com
Cc: sage@redhat.com, ceph-devel@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>

write_inode() could be called variety of reasons, in the case of syncfs(2)
there is no need to wait for flush getting completed in write_inode(),
->sync_fs is for guaranteeing flush completion for all inodes at that point.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a14b2c9..fd6ce29 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2160,7 +2160,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 	u64 flush_tid;
 	int err = 0;
 	int dirty;
-	int wait = wbc->sync_mode == WB_SYNC_ALL;
+	int wait = (wbc->sync_mode == WB_SYNC_ALL && !wbc->for_sync);
 
 	dout("write_inode %p wait=%d\n", inode, wait);
 	if (wait) {
-- 
1.8.3.1

