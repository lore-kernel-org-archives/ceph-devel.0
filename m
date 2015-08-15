From: Loic Dachary <loic@dachary.org>
Subject: Re: /sys/block and /dev and partitions
Date: Sat, 15 Aug 2015 17:35:39 +0200
Message-ID: <55CF5C4B.2010406@dachary.org>
References: <55CF1F99.5050807@dachary.org> <alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="L93wuh2dwEXb9DgLXjrpTUMrVV076LxEc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38563 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751290AbbHOPfl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 11:35:41 -0400
In-Reply-To: <alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L93wuh2dwEXb9DgLXjrpTUMrVV076LxEc
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 15/08/2015 16:28, Sage Weil wrote:
> On Sat, 15 Aug 2015, Loic Dachary wrote:
>> Hi,
>>
>> Is there a portable and consistent way to figure out if a given /dev/X=
XX=20
>> path (for instance /dev/dm-1) is a partition of a whole device ?=20
>> Although checking /sys/block/dm-1/dm/name for a number at the end (lik=
e=20
>> mpatha1 or mpatha2) would probably work, it feels like a fragile hack.=
=20
>> Looking into /sys/block/dm-1/slaves will lead to=20
>> /sys/block/dm-1/slaves/dm-0 and we can check that=20
>> /sys/block/dm-*/subsystem is class/block. But that does not necessaril=
y=20
>> mean dm-1 is a partition of dm-0, just that it's a slave of dm-0.
>=20
> Take a look at is_partition in ceph-disk, whih is the best I came up wi=
th. =20
> Basically it checks if the device name appears as /sys/block/*/$foo...

That is consistently updated for /dev/sdb or /dev/vdb but things are diff=
erent when using multipath. I'll rely on /sys/block/dm-?/dm/name instead =
until a better solution is found.=20

Thanks !

>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--L93wuh2dwEXb9DgLXjrpTUMrVV076LxEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXPXEsACgkQ8dLMyEl6F206PACfWfnu0JBlaLI3Qvnaoh63Cy+a
edcAoJVgalaimwhKxXozJHWKwxiTgSco
=QWgV
-----END PGP SIGNATURE-----

--L93wuh2dwEXb9DgLXjrpTUMrVV076LxEc--
