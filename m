From: =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>
Subject: [PATCH v2] libceph: Avoid holding the zero page on ceph_msgr_slab_init errors
Date: Thu, 25 Jun 2015 21:02:57 +0200
Message-ID: <1435258977-30890-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 28-113-190-109.dsl.ovh.fr ([109.190.113.28]:33573 "EHLO ariel"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751019AbbFYTC6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Jun 2015 15:02:58 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, elder@ieee.org, =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>

ceph_msgr_slab_init may fail due to a temporary ENOMEM.

Delay a bit the initialization of zero_page in ceph_msgr_init and
reorder it's cleanup in _ceph_msgr_exit so it's done in reverse
order of setup.

BUG_ON() will not suffer to be postponed in case it is triggered.

Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 net/ceph/messenger.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 38f06a4..ec68cd3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -275,22 +275,22 @@ static void _ceph_msgr_exit(void)
 		ceph_msgr_wq =3D NULL;
 	}
=20
-	ceph_msgr_slab_exit();
-
 	BUG_ON(zero_page =3D=3D NULL);
 	page_cache_release(zero_page);
 	zero_page =3D NULL;
+
+	ceph_msgr_slab_exit();
 }
=20
 int ceph_msgr_init(void)
 {
+	if (ceph_msgr_slab_init())
+		return -ENOMEM;
+
 	BUG_ON(zero_page !=3D NULL);
 	zero_page =3D ZERO_PAGE(0);
 	page_cache_get(zero_page);
=20
-	if (ceph_msgr_slab_init())
-		return -ENOMEM;
-
 	/*
 	 * The number of active work items is limited by the number of
 	 * connections, so leave @max_active at default.
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
