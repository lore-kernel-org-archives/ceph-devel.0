From: Loic Dachary <loic@dachary.org>
Subject: Re: rados and the next giant release v0.87.2
Date: Fri, 17 Apr 2015 23:10:39 +0200
Message-ID: <553176CF.80702@dachary.org>
References: <552E33D7.9010800@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="0n9rtdV7NTwcF9KxR5jSU4R52L2LrfOHf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48523 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752176AbbDQVKn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Apr 2015 17:10:43 -0400
In-Reply-To: <552E33D7.9010800@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Abhishek L <abhishek.lekshmanan@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0n9rtdV7NTwcF9KxR5jSU4R52L2LrfOHf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

For the record:

<loicd> sjusthm: when you get a moment could you take a look at the "rado=
s and the next giant release v0.87.2" mail ? it's hopefully a quick revie=
w. If not it can wait until next week ;-)
<sjusthm> loicd: lookin
<sjusthm> loicd: looks good for qe to me
<loicd> sjusthm: thanks !

On 15/04/2015 11:48, Loic Dachary wrote:
> Hi Sam,
>=20
> The next giant release as found at https://github.com/ceph/ceph/tree/gi=
ant passed the rados suite (http://tracker.ceph.com/issues/11153#rados). =
Do you think it is ready for QE to start their own round of testing ?
>=20
> Note that it will be the last giant release.=20
>=20
> Cheers
>=20
> P.S. http://tracker.ceph.com/issues/11153#Release-information has direc=
t links to the pull requests merged into giant since v0.87.1 in case you =
need more context about one of them.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--0n9rtdV7NTwcF9KxR5jSU4R52L2LrfOHf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUxds8ACgkQ8dLMyEl6F21kCACcCL9Jhc5kVS84Rkff3BYKtCNH
CPkAnRxt+ZxDJ6uPdHj/t1B8ZiiZEMYh
=WNpP
-----END PGP SIGNATURE-----

--0n9rtdV7NTwcF9KxR5jSU4R52L2LrfOHf--
