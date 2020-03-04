From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v4 5/6] ceph: update i_requested_max_size only when sending cap msg to auth mds
Date: Thu,  5 Mar 2020 01:32:57 +0800
Message-ID: <20200304173258.48377-6-zyan@redhat.com>
References: <20200304173258.48377-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729892AbgCDRdS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2020 12:33:18 -0500
In-Reply-To: <20200304173258.48377-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

Non-auth mds can't do anything to 'update max' cap message.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 1b6e6fd98169..0408749ced2d 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1359,7 +1359,8 @@ static int __send_cap(struct ceph_mds_client *mdsc,=
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
