From: Sanidhya Kashyap <sanidhya.gatech@gmail.com>
Subject: [PATCH] ceph: kstrdup() memory handling
Date: Sat, 21 Mar 2015 12:54:58 -0400
Message-ID: <1426956898-32132-1-git-send-email-sanidhya.gatech@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, sage@redhat.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, changwoo@gatech.edu, sanidhya@gatech.edu, blee@gatech.edu, Sanidhya Kashyap <sanidhya.gatech@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Currently, there is no check for the kstrdup() for r_path2, r_path1 and snapdir_name
as various locations as there is a possibility of failure during memory pressure.
Therefore, returning ENOMEM where the checks have been missed.

Signed-off-by: Sanidhya Kashyap <sanidhya.gatech@gmail.com>
---
 fs/ceph/dir.c   | 11 +++++++++++
 fs/ceph/super.c |  8 ++++++++
 fs/ceph/xattr.c |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 83e9976..be32703 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -344,6 +344,12 @@ more:
 		req->r_direct_hash = ceph_frag_value(frag);
 		req->r_direct_is_hash = true;
 		req->r_path2 = kstrdup(fi->last_name, GFP_NOFS);
+		if (!req->r_path2) {
+			iput(inode);
+			ceph_mdsc_put_request(req);
+			return -ENOMEM;
+		}
+
 		req->r_readdir_offset = fi->next_offset;
 		req->r_args.readdir.frag = cpu_to_le32(frag);
 		err = ceph_mdsc_do_request(mdsc, NULL, req);
@@ -758,6 +764,11 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_path2 = kstrdup(dest, GFP_NOFS);
+	if (!req->r_path2) {
+		err = -ENOMEM;
+		ceph_mdsc_put_request(req);
+		goto out;
+	}
 	req->r_locked_dir = dir;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a63997b..8e68f53 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -345,6 +345,9 @@ static int parse_mount_options(struct ceph_mount_options **pfsopt,
 	fsopt->rsize = CEPH_RSIZE_DEFAULT;
 	fsopt->rasize = CEPH_RASIZE_DEFAULT;
 	fsopt->snapdir_name = kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL);
+	if (!fsopt->snapdir_name)
+		goto out;
+
 	fsopt->caps_wanted_delay_min = CEPH_CAPS_WANTED_DELAY_MIN_DEFAULT;
 	fsopt->caps_wanted_delay_max = CEPH_CAPS_WANTED_DELAY_MAX_DEFAULT;
 	fsopt->cap_release_safety = CEPH_CAP_RELEASE_SAFETY_DEFAULT;
@@ -730,6 +733,11 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 	if (IS_ERR(req))
 		return ERR_CAST(req);
 	req->r_path1 = kstrdup(path, GFP_NOFS);
+	if (!req->r_path1) {
+		root = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
 	req->r_ino1.ino = CEPH_INO_ROOT;
 	req->r_ino1.snap = CEPH_NOSNAP;
 	req->r_started = started;
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5a492ca..299eb83 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -883,6 +883,11 @@ static int ceph_sync_setxattr(struct dentry *dentry, const char *name,
 	req->r_num_caps = 1;
 	req->r_args.setxattr.flags = cpu_to_le32(flags);
 	req->r_path2 = kstrdup(name, GFP_NOFS);
+	if (!req->r_path2) {
+		ceph_mdsc_put_request(req);
+		err = -ENOMEM;
+		goto out;
+	}
 
 	req->r_pagelist = pagelist;
 	pagelist = NULL;
@@ -1024,6 +1029,8 @@ static int ceph_send_removexattr(struct dentry *dentry, const char *name)
 	req->r_inode_drop = CEPH_CAP_XATTR_SHARED;
 	req->r_num_caps = 1;
 	req->r_path2 = kstrdup(name, GFP_NOFS);
+	if (!req->r_path2)
+		return -ENOMEM;
 
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
-- 
2.1.0
