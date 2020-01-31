From: xiubli@redhat.com
Subject: [RFC PATCH] ceph: do not direct write executes in parallel if O_APPEND is set
Date: Fri, 31 Jan 2020 08:36:19 -0500
Message-ID: <20200131133619.14209-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36977 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728614AbgAaNgg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jan 2020 08:36:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

In O_APPEND & O_DIRECT mode, the data from different writers will
be possiblly overlapping each other. Just use the exclusive clock
instead in O_APPEND & O_DIRECT mode.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/file.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 77f8e58cbb99..1cedba452a66 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1443,6 +1443,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written =3D 0;
 	int err, want, got;
+	bool direct_lock =3D false;
 	loff_t pos;
 	loff_t limit =3D max(i_size_read(inode), fsc->max_file_size);
=20
@@ -1453,8 +1454,11 @@ static ssize_t ceph_write_iter(struct kiocb *iocb,=
 struct iov_iter *from)
 	if (!prealloc_cf)
 		return -ENOMEM;
=20
+	if ((iocb->ki_flags & (IOCB_DIRECT | IOCB_APPEND)) =3D=3D IOCB_DIRECT)
+		direct_lock =3D true;
+
 retry_snap:
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (direct_lock)
 		ceph_start_io_direct(inode);
 	else
 		ceph_start_io_write(inode);
@@ -1544,14 +1548,15 @@ static ssize_t ceph_write_iter(struct kiocb *iocb=
, struct iov_iter *from)
=20
 		/* we might need to revert back to that point */
 		data =3D *from;
-		if (iocb->ki_flags & IOCB_DIRECT) {
+		if (iocb->ki_flags & IOCB_DIRECT)
 			written =3D ceph_direct_read_write(iocb, &data, snapc,
 							 &prealloc_cf);
-			ceph_end_io_direct(inode);
-		} else {
+		else
 			written =3D ceph_sync_write(iocb, &data, pos, snapc);
+		if (direct_lock)
+			ceph_end_io_direct(inode);
+		else
 			ceph_end_io_write(inode);
-		}
 		if (written > 0)
 			iov_iter_advance(from, written);
 		ceph_put_snap_context(snapc);
@@ -1602,7 +1607,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
=20
 	goto out_unlocked;
 out:
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (direct_lock)
 		ceph_end_io_direct(inode);
 	else
 		ceph_end_io_write(inode);
--=20
2.21.0
