From: Loic Dachary <loic@dachary.org>
Subject: Re: gitbuilder, master branch and make check bot
Date: Fri, 06 Mar 2015 18:20:58 +0100
Message-ID: <54F9E1FA.1020604@dachary.org>
References: <54F899B8.1050005@dachary.org> <54F90A4C.60700@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3gh423Fa9iaFUn1D5KRuC27HcL3EewXf7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54016 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751158AbbCFRVB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Mar 2015 12:21:01 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 0E3CA4210B
	for <ceph-devel@vger.kernel.org>; Fri,  6 Mar 2015 18:20:59 +0100 (CET)
In-Reply-To: <54F90A4C.60700@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3gh423Fa9iaFUn1D5KRuC27HcL3EewXf7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The make check bot is back.

If you're curious, here is the corresponding fix https://github.com/dacha=
ry/ceph/commit/3a8b8284ddd17ad5c6e27347433cdde6744d0737

Cheers

On 06/03/2015 03:00, Loic Dachary wrote:
> Hi again,
>=20
> The gitbuilders are fixed as well as master. The make check bot will be=
 back in a few hours.
>=20
> Cheers
>=20
> On 05/03/2015 19:00, Loic Dachary wrote:
>> Hi Ceph,
>>
>> The make check bot that runs on pull requests is on pause until the gi=
tbuilder ( http://ceph.com/gitbuilder.cgi ) upgrade is complete. This sho=
uld fix the build of the master branch. All should be fixed in the next f=
ew hours at most.
>>
>> Thanks for your patience :-)
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--3gh423Fa9iaFUn1D5KRuC27HcL3EewXf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT54foACgkQ8dLMyEl6F20ibwCfYO+Fr5+1gEBauBri+LOEDGES
yOAAn3aL11a2dy6CQW3iZQUnaOz5orSz
=lUIP
-----END PGP SIGNATURE-----

--3gh423Fa9iaFUn1D5KRuC27HcL3EewXf7--
