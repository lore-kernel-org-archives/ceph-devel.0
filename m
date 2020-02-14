From: xiubli@redhat.com
Subject: [PATCH] ceph: switch to ceph_test_mount_opt helper
Date: Fri, 14 Feb 2020 03:32:25 -0500
Message-ID: <20200214083225.2804-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728779AbgBNIck (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Feb 2020 03:32:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Clean up the code.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 3 +--
 fs/ceph/super.c      | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 451c3727cd0b..8a8aaa20699c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2643,8 +2643,7 @@ static void __do_request(struct ceph_mds_client *md=
sc,
 			list_add(&req->r_wait, &mdsc->waiting_for_map);
 			return;
 		}
-		if (!(mdsc->fsc->mount_options->flags &
-		      CEPH_MOUNT_OPT_MOUNTWAIT) &&
+		if (!ceph_test_mount_opt(mdsc->fsc, MOUNTWAIT) &&
 		    !ceph_mdsmap_is_cluster_available(mdsc->mdsmap)) {
 			err =3D -EHOSTUNREACH;
 			goto finish;
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index abdf61909879..c494351e3cc8 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -992,7 +992,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_=
client *fsc,
 			goto out;
=20
 		/* setup fscache */
-		if (fsc->mount_options->flags & CEPH_MOUNT_OPT_FSCACHE) {
+		if (ceph_test_mount_opt(fsc, FSCACHE)) {
 			err =3D ceph_fscache_register_fs(fsc, fc);
 			if (err < 0)
 				goto out;
--=20
2.21.0
