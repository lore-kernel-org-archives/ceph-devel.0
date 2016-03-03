From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] ceph: initial CEPH_FEATURE_FS_FILE_LAYOUT_V2 support
Date: Thu,  3 Mar 2016 16:13:48 +0100
Message-ID: <1457018028-32252-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36209 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbcCCPOg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2016 10:14:36 -0500
Received: by mail-wm0-f46.google.com with SMTP id n186so136232076wmn.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Mar 2016 07:14:34 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>, Zheng Yan <zyan@redhat.com>

From: "Yan, Zheng" <zyan@redhat.com>

Add support for the format change of MClientReply/MclientCaps.
Also add code that denies access to inodes with pool_ns layouts.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/addr.c                     |  4 ++++
 fs/ceph/caps.c                     | 27 ++++++++++++++++++++++++---
 fs/ceph/inode.c                    |  2 ++
 fs/ceph/mds_client.c               | 16 ++++++++++++++++
 fs/ceph/mds_client.h               |  1 +
 fs/ceph/super.h                    |  1 +
 include/linux/ceph/ceph_features.h |  1 +
 7 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 32f57a1f1baf..888674c311c5 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1840,6 +1840,10 @@ int ceph_pool_perm_check(struct ceph_inode_info *ci, int need)
 	u32 pool;
 	int ret, flags;
 
+	/* does not support pool namespace yet */
+	if (ci->i_pool_ns_len)
+		return -EIO;
+
 	if (ceph_test_mount_opt(ceph_inode_to_client(&ci->vfs_inode),
 				NOPOOLPERM))
 		return 0;
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6094d0e7cdc1..de17bb232ff8 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2756,7 +2756,8 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 			     void *inline_data, int inline_len,
 			     struct ceph_buffer *xattr_buf,
 			     struct ceph_mds_session *session,
-			     struct ceph_cap *cap, int issued)
+			     struct ceph_cap *cap, int issued,
+			     u32 pool_ns_len)
 	__releases(ci->i_ceph_lock)
 	__releases(mdsc->snap_rwsem)
 {
@@ -2876,6 +2877,8 @@ static void handle_cap_grant(struct ceph_mds_client *mdsc,
 	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
 		/* file layout may have changed */
 		ci->i_layout = grant->layout;
+		ci->i_pool_ns_len = pool_ns_len;
+
 		/* size/truncate_seq? */
 		queue_trunc = ceph_fill_file_size(inode, issued,
 					le32_to_cpu(grant->truncate_seq),
@@ -3414,6 +3417,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	u32  inline_len = 0;
 	void *snaptrace;
 	size_t snaptrace_len;
+	u32 pool_ns_len = 0;
 	void *p, *end;
 
 	dout("handle_caps from mds%d\n", mds);
@@ -3466,6 +3470,21 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		p += inline_len;
 	}
 
+	if (le16_to_cpu(msg->hdr.version) >= 8) {
+		u64 flush_tid;
+		u32 caller_uid, caller_gid;
+		u32 osd_epoch_barrier;
+		/* version >= 5 */
+		ceph_decode_32_safe(&p, end, osd_epoch_barrier, bad);
+		/* version >= 6 */
+		ceph_decode_64_safe(&p, end, flush_tid, bad);
+		/* version >= 7 */
+		ceph_decode_32_safe(&p, end, caller_uid, bad);
+		ceph_decode_32_safe(&p, end, caller_gid, bad);
+		/* version >= 8 */
+		ceph_decode_32_safe(&p, end, pool_ns_len, bad);
+	}
+
 	/* lookup ino */
 	inode = ceph_find_inode(sb, vino);
 	ci = ceph_inode(inode);
@@ -3521,7 +3540,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 				  &cap, &issued);
 		handle_cap_grant(mdsc, inode, h,
 				 inline_version, inline_data, inline_len,
-				 msg->middle, session, cap, issued);
+				 msg->middle, session, cap, issued,
+				 pool_ns_len);
 		if (realm)
 			ceph_put_snap_realm(mdsc, realm);
 		goto done_unlocked;
@@ -3545,7 +3565,8 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 		issued |= __ceph_caps_dirty(ci);
 		handle_cap_grant(mdsc, inode, h,
 				 inline_version, inline_data, inline_len,
-				 msg->middle, session, cap, issued);
+				 msg->middle, session, cap, issued,
+				 pool_ns_len);
 		goto done_unlocked;
 
 	case CEPH_CAP_OP_FLUSH_ACK:
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 13c71f906d80..39c8e79b5f9e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -396,6 +396,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	ci->i_symlink = NULL;
 
 	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
+	ci->i_pool_ns_len = 0;
 
 	ci->i_fragtree = RB_ROOT;
 	mutex_init(&ci->i_fragtree_mutex);
@@ -760,6 +761,7 @@ static int fill_inode(struct inode *inode, struct page *locked_page,
 		if (ci->i_layout.fl_pg_pool != info->layout.fl_pg_pool)
 			ci->i_ceph_flags &= ~CEPH_I_POOL_PERM;
 		ci->i_layout = info->layout;
+		ci->i_pool_ns_len = iinfo->pool_ns_len;
 
 		queue_trunc = ceph_fill_file_size(inode, issued,
 					le32_to_cpu(info->truncate_seq),
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b6bec2943a51..aa43dcb5f9b9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -100,6 +100,14 @@ static int parse_reply_info_in(void **p, void *end,
 	} else
 		info->inline_version = CEPH_INLINE_NONE;
 
+	if (features & CEPH_FEATURE_FS_FILE_LAYOUT_V2) {
+		ceph_decode_32_safe(p, end, info->pool_ns_len, bad);
+		ceph_decode_need(p, end, info->pool_ns_len, bad);
+		*p += info->pool_ns_len;
+	} else {
+		info->pool_ns_len = 0;
+	}
+
 	return 0;
 bad:
 	return err;
@@ -2298,6 +2306,14 @@ int ceph_mdsc_do_request(struct ceph_mds_client *mdsc,
 		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
 				  CEPH_CAP_PIN);
 
+	/* deny access to directories with pool_ns layouts */
+	if (req->r_inode && S_ISDIR(req->r_inode->i_mode) &&
+	    ceph_inode(req->r_inode)->i_pool_ns_len)
+		return -EIO;
+	if (req->r_locked_dir &&
+	    ceph_inode(req->r_locked_dir)->i_pool_ns_len)
+		return -EIO;
+
 	/* issue */
 	mutex_lock(&mdsc->mutex);
 	__register_request(mdsc, req, dir);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index ccf11ef0ca87..37712ccffcc6 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -44,6 +44,7 @@ struct ceph_mds_reply_info_in {
 	u64 inline_version;
 	u32 inline_len;
 	char *inline_data;
+	u32 pool_ns_len;
 };
 
 /*
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 16f9edc5d1c7..57ac43d64322 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -286,6 +286,7 @@ struct ceph_inode_info {
 
 	struct ceph_dir_layout i_dir_layout;
 	struct ceph_file_layout i_layout;
+	size_t i_pool_ns_len;
 	char *i_symlink;
 
 	/* for dirs */
diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index d2d78861c30a..ae2f66833762 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -75,6 +75,7 @@
 #define CEPH_FEATURE_CRUSH_TUNABLES5	(1ULL<<58) /* chooseleaf stable mode */
 // duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUNABLES5
 #define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
+#define CEPH_FEATURE_FS_FILE_LAYOUT_V2       (1ULL<<58) /* file_layout_t */
 
 /*
  * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
-- 
2.4.3

