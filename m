From: Loic Dachary <loic@dachary.org>
Subject: Re: NEON / SIMD
Date: Mon, 13 Oct 2014 19:36:17 -0700
Message-ID: <543C8C21.6040806@dachary.org>
References: <54399D76.7090805@dachary.org> <20141013100651.GI2532@jannau.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bNBw8fgepb6HHxFGo8VpCn7TwK6nomaRr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:44320 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754316AbaJNCg3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Oct 2014 22:36:29 -0400
In-Reply-To: <20141013100651.GI2532@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bNBw8fgepb6HHxFGo8VpCn7TwK6nomaRr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 13/10/2014 03:06, Janne Grunau wrote:
> Hi,
>=20
> On 2014-10-11 23:13:26 +0200, Loic Dachary wrote:
>>
>> I'd like to learn more about SIMD and NEON. What documents / web site =

>> would you recommend to begin ? There are
>>
>> http://projectne10.github.io/Ne10/
>> http://www.arm.com/products/processors/technologies/neon.php
>>
>> Are you using formal specifications / documentations ? Any hint would =

>> be most appreciated :-)
>=20
> I'm almost exclusively using ARM's Architecture Reference Manuals=20
> (available only after registration in ARM's inforcenter):
>=20
> ARMv7-A:
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0406c/index.html
>=20
> ARMv8-A:
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0487a.c/index.html
>=20
>=20
> http://infocenter.arm.com/help/topic/com.arm.doc.dui0489h/DUI0489H_arm_=
assembler_reference.pdf
> Seems to be available without registration and has similar descriptions=

> of neon and vfp instructions like the ARMv7-A ARM.
>=20
> I don't know any more approachable source off-hand.

Thanks for the tip :-) I'm registered and can see the documents now !

Cheers

>=20
> Janne
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bNBw8fgepb6HHxFGo8VpCn7TwK6nomaRr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ8jCEACgkQ8dLMyEl6F23cGQCfW7KThYKH/x64jjjYcQIWzWrE
yo4AnRk7xD38Tpn1an1bHt0onMTmIPBd
=2gaK
-----END PGP SIGNATURE-----

--bNBw8fgepb6HHxFGo8VpCn7TwK6nomaRr--
