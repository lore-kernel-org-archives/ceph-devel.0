From: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
Subject: [PATCH v4] ceph: set io_pages bdi hint
Date: Tue, 10 Jan 2017 14:17:56 +0100
Message-ID: <1484054308-4901-1-git-send-email-andreas.gerstmayr@catalysts.cc>
References: <7C9D4085-7D14-4BFB-B675-8FE3C661B1C3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7C9D4085-7D14-4BFB-B675-8FE3C661B1C3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: andreas.gerstmayr@gmail.com, Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This patch sets the io_pages bdi hint based on the rsize mount option.
Without this patch large buffered reads (request size > max readahead)
are processed sequentially in chunks of the readahead size (i.e. read
requests are sent out up to the readahead size, then the
do_generic_file_read() function waits until the first page is received).

With this patch read requests are sent out at once up to the size
specified in the rsize mount option (default: 64 MB).

Signed-off-by: Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
---

Changes in v4:
  - update documentation

(Note: This patch depends on kernel version 4.10-rc1)


 Documentation/filesystems/ceph.txt | 5 ++---
 fs/ceph/super.c                    | 8 ++++++++
 fs/ceph/super.h                    | 4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/ceph.txt b/Documentation/filesystems/ceph.txt
index f5306ee..0b302a1 100644
--- a/Documentation/filesystems/ceph.txt
+++ b/Documentation/filesystems/ceph.txt
@@ -98,11 +98,10 @@ Mount Options
 	size.
 
   rsize=X
-	Specify the maximum read size in bytes.  By default there is no
-	maximum.
+	Specify the maximum read size in bytes.  Default: 64 MB.
 
   rasize=X
-	Specify the maximum readahead.
+	Specify the maximum readahead.  Default: 8 MB.
 
   mount_timeout=X
 	Specify the timeout value for mount (in seconds), in the case
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 6bd20d7..a0a0b6d 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -952,6 +952,14 @@ static int ceph_register_bdi(struct super_block *sb,
 		fsc->backing_dev_info.ra_pages =
 			VM_MAX_READAHEAD * 1024 / PAGE_SIZE;
 
+	if (fsc->mount_options->rsize > fsc->mount_options->rasize &&
+	    fsc->mount_options->rsize >= PAGE_SIZE)
+		fsc->backing_dev_info.io_pages =
+			(fsc->mount_options->rsize + PAGE_SIZE - 1)
+			>> PAGE_SHIFT;
+	else if (fsc->mount_options->rsize == 0)
+		fsc->backing_dev_info.io_pages = ULONG_MAX;
+
 	err = bdi_register(&fsc->backing_dev_info, NULL, "ceph-%ld",
 			   atomic_long_inc_return(&bdi_seq));
 	if (!err)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3373b61..88b2e6e 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -45,8 +45,8 @@
 #define ceph_test_mount_opt(fsc, opt) \
 	(!!((fsc)->mount_options->flags & CEPH_MOUNT_OPT_##opt))
 
-#define CEPH_RSIZE_DEFAULT             0           /* max read size */
-#define CEPH_RASIZE_DEFAULT            (8192*1024) /* readahead */
+#define CEPH_RSIZE_DEFAULT              (64*1024*1024) /* max read size */
+#define CEPH_RASIZE_DEFAULT             (8192*1024)    /* max readahead */
 #define CEPH_MAX_READDIR_DEFAULT        1024
 #define CEPH_MAX_READDIR_BYTES_DEFAULT  (512*1024)
 #define CEPH_SNAPDIRNAME_DEFAULT        ".snap"
-- 
1.8.3.1
