From: =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>
Subject: [PATCH] libceph: Remove spurious kunmap() of the zero page
Date: Wed, 24 Jun 2015 23:18:39 +0200
Message-ID: <1435180719-12000-2-git-send-email-benoit.canet@nodalink.com>
References: <1435180719-12000-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 28-113-190-109.dsl.ovh.fr ([109.190.113.28]:60118 "EHLO ariel"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751203AbbFXV0p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 24 Jun 2015 17:26:45 -0400
In-Reply-To: <1435180719-12000-1-git-send-email-benoit.canet@nodalink.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, =?UTF-8?q?Beno=C3=AEt=20Canet?= <benoit.canet@nodalink.com>

ceph_tcp_sendpage already does the work of mapping/unmapping
the zero page if needed.

Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
---
 net/ceph/messenger.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 967080a..38f06a4 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -278,7 +278,6 @@ static void _ceph_msgr_exit(void)
 	ceph_msgr_slab_exit();
=20
 	BUG_ON(zero_page =3D=3D NULL);
-	kunmap(zero_page);
 	page_cache_release(zero_page);
 	zero_page =3D NULL;
 }
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
