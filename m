From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 2/4] ceph: request new max size only when there is auth cap
Date: Tue, 10 Mar 2020 19:34:19 +0800
Message-ID: <20200310113421.174873-3-zyan@redhat.com>
References: <20200310113421.174873-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726211AbgCJLef (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:34:35 -0400
In-Reply-To: <20200310113421.174873-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

When there is no auth cap, check_max_size() can't do anything, may
cause infinite loop inside ceph_get_caps().

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 804f4c65251a..295b61201d85 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2582,7 +2582,7 @@ static int try_get_cap_refs(struct inode *inode, in=
t need, int want,
 			dout("get_cap_refs %p endoff %llu > maxsize %llu\n",
 			     inode, endoff, ci->i_max_size);
 			if (endoff > ci->i_requested_max_size)
-				ret =3D -EFBIG;
+				ret =3D ci->i_auth_cap ? -EFBIG : -ESTALE;
 			goto out_unlock;
 		}
 		/*
--=20
2.21.1
