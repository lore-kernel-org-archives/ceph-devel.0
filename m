From: Loic Dachary <loic@dachary.org>
Subject: Re: crush and go
Date: Mon, 23 Mar 2015 10:13:47 +0100
Message-ID: <550FD94B.9090509@dachary.org>
References: <550DF141.2090800@dachary.org> <alpine.DEB.2.00.1503222217440.12661@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E3dBKrgbaOd1fPHiNpM2983dFipPmjoOw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34837 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751918AbbCWJNv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 05:13:51 -0400
In-Reply-To: <alpine.DEB.2.00.1503222217440.12661@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E3dBKrgbaOd1fPHiNpM2983dFipPmjoOw
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 23/03/2015 06:20, Sage Weil wrote:
> On Sat, 21 Mar 2015, Loic Dachary wrote:
>> Hi,
>>
>> Does anyone know of a go wrapper around the crush library ? I looked a=
t=20
>> http://go-search.org/search?q=3Dcrush but did not find anything releva=
nt.
>=20
> I think it will be difficult to build such a wrapper until we spend the=
=20
> time coralling crush into a nice .so.  The challenge there is that whil=
e=20
> the core mapping code is quite simple (and in C, and duplicated in the =

> kernel), the CrushWrapper stuff depends on a bunch of Ceph infrastrctur=
e,=20
> like the bufferlist encode/decode stuff and CephContext for debugging. =
=20
> Without all of that the core mapping library isn't terribly useful or=20
> friendly.
>=20
> I'm not sure what the best path to making it more easily consumable wou=
ld=20
> be, to be honest...

Hi Sage,

I did not realize it was entangled. Looks like a nice GSoC project :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--E3dBKrgbaOd1fPHiNpM2983dFipPmjoOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUP2UsACgkQ8dLMyEl6F23HZwCfYq9p44VUttCoPXtgliYcJFPX
4AUAoLRPEtiT78MXWf32GE+HUPsAG89R
=AnJc
-----END PGP SIGNATURE-----

--E3dBKrgbaOd1fPHiNpM2983dFipPmjoOw--
