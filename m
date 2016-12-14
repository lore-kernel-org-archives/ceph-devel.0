From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 2/5] ceph: clean up unsafe d_parent accesses in build_dentry_path
Date: Wed, 14 Dec 2016 09:54:27 -0500
Message-ID: <1481727270-12666-3-git-send-email-jlayton@redhat.com>
References: <1481727270-12666-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932609AbcLNOyf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Dec 2016 09:54:35 -0500
In-Reply-To: <1481727270-12666-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, linux-fsdevel@vger.kernel.org, dhowells@redhat.com, viro@ZenIV.linux.org.uk

While we hold a reference to the dentry when build_dentry_path is
called, we could end up racing with a rename that changes d_parent.
Handle that situation correctly, by using the rcu_read_lock to
ensure that the parent dentry and inode stick around long enough
to safely check ceph_snap and ceph_ino.

Link: http://tracker.ceph.com/issues/18148
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e62b566d3817..2cd9e6b04e29 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1802,13 +1802,18 @@ static int build_dentry_path(struct dentry *dentry,
 			     int *pfreepath)
 {
 	char *path;
+	struct inode *dir;
 
-	if (ceph_snap(d_inode(dentry->d_parent)) == CEPH_NOSNAP) {
-		*pino = ceph_ino(d_inode(dentry->d_parent));
+	rcu_read_lock();
+	dir = d_inode_rcu(dentry->d_parent);
+	if (dir && ceph_snap(dir) == CEPH_NOSNAP) {
+		*pino = ceph_ino(dir);
+		rcu_read_unlock();
 		*ppath = dentry->d_name.name;
 		*ppathlen = dentry->d_name.len;
 		return 0;
 	}
+	rcu_read_unlock();
 	path = ceph_mdsc_build_path(dentry, ppathlen, pino, 1);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
-- 
2.7.4

