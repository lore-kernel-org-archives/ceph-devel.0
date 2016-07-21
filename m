From: Venky Shankar <vshankar@redhat.com>
Subject: [RFC 1/2] ceph: introduce 'ceph.all' virtual xattr
Date: Thu, 21 Jul 2016 12:19:17 +0530
Message-ID: <1469083758-2153-1-git-send-email-vshankar@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36073 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcGUGtZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 02:49:25 -0400
Received: by mail-pf0-f178.google.com with SMTP id h186so27199862pfg.3
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 23:49:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com

As of now listing extended attributes result in ceph dump all of
it's internal xattrs thereby confusing tools such as rsync and the
likes. This functionality would be removed in the subsequent patch,
but there needs to be a way to examine ceph's internal xattr.

Remembering all internal xattrs is cumbersome and error prone, so,
we provide a virtual xattr to fetch a list of ceph's internal xattr,
obviously excluding itself.

Signed-off-by: Venky Shankar <vshankar@redhat.com>
---
 fs/ceph/xattr.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 4870b29..d0f59cb 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -204,7 +204,45 @@ static size_t ceph_vxattrcb_dir_rctime(struct ceph_inode_info *ci, char *val,
 			(long)ci->i_rctime.tv_nsec);
 }
 
+static struct ceph_vxattr *ceph_inode_vxattrs(struct inode *inode);
+static size_t ceph_vxattrs_name_size(struct ceph_vxattr *vxattrs);
 
+/* list all ceph internal xattrs */
+static size_t ceph_vxattrcb_list_all(struct ceph_inode_info *ci, char *val,
+                                     size_t size)
+{
+        struct inode *inode = &ci->vfs_inode;
+        struct ceph_vxattr *vxattr;
+        struct ceph_vxattr *vxattrs = ceph_inode_vxattrs(inode);
+        u32 len, namelen;
+        int err = 0;
+
+        if (!vxattrs)
+                goto out;
+
+        namelen = ceph_vxattrs_name_size(vxattrs);
+
+        err = -ERANGE;
+        if (size && (namelen > size))
+                goto out;
+        err = namelen;
+        if (size == 0)
+                goto out;
+
+        /* fill up buffer with virtual xattrs */
+        for (err = 0, vxattr = vxattrs; vxattr->name; vxattr++) {
+                if (!vxattr->hidden && !(vxattr->exists_cb
+                                         && !vxattr->exists_cb(ci))) {
+                        len = snprintf(val + err, size - err, "%s", vxattr->name);
+                        err += len + 1;
+                }
+        }
+
+ out:
+        return err;
+}
+
+#define CEPH_XATTR_LIST_INTERNAL  XATTR_CEPH_PREFIX"all"
 #define CEPH_XATTR_NAME(_type, _name)	XATTR_CEPH_PREFIX #_type "." #_name
 #define CEPH_XATTR_NAME2(_type, _name, _name2)	\
 	XATTR_CEPH_PREFIX #_type "." #_name "." #_name2
@@ -237,6 +275,14 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
 		.hidden = true,
 		.exists_cb = ceph_vxattrcb_layout_exists,
 	},
+        {
+                .name = CEPH_XATTR_LIST_INTERNAL,
+                .name_size = sizeof(CEPH_XATTR_LIST_INTERNAL),
+                .getxattr_cb = ceph_vxattrcb_list_all,
+                .readonly = true,
+                .hidden = true,
+                .exists_cb = NULL,
+        },
 	XATTR_LAYOUT_FIELD(dir, layout, stripe_unit),
 	XATTR_LAYOUT_FIELD(dir, layout, stripe_count),
 	XATTR_LAYOUT_FIELD(dir, layout, object_size),
@@ -264,6 +310,14 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
 		.hidden = true,
 		.exists_cb = ceph_vxattrcb_layout_exists,
 	},
+        {
+                .name = CEPH_XATTR_LIST_INTERNAL,
+                .name_size = sizeof(CEPH_XATTR_LIST_INTERNAL),
+                .getxattr_cb = ceph_vxattrcb_list_all,
+                .readonly = true,
+                .hidden = true,
+                .exists_cb = NULL,
+        },
 	XATTR_LAYOUT_FIELD(file, layout, stripe_unit),
 	XATTR_LAYOUT_FIELD(file, layout, stripe_count),
 	XATTR_LAYOUT_FIELD(file, layout, object_size),
-- 
2.1.4

