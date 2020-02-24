From: xiubli@redhat.com
Subject: [PATCH] ceph: return ETIMEDOUT errno to userland when request timed out
Date: Sun, 23 Feb 2020 22:23:11 -0500
Message-ID: <20200224032311.26107-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727156AbgBXDXb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Feb 2020 22:23:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

The ETIMEOUT errno will be cleaner and be more user-friendly.

URL: https://tracker.ceph.com/issues/44215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3e792eca6af7..a1649eb3a3fd 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2578,7 +2578,7 @@ static void __do_request(struct ceph_mds_client *md=
sc,
 	if (req->r_timeout &&
 	    time_after_eq(jiffies, req->r_started + req->r_timeout)) {
 		dout("do_request timed out\n");
-		err =3D -EIO;
+		err =3D -ETIMEDOUT;
 		goto finish;
 	}
 	if (READ_ONCE(mdsc->fsc->mount_state) =3D=3D CEPH_MOUNT_SHUTDOWN) {
@@ -2752,7 +2752,7 @@ static int ceph_mdsc_wait_request(struct ceph_mds_c=
lient *mdsc,
 		if (timeleft > 0)
 			err =3D 0;
 		else if (!timeleft)
-			err =3D -EIO;  /* timed out */
+			err =3D -ETIMEDOUT;  /* timed out */
 		else
 			err =3D timeleft;  /* killed */
 	}
--=20
2.21.0
