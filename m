From: Loic Dachary <loic@dachary.org>
Subject: Re: durability model
Date: Wed, 28 May 2014 16:05:02 +0200
Message-ID: <5385ED0E.9070204@dachary.org>
References: <1401131148.7008.YahooMailNeo@web165003.mail.bf1.yahoo.com> <CAHxYaFN6R3F6Tn0Vnh9N+pAXhOT8F7+gYLTzTgonn==GJUpX_w@mail.gmail.com> <1401197435.39621.YahooMailNeo@web165002.mail.bf1.yahoo.com> <5384A010.4080300@dachary.org> <1401284130.75330.YahooMailNeo@web165006.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EPLVnUAv08X1D4CFroosDI0sWDTaa00D9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:51768 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbaE1OFI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 May 2014 10:05:08 -0400
In-Reply-To: <1401284130.75330.YahooMailNeo@web165006.mail.bf1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuskus <koleosfuscus@yahoo.com>
Cc: Kyle Bader <kyle@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EPLVnUAv08X1D4CFroosDI0sWDTaa00D9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 28/05/2014 15:35, Koleos Fuskus wrote:
>=20
>=20
>> 1. What will be erasure model unit? Is it a pool or a placement group?=
 I cannot see the best option here yet, probably because my inexperience =
with Ceph.
>=20
> A pool.=20
> OK. this is what I thought but some things are not clear enough. I am d=
eploying Ceph to toying a bit more.
>=20
>=20
>> 3. Metadata: Jerasure creates metadata files. How are those files stor=
ed in ceph (what kind of=20
> Jerasure does not create a metadata file.
>=20
> It does on my machine! at least with jerasure 1.2 on mac os :)

If you mean the files that are created by the command line examples provi=
ded with jerasure (1.2 or 2), they are not required and only meant for te=
st purposes.

Cheers

>=20
>=20
>=20
>=20
> I proposed an update to the documentation to clarify this : https://git=
hub.com/ceph/ceph/pull/1856 . Does it look sensible to you ?
>=20
>=20
>=20
> THanks!
>=20
> Cheers,
>=20
>=20
> Koleosfuscus
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--EPLVnUAv08X1D4CFroosDI0sWDTaa00D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOF7Q4ACgkQ8dLMyEl6F20ZtgCguJlDY6XyEbkTNmoYS3GoJuxG
1ZQAnR/ANHd/XOk62evGyDA6B/9L4ANr
=oVlc
-----END PGP SIGNATURE-----

--EPLVnUAv08X1D4CFroosDI0sWDTaa00D9--
