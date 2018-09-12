From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 04/17] ceph: fix compat_ioctl for ceph_dir_operations
Date: Wed, 12 Sep 2018 17:01:05 +0200
Message-ID: <20180912150142.157913-4-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180912150142.157913-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Chengguang Xu <cgxu519@gmx.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The ceph_ioctl function is used both for files and directories, but only
the files support doing that in 32-bit compat mode.

For consistency, add the same compat handler to the dir operations
as well.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 82928cea0209..da73f29d7faa 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1489,6 +1489,7 @@ const struct file_operations ceph_dir_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
 	.unlocked_ioctl = ceph_ioctl,
+	.compat_ioctl = ceph_ioctl,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
-- 
2.18.0
