From: xiubli@redhat.com
Subject: [PATCH v2] ceph: fix posix acl couldn't be settable
Date: Tue, 11 Feb 2020 01:53:16 -0500
Message-ID: <20200211065316.59091-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727805AbgBKGxu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:53:50 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, dhowells@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

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

Changed in V2:
- move default fc->sb_flags setting to ceph_init_fs_context().

 fs/ceph/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 5fef4f59e13e..c3d9ac768cec 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1089,10 +1089,6 @@ static int ceph_get_tree(struct fs_context *fc)
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
@@ -1215,6 +1211,10 @@ static int ceph_init_fs_context(struct fs_context =
*fc)
 	fsopt->max_readdir_bytes =3D CEPH_MAX_READDIR_BYTES_DEFAULT;
 	fsopt->congestion_kb =3D default_congestion_kb();
=20
+#ifdef CONFIG_CEPH_FS_POSIX_ACL
+	fc->sb_flags |=3D SB_POSIXACL;
+#endif
+
 	fc->fs_private =3D pctx;
 	fc->ops =3D &ceph_context_ops;
 	return 0;
--=20
2.21.0
