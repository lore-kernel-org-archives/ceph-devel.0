From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: make 'nocopyfrom' a default mount option
Date: Mon, 10 Dec 2018 10:23:12 +0000
Message-ID: <20181210102312.31364-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Since we found a problem with the 'copy-from' operation after objects have
been truncated, offloading object copies to OSDs should be discouraged
until the issue is fixed.

Thus, this patch adds the 'nocopyfrom' mount option to the default mount
options which effectily means that remote copies won't be done in
copy_file_range unless they are explicitly enabled at mount time.

Link: https://tracker.ceph.com/issues/37378
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/super.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c005a5400f2e..79a265ba9200 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -42,7 +42,9 @@
 #define CEPH_MOUNT_OPT_NOQUOTADF       (1<<13) /* no root dir quota in statfs */
 #define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<14) /* don't use RADOS 'copy-from' op */
 
-#define CEPH_MOUNT_OPT_DEFAULT    CEPH_MOUNT_OPT_DCACHE
+#define CEPH_MOUNT_OPT_DEFAULT			\
+	(CEPH_MOUNT_OPT_DCACHE |		\
+	 CEPH_MOUNT_OPT_NOCOPYFROM)
 
 #define ceph_set_mount_opt(fsc, opt) \
 	(fsc)->mount_options->flags |= CEPH_MOUNT_OPT_##opt;
