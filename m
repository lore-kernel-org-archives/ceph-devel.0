From: xiubli@redhat.com
Subject: [PATCH] ceph: fix posix acl couldn't be settable
Date: Mon, 10 Feb 2020 08:58:41 -0500
Message-ID: <20200210135841.21177-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28552 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726846AbgBJN67 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:58:59 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, dhowells@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

For the old mount API, the module parameters parseing function will
be called in ceph_mount() and also just after the default posix acl
flag set, so we can control to enable/disable it via the mount option.

But for the new mount API, it will call the module parameters
parseing function before ceph_get_tree(), so the posix acl will always
be enabled.

Fixes: 82995cc6c5ae ("libceph, rbd, ceph: convert to use the new mount AP=
I")
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 5fef4f59e13e..69fa498391dc 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -341,6 +341,10 @@ static int ceph_parse_mount_param(struct fs_context =
*fc,
 	unsigned int mode;
 	int token, ret;
=20
+#ifdef CONFIG_CEPH_FS_POSIX_ACL
+	fc->sb_flags |=3D SB_POSIXACL;
+#endif
+
 	ret =3D ceph_parse_param(param, pctx->copts, fc);
 	if (ret !=3D -ENOPARAM)
 		return ret;
@@ -1089,10 +1093,6 @@ static int ceph_get_tree(struct fs_context *fc)
 	if (!fc->source)
 		return invalf(fc, "ceph: No source");
=20
-#ifdef CONFIG_CEPH_FS_POSIX_ACL
-	fc->sb_flags |=3D SB_POSIXACL;
-#endif
-
 	/* create client (which we may/may not use) */
 	fsc =3D create_fs_client(pctx->opts, pctx->copts);
 	pctx->opts =3D NULL;
--=20
2.21.0
