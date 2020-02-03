From: xiubli@redhat.com
Subject: [RFC PATCH] ceph: fix the debug message for calc_layout
Date: Sun,  2 Feb 2020 23:01:33 -0500
Message-ID: <20200203040133.39319-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727228AbgBCECI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2020 23:02:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 net/ceph/osd_client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 108c9457d629..6afe36ffc1ba 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -113,10 +113,11 @@ static int calc_layout(struct ceph_file_layout *lay=
out, u64 off, u64 *plen,
 	if (*objlen < orig_len) {
 		*plen =3D *objlen;
 		dout(" skipping last %llu, final file extent %llu~%llu\n",
-		     orig_len - *plen, off, *plen);
+		     orig_len - *plen, off, off + *plen);
 	}
=20
-	dout("calc_layout objnum=3D%llx %llu~%llu\n", *objnum, *objoff, *objlen=
);
+	dout("calc_layout objnum=3D%llx, object extent %llu~%llu\n", *objnum,
+	     *objoff, *objoff + *objlen);
 	return 0;
 }
=20
--=20
2.21.0
