From: xiubli@redhat.com
Subject: [PATCH] ceph: add 'fs' mount option support
Date: Sat, 22 Feb 2020 21:14:40 -0500
Message-ID: <20200223021440.40257-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60787 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgBWCPF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:15:05 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

The 'fs' here will be cleaner when specifying the ceph fs name,
and we can easily get the corresponding name from the `ceph fs
dump`:

[...]
Filesystem 'a' (1)
fs_name	a
epoch	12
flags	12
[...]

The 'fs' here just an alias name for 'mds_namespace' mount options,
and we will keep 'mds_namespace' for backwards compatibility.

URL: https://tracker.ceph.com/issues/44214
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c |  8 ++++----
 fs/ceph/super.c      | 21 +++++++++++----------
 fs/ceph/super.h      |  2 +-
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3e792eca6af7..82f63ef2694c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4590,7 +4590,7 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 void ceph_mdsc_handle_fsmap(struct ceph_mds_client *mdsc, struct ceph_ms=
g *msg)
 {
 	struct ceph_fs_client *fsc =3D mdsc->fsc;
-	const char *mds_namespace =3D fsc->mount_options->mds_namespace;
+	const char *fs_name =3D fsc->mount_options->fs_name;
 	void *p =3D msg->front.iov_base;
 	void *end =3D p + msg->front.iov_len;
 	u32 epoch;
@@ -4634,9 +4634,9 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client =
*mdsc, struct ceph_msg *msg)
 		namelen =3D ceph_decode_32(&info_p);
 		ceph_decode_need(&info_p, info_end, namelen, bad);
=20
-		if (mds_namespace &&
-		    strlen(mds_namespace) =3D=3D namelen &&
-		    !strncmp(mds_namespace, (char *)info_p, namelen)) {
+		if (fs_name &&
+		    strlen(fs_name) =3D=3D namelen &&
+		    !strncmp(fs_name, (char *)info_p, namelen)) {
 			mount_fscid =3D fscid;
 			break;
 		}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c7f150686a53..31acb4fe1f2c 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -140,7 +140,7 @@ enum {
 	Opt_congestion_kb,
 	/* int args above */
 	Opt_snapdirname,
-	Opt_mds_namespace,
+	Opt_fs,
 	Opt_recover_session,
 	Opt_source,
 	/* string args above */
@@ -181,7 +181,8 @@ static const struct fs_parameter_spec ceph_mount_para=
meters[] =3D {
 	fsparam_flag_no	("fsc",				Opt_fscache), // fsc|nofsc
 	fsparam_string	("fsc",				Opt_fscache), // fsc=3D...
 	fsparam_flag_no ("ino32",			Opt_ino32),
-	fsparam_string	("mds_namespace",		Opt_mds_namespace),
+	fsparam_string	("mds_namespace",		Opt_fs), // backwards compatibility
+	fsparam_string	("fs",				Opt_fs), // new alias for mds_namespace
 	fsparam_flag_no ("poolperm",			Opt_poolperm),
 	fsparam_flag_no ("quotadf",			Opt_quotadf),
 	fsparam_u32	("rasize",			Opt_rasize),
@@ -300,9 +301,9 @@ static int ceph_parse_mount_param(struct fs_context *=
fc,
 		fsopt->snapdir_name =3D param->string;
 		param->string =3D NULL;
 		break;
-	case Opt_mds_namespace:
-		kfree(fsopt->mds_namespace);
-		fsopt->mds_namespace =3D param->string;
+	case Opt_fs:
+		kfree(fsopt->fs_name);
+		fsopt->fs_name =3D param->string;
 		param->string =3D NULL;
 		break;
 	case Opt_recover_session:
@@ -460,7 +461,7 @@ static void destroy_mount_options(struct ceph_mount_o=
ptions *args)
 		return;
=20
 	kfree(args->snapdir_name);
-	kfree(args->mds_namespace);
+	kfree(args->fs_name);
 	kfree(args->server_path);
 	kfree(args->fscache_uniq);
 	kfree(args);
@@ -494,7 +495,7 @@ static int compare_mount_options(struct ceph_mount_op=
tions *new_fsopt,
 	if (ret)
 		return ret;
=20
-	ret =3D strcmp_null(fsopt1->mds_namespace, fsopt2->mds_namespace);
+	ret =3D strcmp_null(fsopt1->fs_name, fsopt2->fs_name);
 	if (ret)
 		return ret;
=20
@@ -561,8 +562,8 @@ static int ceph_show_options(struct seq_file *m, stru=
ct dentry *root)
 	if ((fsopt->flags & CEPH_MOUNT_OPT_NOCOPYFROM) =3D=3D 0)
 		seq_puts(m, ",copyfrom");
=20
-	if (fsopt->mds_namespace)
-		seq_show_option(m, "mds_namespace", fsopt->mds_namespace);
+	if (fsopt->fs_name)
+		seq_show_option(m, "fs", fsopt->fs_name);
=20
 	if (fsopt->flags & CEPH_MOUNT_OPT_CLEANRECOVER)
 		seq_show_option(m, "recover_session", "clean");
@@ -643,7 +644,7 @@ static struct ceph_fs_client *create_fs_client(struct=
 ceph_mount_options *fsopt,
 	fsc->client->extra_mon_dispatch =3D extra_mon_dispatch;
 	ceph_set_opt(fsc->client, ABORT_ON_FULL);
=20
-	if (!fsopt->mds_namespace) {
+	if (!fsopt->fs_name) {
 		ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP,
 				   0, true);
 	} else {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 4b269dc845bb..fc4c125b42fb 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -90,7 +90,7 @@ struct ceph_mount_options {
 	 */
=20
 	char *snapdir_name;   /* default ".snap" */
-	char *mds_namespace;  /* default NULL */
+	char *fs_name;        /* default NULL */
 	char *server_path;    /* default NULL (means "/") */
 	char *fscache_uniq;   /* default NULL */
 };
--=20
2.21.0
