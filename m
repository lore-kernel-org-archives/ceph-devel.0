From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] ceph: minor cleanups of showing options
Date: Tue, 06 Feb 2018 20:59:54 +0800
Message-ID: <1517921994-19178-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp004.me.com ([17.110.69.135]:43483 "EHLO
        mr11p00im-asmtp004.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeBFNAa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 08:00:30 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp004.me.com by
 mr11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3Q00J00AYXW600@mr11p00im-asmtp004.me.com> for
 ceph-devel@vger.kernel.org; Tue, 06 Feb 2018 13:00:18 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, idryomov@gmail.com, Chengguang Xu <cgxu519@icloud.com>

Minor cleanups of showing options for mount and client.

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 fs/ceph/super.c        | 13 ++-----------
 net/ceph/ceph_common.c | 39 +++++++++++++++++++--------------------
 2 files changed, 21 insertions(+), 31 deletions(-)

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
index cdb5b69..fc396ef 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -543,46 +543,45 @@ struct ceph_options *
 int ceph_print_client_options(struct seq_file *m, struct ceph_client *client)
 {
 	struct ceph_options *opt = client->options;
-	size_t pos = m->count;
 
 	if (opt->name) {
-		seq_puts(m, "name=");
-		seq_escape(m, opt->name, ", \t\n\\");
-		seq_putc(m, ',');
+		if (m->count) {
+			seq_show_option(m, "name", opt->name);
+		} else {
+			seq_puts(m, "name=");
+			seq_escape(m, opt->name, ", \t\n\\");
+		}
 	}
+
 	if (opt->key)
-		seq_puts(m, "secret=<hidden>,");
+		seq_puts(m, ",secret=<hidden>");
 
 	if (opt->flags & CEPH_OPT_FSID)
-		seq_printf(m, "fsid=%pU,", &opt->fsid);
+		seq_printf(m, ",fsid=%pU", &opt->fsid);
 	if (opt->flags & CEPH_OPT_NOSHARE)
-		seq_puts(m, "noshare,");
+		seq_puts(m, ",noshare");
 	if (opt->flags & CEPH_OPT_NOCRC)
-		seq_puts(m, "nocrc,");
+		seq_puts(m, ",nocrc");
 	if (opt->flags & CEPH_OPT_NOMSGAUTH)
-		seq_puts(m, "nocephx_require_signatures,");
+		seq_puts(m, ",nocephx_require_signatures");
 	if (opt->flags & CEPH_OPT_NOMSGSIGN)
-		seq_puts(m, "nocephx_sign_messages,");
-	if ((opt->flags & CEPH_OPT_TCP_NODELAY) == 0)
-		seq_puts(m, "notcp_nodelay,");
+		seq_puts(m, ",nocephx_sign_messages");
+	if (!(opt->flags & CEPH_OPT_TCP_NODELAY))
+		seq_puts(m, ",notcp_nodelay");
 
 	if (opt->mount_timeout != CEPH_MOUNT_TIMEOUT_DEFAULT)
-		seq_printf(m, "mount_timeout=%d,",
+		seq_printf(m, ",mount_timeout=%d",
 			   jiffies_to_msecs(opt->mount_timeout) / 1000);
 	if (opt->osd_idle_ttl != CEPH_OSD_IDLE_TTL_DEFAULT)
-		seq_printf(m, "osd_idle_ttl=%d,",
+		seq_printf(m, ",osd_idle_ttl=%d",
 			   jiffies_to_msecs(opt->osd_idle_ttl) / 1000);
 	if (opt->osd_keepalive_timeout != CEPH_OSD_KEEPALIVE_DEFAULT)
-		seq_printf(m, "osdkeepalivetimeout=%d,",
+		seq_printf(m, ",osdkeepalivetimeout=%d",
 		    jiffies_to_msecs(opt->osd_keepalive_timeout) / 1000);
 	if (opt->osd_request_timeout != CEPH_OSD_REQUEST_TIMEOUT_DEFAULT)
-		seq_printf(m, "osd_request_timeout=%d,",
+		seq_printf(m, ",osd_request_timeout=%d",
 			   jiffies_to_msecs(opt->osd_request_timeout) / 1000);
 
-	/* drop redundant comma */
-	if (m->count != pos)
-		m->count--;
-
 	return 0;
 }
 EXPORT_SYMBOL(ceph_print_client_options);
-- 
1.8.3.1

