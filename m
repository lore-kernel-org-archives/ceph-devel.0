From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v4 4/6] ceph: quota: support for ceph.quota.max_bytes
Date: Fri,  5 Jan 2018 10:47:21 +0000
Message-ID: <20180105104723.16202-5-lhenriques@suse.com>
References: <20180105104723.16202-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36331 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbeAEKri (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 05:47:38 -0500
In-Reply-To: <20180105104723.16202-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c  | 11 +++++++++++
 fs/ceph/inode.c |  4 ++++
 fs/ceph/quota.c | 28 +++++++++++++++++++++++++++-
 fs/ceph/super.h |  2 ++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 5a77a66e3d6b..762402d323a6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1331,6 +1331,11 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	pos = iocb->ki_pos;
 	count = iov_iter_count(from);
+	if (ceph_quota_is_max_bytes_exceeded(inode, pos + count)) {
+		err = -EDQUOT;
+		goto out;
+	}
+
 	err = file_remove_privs(file);
 	if (err)
 		goto out;
@@ -1661,6 +1666,12 @@ static long ceph_fallocate(struct file *file, int mode,
 		goto unlock;
 	}
 
+	if (!(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)) &&
+	    ceph_quota_is_max_bytes_exceeded(inode, offset + length)) {
+		ret = -EDQUOT;
+		goto unlock;
+	}
+
 	if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) &&
 	    !(mode & FALLOC_FL_PUNCH_HOLE)) {
 		ret = -ENOSPC;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8a0ba96e105d..342ba26f6232 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2130,6 +2130,10 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err != 0)
 		return err;
 
+	if ((attr->ia_valid & ATTR_SIZE) &&
+	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
+		return -EDQUOT;
+
 	err = __ceph_setattr(inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 5d7dada91a57..745f9f47027b 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -134,7 +134,8 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 }
 
 enum quota_check_op {
-	QUOTA_CHECK_MAX_FILES_OP	/* check quota max_files limit */
+	QUOTA_CHECK_MAX_FILES_OP,	/* check quota max_files limit */
+	QUOTA_CHECK_MAX_BYTES_OP	/* check quota max_files limit */
 };
 
 /*
@@ -171,6 +172,9 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		if (op == QUOTA_CHECK_MAX_FILES_OP) {
 			max = ci->i_max_files;
 			rvalue = ci->i_rfiles + ci->i_rsubdirs;
+		} else {
+			max = ci->i_max_bytes;
+			rvalue = ci->i_rbytes;
 		}
 		is_root = (ci->i_vino.ino == CEPH_INO_ROOT);
 		spin_unlock(&ci->i_ceph_lock);
@@ -178,6 +182,9 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		case QUOTA_CHECK_MAX_FILES_OP:
 			exceeded = (max && (rvalue >= max));
 			break;
+		case QUOTA_CHECK_MAX_BYTES_OP:
+			exceeded = (max && (rvalue + delta > max));
+			break;
 		default:
 			/* Shouldn't happen */
 			pr_warn("Invalid quota check op (%d)\n", op);
@@ -212,3 +219,22 @@ bool ceph_quota_is_max_files_exceeded(struct inode *inode)
 
 	return check_quota_exceeded(inode, QUOTA_CHECK_MAX_FILES_OP, 0);
 }
+
+/*
+ * ceph_quota_is_max_bytes_exceeded - check if we can write to a file
+ * @inode:	inode being written
+ * @newsize:	new size if write succeeds
+ *
+ * This functions returns true is max_bytes quota allows a file size to reach
+ * @newsize; it returns false otherwise.
+ */
+bool ceph_quota_is_max_bytes_exceeded(struct inode *inode, loff_t newsize)
+{
+	loff_t size = i_size_read(inode);
+
+	/* return immediately if we're decreasing file size */
+	if (newsize <= size)
+		return false;
+
+	return check_quota_exceeded(inode, QUOTA_CHECK_MAX_BYTES_OP, (newsize - size));
+}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a66e73338386..60ace9ce5a94 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1028,5 +1028,7 @@ extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
 			      struct ceph_msg *msg);
 extern bool ceph_quota_is_max_files_exceeded(struct inode *inode);
 extern bool ceph_quota_is_same_realm(struct inode *old, struct inode *new);
+extern bool ceph_quota_is_max_bytes_exceeded(struct inode *inode,
+					     loff_t newlen);
 
 #endif /* _FS_CEPH_SUPER_H */
