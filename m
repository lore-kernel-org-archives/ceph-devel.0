From: xiubli@redhat.com
Subject: [RFC PATCH v2] ceph: do not execute direct write in parallel if O_APPEND is specified
Date: Mon,  3 Feb 2020 21:28:25 -0500
Message-ID: <20200204022825.26538-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37089 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726561AbgBDC2q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2020 21:28:46 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, hch@infradead.org, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

In O_APPEND & O_DIRECT mode, the data from different writers will
be possiblly overlapping each other with shared lock.

For example, both Writer1 and Writer2 are in O_APPEND and O_DIRECT
mode:

          Writer1                         Writer2

     shared_lock()                   shared_lock()
     getattr(CAP_SIZE)               getattr(CAP_SIZE)
     iocb->ki_pos =3D EOF              iocb->ki_pos =3D EOF
     write(data1)
                                     write(data2)
     shared_unlock()                 shared_unlock()

The data2 will overlap the data1 from the same file offset, the
old EOF.

Switch to exclusive lock instead when O_APPEND is specified.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---

Changed in V2:
- fix the commit comment
- add more detail in the commit comment
- s/direct_lock/shared_lock/g

 fs/ceph/file.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ac7fe8b8081c..e3e67ef215dd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1475,6 +1475,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written =3D 0;
 	int err, want, got;
+	bool shared_lock =3D false;
 	loff_t pos;
 	loff_t limit =3D max(i_size_read(inode), fsc->max_file_size);
=20
@@ -1485,8 +1486,11 @@ static ssize_t ceph_write_iter(struct kiocb *iocb,=
 struct iov_iter *from)
 	if (!prealloc_cf)
 		return -ENOMEM;
=20
+	if ((iocb->ki_flags & (IOCB_DIRECT | IOCB_APPEND)) =3D=3D IOCB_DIRECT)
+		shared_lock =3D true;
+
 retry_snap:
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (shared_lock)
 		ceph_start_io_direct(inode);
 	else
 		ceph_start_io_write(inode);
@@ -1576,14 +1580,15 @@ static ssize_t ceph_write_iter(struct kiocb *iocb=
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
+		if (shared_lock)
+			ceph_end_io_direct(inode);
+		else
 			ceph_end_io_write(inode);
-		}
 		if (written > 0)
 			iov_iter_advance(from, written);
 		ceph_put_snap_context(snapc);
@@ -1634,7 +1639,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
=20
 	goto out_unlocked;
 out:
-	if (iocb->ki_flags & IOCB_DIRECT)
+	if (shared_lock)
 		ceph_end_io_direct(inode);
 	else
 		ceph_end_io_write(inode);
--=20
2.21.0
