From: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Subject: [PATCH v2] ceph: set io_pages bdi hint
Date: Thu, 5 Jan 2017 14:23:06 +0100
Message-ID: <1483622696-30353-1-git-send-email-andreas.gerstmayr@catalysts.cc>
References: <C3DA23CD-10FF-491D-BD31-0C1D8673105E@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from exchange.catalysts.cc ([81.10.172.115]:23173 "EHLO
        mail01-vie.catalysts.cc" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936951AbdAENZ3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2017 08:25:29 -0500
In-Reply-To: <C3DA23CD-10FF-491D-BD31-0C1D8673105E@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: andreas.gerstmayr@gmail.com, Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>

This patch sets the io_pages bdi hint based on the rvsize mount option.
Without this patch large buffered reads (request size > max readahead)
are processed sequentially in chunks of the readahead size (i.e. read
requests are sent out up to the readahead size, then the
do_generic_file_read() function waits until the first page is received).

With this patch read requests are sent out up to the size specified in
the new rvsize mount option at once (default: 64 MB).

Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
---

Thanks for your review.
On second thought, I think I should not reuse the rsize mount option
(maximum read size per OSD request), therefore I created a new mount
option rvsize with a default value of 64 MB (as you suggested).

(Note: This patch depends on kernel version 4.10-rc1)


 Documentation/filesystems/ceph.txt |  4 ++++
 fs/ceph/super.c                    | 15 +++++++++++++++
 fs/ceph/super.h                    |  8 +++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.txt
index f5306ee..65171e1 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.txt
@@ -104,6 +104,10 @@ Mount Options
   rasize=X
 	Specify the maximum readahead.
 
+  rvsize=X
+	Specify the maximum volume of read requests sent out at once.
+	The default is 64 MB.
+
   mount_timeout=X
 	Specify the timeout value for mount (in seconds), in the case
 	of a non-responsive Ceph file system.  The default is 30
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 6bd20d7..71bed5a 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -111,6 +111,7 @@ enum {
 	Opt_wsize,
 	Opt_rsize,
 	Opt_rasize,
+	Opt_rvsize,
 	Opt_caps_wanted_delay_min,
 	Opt_caps_wanted_delay_max,
 	Opt_cap_release_safety,
@@ -149,6 +150,7 @@ enum {
 	{Opt_wsize, "wsize=%d"},
 	{Opt_rsize, "rsize=%d"},
 	{Opt_rasize, "rasize=%d"},
+	{Opt_rvsize, "rvsize=%d"},
 	{Opt_caps_wanted_delay_min, "caps_wanted_delay_min=%d"},
 	{Opt_caps_wanted_delay_max, "caps_wanted_delay_max=%d"},
 	{Opt_cap_release_safety, "cap_release_safety=%d"},
@@ -233,6 +235,9 @@ static int parse_fsopt_token(char *c, void *private)
 	case Opt_rasize:
 		fsopt->rasize = intval;
 		break;
+	case Opt_rvsize:
+		fsopt->rvsize = intval;
+		break;
 	case Opt_caps_wanted_delay_min:
 		fsopt->caps_wanted_delay_min = intval;
 		break;
@@ -381,6 +386,7 @@ static int parse_mount_options(struct ceph_mount_options **pfsopt,
 
 	fsopt->rsize = CEPH_RSIZE_DEFAULT;
 	fsopt->rasize = CEPH_RASIZE_DEFAULT;
+	fsopt->rvsize = CEPH_RVSIZE_DEFAULT;
 	fsopt->snapdir_name = kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL);
 	if (!fsopt->snapdir_name) {
 		err = -ENOMEM;
@@ -495,6 +501,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",rsize=%d", fsopt->rsize);
 	if (fsopt->rasize != CEPH_RASIZE_DEFAULT)
 		seq_printf(m, ",rasize=%d", fsopt->rasize);
+	if (fsopt->rvsize != CEPH_RVSIZE_DEFAULT)
+		seq_printf(m, ",rvsize=%d", fsopt->rvsize);
 	if (fsopt->congestion_kb != default_congestion_kb())
 		seq_printf(m, ",write_congestion_kb=%d", fsopt->congestion_kb);
 	if (fsopt->caps_wanted_delay_min != CEPH_CAPS_WANTED_DELAY_MIN_DEFAULT)
@@ -952,6 +960,13 @@ static int ceph_register_bdi(struct super_block *sb,
 		fsc->backing_dev_info.ra_pages =
 			VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
 
+	if (fsc->mount_options->rvsize)
+		fsc->backing_dev_info.io_pages =
+			(fsc->mount_options->rvsize + PAGE_SIZE - 1)
+			>> PAGE_SHIFT;
+	else
+		fsc->backing_dev_info.io_pages = ULONG_MAX;
+
 	err = bdi_register(&fsc->backing_dev_info, NULL, "ceph-%ld",
 			   atomic_long_inc_return(&bdi_seq));
 	if (!err)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3373b61..676ef6d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -45,8 +45,9 @@
 #define ceph_test_mount_opt(fsc, opt) \
 	(!!((fsc)->mount_options->flags & CEPH_MOUNT_OPT_##opt))
 
-#define CEPH_RSIZE_DEFAULT             0           /* max read size */
-#define CEPH_RASIZE_DEFAULT            (8192*1024) /* readahead */
+#define CEPH_RSIZE_DEFAULT              0              /* max read size per osd request */
+#define CEPH_RASIZE_DEFAULT             (8192*1024)    /* max readahead */
+#define CEPH_RVSIZE_DEFAULT             (64*1024*1024) /* max volume of read requests sent out at once */
 #define CEPH_MAX_READDIR_DEFAULT        1024
 #define CEPH_MAX_READDIR_BYTES_DEFAULT  (512*1024)
 #define CEPH_SNAPDIRNAME_DEFAULT        ".snap"
@@ -56,8 +57,9 @@ struct ceph_mount_options {
 	int sb_flags;
 
 	int wsize;            /* max write size */
-	int rsize;            /* max read size */
+	int rsize;            /* max read size per osd request */
 	int rasize;           /* max readahead */
+	int rvsize;           /* max volume of read requests sent out at once */
 	int congestion_kb;    /* max writeback in flight */
 	int caps_wanted_delay_min, caps_wanted_delay_max;
 	int cap_release_safety;
-- 
1.8.3.1

