From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v4 5/6] ceph: quota: update MDS when max_bytes is approaching
Date: Fri,  5 Jan 2018 10:47:22 +0000
Message-ID: <20180105104723.16202-6-lhenriques@suse.com>
References: <20180105104723.16202-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeAEKri (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 05:47:38 -0500
In-Reply-To: <20180105104723.16202-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

When we're reaching the ceph.quota.max_bytes limit, i.e., when writing
more than 1/16th of the space left in a quota realm, update the MDS with
the new file size.

This mirrors the fuse-client approach with commit 122c50315ed1 ("client:
Inform mds file size when approaching quota limit"), in the ceph git tree.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c  |  6 ++++++
 fs/ceph/quota.c | 38 +++++++++++++++++++++++++++++++++++++-
 fs/ceph/super.h |  2 ++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 762402d323a6..4a8fe87edfa3 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1417,6 +1417,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (written >= 0) {
 		int dirty;
+
 		spin_lock(&ci->i_ceph_lock);
 		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
@@ -1424,6 +1425,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		spin_unlock(&ci->i_ceph_lock);
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
+		if (ceph_quota_is_max_bytes_approaching(inode, iocb->ki_pos))
+			ceph_check_caps(ci, CHECK_CAPS_NODELAY, NULL);
 	}
 
 	dout("aio_write %p %llx.%llx %llu~%u  dropping cap refs on %s\n",
@@ -1720,6 +1723,9 @@ static long ceph_fallocate(struct file *file, int mode,
 		spin_unlock(&ci->i_ceph_lock);
 		if (dirty)
 			__mark_inode_dirty(inode, dirty);
+		if ((endoff > size) &&
+		    ceph_quota_is_max_bytes_approaching(inode, endoff))
+			ceph_check_caps(ci, CHECK_CAPS_NODELAY, NULL);
 	}
 
 	ceph_put_cap_refs(ci, got);
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 745f9f47027b..caa79fda4c5d 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -135,7 +135,9 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
 
 enum quota_check_op {
 	QUOTA_CHECK_MAX_FILES_OP,	/* check quota max_files limit */
-	QUOTA_CHECK_MAX_BYTES_OP	/* check quota max_files limit */
+	QUOTA_CHECK_MAX_BYTES_OP,	/* check quota max_files limit */
+	QUOTA_CHECK_MAX_BYTES_APPROACHING_OP	/* check if quota max_files
+						   limit is approaching */
 };
 
 /*
@@ -185,6 +187,20 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 		case QUOTA_CHECK_MAX_BYTES_OP:
 			exceeded = (max && (rvalue + delta > max));
 			break;
+		case QUOTA_CHECK_MAX_BYTES_APPROACHING_OP:
+			if (max) {
+				if (rvalue >= max)
+					exceeded = true;
+				else {
+					/*
+					 * when we're writing more that 1/16th
+					 * of the available space
+					 */
+					exceeded =
+						(((max - rvalue) >> 4) < delta);
+				}
+			}
+			break;
 		default:
 			/* Shouldn't happen */
 			pr_warn("Invalid quota check op (%d)\n", op);
@@ -238,3 +254,23 @@ bool ceph_quota_is_max_bytes_exceeded(struct inode *inode, loff_t newsize)
 
 	return check_quota_exceeded(inode, QUOTA_CHECK_MAX_BYTES_OP, (newsize - size));
 }
+
+/*
+ * ceph_quota_is_max_bytes_approaching - check if we're reaching max_bytes
+ * @inode:	inode being written
+ * @newsize:	new size if write succeeds
+ *
+ * This function returns true if the new file size @newsize will be consuming
+ * more than 1/16th of the available quota space; it returns false otherwise.
+ */
+bool ceph_quota_is_max_bytes_approaching(struct inode *inode, loff_t newsize)
+{
+	loff_t size = ceph_inode(inode)->i_reported_size;
+
+	/* return immediately if we're decreasing file size */
+	if (newsize <= size)
+		return false;
+
+	return check_quota_exceeded(inode, QUOTA_CHECK_MAX_BYTES_APPROACHING_OP,
+				    (newsize - size));
+}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 60ace9ce5a94..13623dac0e1b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1030,5 +1030,7 @@ extern bool ceph_quota_is_max_files_exceeded(struct inode *inode);
 extern bool ceph_quota_is_same_realm(struct inode *old, struct inode *new);
 extern bool ceph_quota_is_max_bytes_exceeded(struct inode *inode,
 					     loff_t newlen);
+extern bool ceph_quota_is_max_bytes_approaching(struct inode *inode,
+						loff_t newlen);
 
 #endif /* _FS_CEPH_SUPER_H */
