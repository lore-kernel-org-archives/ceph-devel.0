From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 2/2] ceph: quota: add counter for snaprealms with quota
Date: Fri, 12 Jan 2018 17:19:29 +0000
Message-ID: <20180112171929.11791-3-lhenriques@suse.com>
References: <20180112171929.11791-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964926AbeALRTk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 12:19:40 -0500
In-Reply-To: <20180112171929.11791-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

By keeping a counter with the number of snaprealms that have quota set
allows to optimize the functions that need to walk throught the realms
hierarchy looking for quotas.  Thus, if this counter is zero it's safe to
assume that there are no realms with quota.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/inode.c      |  3 +--
 fs/ceph/mds_client.c |  1 +
 fs/ceph/mds_client.h |  2 ++
 fs/ceph/quota.c      | 38 ++++++++++++++++++++++++++++++++++++--
 fs/ceph/super.h      |  3 +++
 5 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 6563543692b2..7dfd17bec963 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -801,8 +801,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 	inode->i_rdev = le32_to_cpu(info->rdev);
 	inode->i_blkbits = fls(le32_to_cpu(info->layout.fl_stripe_unit)) - 1;
 
-	ci->i_max_bytes = iinfo->max_bytes;
-	ci->i_max_files = iinfo->max_files;
+	ceph_quota_update_inode(mdsc, ci, iinfo->max_bytes, iinfo->max_files);
 
 	if ((new_version || (new_issued & CEPH_CAP_AUTH_SHARED)) &&
 	    (issued & CEPH_CAP_AUTH_EXCL) == 0) {
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 6e4640d41446..ed8cb5c3be3f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3599,6 +3599,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	atomic_set(&mdsc->num_sessions, 0);
 	mdsc->max_sessions = 0;
 	mdsc->stopping = 0;
+	atomic64_set(&mdsc->quotarealms_count, 0);
 	mdsc->last_snap_seq = 0;
 	init_rwsem(&mdsc->snap_rwsem);
 	mdsc->snap_realms = RB_ROOT;
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 1dd013f49f8d..8c5657b78da1 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -323,6 +323,8 @@ struct ceph_mds_client {
 	int                     max_sessions;  /* len of s_mds_sessions */
 	int                     stopping;      /* true if shutting down */
 
+	atomic64_t		quotarealms_count; /* # realms with quota */
+
 	/*
 	 * snap_rwsem will cover cap linkage into snaprealms, and
 	 * realm snap contexts.  (later, we can do per-realm snap
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index d8bd6d346324..c1f8d5ae15fb 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -26,6 +26,31 @@ static inline bool ceph_has_quota(struct ceph_inode_info *ci)
 	return (ci && (ci->i_max_files || ci->i_max_bytes));
 }
 
+static inline bool ceph_has_realms_with_quotas(struct inode *inode)
+{
+	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+
+	return (atomic64_read(&mdsc->quotarealms_count) != 0);
+}
+
+void ceph_quota_update_inode(struct ceph_mds_client *mdsc, struct
+			     ceph_inode_info *ci,
+			     u64 max_bytes, u64 max_files)
+{
+	bool had_quota, has_quota;
+
+	had_quota = ceph_has_quota(ci);
+	ci->i_max_bytes = max_bytes;
+	ci->i_max_files = max_files;
+	has_quota = ceph_has_quota(ci);
+
+	/* Update number of realms that have quotas */
+	if (has_quota && !had_quota)
+		atomic64_inc(&mdsc->quotarealms_count);
+	else if (!has_quota && had_quota)
+		atomic64_dec(&mdsc->quotarealms_count);
+}
+
 void ceph_handle_quota(struct ceph_mds_client *mdsc,
 		       struct ceph_mds_session *session,
 		       struct ceph_msg *msg)
@@ -62,8 +87,8 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 	ci->i_rbytes = le64_to_cpu(h->rbytes);
 	ci->i_rfiles = le64_to_cpu(h->rfiles);
 	ci->i_rsubdirs = le64_to_cpu(h->rsubdirs);
-	ci->i_max_bytes = le64_to_cpu(h->max_bytes);
-	ci->i_max_files = le64_to_cpu(h->max_files);
+	ceph_quota_update_inode(mdsc, ci, le64_to_cpu(h->max_bytes),
+				le64_to_cpu(h->max_files));
 	spin_unlock(&ci->i_ceph_lock);
 
 	iput(inode);
@@ -231,6 +256,9 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
  */
 bool ceph_quota_is_max_files_exceeded(struct inode *inode)
 {
+	if (!ceph_has_realms_with_quotas(inode))
+		return false;
+
 	WARN_ON(!S_ISDIR(inode->i_mode));
 
 	return check_quota_exceeded(inode, QUOTA_CHECK_MAX_FILES_OP, 0);
@@ -248,6 +276,9 @@ bool ceph_quota_is_max_bytes_exceeded(struct inode *inode, loff_t newsize)
 {
 	loff_t size = i_size_read(inode);
 
+	if (!ceph_has_realms_with_quotas(inode))
+		return false;
+
 	/* return immediately if we're decreasing file size */
 	if (newsize <= size)
 		return false;
@@ -267,6 +298,9 @@ bool ceph_quota_is_max_bytes_approaching(struct inode *inode, loff_t newsize)
 {
 	loff_t size = ceph_inode(inode)->i_reported_size;
 
+	if (!ceph_has_realms_with_quotas(inode))
+		return false;
+
 	/* return immediately if we're decreasing file size */
 	if (newsize <= size)
 		return false;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5f788350cd75..cc6c4d6d45d6 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1082,6 +1082,9 @@ extern int ceph_fs_debugfs_init(struct ceph_fs_client *client);
 extern void ceph_fs_debugfs_cleanup(struct ceph_fs_client *client);
 
 /* quota.c */
+extern void ceph_quota_update_inode(struct ceph_mds_client *mdsc,
+				    struct ceph_inode_info *ci,
+				    u64 max_bytes, u64 max_files);
 extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
 			      struct ceph_mds_session *session,
 			      struct ceph_msg *msg);
