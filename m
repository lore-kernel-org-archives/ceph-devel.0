From: Loic Dachary <loic@dachary.org>
Subject: Re: jerasure buffer misaligned
Date: Fri, 12 Sep 2014 11:34:46 +0200
Message-ID: <5412BE36.5090008@dachary.org>
References: <54120E60.3030704@dachary.org> <20140912091705.GQ2591@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BcsuphspUSABGC0weVGh8bwDCo2OnbnK6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50582 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753884AbaILJf0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Sep 2014 05:35:26 -0400
In-Reply-To: <20140912091705.GQ2591@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BcsuphspUSABGC0weVGh8bwDCo2OnbnK6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 12/09/2014 11:17, Janne Grunau wrote:
> Hi Loic,
>=20
> On 2014-09-11 23:04:32 +0200, Loic Dachary wrote:
>>
>> In the context of jerasure buffers you found to be misaligned, (=20
>> http://tracker.ceph.com/issues/9408 ) it would help fix it if you had =

>> a simple way to reproduce it.
>=20
> I've updated the issues with a way to reproduce it. You don't need work=
=20
> on it since I've already removed the offending code in my effort to=20
> reduce memory management overhead for small sizes.

Nice :-) I'm curious about the offending code you had to remove. Where wa=
s it ?

Cheers

>=20
> Janne
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--BcsuphspUSABGC0weVGh8bwDCo2OnbnK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQSvjYACgkQ8dLMyEl6F22klACffBrOK0nmgTePaBGlTh6ORdh3
NVoAnA6RyhMxcgU5cJwAezwu+o7giUsw
=/u9O
-----END PGP SIGNATURE-----

--BcsuphspUSABGC0weVGh8bwDCo2OnbnK6--
