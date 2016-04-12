From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/3] ceph: kill __ceph_removexattr()
Date: Tue, 12 Apr 2016 20:19:26 +0800
Message-ID: <1460463566-75273-3-git-send-email-zyan@redhat.com>
References: <1460463566-75273-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50735 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932759AbcDLMTn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Apr 2016 08:19:43 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD77264D0B
	for <ceph-devel@vger.kernel.org>; Tue, 12 Apr 2016 12:19:42 +0000 (UTC)
In-Reply-To: <1460463566-75273-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: agruenba@redhat.com, "Yan, Zheng" <zyan@redhat.com>

when removing a xattr, generic_removexattr() calls __ceph_setxattr()
with NULL value and XATTR_REPLACE flag. __ceph_removexattr() is not
used any more.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/xattr.c | 126 --------------------------------------------------------
 1 file changed, 126 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index adc81f6..f3bad03 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -519,19 +519,6 @@ static int __remove_xattr(struct ceph_inode_info *ci,
 	return 0;
 }
 
-static int __remove_xattr_by_name(struct ceph_inode_info *ci,
-			   const char *name)
-{
-	struct rb_node **p;
-	struct ceph_inode_xattr *xattr;
-	int err;
-
-	p = &ci->i_xattrs.index.rb_node;
-	xattr = __get_xattr(ci, name);
-	err = __remove_xattr(ci, xattr);
-	return err;
-}
-
 static char *__copy_xattr_names(struct ceph_inode_info *ci,
 				char *dest)
 {
@@ -1075,119 +1062,6 @@ out:
 	return err;
 }
 
-static int ceph_send_removexattr(struct inode *inode, const char *name)
-{
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
-	struct ceph_mds_client *mdsc = fsc->mdsc;
-	struct ceph_mds_request *req;
-	int err;
-
-	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_RMXATTR,
-				       USE_AUTH_MDS);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-	req->r_path2 = kstrdup(name, GFP_NOFS);
-	if (!req->r_path2)
-		return -ENOMEM;
-
-	req->r_inode = inode;
-	ihold(inode);
-	req->r_num_caps = 1;
-	req->r_inode_drop = CEPH_CAP_XATTR_SHARED;
-	err = ceph_mdsc_do_request(mdsc, NULL, req);
-	ceph_mdsc_put_request(req);
-	return err;
-}
-
-static int __ceph_removexattr(struct inode *inode, const char *name)
-{
-	struct ceph_vxattr *vxattr;
-	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
-	struct ceph_cap_flush *prealloc_cf = NULL;
-	int issued;
-	int err;
-	int required_blob_size;
-	int dirty;
-	bool lock_snap_rwsem = false;
-
-	if (ceph_snap(inode) != CEPH_NOSNAP)
-		return -EROFS;
-
-	vxattr = ceph_match_vxattr(inode, name);
-	if (vxattr && vxattr->readonly)
-		return -EOPNOTSUPP;
-
-	/* pass any unhandled ceph.* xattrs through to the MDS */
-	if (!strncmp(name, XATTR_CEPH_PREFIX, XATTR_CEPH_PREFIX_LEN))
-		goto do_sync_unlocked;
-
-	prealloc_cf = ceph_alloc_cap_flush();
-	if (!prealloc_cf)
-		return -ENOMEM;
-
-	err = -ENOMEM;
-	spin_lock(&ci->i_ceph_lock);
-retry:
-	issued = __ceph_caps_issued(ci, NULL);
-	if (ci->i_xattrs.version == 0 || !(issued & CEPH_CAP_XATTR_EXCL))
-		goto do_sync;
-
-	if (!lock_snap_rwsem && !ci->i_head_snapc) {
-		lock_snap_rwsem = true;
-		if (!down_read_trylock(&mdsc->snap_rwsem)) {
-			spin_unlock(&ci->i_ceph_lock);
-			down_read(&mdsc->snap_rwsem);
-			spin_lock(&ci->i_ceph_lock);
-			goto retry;
-		}
-	}
-
-	dout("removexattr %p issued %s\n", inode, ceph_cap_string(issued));
-
-	__build_xattrs(inode);
-
-	required_blob_size = __get_required_blob_size(ci, 0, 0);
-
-	if (!ci->i_xattrs.prealloc_blob ||
-	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
-		struct ceph_buffer *blob;
-
-		spin_unlock(&ci->i_ceph_lock);
-		dout(" preaallocating new blob size=%d\n", required_blob_size);
-		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
-		if (!blob)
-			goto do_sync_unlocked;
-		spin_lock(&ci->i_ceph_lock);
-		if (ci->i_xattrs.prealloc_blob)
-			ceph_buffer_put(ci->i_xattrs.prealloc_blob);
-		ci->i_xattrs.prealloc_blob = blob;
-		goto retry;
-	}
-
-	err = __remove_xattr_by_name(ceph_inode(inode), name);
-
-	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL,
-				       &prealloc_cf);
-	ci->i_xattrs.dirty = true;
-	inode->i_ctime = current_fs_time(inode->i_sb);
-	spin_unlock(&ci->i_ceph_lock);
-	if (lock_snap_rwsem)
-		up_read(&mdsc->snap_rwsem);
-	if (dirty)
-		__mark_inode_dirty(inode, dirty);
-	ceph_free_cap_flush(prealloc_cf);
-	return err;
-do_sync:
-	spin_unlock(&ci->i_ceph_lock);
-do_sync_unlocked:
-	if (lock_snap_rwsem)
-		up_read(&mdsc->snap_rwsem);
-	ceph_free_cap_flush(prealloc_cf);
-	err = ceph_send_removexattr(inode, name);
-	return err;
-}
-
 static int ceph_get_xattr_handler(const struct xattr_handler *handler,
 				  struct dentry *dentry, const char *name,
 				  void *value, size_t size)
-- 
2.5.0

