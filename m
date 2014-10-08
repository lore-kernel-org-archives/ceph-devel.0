From: Loic Dachary <loic@dachary.org>
Subject: Re: make check failures
Date: Wed, 08 Oct 2014 19:36:36 +0200
Message-ID: <54357624.6080205@dachary.org>
References: <5434D99E.604@dachary.org> <97DE3B79-88BF-470C-A058-4297AC4FF3DC@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="falxSrogP6nMRE3t6qICFtCuP4oudq4G4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40441 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751976AbaJHRgn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 13:36:43 -0400
In-Reply-To: <97DE3B79-88BF-470C-A058-4297AC4FF3DC@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--falxSrogP6nMRE3t6qICFtCuP4oudq4G4
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

For the record, here is another attempt to stablize this test : https://g=
ithub.com/ceph/ceph/pull/2670

Cheers

On 08/10/2014 19:10, David Zafman wrote:
>=20
> After updating my master branch "make check=94 passes now.
>=20
> David Zafman
> Senior Developer
> http://www.inktank.com
>=20
>=20
>=20
>=20
> On Oct 7, 2014, at 11:28 PM, Loic Dachary <loic@dachary.org> wrote:
>=20
>> [cc'ing the list in case someone else experiences problems with make c=
heck]
>>
>> Hi David,
>>
>> Yesterday you mentioned that make check is failing for you on master. =
Would you be so kind as to send the logs ?
>>
>> Cheers
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--falxSrogP6nMRE3t6qICFtCuP4oudq4G4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ1diQACgkQ8dLMyEl6F20IRQCgxjKyoi/xlp25tEhqY43tlyIo
+rIAnRKGvCjvy0W9DGs6qn6Jx8qQoxYs
=nd1g
-----END PGP SIGNATURE-----

--falxSrogP6nMRE3t6qICFtCuP4oudq4G4--
