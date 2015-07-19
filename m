From: Loic Dachary <loic@dachary.org>
Subject: pulpito slowness
Date: Sun, 19 Jul 2015 18:56:12 +0200
Message-ID: <55ABD6AC.3030903@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lkUf0OtrdTCV2VOGwGaJIv3v2X45kbiC6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52577 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752822AbbGSQ4O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Jul 2015 12:56:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lkUf0OtrdTCV2VOGwGaJIv3v2X45kbiC6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alfredo,

After installing pulpito and run from sources with:

        virtualenv ./virtualenv
        source ./virtualenv/bin/activate
        pip install -r requirements.txt
        python run.py &

I run a rados suite with 40 workers and 218 jobs. All is well except a sl=
owness from pulpito that I don't quite understand. It takes 9 seconds to =
load although the load average of the machine is low, the CPU are not all=
 busy, there is plenty of free ram.

ubuntu@teuthology:~$ curl http://localhost:8081/ubuntu-2015-07-19_15:57:1=
3-rados-hammer---basic-openstack/ > /dev/null  % Total    % Received % Xf=
erd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  S=
peed
100  391k  100  391k    0     0  42774      0  0:00:09  0:00:09 --:--:-- =
96305

Do you have an idea of the reason for this slowness ?=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--lkUf0OtrdTCV2VOGwGaJIv3v2X45kbiC6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWr1qwACgkQ8dLMyEl6F20BoQCfQcHW1vYhM9SPeAlGXLeFijNP
LrEAoMQ3KiS61fz4GS3o5gTRA4mbNEWF
=JYWU
-----END PGP SIGNATURE-----

--lkUf0OtrdTCV2VOGwGaJIv3v2X45kbiC6--
