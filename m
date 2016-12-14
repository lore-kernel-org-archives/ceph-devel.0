From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 3/5] ceph: pass parent dir ino info to build_dentry_path
Date: Wed, 14 Dec 2016 09:54:28 -0500
Message-ID: <1481727270-12666-4-git-send-email-jlayton@redhat.com>
References: <1481727270-12666-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932299AbcLNOyf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 14 Dec 2016 09:54:35 -0500
In-Reply-To: <1481727270-12666-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, linux-fsdevel@vger.kernel.org, dhowells@redhat.com, viro@ZenIV.linux.org.uk

In the event that we have a parent inode reference in the request, we
can use that instead of mucking about in the dcache. Pass any parent
inode info we have down to build_dentry_path so it can make use of it.

Link: http://tracker.ceph.com/issues/18148
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 2cd9e6b04e29..26cc17ee6d65 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1797,15 +1797,15 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *base,
 	return path;
 }
 
-static int build_dentry_path(struct dentry *dentry,
+static int build_dentry_path(struct dentry *dentry, struct inode *dir,
 			     const char **ppath, int *ppathlen, u64 *pino,
 			     int *pfreepath)
 {
 	char *path;
-	struct inode *dir;
 
 	rcu_read_lock();
-	dir = d_inode_rcu(dentry->d_parent);
+	if (!dir)
+		dir = d_inode_rcu(dentry->d_parent);
 	if (dir && ceph_snap(dir) == CEPH_NOSNAP) {
 		*pino = ceph_ino(dir);
 		rcu_read_unlock();
@@ -1849,8 +1849,8 @@ static int build_inode_path(struct inode *inode,
  * an explicit ino+path.
  */
 static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
-				  const char *rpath, u64 rino,
-				  const char **ppath, int *pathlen,
+				  struct inode *rdirino, const char *rpath,
+				  u64 rino, const char **ppath, int *pathlen,
 				  u64 *ino, int *freepath)
 {
 	int r = 0;
@@ -1860,7 +1860,7 @@ static int set_request_path_attr(struct inode *rinode, struct dentry *rdentry,
 		dout(" inode %p %llx.%llx\n", rinode, ceph_ino(rinode),
 		     ceph_snap(rinode));
 	} else if (rdentry) {
-		r = build_dentry_path(rdentry, ppath, pathlen, ino, freepath);
+		r = build_dentry_path(rdentry, rdirino, ppath, pathlen, ino, freepath);
 		dout(" dentry %p %llx/%.*s\n", rdentry, *ino, *pathlen,
 		     *ppath);
 	} else if (rpath || rino) {
@@ -1893,7 +1893,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 	int ret;
 
 	ret = set_request_path_attr(req->r_inode, req->r_dentry,
-			      req->r_path1, req->r_ino1.ino,
+			      req->r_locked_dir, req->r_path1, req->r_ino1.ino,
 			      &path1, &pathlen1, &ino1, &freepath1);
 	if (ret < 0) {
 		msg = ERR_PTR(ret);
@@ -1901,6 +1901,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 	}
 
 	ret = set_request_path_attr(NULL, req->r_old_dentry,
+			      req->r_old_dentry_dir,
 			      req->r_path2, req->r_ino2.ino,
 			      &path2, &pathlen2, &ino2, &freepath2);
 	if (ret < 0) {
-- 
2.7.4

