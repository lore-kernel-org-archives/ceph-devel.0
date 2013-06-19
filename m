From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 09:00:10 +0200
Message-ID: <51C156FA.2000509@dachary.org>
References: <51C05123.8000002@dachary.org> <kpr0dn$3cr$1@ger.gmane.org> <kpr0ld$3cr$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1DB6DEE073692B389734DEEA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:56126 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933853Ab3FSHAM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 03:00:12 -0400
In-Reply-To: <kpr0ld$3cr$2@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DB6DEE073692B389734DEEA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/19/2013 03:14 AM, Alex Elsayed wrote:
> Alex Elsayed wrote:
>=20
>> Loic Dachary wrote:
>>
>>> Hi Ceph,
>>>
>> <snip>
>>> Reed-Solomon coding family is the only one that can keep the chuncks
>>> unencoded and therefore concatenable.
>> <snip>
>>
>> In my understanding, this is not strictly true - any 'systematic' code=

>> will have the unencoded chunks remain available in this manner, and an=
y
>> non- systematic linear code can be transformed into a systematic code =
with
>> the same minimum distance. Fountain codes are often explicitly constru=
cted
>> to maintain this property, as in the case of RaptorQ [RFC 6330].
>>
>> https://en.wikipedia.org/wiki/Systematic_code
>=20
> ...that said, Reed-Solomon is to the best of my knowledge the only spac=
e-
> optimal such code.=20

What does "space-optimal" mean ? Does it mean that Reed-Solomon will use =
less disk space than fountain codes to code the same number of parity chu=
nks ?=20

> An interesting option, however, might be to use a=20
> fountain code over the network when distributing either replicas *or* p=
arity=20
> chunks, so that losses can be recovered with <1 full chunk retransmissi=
on.

I would be gratefull if you could expand on this idea. I don't get it :-)=


Cheers

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


--------------enig1DB6DEE073692B389734DEEA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHBVvoACgkQ8dLMyEl6F23wFgCdHA95eYWQEglr88CPjiM+alvC
/CcAn3bCR1bfGuwbXE0btEQJ8iwSGjQ/
=tTtL
-----END PGP SIGNATURE-----

--------------enig1DB6DEE073692B389734DEEA--
