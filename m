From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 03/11 linux-next] ceph: use magic.h
Date: Sun, 21 May 2017 17:40:45 +0200
Message-ID: <20170521154045.26925-1-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, fabf@skynet.be
List-Id: ceph-devel.vger.kernel.org

Filesystems generally use SUPER_MAGIC values from magic.h
instead of a local definition.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/ceph/super.h            | 4 +---
 include/uapi/linux/magic.h | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a973acd..8be85c4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/posix_acl.h>
 #include <linux/refcount.h>
+#include <linux/magic.h>
 
 #include <linux/ceph/libceph.h>
 
@@ -22,9 +23,6 @@
 #include <linux/fscache.h>
 #endif
 
-/* f_type in struct statfs */
-#define CEPH_SUPER_MAGIC 0x00c36400
-
 /* large granularity for statfs utilization stats to facilitate
  * large volume sizes on 32-bit machines. */
 #define CEPH_BLOCK_SHIFT   22  /* 4 MB */
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 1265355..507f3c3 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -12,6 +12,7 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #define BTRFS_SUPER_MAGIC	0x9123683E
 #define BTRFS_TEST_MAGIC	0x73727279
+#define CEPH_SUPER_MAGIC	0x00c36400
 #define CGROUP2_SUPER_MAGIC	0x63677270
 #define CGROUP_SUPER_MAGIC	0x27e0eb
 #define CODA_SUPER_MAGIC	0x73757245
-- 
2.9.3
