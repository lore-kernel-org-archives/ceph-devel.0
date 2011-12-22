From: Sage Weil <sage@newdream.net>
Subject: [PATCH 3/3] ceph: enable/disable dentry complete flags via mount option
Date: Thu, 22 Dec 2011 12:13:11 -0800
Message-ID: <1324584791-31933-3-git-send-email-sage@newdream.net>
References: <1324584791-31933-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45299 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab1LVURN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 15:17:13 -0500
In-Reply-To: <1324584791-31933-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Enable/disable use of the dentry dir 'complete' flag via a mount option.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/dir.c   |    3 ++-
 fs/ceph/super.c |   14 ++++++++++++++
 fs/ceph/super.h |    1 +
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index caddb7d..35db035 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1134,7 +1134,8 @@ void ceph_dir_set_complete(struct inode *inode)
 {
 	struct dentry *dentry = d_find_any_alias(inode);
 	
-	if (dentry && ceph_dentry(dentry)) {
+	if (dentry && ceph_dentry(dentry) &&
+	    ceph_test_mount_opt(ceph_sb_to_client(dentry->d_sb), USEDCACHE)) {
 		dout(" marking %p (%p) complete\n", inode, dentry);
 		set_bit(CEPH_D_COMPLETE, &ceph_dentry(dentry)->flags);
 	}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b48f15f..3f4e5ad 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -131,6 +131,8 @@ enum {
 	Opt_rbytes,
 	Opt_norbytes,
 	Opt_noasyncreaddir,
+	Opt_usedcache,
+	Opt_nousedcache,
 	Opt_ino32,
 };
 
@@ -152,6 +154,8 @@ static match_table_t fsopt_tokens = {
 	{Opt_rbytes, "rbytes"},
 	{Opt_norbytes, "norbytes"},
 	{Opt_noasyncreaddir, "noasyncreaddir"},
+	{Opt_usedcache, "usedcache"},
+	{Opt_nousedcache, "nousedcache"},
 	{Opt_ino32, "ino32"},
 	{-1, NULL}
 };
@@ -231,6 +235,12 @@ static int parse_fsopt_token(char *c, void *private)
 	case Opt_noasyncreaddir:
 		fsopt->flags |= CEPH_MOUNT_OPT_NOASYNCREADDIR;
 		break;
+	case Opt_usedcache:
+		fsopt->flags |= CEPH_MOUNT_OPT_USEDCACHE;
+		break;
+	case Opt_nousedcache:
+		fsopt->flags &= ~CEPH_MOUNT_OPT_USEDCACHE;
+		break;
 	case Opt_ino32:
 		fsopt->flags |= CEPH_MOUNT_OPT_INO32;
 		break;
@@ -377,6 +387,10 @@ static int ceph_show_options(struct seq_file *m, struct vfsmount *mnt)
 		seq_puts(m, ",norbytes");
 	if (fsopt->flags & CEPH_MOUNT_OPT_NOASYNCREADDIR)
 		seq_puts(m, ",noasyncreaddir");
+	if (fsopt->flags & CEPH_MOUNT_OPT_USEDCACHE)
+		seq_puts(m, ",usedcache");
+	else
+		seq_puts(m, ",nousedcache");
 
 	if (fsopt->wsize)
 		seq_printf(m, ",wsize=%d", fsopt->wsize);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index edcbf37..9270d9d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -28,6 +28,7 @@
 #define CEPH_MOUNT_OPT_RBYTES          (1<<5) /* dir st_bytes = rbytes */
 #define CEPH_MOUNT_OPT_NOASYNCREADDIR  (1<<7) /* no dcache readdir */
 #define CEPH_MOUNT_OPT_INO32           (1<<8) /* 32 bit inos */
+#define CEPH_MOUNT_OPT_USEDCACHE       (1<<9)
 
 #define CEPH_MOUNT_OPT_DEFAULT    (CEPH_MOUNT_OPT_RBYTES)
 
-- 
1.7.5.4

