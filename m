From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v2] ceph: fix recursively call between ceph_set_acl and __ceph_setattr
Date: Wed, 19 Apr 2017 18:36:22 +0800
Message-ID: <20170419103622.52060-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762239AbdDSKg3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Apr 2017 06:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8FF9C1CA438
        for <ceph-devel@vger.kernel.org>; Wed, 19 Apr 2017 10:36:28 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

ceph_set_acl() calls __ceph_setattr() if the setacl operation needs
to modify inode's i_mode. __ceph_setattr() updates inode's i_mode,
then calls posix_acl_chmod().

The problem is that __ceph_setattr() calls posix_acl_chmod() before
sending the setattr request. The get_acl() call in posix_acl_chmod()
can trigger a getxattr request. The reply of the getxattr request
can restore inode's i_mode to its old value. The set_acl() call in
posix_acl_chmod() sees old value of inode's i_mode, so it calls
__ceph_setattr() again.

Link: http://tracker.ceph.com/issues/19688
Reported-by: Jerry Lee <leisurelysw24@gmail.com>
Tested-by: Luis Henriques <lhenriques@suse.com>
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/inode.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index efee88c..976fd3a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2078,11 +2078,6 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (inode_dirty_flags)
 		__mark_inode_dirty(inode, inode_dirty_flags);
 
-	if (ia_valid & ATTR_MODE) {
-		err = posix_acl_chmod(inode, attr->ia_mode);
-		if (err)
-			goto out_put;
-	}
 
 	if (mask) {
 		req->r_inode = inode;
@@ -2096,13 +2091,13 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	     ceph_cap_string(dirtied), mask);
 
 	ceph_mdsc_put_request(req);
-	if (mask & CEPH_SETATTR_SIZE)
-		__ceph_do_pending_vmtruncate(inode);
-	ceph_free_cap_flush(prealloc_cf);
-	return err;
-out_put:
-	ceph_mdsc_put_request(req);
 	ceph_free_cap_flush(prealloc_cf);
+
+	if (err >= 0) {
+		if (mask & CEPH_SETATTR_SIZE) {
+			__ceph_do_pending_vmtruncate(inode);
+		}
+	}
 	return err;
 }
 
@@ -2121,7 +2116,12 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (err != 0)
 		return err;
 
-	return __ceph_setattr(inode, attr);
+	err = __ceph_setattr(inode, attr);
+
+	if (err >= 0 && (attr->ia_valid & ATTR_MODE)) {
+		err = posix_acl_chmod(inode, attr->ia_mode);
+	}
+	return err;
 }
 
 /*
-- 
2.9.3

