From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v4 5/5] ceph: pass parent inode info to ceph_encode_dentry_release if we have it
Date: Thu, 15 Dec 2016 06:34:29 -0500
Message-ID: <1481801669-4916-6-git-send-email-jlayton@redhat.com>
References: <1481801669-4916-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1481801669-4916-1-git-send-email-jlayton@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, linux-fsdevel@vger.kernel.org, dhowells@redhat.com, viro@ZenIV.linux.org.uk
List-Id: ceph-devel.vger.kernel.org

If we have a parent inode reference already, then we don't need to
go back up the directory tree to find one.

Link: http://tracker.ceph.com/issues/18148
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c       | 11 +++++++----
 fs/ceph/mds_client.c |  7 +++++--
 fs/ceph/super.h      |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6bc5c1efbb26..e960b51dcae1 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3832,9 +3832,10 @@ int ceph_encode_inode_release(void **p, struct inode *inode,
 }
 
 int ceph_encode_dentry_release(void **p, struct dentry *dentry,
+			       struct inode *dir,
 			       int mds, int drop, int unless)
 {
-	struct dentry *parent;
+	struct dentry *parent = NULL;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int force = 0;
@@ -3849,11 +3850,13 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (di->lease_session && di->lease_session->s_mds == mds)
 		force = 1;
-	parent = dget(dentry->d_parent);
+	if (!dir) {
+		parent = dget(dentry->d_parent);
+		dir = d_inode(parent);
+	}
 	spin_unlock(&dentry->d_lock);
 
-	ret = ceph_encode_inode_release(p, d_inode(parent), mds, drop,
-					unless, force);
+	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
 	dput(parent);
 
 	spin_lock(&dentry->d_lock);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 9fe5a56122f0..a29997ce982b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1953,10 +1953,13 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
 		      mds, req->r_inode_drop, req->r_inode_unless, 0);
 	if (req->r_dentry_drop)
 		releases += ceph_encode_dentry_release(&p, req->r_dentry,
-		       mds, req->r_dentry_drop, req->r_dentry_unless);
+				req->r_locked_dir, mds, req->r_dentry_drop,
+				req->r_dentry_unless);
 	if (req->r_old_dentry_drop)
 		releases += ceph_encode_dentry_release(&p, req->r_old_dentry,
-		       mds, req->r_old_dentry_drop, req->r_old_dentry_unless);
+				req->r_old_dentry_dir, mds,
+				req->r_old_dentry_drop,
+				req->r_old_dentry_unless);
 	if (req->r_old_inode_drop)
 		releases += ceph_encode_inode_release(&p,
 		      d_inode(req->r_old_dentry),
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 3e3fa9163059..e4ca0b718b6f 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -901,6 +901,7 @@ extern void ceph_flush_dirty_caps(struct ceph_mds_client *mdsc);
 extern int ceph_encode_inode_release(void **p, struct inode *inode,
 				     int mds, int drop, int unless, int force);
 extern int ceph_encode_dentry_release(void **p, struct dentry *dn,
+				      struct inode *dir,
 				      int mds, int drop, int unless);
 
 extern int ceph_get_caps(struct ceph_inode_info *ci, int need, int want,
-- 
2.7.4

