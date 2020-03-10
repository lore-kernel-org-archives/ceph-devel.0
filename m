From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 4/4] ceph: wait for async creating inode before requesting new max size
Date: Tue, 10 Mar 2020 19:34:21 +0800
Message-ID: <20200310113421.174873-5-zyan@redhat.com>
References: <20200310113421.174873-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57193 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgCJLek (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:34:40 -0400
In-Reply-To: <20200310113421.174873-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

ceph_check_caps() can't request new max size for async creating inode.
This may make ceph_get_caps() loop busily until getting reply of the
async create.

This patch also waits for async creating inode before calling
ceph_renew_caps()

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f63db3cb9c4f..14bedf2c16cd 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2832,6 +2832,11 @@ int ceph_get_caps(struct file *filp, int need, int=
 want,
 		}
=20
 		if (ret < 0) {
+			if (ret =3D=3D -EFBIG || ret =3D=3D -ESTALE) {
+				int ret2 =3D ceph_wait_on_async_create(inode);
+				if (ret2 < 0)
+					return ret2;
+			}
 			if (ret =3D=3D -EFBIG) {
 				check_max_size(inode, endoff);
 				continue;
--=20
2.21.1
