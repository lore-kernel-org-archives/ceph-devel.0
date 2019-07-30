From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 07/29] ceph: fix compat_ioctl for ceph_dir_operations
Date: Tue, 30 Jul 2019 21:25:18 +0200
Message-ID: <20190730192552.4014288-8-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Yan, Zheng" <zyan@redhat.com>, stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The ceph_ioctl function is used both for files and directories, but only
the files support doing that in 32-bit compat mode.

For consistency, add the same compat handler to the dir operations
as well, and use a handler that applies the appropriate compat_ptr()
conversion.

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/dir.c   |  1 +
 fs/ceph/file.c  |  2 +-
 fs/ceph/super.h | 10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 4ca0b8ff9a72..401c17d36b71 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1808,6 +1808,7 @@ const struct file_operations ceph_dir_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
 	.unlocked_ioctl = ceph_ioctl,
+	.compat_ioctl = ceph_compat_ioctl,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 685a03cc4b77..99712b6b1ad5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2138,7 +2138,7 @@ const struct file_operations ceph_file_fops = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl = ceph_ioctl,
-	.compat_ioctl	= ceph_ioctl,
+	.compat_ioctl = ceph_compat_ioctl,
 	.fallocate	= ceph_fallocate,
 	.copy_file_range = ceph_copy_file_range,
 };
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d2352fd95dbc..0aebccd48fa0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -6,6 +6,7 @@
 
 #include <asm/unaligned.h>
 #include <linux/backing-dev.h>
+#include <linux/compat.h>
 #include <linux/completion.h>
 #include <linux/exportfs.h>
 #include <linux/fs.h>
@@ -1108,6 +1109,15 @@ extern void ceph_readdir_cache_release(struct ceph_readdir_cache_control *ctl);
 
 /* ioctl.c */
 extern long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+static inline long
+ceph_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+#ifdef CONFIG_COMPAT
+	return ceph_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+#else
+	return -ENOTTY;
+#endif
+}
 
 /* export.c */
 extern const struct export_operations ceph_export_ops;
-- 
2.20.0
