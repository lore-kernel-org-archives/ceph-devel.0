From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 2/2] ceph: make 'copyfrom' a default mount option again
Date: Fri,  8 Nov 2019 14:15:55 +0000
Message-ID: <20191108141555.31176-3-lhenriques@suse.com>
References: <20191108141555.31176-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108141555.31176-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Now that we're able to detect whether an OSD can correctly handle
'copy-from' without corrupting the destination file, we can make the
'copyfrom' mount option the default again.  This effectively reverts
commit 6f9718fe41c3 ("ceph: make 'nocopyfrom' a default mount option").

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/super.c | 4 ++--
 fs/ceph/super.h | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index edfd643a8205..c761be9eecbf 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -584,8 +584,8 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",noacl");
 #endif
 
-	if ((fsopt->flags & CEPH_MOUNT_OPT_NOCOPYFROM) == 0)
-		seq_puts(m, ",copyfrom");
+	if (fsopt->flags & CEPH_MOUNT_OPT_NOCOPYFROM)
+		seq_puts(m, ",nocopyfrom");
 
 	if (fsopt->mds_namespace)
 		seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f98d9247f9cb..4cbcaee6e670 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -44,9 +44,7 @@
 #define CEPH_MOUNT_OPT_NOQUOTADF       (1<<13) /* no root dir quota in statfs */
 #define CEPH_MOUNT_OPT_NOCOPYFROM      (1<<14) /* don't use RADOS 'copy-from' op */
 
-#define CEPH_MOUNT_OPT_DEFAULT			\
-	(CEPH_MOUNT_OPT_DCACHE |		\
-	 CEPH_MOUNT_OPT_NOCOPYFROM)
+#define CEPH_MOUNT_OPT_DEFAULT	CEPH_MOUNT_OPT_DCACHE
 
 #define ceph_set_mount_opt(fsc, opt) \
 	(fsc)->mount_options->flags |= CEPH_MOUNT_OPT_##opt;
