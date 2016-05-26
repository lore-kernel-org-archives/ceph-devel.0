From: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/5] ceph: Propagate dentry down to inode_change_ok()
Date: Thu, 26 May 2016 18:19:57 +0200
Message-ID: <1464279600-13009-3-git-send-email-jack@suse.cz>
References: <1464279600-13009-1-git-send-email-jack@suse.cz>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54486 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754532AbcEZQUK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2016 12:20:10 -0400
In-Reply-To: <1464279600-13009-1-git-send-email-jack@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, xfs@oss.sgi.com, ceph-devel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>

To avoid clearing of capabilities or security related extended
attributes too early, inode_change_ok() will need to take dentry instead
of inode. ceph_setattr() has the dentry easily available but
__ceph_setattr() is also called from ceph_set_acl() where dentry is not
easily available. Luckily that call path does not need inode_change_ok()
to be called anyway. So reorganize functions a bit so that
inode_change_ok() is called only from paths where dentry is available.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ceph/acl.c   |  5 +++++
 fs/ceph/inode.c | 19 +++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 013151d50069..a2cedfde75eb 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -127,6 +127,11 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 			goto out_free;
 	}
 
+	if (ceph_snap(inode) != CEPH_NOSNAP) {
+		ret = -EROFS;
+		goto out_free;
+	}
+
 	if (new_mode != old_mode) {
 		newattrs.ia_mode = new_mode;
 		newattrs.ia_valid = ATTR_MODE;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e669cfa9d793..29873cbd6b2b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1791,13 +1791,6 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	int inode_dirty_flags = 0;
 	bool lock_snap_rwsem = false;
 
-	if (ceph_snap(inode) != CEPH_NOSNAP)
-		return -EROFS;
-
-	err = inode_change_ok(inode, attr);
-	if (err != 0)
-		return err;
-
 	prealloc_cf = ceph_alloc_cap_flush();
 	if (!prealloc_cf)
 		return -ENOMEM;
@@ -2011,7 +2004,17 @@ out_put:
  */
 int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 {
-	return __ceph_setattr(d_inode(dentry), attr);
+	struct inode *inode = d_inode(dentry);
+	int err;
+
+	if (ceph_snap(inode) != CEPH_NOSNAP)
+		return -EROFS;
+
+	err = inode_change_ok(inode, attr);
+	if (err != 0)
+		return err;
+
+	return __ceph_setattr(inode, attr);
 }
 
 /*
-- 
2.6.6

