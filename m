From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 11/26] ceph: fix compat_ioctl for ceph_dir_operations
Date: Tue, 16 Apr 2019 22:19:49 +0200
Message-ID: <20190416202013.4034148-12-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Yan, Zheng" <zyan@redhat.com>, stable@vger.kernel.org, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The ceph_ioctl function is used both for files and directories, but only
the files support doing that in 32-bit compat mode.

For consistency, add the same compat handler to the dir operations
as well.

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a8f429882249..7c060cb22aa3 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1785,6 +1785,7 @@ const struct file_operations ceph_dir_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
 	.unlocked_ioctl = ceph_ioctl,
+	.compat_ioctl = ceph_ioctl,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
-- 
2.20.0
