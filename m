From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure Code user guide
Date: Mon, 03 Mar 2014 16:35:44 +0100
Message-ID: <5314A150.6050102@dachary.org>
References: <53148187.2040408@dachary.org> <531495F2.5040008@42on.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pPcsldrCFCgswUHaGERop0EfXBvu0iAcL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59031 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbaCCPfq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 10:35:46 -0500
In-Reply-To: <531495F2.5040008@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pPcsldrCFCgswUHaGERop0EfXBvu0iAcL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 03/03/2014 15:47, Wido den Hollander wrote:
> On 03/03/2014 02:20 PM, Loic Dachary wrote:
>> Hi John,
>>
>> I'd like to draft a user guide for erasure coded pools, oriented towar=
d system administrators. Where do you advise me to insert this ? Should I=
 get inspiration from an example ?
>>
>=20
> the docs dir isn't good for that? If not, might be that the Wiki is a p=
roper location?

Are you suggesting something like doc/dev/erasure-coded-pool.rst next to =
doc/dev/cache-pool.rst ? I'm not sure about the wiki.

Cheers

>=20
>> Thanks in advance for any pointers or advice :-)
>>
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--pPcsldrCFCgswUHaGERop0EfXBvu0iAcL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMUoVAACgkQ8dLMyEl6F22W1QCgvFxUHdgA6V7uu6Tf+D8gsZC6
op0An2iWQCRj7Mbk+X+QyBOvY+XCnnXp
=qa0t
-----END PGP SIGNATURE-----

--pPcsldrCFCgswUHaGERop0EfXBvu0iAcL--
