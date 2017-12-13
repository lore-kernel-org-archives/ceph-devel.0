From: Florian Margaine <florian@platform.sh>
Subject: [PATCH] rbd: reacquire lock should update lock owner client id
Date: Wed, 13 Dec 2017 16:43:59 +0100
Message-ID: <87tvwumy4g.fsf@platform.sh>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40645 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbdLMPoD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Dec 2017 10:44:03 -0500
Received: by mail-wr0-f196.google.com with SMTP id q9so2485895wre.7
        for <ceph-devel@vger.kernel.org>; Wed, 13 Dec 2017 07:44:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Otherwise, future operations on this RBD using exclusive-lock are
going to require the lock from a non-existent client id.

This ports commit 475dda114a7e25b43dc9066b9808a64fc0c6dc89 from librbd
to krbd.

Signed-off-by: Florian Margaine <florian@platform.sh>
=2D--
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index adc877dfef5c..4e2acf9c81af 100644
=2D-- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3884,6 +3884,7 @@ static void rbd_reacquire_lock(struct rbd_device *rbd=
_dev)
 					   &rbd_dev->lock_dwork, 0);
 	} else {
 		strcpy(rbd_dev->lock_cookie, cookie);
+		queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
 	}
 }
=20
=2D-=20
2.14.3


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEWcDV2nrrM20UJL9WhD9tdT2UlyoFAloxSr8ACgkQhD9tdT2U
lyrxIQf+M/xxGhCPQVr1+nxxJvNcMqLEa6uC9fdwqxWmHLvDZRApihJQdAUue1OD
BvMHw4mH5UUkfZxW0unEkiLkWLtg5pSatBIHOeJrcaCgwPKwRy1PJqLre3dYy8nA
39DpXoPnBl7XHNQahK7RxuEP/YV5UAdhJeRUOajxxj4TZ3YmkfdbuQzGeOsEM3/A
phOXku3VpDnGF3fOvGobb7qS3GWA4Ppt0coonEaW8NPHrXJxsa1GD79PCOsgD/Ry
iCyE+cmoVMRo1E0uQIJRh0FzEMangZMCuj9DrqhK3wOzFjWLQI3pTJWTusA/soIR
hXx+BIbMh9u5GC07tAxURodQvly2GA==
=IojP
-----END PGP SIGNATURE-----
--=-=-=--
