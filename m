From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] ceph: use seq_show_option for string type options
Date: Tue, 13 Feb 2018 09:30:59 +0800
Message-ID: <1518485459-199037-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp003.me.com ([17.110.69.254]:26555 "EHLO
        mr11p00im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeBMBbI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 20:31:08 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp003.me.com by
 mr11p00im-asmtp003.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P4200D00DB5XX00@mr11p00im-asmtp003.me.com> for
 ceph-devel@vger.kernel.org; Tue, 13 Feb 2018 01:31:07 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com
Cc: zyan@redhat.com, ceph-devel@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>

Using seq_show_option to replace seq_printf for string type options.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 fs/ceph/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a62d2a9..d8a33ad 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -512,7 +512,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",nodcache");
 	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
 		if (fsopt->fscache_uniq)
-			seq_printf(m, ",fsc=%s", fsopt->fscache_uniq);
+			seq_show_option(m, "fsc", fsopt->fscache_uniq);
 		else
 			seq_puts(m, ",fsc");
 	}
@@ -527,7 +527,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 #endif
 
 	if (fsopt->mds_namespace)
-		seq_printf(m, ",mds_namespace=%s", fsopt->mds_namespace);
+		seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
 	if (fsopt->rsize != CEPH_MAX_READ_SIZE)
-- 
1.8.3.1

