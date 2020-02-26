From: xiubli@redhat.com
Subject: [PATCH v3] ceph: show more detail logs during mount
Date: Tue, 25 Feb 2020 21:51:12 -0500
Message-ID: <20200226025112.3839-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36043 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730170AbgBZCvd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2020 21:51:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Print the logs in error level to give a helpful hint to make it
more user-friendly to do debug.

URL: https://tracker.ceph.com/issues/44215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c7f150686a53..0768e1bbd22e 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -905,8 +905,11 @@ static struct dentry *ceph_real_mount(struct ceph_fs=
_client *fsc,
 				     fsc->mount_options->server_path + 1 : "";
=20
 		err =3D __ceph_open_session(fsc->client, started);
-		if (err < 0)
+		if (err < 0) {
+			errorfc(fc, "mount joining the ceph cluster fail %d",
+				err);
 			goto out;
+		}
=20
 		/* setup fscache */
 		if (fsc->mount_options->flags & CEPH_MOUNT_OPT_FSCACHE) {
@@ -922,6 +925,8 @@ static struct dentry *ceph_real_mount(struct ceph_fs_=
client *fsc,
 		root =3D open_root_dentry(fsc, path, started);
 		if (IS_ERR(root)) {
 			err =3D PTR_ERR(root);
+			errorfc(fc, "mount opening the root directory fail %d",
+				err);
 			goto out;
 		}
 		fsc->sb->s_root =3D dget(root);
@@ -1079,7 +1084,7 @@ static int ceph_get_tree(struct fs_context *fc)
=20
 out_splat:
 	if (!ceph_mdsmap_is_cluster_available(fsc->mdsc->mdsmap)) {
-		pr_info("No mds server is up or the cluster is laggy\n");
+		errorfc(fc, "No mds server is up or the cluster is laggy");
 		err =3D -EHOSTUNREACH;
 	}
=20
--=20
2.21.0
