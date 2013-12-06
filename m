From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 07/12] ceph: check inode caps in ceph_d_revalidate
Date: Fri,  6 Dec 2013 16:46:38 +0800
Message-ID: <1386319603-2610-8-git-send-email-zheng.z.yan@intel.com>
References: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23371 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757148Ab3LFIqx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 Dec 2013 03:46:53 -0500
In-Reply-To: <1386319603-2610-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

Some inodes in readdir reply may have no caps. Getattr mds request
for these inodes can return -ESTALE. The fix is consider dentry that
links to inode with no caps as invalid. Invalid dentry causes a
lookup request to send to the mds, the MDS will send caps back.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c  | 12 ++++++++++++
 fs/ceph/dir.c   | 11 ++++++++---
 fs/ceph/super.h |  1 +
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index a32103f..53296c6 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -891,6 +891,18 @@ static int __ceph_is_any_caps(struct ceph_inode_info *ci)
 	return !RB_EMPTY_ROOT(&ci->i_caps) || ci->i_cap_exporting_mds >= 0;
 }
 
+int ceph_is_any_caps(struct inode *inode)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	int ret;
+
+	spin_lock(&ci->i_ceph_lock);
+	ret = __ceph_is_any_caps(ci);
+	spin_unlock(&ci->i_ceph_lock);
+
+	return ret;
+}
+
 /*
  * Remove a cap.  Take steps to deal with a racing iterate_session_caps.
  *
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 2a0bcae..a6e9f2e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1037,14 +1037,19 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		valid = 1;
 	} else if (dentry_lease_is_valid(dentry) ||
 		   dir_lease_is_valid(dir, dentry)) {
-		valid = 1;
+		if (dentry->d_inode)
+			valid = ceph_is_any_caps(dentry->d_inode);
+		else
+			valid = 1;
 	}
 
 	dout("d_revalidate %p %s\n", dentry, valid ? "valid" : "invalid");
-	if (valid)
+	if (valid) {
 		ceph_dentry_lru_touch(dentry);
-	else
+	} else {
+		ceph_dir_clear_complete(dir);
 		d_drop(dentry);
+	}
 	iput(dir);
 	return valid;
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index ae074df..3a4a0f2 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -747,6 +747,7 @@ extern int ceph_add_cap(struct inode *inode,
 extern void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release);
 extern void ceph_put_cap(struct ceph_mds_client *mdsc,
 			 struct ceph_cap *cap);
+extern int ceph_is_any_caps(struct inode *inode);
 
 extern void __queue_cap_release(struct ceph_mds_session *session, u64 ino,
 				u64 cap_id, u32 migrate_seq, u32 issue_seq);
-- 
1.8.1.4

