From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH v2] ceph: use seq_show_option for string type options
Date: Thu, 15 Feb 2018 15:39:05 +0800
Message-ID: <1518680345-17700-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp004.me.com ([17.110.69.135]:17935 "EHLO
        mr11p00im-asmtp004.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754824AbeBOHjw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Feb 2018 02:39:52 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp004.me.com by
 mr11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P4600N00KVTJ200@mr11p00im-asmtp004.me.com> for
 ceph-devel@vger.kernel.org; Thu, 15 Feb 2018 07:39:13 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>

Using seq_show_option to replace seq_printf for string type options.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
Changes since v1:
- Code cleanup for showing fscache related options.

 fs/ceph/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a62d2a9..f9418d4 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -511,10 +511,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 	if ((fsopt->flags & CEPH_MOUNT_OPT_DCACHE) == 0)
 		seq_puts(m, ",nodcache");
 	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
-		if (fsopt->fscache_uniq)
-			seq_printf(m, ",fsc=%s", fsopt->fscache_uniq);
-		else
-			seq_puts(m, ",fsc");
+		seq_show_option(m, "fsc", fsopt->fscache_uniq);
 	}
 	if (fsopt->flags & CEPH_MOUNT_OPT_NOPOOLPERM)
 		seq_puts(m, ",nopoolperm");
@@ -527,7 +524,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 #endif
 
 	if (fsopt->mds_namespace)
-		seq_printf(m, ",mds_namespace=%s", fsopt->mds_namespace);
+		seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
 	if (fsopt->rsize != CEPH_MAX_READ_SIZE)
-- 
1.8.3.1

