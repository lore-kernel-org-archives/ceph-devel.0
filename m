From: Venky Shankar <vshankar@redhat.com>
Subject: [PATCH 2/2] ceph: do not return virtual xattrs in listxattr()
Date: Thu, 21 Jul 2016 17:47:30 +0530
Message-ID: <1469103450-5255-3-git-send-email-vshankar@redhat.com>
References: <1469083758-2153-1-git-send-email-vshankar@redhat.com>
 <1469103450-5255-1-git-send-email-vshankar@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35288 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596AbcGUMRu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 08:17:50 -0400
Received: by mail-pa0-f46.google.com with SMTP id iw10so28710820pac.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 05:17:50 -0700 (PDT)
In-Reply-To: <1469103450-5255-1-git-send-email-vshankar@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com

Signed-off-by: Venky Shankar <vshankar@redhat.com>
---
 fs/ceph/xattr.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 019f784..816c4ef 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -848,12 +848,8 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 {
 	struct inode *inode = d_inode(dentry);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_vxattr *vxattrs = ceph_inode_vxattrs(inode);
-	u32 vir_namelen = 0;
 	u32 namelen;
 	int err;
-	u32 len;
-	int i;
 
 	spin_lock(&ci->i_ceph_lock);
 	dout("listxattr %p ver=%lld index_ver=%lld\n", inode,
@@ -871,38 +867,19 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	err = __build_xattrs(inode);
 	if (err < 0)
 		goto out;
-	/*
-	 * Start with virtual dir xattr names (if any) (including
-	 * terminating '\0' characters for each).
-	 */
-	vir_namelen = ceph_vxattrs_name_size(vxattrs);
 
 	/* adding 1 byte per each variable due to the null termination */
 	namelen = ci->i_xattrs.names_size + ci->i_xattrs.count;
 	err = -ERANGE;
-	if (size && vir_namelen + namelen > size)
+	if (size && namelen > size)
 		goto out;
 
-	err = namelen + vir_namelen;
+	err = namelen;
 	if (size == 0)
 		goto out;
 
 	names = __copy_xattr_names(ci, names);
 
-	/* virtual xattr names, too */
-	err = namelen;
-	if (vxattrs) {
-		for (i = 0; vxattrs[i].name; i++) {
-			if (!vxattrs[i].hidden &&
-			    !(vxattrs[i].exists_cb &&
-			      !vxattrs[i].exists_cb(ci))) {
-				len = sprintf(names, "%s", vxattrs[i].name);
-				names += len + 1;
-				err += len + 1;
-			}
-		}
-	}
-
 out:
 	spin_unlock(&ci->i_ceph_lock);
 	return err;
-- 
2.1.4

