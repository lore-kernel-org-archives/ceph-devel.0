From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 08/13] ceph: don't need session pointer to ceph_fill_trace
Date: Wed,  1 Feb 2017 06:49:09 -0500
Message-ID: <20170201114914.20808-9-jlayton@redhat.com>
References: <20170130161942.16537-1-jlayton@redhat.com>
 <20170201114914.20808-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdBALtW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Feb 2017 06:49:22 -0500
In-Reply-To: <20170201114914.20808-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

Just get it from r_session since that's what's always passed in.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c      | 4 ++--
 fs/ceph/mds_client.c | 2 +-
 fs/ceph/super.h      | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index b93e8eb3c2ee..e54ba03d3df7 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1108,9 +1108,9 @@ static struct dentry *splice_dentry(struct dentry *dn, struct inode *in)
  *
  * Called with snap_rwsem (read).
  */
-int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req,
-		    struct ceph_mds_session *session)
+int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 {
+	struct ceph_mds_session *session = req->r_session;
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct inode *in = NULL;
 	struct ceph_vino vino;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index fc7ae1e0f691..ccf75a3260e8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2518,7 +2518,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	/* insert trace into our cache */
 	mutex_lock(&req->r_fill_mutex);
 	current->journal_info = req;
-	err = ceph_fill_trace(mdsc->fsc->sb, req, req->r_session);
+	err = ceph_fill_trace(mdsc->fsc->sb, req);
 	if (err == 0) {
 		if (result == 0 && (req->r_op == CEPH_MDS_OP_READDIR ||
 				    req->r_op == CEPH_MDS_OP_LSSNAP))
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 6477264bfc7e..950170136be9 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -764,8 +764,7 @@ extern void ceph_fill_file_time(struct inode *inode, int issued,
 				u64 time_warp_seq, struct timespec *ctime,
 				struct timespec *mtime, struct timespec *atime);
 extern int ceph_fill_trace(struct super_block *sb,
-			   struct ceph_mds_request *req,
-			   struct ceph_mds_session *session);
+			   struct ceph_mds_request *req);
 extern int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 				    struct ceph_mds_session *session);
 
-- 
2.9.3

