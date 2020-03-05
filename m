From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v5 7/7] ceph: calculate dir's wanted caps according to recent dirops
Date: Thu,  5 Mar 2020 20:21:05 +0800
Message-ID: <20200305122105.69184-8-zyan@redhat.com>
References: <20200305122105.69184-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21671 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbgCEMVg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2020 07:21:36 -0500
In-Reply-To: <20200305122105.69184-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

Call __ceph_touch_fmode() for dir operations. __ceph_caps_file_wanted()
calculate dir's wanted caps according to last dir read/modification. If
there is recent dir read, dir inode wants CEPH_CAP_ANY_SHARED caps, if
there is recent dir modification, also wants CEPH_CAP_FILE_EXCL.

Readdir is a special, dir inode wants CEPH_CAP_FILE_EXCL after readdir.
Because if dir indoe has CEPH_CAP_FILE_EXCL, later dir modifications do
not need to release CEPH_CAP_FILE_SHARED, invalidate all dentry leases
issued by readdir.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c       | 30 ++++++++++++++++++++++--------
 fs/ceph/dir.c        | 21 +++++++++++++++------
 fs/ceph/mds_client.c | 11 +++++++++--
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 622568cd6d8a..4ff832edd9dd 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -978,12 +978,29 @@ int __ceph_caps_file_wanted(struct ceph_inode_info =
*ci)
 		ceph_inode_to_client(&ci->vfs_inode)->mount_options;
 	unsigned long used_cutoff =3D jiffies - opt->caps_wanted_delay_max * HZ=
;
 	unsigned long idle_cutoff =3D jiffies - opt->caps_wanted_delay_min * HZ=
;
-	int bits =3D 0;
=20
 	if (S_ISDIR(ci->vfs_inode.i_mode)) {
-		if (ci->i_nr_by_mode[PIN_SHIFT] > 0)
-			bits |=3D 1 << PIN_SHIFT;
+		int want =3D 0;
+
+		/* use used_cutoff here, to keep dir's wanted caps longer */
+		if (ci->i_nr_by_mode[RD_SHIFT] > 0 ||
+		    time_after(ci->i_last_rd, used_cutoff))
+			want |=3D CEPH_CAP_ANY_SHARED;
+
+		if (ci->i_nr_by_mode[WR_SHIFT] > 0 ||
+		    time_after(ci->i_last_wr, used_cutoff)) {
+			want |=3D CEPH_CAP_ANY_SHARED | CEPH_CAP_FILE_EXCL;
+			if (opt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
+				want |=3D CEPH_CAP_ANY_DIR_OPS;
+		}
+
+		if (want || ci->i_nr_by_mode[PIN_SHIFT] > 0)
+			want |=3D CEPH_CAP_PIN;
+
+		return want;
 	} else {
+		int bits =3D 0;
+
 		if (ci->i_nr_by_mode[RD_SHIFT] > 0) {
 			if (ci->i_nr_by_mode[RD_SHIFT] >=3D FMODE_WAIT_BIAS ||
 			    time_after(ci->i_last_rd, used_cutoff))
@@ -1005,9 +1022,8 @@ int __ceph_caps_file_wanted(struct ceph_inode_info =
*ci)
 		    ci->i_nr_by_mode[LAZY_SHIFT] > 0)
 			bits |=3D 1 << LAZY_SHIFT;
 	=09
+		return bits ? ceph_caps_for_mode(bits >> 1) : 0;
 	}
-
-	return bits ? ceph_caps_for_mode(bits >> 1) : 0;
 }
=20
 /*
@@ -1888,9 +1904,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, in=
t flags,
 			if (IS_RDONLY(inode)) {
 				want =3D CEPH_CAP_ANY_SHARED;
 			} else {
-				want =3D CEPH_CAP_ANY_SHARED |
-				       CEPH_CAP_FILE_EXCL |
-				       CEPH_CAP_ANY_DIR_OPS;
+				want |=3D CEPH_CAP_ANY_SHARED | CEPH_CAP_FILE_EXCL;
 			}
 			retain |=3D want;
 		} else {
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ee6b319e5481..d594c2627430 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -335,8 +335,11 @@ static int ceph_readdir(struct file *file, struct di=
r_context *ctx)
 		ctx->pos =3D 2;
 	}
=20
-	/* can we use the dcache? */
 	spin_lock(&ci->i_ceph_lock);
+	/* request Fx cap. if have Fx, we don't need to release Fs cap
+	 * for later create/unlink. */
+	__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_WR);
+	/* can we use the dcache? */
 	if (ceph_test_mount_opt(fsc, DCACHE) &&
 	    !ceph_test_mount_opt(fsc, NOASYNCREADDIR) &&
 	    ceph_snap(inode) !=3D CEPH_SNAPDIR &&
@@ -760,6 +763,7 @@ static struct dentry *ceph_lookup(struct inode *dir, =
struct dentry *dentry,
 		    ceph_test_mount_opt(fsc, DCACHE) &&
 		    __ceph_dir_is_complete(ci) &&
 		    (__ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1))) {
+			__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
 			spin_unlock(&ci->i_ceph_lock);
 			dout(" dir %p complete, -ENOENT\n", dir);
 			d_add(dentry, NULL);
@@ -1621,7 +1625,8 @@ static int __dir_lease_try_check(const struct dentr=
y *dentry)
 /*
  * Check if directory-wide content lease/cap is valid.
  */
-static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry)
+static int dir_lease_is_valid(struct inode *dir, struct dentry *dentry,
+			      struct ceph_mds_client *mdsc)
 {
 	struct ceph_inode_info *ci =3D ceph_inode(dir);
 	int valid;
@@ -1629,7 +1634,10 @@ static int dir_lease_is_valid(struct inode *dir, s=
truct dentry *dentry)
=20
 	spin_lock(&ci->i_ceph_lock);
 	valid =3D __ceph_caps_issued_mask(ci, CEPH_CAP_FILE_SHARED, 1);
-	shared_gen =3D atomic_read(&ci->i_shared_gen);
+	if (valid) {
+		__ceph_touch_fmode(ci, mdsc, CEPH_FILE_MODE_RD);
+		shared_gen =3D atomic_read(&ci->i_shared_gen);
+	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (valid) {
 		struct ceph_dentry_info *di;
@@ -1655,6 +1663,7 @@ static int ceph_d_revalidate(struct dentry *dentry,=
 unsigned int flags)
 	int valid =3D 0;
 	struct dentry *parent;
 	struct inode *dir, *inode;
+	struct ceph_mds_client *mdsc;
=20
 	if (flags & LOOKUP_RCU) {
 		parent =3D READ_ONCE(dentry->d_parent);
@@ -1671,6 +1680,8 @@ static int ceph_d_revalidate(struct dentry *dentry,=
 unsigned int flags)
 	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
 	     dentry, inode, ceph_dentry(dentry)->offset);
=20
+	mdsc =3D ceph_sb_to_client(dir->i_sb)->mdsc;
+
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) !=3D CEPH_NOSNAP) {
 		dout("d_revalidate %p '%pd' inode %p is SNAPPED\n", dentry,
@@ -1682,7 +1693,7 @@ static int ceph_d_revalidate(struct dentry *dentry,=
 unsigned int flags)
 		valid =3D dentry_lease_is_valid(dentry, flags);
 		if (valid =3D=3D -ECHILD)
 			return valid;
-		if (valid || dir_lease_is_valid(dir, dentry)) {
+		if (valid || dir_lease_is_valid(dir, dentry, mdsc)) {
 			if (inode)
 				valid =3D ceph_is_any_caps(inode);
 			else
@@ -1691,8 +1702,6 @@ static int ceph_d_revalidate(struct dentry *dentry,=
 unsigned int flags)
 	}
=20
 	if (!valid) {
-		struct ceph_mds_client *mdsc =3D
-			ceph_sb_to_client(dir->i_sb)->mdsc;
 		struct ceph_mds_request *req;
 		int op, err;
 		u32 mask;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 68b8afded466..486f91f9685b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2486,7 +2486,8 @@ static struct ceph_msg *create_request_message(stru=
ct ceph_mds_client *mdsc,
 	if (req->r_inode_drop)
 		releases +=3D ceph_encode_inode_release(&p,
 		      req->r_inode ? req->r_inode : d_inode(req->r_dentry),
-		      mds, req->r_inode_drop, req->r_inode_unless, 0);
+		      mds, req->r_inode_drop, req->r_inode_unless,
+		      req->r_op =3D=3D CEPH_MDS_OP_READDIR);
 	if (req->r_dentry_drop)
 		releases +=3D ceph_encode_dentry_release(&p, req->r_dentry,
 				req->r_parent, mds, req->r_dentry_drop,
@@ -2833,7 +2834,13 @@ int ceph_mdsc_submit_request(struct ceph_mds_clien=
t *mdsc, struct inode *dir,
 	if (req->r_inode)
 		ceph_get_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
 	if (req->r_parent) {
-		ceph_get_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
+		struct ceph_inode_info *ci =3D ceph_inode(req->r_parent);
+		int fmode =3D (req->r_op & CEPH_MDS_OP_WRITE) ?
+			    CEPH_FILE_MODE_WR : CEPH_FILE_MODE_RD;
+		spin_lock(&ci->i_ceph_lock);
+		ceph_take_cap_refs(ci, CEPH_CAP_PIN, false);
+		__ceph_touch_fmode(ci, mdsc, fmode);
+		spin_unlock(&ci->i_ceph_lock);
 		ihold(req->r_parent);
 	}
 	if (req->r_old_dentry_dir)
--=20
2.21.1
