From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 1/4] ceph: remove ceph_mdsc_lease_release
Date: Tue,  5 Jul 2016 12:27:46 -0400
Message-ID: <1467736069-27140-2-git-send-email-jlayton@redhat.com>
References: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, zyan@redhat.com
Cc: Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: ceph-devel.vger.kernel.org

Nothing calls it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/mds_client.c | 41 -----------------------------------------
 fs/ceph/mds_client.h |  4 ----
 2 files changed, 45 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 0d4bb24c670a..78a3495a11be 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3292,47 +3292,6 @@ void ceph_mdsc_lease_send_msg(struct ceph_mds_session *session,
 }
 
 /*
- * Preemptively release a lease we expect to invalidate anyway.
- * Pass @inode always, @dentry is optional.
- */
-void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc, struct inode *inode,
-			     struct dentry *dentry)
-{
-	struct ceph_dentry_info *di;
-	struct ceph_mds_session *session;
-	u32 seq;
-
-	BUG_ON(inode == NULL);
-	BUG_ON(dentry == NULL);
-
-	/* is dentry lease valid? */
-	spin_lock(&dentry->d_lock);
-	di = ceph_dentry(dentry);
-	if (!di || !di->lease_session ||
-	    di->lease_session->s_mds < 0 ||
-	    di->lease_gen != di->lease_session->s_cap_gen ||
-	    !time_before(jiffies, di->time)) {
-		dout("lease_release inode %p dentry %p -- "
-		     "no lease\n",
-		     inode, dentry);
-		spin_unlock(&dentry->d_lock);
-		return;
-	}
-
-	/* we do have a lease on this dentry; note mds and seq */
-	session = ceph_get_mds_session(di->lease_session);
-	seq = di->lease_seq;
-	__ceph_mdsc_drop_dentry_lease(dentry);
-	spin_unlock(&dentry->d_lock);
-
-	dout("lease_release inode %p dentry %p to mds%d\n",
-	     inode, dentry, session->s_mds);
-	ceph_mdsc_lease_send_msg(session, inode, dentry,
-				 CEPH_MDS_LEASE_RELEASE, seq);
-	ceph_put_mds_session(session);
-}
-
-/*
  * drop all leases (and dentry refs) in preparation for umount
  */
 static void drop_leases(struct ceph_mds_client *mdsc)
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 2ce8e9f9bfc9..9dd2c82379f8 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -385,10 +385,6 @@ extern void ceph_mdsc_destroy(struct ceph_fs_client *fsc);
 
 extern void ceph_mdsc_sync(struct ceph_mds_client *mdsc);
 
-extern void ceph_mdsc_lease_release(struct ceph_mds_client *mdsc,
-				    struct inode *inode,
-				    struct dentry *dn);
-
 extern void ceph_invalidate_dir_request(struct ceph_mds_request *req);
 extern int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
 					   struct inode *dir);
-- 
2.5.5

