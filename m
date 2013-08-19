From: Loic Dachary <loic@dachary.org>
Subject: Re: Review request : Erasure Code plugin loader implementation
Date: Mon, 19 Aug 2013 15:27:01 +0200
Message-ID: <52121D25.9050309@dachary.org>
References: <5210F429.2020805@dachary.org> <alpine.DEB.2.00.1308181031580.1479@cobra.newdream.net> <521128ED.1080605@dachary.org> <alpine.DEB.2.00.1308181719340.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig088DBB948FCB01ABD5E3C751"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:57019 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab3HSN1F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 09:27:05 -0400
In-Reply-To: <alpine.DEB.2.00.1308181719340.1479@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig088DBB948FCB01ABD5E3C751
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

This makes a lot more sense indeed. I updated the http://tracker.ceph.com=
/issues/5878 description accordingly.

ceph osd pool create poolname erasure-code-dir=3D/var/lib/ceph/erasure-co=
de
erasure-code-plugin=3Djerasure erasure-code-m=3D10 erasure-code-k=3D3 era=
sure-code-algorithm=3DReed-Solomon=20

Thanks :-)

On 19/08/2013 02:24, Sage Weil wrote:
> Hi Loic,
>=20
> One other thought on http://tracker.ceph.com/issues/5878:
>=20
> The user interface there would let you adjust various parameters of the=
=20
> pool's erasure coding scheme after the pool is created.  As a practical=
=20
> matter, I suspect that many/most of these fields will be specified exac=
tly=20
> once (at pool creation time) and will be immutable properties of the po=
ol=20
> after that.  The m/k at a minimum need to match up with what we are=20
> requesting out of crush.  And once there is data stored, I don't think =
it=20
> will make sense to be able to change the encoding scheme for new object=
s=20
> and still be able to deal with old objects.  (Or maybe it will be, if t=
he=20
> code metadata is in the object_info_t.)
>=20
> Even if we do support changing some of these on the fly, though, I susp=
ect=20
> the most important interface, and the first we implement, will be=20
> something like
>=20
>  ceph osd pool create <name> [key=3Dvalue ...]
>=20
> the various parameters listed, like EC algorithm, m, k, and pg_num.  We=
=20
> can probably generalize the mon command interface to have a key/value l=
ist=20
> type that will make this easy to plumb from the CLI (and trivial via=20
> ceph-rest-api).
>=20
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig088DBB948FCB01ABD5E3C751
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlISHSUACgkQ8dLMyEl6F23G1wCghm/7tvs63vgppgwqQAGkcgO4
T9kAnRFcS1P/J+Awe3+lf31o+0Gf9eEm
=M6et
-----END PGP SIGNATURE-----

--------------enig088DBB948FCB01ABD5E3C751--
