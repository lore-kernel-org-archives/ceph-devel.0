From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 4/4] ceph: handle LOOKUP_RCU in ceph_d_revalidate
Date: Tue,  5 Jul 2016 12:27:49 -0400
Message-ID: <1467736069-27140-5-git-send-email-jlayton@redhat.com>
References: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46303 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbcGEQ1z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jul 2016 12:27:55 -0400
In-Reply-To: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, zyan@redhat.com
Cc: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>

We can now handle the snapshot cases under RCU, as well as the
non-snapshot case when we don't need to queue up a lease renewal.
Allow LOOKUP_RCU walks to proceed under those conditions.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 60dcca163ba0..c64a0b794d49 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1214,15 +1214,19 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct dentry *parent;
 	struct inode *dir;
 
-	if (flags & LOOKUP_RCU)
-		return -ECHILD;
+	if (flags & LOOKUP_RCU) {
+		parent = ACCESS_ONCE(dentry->d_parent);
+		dir = d_inode_rcu(parent);
+		if (!dir)
+			return -ECHILD;
+	} else {
+		parent = dget_parent(dentry);
+		dir = d_inode(parent);
+	}
 
 	dout("d_revalidate %p '%pd' inode %p offset %lld\n", dentry,
 	     dentry, d_inode(dentry), ceph_dentry(dentry)->offset);
 
-	parent = dget_parent(dentry);
-	dir = d_inode(parent);
-
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
 		dout("d_revalidate %p '%pd' inode %p is SNAPPED\n", dentry,
@@ -1249,6 +1253,9 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		struct ceph_mds_request *req;
 		int op, mask, err;
 
+		if (flags & LOOKUP_RCU)
+			return -ECHILD;
+
 		op = ceph_snap(dir) == CEPH_SNAPDIR ?
 			CEPH_MDS_OP_LOOKUPSNAP : CEPH_MDS_OP_LOOKUP;
 		req = ceph_mdsc_create_request(mdsc, op, USE_ANY_MDS);
@@ -1284,7 +1291,8 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		ceph_dir_clear_complete(dir);
 	}
 
-	dput(parent);
+	if (!(flags & LOOKUP_RCU))
+		dput(parent);
 	return valid;
 }
 
-- 
2.5.5

