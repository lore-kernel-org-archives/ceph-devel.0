From: xiubli@redhat.com
Subject: [PATCH] ceph: show more detail logs during mount
Date: Mon, 24 Feb 2020 22:30:13 -0500
Message-ID: <20200225033013.4832-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726962AbgBYDac (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2020 22:30:32 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Print the logs in error level to give a helpful hint to make it
more user-friendly to debug.

URL: https://tracker.ceph.com/issues/44215
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/super.c       | 8 ++++++--
 net/ceph/mon_client.c | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c7f150686a53..e33c2f86647b 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -905,8 +905,10 @@ static struct dentry *ceph_real_mount(struct ceph_fs=
_client *fsc,
 				     fsc->mount_options->server_path + 1 : "";
=20
 		err =3D __ceph_open_session(fsc->client, started);
-		if (err < 0)
+		if (err < 0) {
+			pr_err("mount joining the ceph cluster fail %d\n", err);
 			goto out;
+		}
=20
 		/* setup fscache */
 		if (fsc->mount_options->flags & CEPH_MOUNT_OPT_FSCACHE) {
@@ -922,6 +924,8 @@ static struct dentry *ceph_real_mount(struct ceph_fs_=
client *fsc,
 		root =3D open_root_dentry(fsc, path, started);
 		if (IS_ERR(root)) {
 			err =3D PTR_ERR(root);
+			pr_err("mount opening the root directory fail %d\n",
+			       err);
 			goto out;
 		}
 		fsc->sb->s_root =3D dget(root);
@@ -1079,7 +1083,7 @@ static int ceph_get_tree(struct fs_context *fc)
=20
 out_splat:
 	if (!ceph_mdsmap_is_cluster_available(fsc->mdsc->mdsmap)) {
-		pr_info("No mds server is up or the cluster is laggy\n");
+		pr_err("No mds server is up or the cluster is laggy\n");
 		err =3D -EHOSTUNREACH;
 	}
=20
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 9d9e4e4ea600..6f1372f5f2a7 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1179,6 +1179,8 @@ static void handle_auth_reply(struct ceph_mon_clien=
t *monc,
=20
 	if (ret < 0) {
 		monc->client->auth_err =3D ret;
+		pr_err("authenticate fail on mon%d %s\n", monc->cur_mon,
+			ceph_pr_addr(&monc->con.peer_addr));
 	} else if (!was_auth && ceph_auth_is_authenticated(monc->auth)) {
 		dout("authenticated, starting session\n");
=20
--=20
2.21.0
