From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: check if file lock exists before sending unlock request
Date: Tue, 11 Feb 2020 16:59:01 +0800
Message-ID: <20200211085901.16256-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54080 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727608AbgBKI7K (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:59:10 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

When a process exits, kernel closes its files. locks_remove_file()
is called to remove file locks on these files. locks_remove_file()
tries unlocking files locks even there is no file locks.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/locks.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 544e9e85b120..78be861259eb 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -255,9 +255,21 @@ int ceph_lock(struct file *file, int cmd, struct fil=
e_lock *fl)
 	else
 		lock_cmd =3D CEPH_LOCK_UNLOCK;
=20
+	if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && F_UNLCK =3D=3D fl->fl_type) {
+		unsigned int orig_flags =3D fl->fl_flags;
+		fl->fl_flags |=3D FL_EXISTS;
+		err =3D posix_lock_file(file, fl, NULL);
+		fl->fl_flags =3D orig_flags;
+		if (err =3D=3D -ENOENT) {
+			if (!(orig_flags & FL_EXISTS))
+				err =3D 0;
+			return err;
+		}
+	}
+
 	err =3D ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, f=
l);
 	if (!err) {
-		if (op =3D=3D CEPH_MDS_OP_SETFILELOCK) {
+		if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && F_UNLCK !=3D fl->fl_type) {
 			dout("mds locked, locking locally\n");
 			err =3D posix_lock_file(file, fl, NULL);
 			if (err) {
@@ -311,9 +323,21 @@ int ceph_flock(struct file *file, int cmd, struct fi=
le_lock *fl)
 	else
 		lock_cmd =3D CEPH_LOCK_UNLOCK;
=20
+	if (F_UNLCK =3D=3D fl->fl_type) {
+		unsigned int orig_flags =3D fl->fl_flags;
+		fl->fl_flags |=3D FL_EXISTS;
+		err =3D locks_lock_file_wait(file, fl);
+		fl->fl_flags =3D orig_flags;
+		if (err =3D=3D -ENOENT) {
+			if (!(orig_flags & FL_EXISTS))
+				err =3D 0;
+			return err;
+		}
+	}
+
 	err =3D ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
 				inode, lock_cmd, wait, fl);
-	if (!err) {
+	if (!err && F_UNLCK !=3D fl->fl_type) {
 		err =3D locks_lock_file_wait(file, fl);
 		if (err) {
 			ceph_lock_message(CEPH_LOCK_FLOCK,
--=20
2.21.1
