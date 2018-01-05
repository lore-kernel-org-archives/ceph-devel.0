From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v4 3/6] ceph: quota: don't allow cross-quota renames
Date: Fri,  5 Jan 2018 10:47:20 +0000
Message-ID: <20180105104723.16202-4-lhenriques@suse.com>
References: <20180105104723.16202-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36325 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbeAEKrh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 5 Jan 2018 05:47:37 -0500
In-Reply-To: <20180105104723.16202-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>, Jeff Layton <jlayton@redhat.com>, Jan Fajerski <jfajerski@suse.com>, Luis Henriques <lhenriques@suse.com>

This patch changes ceph_rename so that -EXDEV is returned if an attempt is
made to mv a file between two different dir trees with different quotas
setup.

Link: http://tracker.ceph.com/issues/22372
Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/dir.c   |  5 +++++
 fs/ceph/quota.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h |  1 +
 3 files changed, 75 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 66550d92b1ac..f6ac16caa1e9 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1090,6 +1090,11 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
 		else
 			return -EROFS;
 	}
+	/* don't allow cross-quota renames */
+	if ((old_dir != new_dir) &&
+	    (!ceph_quota_is_same_realm(old_dir, new_dir)))
+		return -EXDEV;
+
 	dout("rename dir %p dentry %p to dir %p dentry %p\n",
 	     old_dir, old_dentry, new_dir, new_dentry);
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index cf1c78c4a4d2..5d7dada91a57 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -21,6 +21,11 @@
 #include "super.h"
 #include "mds_client.h"
 
+static inline bool ceph_has_quota(struct ceph_inode_info *ci)
+{
+	return (ci && (ci->i_max_files || ci->i_max_bytes));
+}
+
 void ceph_handle_quota(struct ceph_mds_client *mdsc,
 		       struct ceph_mds_session *session,
 		       struct ceph_msg *msg)
@@ -64,6 +69,70 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 	iput(inode);
 }
 
+/*
+ * This function walks through the snaprealm for an inode and returns the
+ * ceph_snap_realm for the first snaprealm that has quotas set (either max_files
+ * or max_bytes).  If the root is reached, return the root ceph_snap_realm
+ * instead.
+ *
+ * Note that the caller is responsible for calling ceph_put_snap_realm() on the
+ * returned realm.
+ */
+static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
+					       struct inode *inode)
+{
+	struct ceph_inode_info *ci = NULL;
+	struct ceph_snap_realm *realm, *next;
+	struct ceph_vino vino;
+	struct inode *in;
+
+	realm = ceph_inode(inode)->i_snap_realm;
+	ceph_get_snap_realm(mdsc, realm);
+	while (realm) {
+		vino.ino = realm->ino;
+		vino.snap = CEPH_NOSNAP;
+		in = ceph_find_inode(inode->i_sb, vino);
+		if (!in) {
+			pr_warn("Failed to find inode for %llu\n", vino.ino);
+			break;
+		}
+		ci = ceph_inode(in);
+		if (ceph_has_quota(ci) || (ci->i_vino.ino == CEPH_INO_ROOT)) {
+			iput(in);
+			return realm;
+		}
+		iput(in);
+		next = realm->parent;
+		ceph_get_snap_realm(mdsc, next);
+		ceph_put_snap_realm(mdsc, realm);
+		realm = next;
+	}
+	if (realm)
+		ceph_put_snap_realm(mdsc, realm);
+
+	return NULL;
+}
+
+bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
+{
+	struct ceph_mds_client *mdsc = ceph_inode_to_client(old)->mdsc;
+	struct ceph_snap_realm *old_realm, *new_realm;
+	bool is_same;
+
+	down_read(&mdsc->snap_rwsem);
+	old_realm = get_quota_realm(mdsc, old);
+	new_realm = get_quota_realm(mdsc, new);
+	is_same = (old_realm == new_realm);
+	up_read(&mdsc->snap_rwsem);
+
+	if (old_realm)
+		ceph_put_snap_realm(mdsc, old_realm);
+	if (new_realm)
+		ceph_put_snap_realm(mdsc, new_realm);
+
+	return is_same;
+}
+
 enum quota_check_op {
 	QUOTA_CHECK_MAX_FILES_OP	/* check quota max_files limit */
 };
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 20197e29a7f0..a66e73338386 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1027,5 +1027,6 @@ extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
 			      struct ceph_mds_session *session,
 			      struct ceph_msg *msg);
 extern bool ceph_quota_is_max_files_exceeded(struct inode *inode);
+extern bool ceph_quota_is_same_realm(struct inode *old, struct inode *new);
 
 #endif /* _FS_CEPH_SUPER_H */
