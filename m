From: Alex Elder <elder@dreamhost.com>
Subject: ceph: ensure prealloc_blob is in place when removing xattr
Date: Thu, 05 Jan 2012 11:12:09 -0600
Message-ID: <1325783529.30703.38.camel@doink>
Reply-To: elder@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:50482 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757761Ab2AERMM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2012 12:12:12 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 9E284C064
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jan 2012 09:23:45 -0800 (PST)
Received: from [172.22.22.65] (c-71-193-71-178.hsd1.mn.comcast.net [71.193.71.178])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 5C8D4C062
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jan 2012 09:23:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

In __ceph_build_xattrs_blob(), if a ceph inode's extended attributes
are marked dirty, all attributes recorded in its rb_tree index are
formatted into a "blob" buffer.  The target buffer is recorded in
ceph_inode->i_xattrs.prealloc_blob, and it is expected to exist and
be of sufficient size to hold the attributes.

The extended attributes are marked dirty in two cases: when a new
attribute is added to the inode; or when one is removed.  In the
former case work is done to ensure the prealloc_blob buffer is
properly set up, but in the latter it is not.

Change the logic in ceph_removexattr() so it matches what is
done in ceph_setxattr().  Note that this is done in a way that
keeps the two blocks of code nearly identical, in anticipation
of a subsequent patch that encapsulates some of this logic into
one or more helper routines.

Signed-off-by: Alex Elder <elder@dreamhost.com>

---
 fs/ceph/xattr.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: b/fs/ceph/xattr.c
===================================================================
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -818,6 +818,7 @@ int ceph_removexattr(struct dentry *dent
 	struct ceph_vxattr_cb *vxattrs = ceph_inode_vxattrs(inode);
 	int issued;
 	int err;
+	int required_blob_size;
 	int dirty;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -833,14 +834,34 @@ int ceph_removexattr(struct dentry *dent
 			return -EOPNOTSUPP;
 	}
 
+	err = -ENOMEM;
 	spin_lock(&ci->i_ceph_lock);
 	__build_xattrs(inode);
+retry:
 	issued = __ceph_caps_issued(ci, NULL);
 	dout("removexattr %p issued %s\n", inode, ceph_cap_string(issued));
 
 	if (!(issued & CEPH_CAP_XATTR_EXCL))
 		goto do_sync;
 
+	required_blob_size = __get_required_blob_size(ci, 0, 0);
+
+	if (!ci->i_xattrs.prealloc_blob ||
+	    required_blob_size > ci->i_xattrs.prealloc_blob->alloc_len) {
+		struct ceph_buffer *blob;
+
+		spin_unlock(&ci->i_ceph_lock);
+		dout(" preaallocating new blob size=%d\n", required_blob_size);
+		blob = ceph_buffer_new(required_blob_size, GFP_NOFS);
+		if (!blob)
+			goto out;
+		spin_lock(&ci->i_ceph_lock);
+		if (ci->i_xattrs.prealloc_blob)
+			ceph_buffer_put(ci->i_xattrs.prealloc_blob);
+		ci->i_xattrs.prealloc_blob = blob;
+		goto retry;
+	}
+
 	err = __remove_xattr_by_name(ceph_inode(inode), name);
 	dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_XATTR_EXCL);
 	ci->i_xattrs.dirty = true;
@@ -853,6 +874,7 @@ int ceph_removexattr(struct dentry *dent
 do_sync:
 	spin_unlock(&ci->i_ceph_lock);
 	err = ceph_send_removexattr(dentry, name);
+out:
 	return err;
 }
 


