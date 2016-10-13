From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ceph: Fix uninitialized dentry pointer in ceph_real_mount()
Date: Thu, 13 Oct 2016 17:15:37 +0200
Message-ID: <1476371737-2116-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:59115 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbcJMPQF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Oct 2016 11:16:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zheng Yan <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

    fs/ceph/super.c: In function ‘ceph_real_mount’:
    fs/ceph/super.c:818: warning: ‘root’ may be used uninitialized in this function

If s_root is already valid, dentry pointer root is never initialized,
and returned by ceph_real_mount(). This will cause a crash later when
the caller dereferences the pointer.

Fix this by initializing root early.

Fixes: ce2728aaa82bbeba ("ceph: avoid accessing / when mounting a subpath")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.
---
 fs/ceph/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a29ffce981879d5f..794c5fd0e0cf5e45 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -821,7 +821,8 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
 	dout("mount start %p\n", fsc);
 	mutex_lock(&fsc->client->mount_mutex);
 
-	if (!fsc->sb->s_root) {
+	root = fsc->sb->s_root;
+	if (!root) {
 		const char *path;
 		err = __ceph_open_session(fsc->client, started);
 		if (err < 0)
-- 
1.9.1

