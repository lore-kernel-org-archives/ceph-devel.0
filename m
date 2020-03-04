From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v4 1/6] ceph: always renew caps if mds_wanted is insufficient
Date: Thu,  5 Mar 2020 01:32:53 +0800
Message-ID: <20200304173258.48377-2-zyan@redhat.com>
References: <20200304173258.48377-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727084AbgCDRdJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2020 12:33:09 -0500
In-Reply-To: <20200304173258.48377-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

Original code only renews caps for inodes with CEPH_I_CAP_DROPPED flag,
which indicates that mds has closed the session and caps were dropped.
Remove this flag in preparation for not requesting caps for idle open
files.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c       | 36 +++++++++++++++---------------------
 fs/ceph/mds_client.c |  5 -----
 fs/ceph/super.h      | 13 ++++++-------
 3 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index be85225b962c..a75e5eb3740e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2686,6 +2686,7 @@ static int try_get_cap_refs(struct inode *inode, in=
t need, int want,
 		}
 	} else {
 		int session_readonly =3D false;
+		int mds_wanted;
 		if (ci->i_auth_cap &&
 		    (need & (CEPH_CAP_FILE_WR | CEPH_CAP_FILE_EXCL))) {
 			struct ceph_mds_session *s =3D ci->i_auth_cap->session;
@@ -2694,32 +2695,27 @@ static int try_get_cap_refs(struct inode *inode, =
int need, int want,
 			spin_unlock(&s->s_cap_lock);
 		}
 		if (session_readonly) {
-			dout("get_cap_refs %p needed %s but mds%d readonly\n",
+			dout("get_cap_refs %p need %s but mds%d readonly\n",
 			     inode, ceph_cap_string(need), ci->i_auth_cap->mds);
 			ret =3D -EROFS;
 			goto out_unlock;
 		}
=20
-		if (ci->i_ceph_flags & CEPH_I_CAP_DROPPED) {
-			int mds_wanted;
-			if (READ_ONCE(mdsc->fsc->mount_state) =3D=3D
-			    CEPH_MOUNT_SHUTDOWN) {
-				dout("get_cap_refs %p forced umount\n", inode);
-				ret =3D -EIO;
-				goto out_unlock;
-			}
-			mds_wanted =3D __ceph_caps_mds_wanted(ci, false);
-			if (need & ~(mds_wanted & need)) {
-				dout("get_cap_refs %p caps were dropped"
-				     " (session killed?)\n", inode);
-				ret =3D -ESTALE;
-				goto out_unlock;
-			}
-			if (!(file_wanted & ~mds_wanted))
-				ci->i_ceph_flags &=3D ~CEPH_I_CAP_DROPPED;
+		if (READ_ONCE(mdsc->fsc->mount_state) =3D=3D CEPH_MOUNT_SHUTDOWN) {
+			dout("get_cap_refs %p forced umount\n", inode);
+			ret =3D -EIO;
+			goto out_unlock;
+		}
+		mds_wanted =3D __ceph_caps_mds_wanted(ci, false);
+		if (need & ~mds_wanted) {
+			dout("get_cap_refs %p need %s > mds_wanted %s\n",
+			     inode, ceph_cap_string(need),
+			     ceph_cap_string(mds_wanted));
+			ret =3D -ESTALE;
+			goto out_unlock;
 		}
=20
-		dout("get_cap_refs %p have %s needed %s\n", inode,
+		dout("get_cap_refs %p have %s need %s\n", inode,
 		     ceph_cap_string(have), ceph_cap_string(need));
 	}
 out_unlock:
@@ -3678,8 +3674,6 @@ static void handle_cap_export(struct inode *inode, =
struct ceph_mds_caps *ex,
 		goto out_unlock;
=20
 	if (target < 0) {
-		if (cap->mds_wanted | cap->issued)
-			ci->i_ceph_flags |=3D CEPH_I_CAP_DROPPED;
 		__ceph_remove_cap(cap, false);
 		goto out_unlock;
 	}
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 177acb9f456b..68b8afded466 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1514,8 +1514,6 @@ static int remove_session_caps_cb(struct inode *ino=
de, struct ceph_cap *cap,
 	dout("removing cap %p, ci is %p, inode is %p\n",
 	     cap, ci, &ci->vfs_inode);
 	spin_lock(&ci->i_ceph_lock);
-	if (cap->mds_wanted | cap->issued)
-		ci->i_ceph_flags |=3D CEPH_I_CAP_DROPPED;
 	__ceph_remove_cap(cap, false);
 	if (!ci->i_auth_cap) {
 		struct ceph_cap_flush *cf;
@@ -1681,9 +1679,6 @@ static int wake_up_session_cb(struct inode *inode, =
struct ceph_cap *cap,
 			/* mds did not re-issue stale cap */
 			spin_lock(&ci->i_ceph_lock);
 			cap->issued =3D cap->implemented =3D CEPH_CAP_PIN;
-			/* make sure mds knows what we want */
-			if (__ceph_caps_file_wanted(ci) & ~cap->mds_wanted)
-				ci->i_ceph_flags |=3D CEPH_I_CAP_DROPPED;
 			spin_unlock(&ci->i_ceph_lock);
 		}
 	} else if (ev =3D=3D FORCE_RO) {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 22b89eaeaad4..356ad7b46b85 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -522,13 +522,12 @@ static inline struct inode *ceph_find_inode(struct =
super_block *sb,
 #define CEPH_I_POOL_RD		(1 << 4)  /* can read from pool */
 #define CEPH_I_POOL_WR		(1 << 5)  /* can write to pool */
 #define CEPH_I_SEC_INITED	(1 << 6)  /* security initialized */
-#define CEPH_I_CAP_DROPPED	(1 << 7)  /* caps were forcibly dropped */
-#define CEPH_I_KICK_FLUSH	(1 << 8)  /* kick flushing caps */
-#define CEPH_I_FLUSH_SNAPS	(1 << 9)  /* need flush snapss */
-#define CEPH_I_ERROR_WRITE	(1 << 10) /* have seen write errors */
-#define CEPH_I_ERROR_FILELOCK	(1 << 11) /* have seen file lock errors */
-#define CEPH_I_ODIRECT		(1 << 12) /* inode in direct I/O mode */
-#define CEPH_ASYNC_CREATE_BIT	(13)	  /* async create in flight for this =
*/
+#define CEPH_I_KICK_FLUSH	(1 << 7)  /* kick flushing caps */
+#define CEPH_I_FLUSH_SNAPS	(1 << 8)  /* need flush snapss */
+#define CEPH_I_ERROR_WRITE	(1 << 9) /* have seen write errors */
+#define CEPH_I_ERROR_FILELOCK	(1 << 10) /* have seen file lock errors */
+#define CEPH_I_ODIRECT		(1 << 11) /* inode in direct I/O mode */
+#define CEPH_ASYNC_CREATE_BIT	(12)	  /* async create in flight for this =
*/
 #define CEPH_I_ASYNC_CREATE	(1 << CEPH_ASYNC_CREATE_BIT)
=20
 /*
--=20
2.21.1
