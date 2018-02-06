From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH v2] ceph: minor cleanups of showing options
Date: Tue, 06 Feb 2018 21:54:21 +0800
Message-ID: <1517925261-50747-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp003.me.com ([17.110.69.254]:30377 "EHLO
        mr11p00im-asmtp003.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeBFNzd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 08:55:33 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp003.me.com by
 mr11p00im-asmtp003.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3Q00900CW2H100@mr11p00im-asmtp003.me.com> for
 ceph-devel@vger.kernel.org; Tue, 06 Feb 2018 13:54:57 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, idryomov@gmail.com, Chengguang Xu <cgxu519@icloud.com>

Minor cleanups of showing options for mount and client.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
Changes since v1:
- Do not change comma seqence in ceph_print_client_options()
 because there is another caller from different path.

 fs/ceph/super.c        | 13 ++-----------
 net/ceph/ceph_common.c |  3 +++
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index bfc85b2..7f1e212 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -489,21 +489,12 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(root->d_sb);
 	struct ceph_mount_options *fsopt = fsc->mount_options;
-	size_t pos;
 	int ret;
 
-	/* a comma between MNT/MS and client options */
-	seq_putc(m, ',');
-	pos = m->count;
-
 	ret = ceph_print_client_options(m, fsc->client);
 	if (ret)
 		return ret;
 
-	/* retract our comma if no client options */
-	if (m->count == pos)
-		m->count--;
-
 	if (fsopt->flags & CEPH_MOUNT_OPT_DIRSTAT)
 		seq_puts(m, ",dirstat");
 	if ((fsopt->flags & CEPH_MOUNT_OPT_RBYTES))
@@ -514,7 +505,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",nodcache");
 	if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
 		if (fsopt->fscache_uniq)
-			seq_printf(m, ",fsc=%s", fsopt->fscache_uniq);
+			seq_show_option(m, "fsc", fsopt->fscache_uniq);
 		else
 			seq_puts(m, ",fsc");
 	}
@@ -529,7 +520,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 #endif
 
 	if (fsopt->mds_namespace)
-		seq_printf(m, ",mds_namespace=%s", fsopt->mds_namespace);
+		seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
 	if (fsopt->rsize != CEPH_MAX_READ_SIZE)
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index cdb5b69..3f30636 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -545,6 +545,9 @@ int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
 	struct ceph_options *opt = client->options;
 	size_t pos = m->count;
 
+	if (m->count)
+		seq_putc(m, ',');
+
 	if (opt->name) {
 		seq_puts(m, "name=");
 		seq_escape(m, opt->name, ", \t\n\\");
-- 
1.8.3.1

