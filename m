From: Sage Weil <sage@newdream.net>
Subject: [PATCH 09/23] ceph: fix bad parent_inode calc in ceph_lookup_open
Date: Fri, 22 Jul 2011 17:02:48 -0700
Message-ID: <1311379382-9218-10-git-send-email-sage@newdream.net>
References: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44319 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab1GWAFy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:54 -0400
In-Reply-To: <1311379382-9218-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

We were always getting NULL here because the intent file f_dentry is always
NULL at this point, which means we were always passing NULL to
ceph_mdsc_do_request.  In reality, this was fine, since this isn't
currently ever a write operation that needs to get strung on the dir's
unsafe list.

Use the dir explicitly, and only pass it if this open has side-effects that
a dir fsync should flush.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 fs/ceph/file.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 6c90cf0..9b667e9 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -223,7 +223,6 @@ struct dentry *ceph_lookup_open(struct inode *dir, struct dentry *dentry,
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct file *file = nd->intent.open.file;
-	struct inode *parent_inode = get_dentry_parent_inode(file->f_dentry);
 	struct ceph_mds_request *req;
 	int err;
 	int flags = nd->intent.open.flags - 1;  /* silly vfs! */
@@ -242,7 +241,9 @@ struct dentry *ceph_lookup_open(struct inode *dir, struct dentry *dentry,
 		req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
 	}
 	req->r_locked_dir = dir;           /* caller holds dir->i_mutex */
-	err = ceph_mdsc_do_request(mdsc, parent_inode, req);
+	err = ceph_mdsc_do_request(mdsc,
+				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
+				   req);
 	dentry = ceph_finish_lookup(req, dentry, err);
 	if (!err && (flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
-- 
1.7.0

