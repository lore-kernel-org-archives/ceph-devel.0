From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v3 1/2] ceph: factor out ceph_lookup_inode()
Date: Thu, 21 Mar 2019 10:20:09 +0000
Message-ID: <20190321102010.26958-2-lhenriques@suse.com>
References: <20190321102010.26958-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321102010.26958-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

This function will be used by __fh_to_dentry and by the quotas code, to
find quota realm inodes that are not visible in the mountpoint.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/export.c | 14 +++++++++++++-
 fs/ceph/super.h  |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 3c59ad180ef0..0d8ead82c816 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -59,7 +59,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 	return type;
 }
 
-static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
+struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
 	struct inode *inode;
@@ -92,12 +92,24 @@ static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
 		ceph_mdsc_put_request(req);
 		if (!inode)
 			return ERR_PTR(-ESTALE);
+		if (err)
+			return ERR_PTR(err);
 		if (inode->i_nlink == 0) {
 			iput(inode);
 			return ERR_PTR(-ESTALE);
 		}
 	}
 
+	return inode;
+}
+
+static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
+{
+	struct inode *inode = ceph_lookup_inode(sb, ino);
+
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
 	return d_obtain_alias(inode);
 }
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 16c03188578e..976f200164f9 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1082,6 +1082,7 @@ extern long ceph_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 /* export.c */
 extern const struct export_operations ceph_export_ops;
+struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino);
 
 /* locks.c */
 extern __init void ceph_flock_init(void);
