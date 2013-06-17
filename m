From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] rbd: silence GCC warnings
Date: Mon, 17 Jun 2013 12:12:43 +0200
Message-ID: <1371463963.26299.9.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Building rbd.o triggers two GCC warnings:
    drivers/block/rbd.c: In function =E2=80=98rbd_img_request_fill=E2=80=
=99:
    drivers/block/rbd.c:1272:22: warning: =E2=80=98bio_list=E2=80=99 ma=
y be used uninitialized in this function [-Wmaybe-uninitialized]
    drivers/block/rbd.c:2170:14: note: =E2=80=98bio_list=E2=80=99 was d=
eclared here
    drivers/block/rbd.c:2231:10: warning: =E2=80=98pages=E2=80=99 may b=
e used uninitialized in this function [-Wmaybe-uninitialized]

Apparently GCC has trouble determining that "bio_list" is unused if "ty=
pe"
is "OBJ_REQUEST_PAGES" and, conversely, that "pages" will be unused if
"type" is "OBJ_REQUEST_BIO". Add harmless initializations to NULL to
help GCC.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
0) Compile tested only.

1) These warnings were introduced in v3.10-rc1, apparently through
commit f1a4739f33 ("rbd: support page array image requests").=20

2) Note that
    rbd_assert(type =3D=3D OBJ_REQUEST_PAGES);

seems redundant. I see no way that this assertion could ever be false.=20

 drivers/block/rbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3063452..b8a58178 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2185,9 +2185,11 @@ static int rbd_img_request_fill(struct rbd_img_r=
equest *img_request,
 	if (type =3D=3D OBJ_REQUEST_BIO) {
 		bio_list =3D data_desc;
 		rbd_assert(img_offset =3D=3D bio_list->bi_sector << SECTOR_SHIFT);
+		pages =3D NULL;
 	} else {
 		rbd_assert(type =3D=3D OBJ_REQUEST_PAGES);
 		pages =3D data_desc;
+		bio_list =3D NULL;
 	}
=20
 	while (resid) {
--=20
1.8.1.4
