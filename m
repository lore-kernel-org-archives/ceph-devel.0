From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC v2 PATCH 4/4] ceph: quota: don't allow cross-quota renames
Date: Mon, 18 Dec 2017 15:39:02 +0000
Message-ID: <20171218153902.7455-5-lhenriques@suse.com>
References: <20171218153902.7455-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752987AbdLRPjP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 18 Dec 2017 10:39:15 -0500
In-Reply-To: <20171218153902.7455-1-lhenriques@suse.com>
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
 fs/ceph/quota.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/super.h |  1 +
 3 files changed, 69 insertions(+)

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
index 06f28f11be25..119e16ce793b 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -20,6 +20,11 @@
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
@@ -58,6 +63,64 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 	iput(inode);
 }
 
+/*
+ * This function walks through the snaprealm for an inode and returns the
+ * ceph_inode_info for the first snaprealm that has quotas set (either max_files
+ * or max_bytes).  If the root is reached, return the root ceph_inode_info
+ * instead.
+ *
+ * Note that this snaprealm walk isn't protected with snaprealm_look, that shall
+ * be done by the caller.
+ */
+static struct ceph_inode_info *get_quota_realm(struct inode *inode)
+{
+	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_inode_info *ci = NULL;
+	struct ceph_snap_realm *realm, *next;
+	struct ceph_vino vino;
+	struct inode *ino;
+
+	realm = ceph_inode(inode)->i_snap_realm;
+	ceph_get_snap_realm(mdsc, realm);
+	while (realm) {
+		vino.ino = realm->ino;
+		vino.snap = CEPH_NOSNAP;
+		ino = ceph_find_inode(inode->i_sb, vino);
+		if (!ino) {
+			pr_warn("Failed to find inode for %llu\n", vino.ino);
+			break;
+		}
+		ci = ceph_inode(ino);
+		if (ceph_has_quota(ci) || (ci->i_vino.ino == CEPH_INO_ROOT)) {
+			iput(ino);
+			break;
+		}
+		iput(ino);
+		next = realm->parent;
+		ceph_get_snap_realm(mdsc, next);
+		ceph_put_snap_realm(mdsc, realm);
+		realm = next;
+	}
+	ceph_put_snap_realm(mdsc, realm);
+
+	return ci;
+}
+
+bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
+{
+	struct ceph_inode_info *ci_old, *ci_new;
+	unsigned seq;
+
+retry:
+	seq = read_seqbegin(&snaprealm_lock);
+	ci_old = get_quota_realm(old);
+	ci_new = get_quota_realm(new);
+	if (read_seqretry(&snaprealm_lock, seq))
+		goto retry;
+
+	return (ci_old == ci_new);
+}
+
 /*
  * check_quota_exceeded() will walk up the snaprealm hierarchy and, for each
  * realm, it will execute quota check operation defined by the 'op' parameter.
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index a83847d6f8f9..d8c8baaf049c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1029,5 +1029,6 @@ extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
 			      struct ceph_mds_session *session,
 			      struct ceph_msg *msg);
 extern bool ceph_quota_is_max_files_exceeded(struct inode *inode);
+extern bool ceph_quota_is_same_realm(struct inode *old, struct inode *new);
 
 #endif /* _FS_CEPH_SUPER_H */
