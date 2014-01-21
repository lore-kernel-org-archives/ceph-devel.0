From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 06/11] ceph: check inode caps in ceph_d_revalidate
Date: Tue, 21 Jan 2014 12:15:40 +0800
Message-ID: <1390277745-20142-6-git-send-email-zheng.z.yan@intel.com>
References: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:62235 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbaAUEPz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 20 Jan 2014 23:15:55 -0500
In-Reply-To: <1390277745-20142-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

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
index d2154d6..d65ff33 100644
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
index b629e9d..619616d 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1041,14 +1041,19 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
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
index 891cda8..a6ba32f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -782,6 +782,7 @@ extern int ceph_add_cap(struct inode *inode,
 extern void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release);
 extern void ceph_put_cap(struct ceph_mds_client *mdsc,
 			 struct ceph_cap *cap);
+extern int ceph_is_any_caps(struct inode *inode);
 
 extern void __queue_cap_release(struct ceph_mds_session *session, u64 ino,
 				u64 cap_id, u32 migrate_seq, u32 issue_seq);
-- 
1.8.4.2

