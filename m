From: xiubli@redhat.com
Subject: [PATCH] ceph: fix dout logs for null pointers
Date: Mon, 17 Feb 2020 06:28:06 -0500
Message-ID: <20200217112806.30738-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26958 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgBQL20 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Feb 2020 06:28:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

For example, if dentry and inode is NULL, the log will be:
ceph:  lookup result=3D000000007a1ca695
ceph:  submit_request on 0000000041d5070e for inode 000000007a1ca695

The will be confusing without checking the corresponding code carefully.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/dir.c        | 2 +-
 fs/ceph/mds_client.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index ffeaff5bf211..245a262ec198 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -798,7 +798,7 @@ static struct dentry *ceph_lookup(struct inode *dir, =
struct dentry *dentry,
 	err =3D ceph_handle_snapdir(req, dentry, err);
 	dentry =3D ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
-	dout("lookup result=3D%p\n", dentry);
+	dout("lookup result=3D%d\n", err);
 	return dentry;
 }
=20
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b6aa357f7c61..e34f159d262b 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2772,7 +2772,11 @@ int ceph_mdsc_submit_request(struct ceph_mds_clien=
t *mdsc, struct inode *dir,
 		ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
 				  CEPH_CAP_PIN);
=20
-	dout("submit_request on %p for inode %p\n", req, dir);
+	if (dir)
+		dout("submit_request on %p for inode %p\n", req, dir);
+	else
+		dout("submit_request on %p\n", req);
+
 	mutex_lock(&mdsc->mutex);
 	__register_request(mdsc, req, dir);
 	__do_request(mdsc, req);
--=20
2.21.0
