From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH 3/3] ceph: quota: don't allow cross-quota renames
Date: Wed,  6 Sep 2017 15:12:24 +0100
Message-ID: <20170906141224.11813-4-lhenriques@suse.com>
References: <20170906141224.11813-1-lhenriques@suse.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932242AbdIFOMd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 6 Sep 2017 10:12:33 -0400
In-Reply-To: <20170906141224.11813-1-lhenriques@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Fajerski <jfajerski@suse.com>
Cc: ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>

This patch changes ceph_rename so that -EXDEV is returned if an attempt is
made to mv a file between two different dir trees with different quotas
setup.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/dir.c   |  4 ++++
 fs/ceph/quota.c | 35 +++++++++++++++++++++++++++++++++++
 fs/ceph/super.h |  1 +
 3 files changed, 40 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index fb6adcf0ff51..dba96e227b43 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1087,6 +1087,10 @@ static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
 		else
 			return -EROFS;
 	}
+	/* don't allow cross-quota renames */
+	if ((old_dir != new_dir) && (!ceph_quota_is_same_root(old_dir, new_dir)))
+		return -EXDEV;
+
 	dout("rename dir %p dentry %p to dir %p dentry %p\n",
 	     old_dir, old_dentry, new_dir, new_dentry);
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 1bd02658f16a..80d5231a0905 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -20,6 +20,11 @@
 #include "super.h"
 #include "mds_client.h"
 
+static inline bool ceph_has_quota(struct ceph_inode_info *ci)
+{
+	return (ci->i_max_files || ci->i_max_bytes);
+}
+
 void ceph_handle_quota(struct ceph_mds_client *mdsc,
 		       struct ceph_mds_session *session,
 		       struct ceph_msg *msg)
@@ -58,6 +63,36 @@ void ceph_handle_quota(struct ceph_mds_client *mdsc,
 	iput(inode);
 }
 
+static struct ceph_inode_info *get_quota_root(struct inode *inode)
+{
+	struct ceph_inode_info *ci;
+	struct dentry *next, *parent;
+
+	next = d_find_any_alias(inode);
+	ci = ceph_inode(d_inode(next));
+	while (!ceph_has_quota(ci) && !IS_ROOT(next)) {
+		parent = dget_parent(next);
+		dput(next);
+		next = parent;
+		ci = ceph_inode(d_inode(next));
+	}
+
+	dput(next);
+	if (ceph_has_quota(ci))
+		return ci;
+	return NULL;
+}
+
+bool ceph_quota_is_same_root(struct inode *old, struct inode *new)
+{
+	struct ceph_inode_info *ci_old, *ci_new;
+
+	ci_old = get_quota_root(old);
+	ci_new = get_quota_root(new);
+
+	return (ci_old == ci_new);
+}
+
 bool ceph_quota_is_quota_files_exceeded(struct inode *inode)
 {
 	struct ceph_inode_info *ci;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index ef131107dbf6..5e4f23ab556f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1012,5 +1012,6 @@ extern void ceph_handle_quota(struct ceph_mds_client *mdsc,
 			      struct ceph_mds_session *session,
 			      struct ceph_msg *msg);
 extern bool ceph_quota_is_quota_files_exceeded(struct inode *inode);
+extern bool ceph_quota_is_same_root(struct inode *old, struct inode *new);
 
 #endif /* _FS_CEPH_SUPER_H */
