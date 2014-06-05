From: Loic Dachary <loic@dachary.org>
Subject: Re: Locally Repairable Codes vs Pyramid
Date: Thu, 05 Jun 2014 16:00:50 +0200
Message-ID: <53907812.6030100@dachary.org>
References: <538C9FA2.3020805@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3gr566B5Ep0hKbeN13E6ob7GiuGjVvtxr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:34797 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaFEOAx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jun 2014 10:00:53 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id D69E1428A3
	for <ceph-devel@vger.kernel.org>; Thu,  5 Jun 2014 16:00:50 +0200 (CEST)
In-Reply-To: <538C9FA2.3020805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3gr566B5Ep0hKbeN13E6ob7GiuGjVvtxr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For the record and since nobody objected, I made the suggested change.

On 02/06/2014 18:00, Loic Dachary wrote:
> Hi Ceph,
>=20
> TL;DR: s/pyramid/LRC/ in the implementation of http://pad.ceph.com/p/cd=
sgiant-pyramid-erasure-code for clarity
>=20
> Although the term "Pyramid code" has been consistently used in referenc=
e to the technique used to reduce the network requirements when repairing=
 from the loss of a single OSD (put simply ;-), I realized today when dis=
cussing with Dan Lambright and Xavier Hernandez from glusterfs that I was=
 unclear about what it really means.
>=20
> As far as I can tell, LRC as described in http://anrg.usc.edu/~maheswar=
an/Xorbas.pdf suggests an implementation that is close to what has been d=
escribed during the last CDS. In contrast the pyramid code paper http://r=
esearch.microsoft.com/pubs/70415/tr-2007-25.pdf suggests a more sophistic=
ated approach which I do not fully understand.=20
>=20
> Instead of hardcoding the word "pyramid" in the pathnames of the implem=
entation it seems better to use "LRC" instead.
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--3gr566B5Ep0hKbeN13E6ob7GiuGjVvtxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOQeBIACgkQ8dLMyEl6F23gAwCfWqsa2H4ZF+o6Bs/1PjYp4dcC
L5sAnRclLl8mV5A8aO7aDqjRTWOm7a41
=ioa0
-----END PGP SIGNATURE-----

--3gr566B5Ep0hKbeN13E6ob7GiuGjVvtxr--
