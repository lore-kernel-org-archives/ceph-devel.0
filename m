From: Guangliang Zhao <lucienchao@gmail.com>
Subject: [PATCH 2/3] ceph: add acl, noacl options for cephfs mount
Date: Fri, 14 Feb 2014 13:29:43 +0800
Message-ID: <1392355784-10422-3-git-send-email-lucienchao@gmail.com>
References: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43392 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaBNFaB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2014 00:30:01 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so11881628pbb.20
        for <ceph-devel@vger.kernel.org>; Thu, 13 Feb 2014 21:30:00 -0800 (PST)
In-Reply-To: <1392355784-10422-1-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com

Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
---
 fs/ceph/super.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2df963f..9d65c08 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -144,7 +144,9 @@ enum {
 	Opt_ino32,
 	Opt_noino32,
 	Opt_fscache,
-	Opt_nofscache
+	Opt_nofscache,
+	Opt_acl,
+	Opt_noacl
 };
 
 static match_table_t fsopt_tokens = {
@@ -172,6 +174,8 @@ static match_table_t fsopt_tokens = {
 	{Opt_noino32, "noino32"},
 	{Opt_fscache, "fsc"},
 	{Opt_nofscache, "nofsc"},
+	{Opt_acl, "acl"},
+	{Opt_noacl, "noacl"},
 	{-1, NULL}
 };
 
@@ -271,6 +275,12 @@ static int parse_fsopt_token(char *c, void *private)
 	case Opt_nofscache:
 		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
 		break;
+	case Opt_acl:
+		fsopt->sb_flags |= MS_POSIXACL;
+		break;
+	case Opt_noacl:
+		fsopt->sb_flags &= ~MS_POSIXACL;
+		break;
 	default:
 		BUG_ON(token);
 	}
@@ -438,6 +448,11 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 	else
 		seq_puts(m, ",nofsc");
 
+	if (fsopt->sb_flags & MS_POSIXACL)
+		seq_puts(m, ",acl");
+	else
+		seq_puts(m, ",noacl");
+
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
 	if (fsopt->rsize != CEPH_RSIZE_DEFAULT)
@@ -819,9 +834,6 @@ static int ceph_set_super(struct super_block *s, void *data)
 
 	s->s_flags = fsc->mount_options->sb_flags;
 	s->s_maxbytes = 1ULL << 40;  /* temp value until we get mdsmap */
-#ifdef CONFIG_CEPH_FS_POSIX_ACL
-	s->s_flags |= MS_POSIXACL;
-#endif
 
 	s->s_xattr = ceph_xattr_handlers;
 	s->s_fs_info = fsc;
@@ -911,6 +923,10 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
 	struct ceph_options *opt = NULL;
 
 	dout("ceph_mount\n");
+
+#ifdef CONFIG_CEPH_FS_POSIX_ACL
+       flags |= MS_POSIXACL;
+#endif
 	err = parse_mount_options(&fsopt, &opt, flags, data, dev_name, &path);
 	if (err < 0) {
 		res = ERR_PTR(err);
-- 
1.7.9.5

