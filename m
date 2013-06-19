From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 08:56:06 +0200
Message-ID: <51C15606.4010105@dachary.org>
References: <51C05123.8000002@dachary.org> <kpr0dn$3cr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE93691C3D4E78C2AE62750AB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:51418 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933154Ab3FSG4J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 02:56:09 -0400
In-Reply-To: <kpr0dn$3cr$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE93691C3D4E78C2AE62750AB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/19/2013 03:10 AM, Alex Elsayed wrote:
> Loic Dachary wrote:
>=20
>> Hi Ceph,
>>
> <snip>
>> Reed-Solomon coding family is the only one that can keep the chuncks
>> unencoded and therefore concatenable.
> <snip>
>=20
> In my understanding, this is not strictly true - any 'systematic' code =
will=20
> have the unencoded chunks remain available in this manner, and any non-=

> systematic linear code can be transformed into a systematic code with t=
he=20
> same minimum distance. Fountain codes are often explicitly constructed =
to=20
> maintain this property, as in the case of RaptorQ [RFC 6330].
>=20
> https://en.wikipedia.org/wiki/Systematic_code

Thanks for correcting my mistake :-)

>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigE93691C3D4E78C2AE62750AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHBVgYACgkQ8dLMyEl6F21j5gCgt8BoSUeFYkgvOIajGHzOyfQe
maIAn1lHNSNDDZ2/8Cx0gh5bHklS09UG
=8msY
-----END PGP SIGNATURE-----

--------------enigE93691C3D4E78C2AE62750AB--
