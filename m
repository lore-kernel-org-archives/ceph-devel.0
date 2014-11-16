From: Loic Dachary <loic@dachary.org>
Subject: teuthology gevent version
Date: Sun, 16 Nov 2014 13:04:20 +0100
Message-ID: <546892C4.1080205@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GriiJ2PUHgoIN0brmITIII9TRc4w1xkK0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37706 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755114AbaKPMEX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 16 Nov 2014 07:04:23 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GriiJ2PUHgoIN0brmITIII9TRc4w1xkK0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Zack,

At the moment teuthology requires gevent =3D=3D 0.13.6 ( https://github.c=
om/ceph/teuthology/blob/master/requirements.txt#L2 ). Would it be a probl=
em to upgrade to a more recent version ? I'd like to use https://github.c=
om/gevent/gevent/blob/master/gevent/threadpool.py which was introduced in=
 1.0b1 http://gevent.org/changelog.html#release-1-0b1-jan-10-2012

Cheers
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--GriiJ2PUHgoIN0brmITIII9TRc4w1xkK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRoksQACgkQ8dLMyEl6F23zWgCfac/cdnszbk7nNavnyrIvBtXv
TE8AoI8wKSENqB01Khs3mBStfVsAqnrv
=mGNf
-----END PGP SIGNATURE-----

--GriiJ2PUHgoIN0brmITIII9TRc4w1xkK0--
