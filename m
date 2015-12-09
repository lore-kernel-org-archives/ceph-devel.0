From: Loic Dachary <loic@dachary.org>
Subject: Re: new OSD re-using old OSD id fails to boot
Date: Wed, 9 Dec 2015 14:08:36 +0100
Message-ID: <566827D4.1000100@dachary.org>
References: <5663158D.1010302@dachary.org> <56678036.5050909@redhat.com>
 <alpine.DEB.2.00.1512081838240.25269@cobra.newdream.net>
 <CABF_e-FC7TGFw9=_zEB2-GX=3EOcoX-oc6=L=NPbuipBRo+atg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LktPrKDVp3k6u9CihrF4SIcto1NU9txCi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47055 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751310AbbLINIi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Dec 2015 08:08:38 -0500
In-Reply-To: <CABF_e-FC7TGFw9=_zEB2-GX=3EOcoX-oc6=L=NPbuipBRo+atg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei-Chung Cheng <freeze.vicente.cheng@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LktPrKDVp3k6u9CihrF4SIcto1NU9txCi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/12/2015 11:39, Wei-Chung Cheng wrote:
> Hi Loic,
>=20
> I try to reproduce this problem on my CentOS7.
> I can not do the same issue.
> This is my version:
> ceph version 10.0.0-928-g8eb0ed1 (8eb0ed1dcda9ee6180a06ee6a4415b112090c=
534)
> Would you describe more detail?

I reproduced the problem yesterday once more by running the ceph-disk sui=
te. It happens every time.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--LktPrKDVp3k6u9CihrF4SIcto1NU9txCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZoJ9QACgkQ8dLMyEl6F22I3gCePlw41E1cNE+api0HBhYlw6/w
fcoAn2Y7blmq4vkolcRZqnROcLiUrSHS
=83wT
-----END PGP SIGNATURE-----

--LktPrKDVp3k6u9CihrF4SIcto1NU9txCi--
