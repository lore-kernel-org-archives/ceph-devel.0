From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v3 5/6] ceph: update i_requested_max_size only when sending cap msg to auth mds
Date: Fri, 28 Feb 2020 19:55:49 +0800
Message-ID: <20200228115550.6904-6-zyan@redhat.com>
References: <20200228115550.6904-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60336 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726809AbgB1L4L (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2020 06:56:11 -0500
In-Reply-To: <20200228115550.6904-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

because non-auth mds can't do anything to 'update max' cap message.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 29f39058aca7..49f773247044 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1339,7 +1339,8 @@ static int __send_cap(struct ceph_mds_client *mdsc,=
 struct ceph_cap *cap,
 	arg.size =3D inode->i_size;
 	ci->i_reported_size =3D arg.size;
 	arg.max_size =3D ci->i_wanted_max_size;
-	ci->i_requested_max_size =3D arg.max_size;
+	if (cap =3D=3D ci->i_auth_cap)
+		ci->i_requested_max_size =3D arg.max_size;
=20
 	if (flushing & CEPH_CAP_XATTR_EXCL) {
 		old_blob =3D __ceph_build_xattrs_blob(ci);
--=20
2.21.1
