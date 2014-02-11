From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/5] ceph: add missing init_acl() for mkdir() and atomic_open()
Date: Tue, 11 Feb 2014 13:30:11 +0800
Message-ID: <1392096612-11481-4-git-send-email-zheng.z.yan@intel.com>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62079 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbaBKFaK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Feb 2014 00:30:10 -0500
In-Reply-To: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, "Yan, Zheng" <zheng.z.yan@intel.com>

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/dir.c  | 9 +++++----
 fs/ceph/file.c | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 6da4df8..3bbd0eb 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -695,9 +695,8 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	ceph_mdsc_put_request(req);
 
 	if (!err)
-		err = ceph_init_acl(dentry, dentry->d_inode, dir);
-
-	if (err)
+		ceph_init_acl(dentry, dentry->d_inode, dir);
+	else
 		d_drop(dentry);
 	return err;
 }
@@ -776,7 +775,9 @@ static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 		err = ceph_handle_notrace_create(dir, dentry);
 	ceph_mdsc_put_request(req);
 out:
-	if (err < 0)
+	if (!err)
+		ceph_init_acl(dentry, dentry->d_inode, dir);
+	else
 		d_drop(dentry);
 	return err;
 }
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index dfd2ce3..09c7afe 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -286,6 +286,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	} else {
 		dout("atomic_open finish_open on dn %p\n", dn);
 		if (req->r_op == CEPH_MDS_OP_CREATE && req->r_reply_info.has_create_ino) {
+			ceph_init_acl(dentry, dentry->d_inode, dir);
 			*opened |= FILE_CREATED;
 		}
 		err = finish_open(file, dentry, ceph_open, opened);
-- 
1.8.5.3

