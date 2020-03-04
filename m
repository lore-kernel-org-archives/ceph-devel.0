From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] mds: update dentry lease for async create
Date: Wed,  4 Mar 2020 21:22:20 +0800
Message-ID: <20200304132220.41238-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45763 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387776AbgCDNWa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Mar 2020 08:22:30 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

Otherwise ceph_d_delete() may return 1 for the dentry, which makes
dput() prune the dentry and clear parent dir's complete flag.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 53321bf517c2..671b141aedfe 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -480,6 +480,9 @@ static int try_prep_async_create(struct inode *dir, s=
truct dentry *dentry,
 	if (d_in_lookup(dentry)) {
 		if (!__ceph_dir_is_complete(ci))
 			goto no_async;
+		spin_lock(&dentry->d_lock);
+		di->lease_shared_gen =3D atomic_read(&ci->i_shared_gen);
+		spin_unlock(&dentry->d_lock);
 	} else if (atomic_read(&ci->i_shared_gen) !=3D
 		   READ_ONCE(di->lease_shared_gen)) {
 		goto no_async;
--=20
2.21.1
