From: Loic Dachary <loic@dachary.org>
Subject: Raring upstart reload bug workaround
Date: Fri, 23 May 2014 18:53:09 +0200
Message-ID: <537F7CF5.9010701@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="igvcwMVB4ToDi0ajLQlRk3dDttrqrV7aT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46896 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbaEWQxN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 May 2014 12:53:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>, James Hunt <james.hunt@ubuntu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--igvcwMVB4ToDi0ajLQlRk3dDttrqrV7aT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I'm looking for the simplest workaround for a bug in the reload implement=
ation of upstart as shipped with Ubuntu raring. It manifests itself by lo=
osing track of the "exec" process. If it does not ring a bell, the steps =
to reproduce from a fresh Ubuntu raring installation are here : http://tr=
acker.ceph.com/issues/7188 . It was fixed because it does not show on Tru=
sty but I was not able to find a reference in https://bugs.launchpad.net/=
upstart

Thanks in advance for any advice you may have. And for your continuous ef=
forts to make Ubuntu better ;-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--igvcwMVB4ToDi0ajLQlRk3dDttrqrV7aT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlN/fPUACgkQ8dLMyEl6F22yXwCfdXfE1GBA5STh2EJaNqG5ymQH
0bAAmQFNt08tGYcp16p6ttaDG7r9ZmCr
=55F4
-----END PGP SIGNATURE-----

--igvcwMVB4ToDi0ajLQlRk3dDttrqrV7aT--
