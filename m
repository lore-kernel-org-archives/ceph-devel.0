From: Loic Dachary <loic@dachary.org>
Subject: Re: /sys/block and /dev and partitions
Date: Tue, 18 Aug 2015 12:13:48 +0200
Message-ID: <55D3055C.6090606@dachary.org>
References: <55CF1F99.5050807@dachary.org>	<alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>	<55CF5C4B.2010406@dachary.org>	<CAOi1vP-0Kz6x=nEO=9yijNfS1QzN9hEa0GMQR94Ggv-KCrM=cw@mail.gmail.com>	<55CFA778.6030703@dachary.org>	<CAOi1vP--kcWVtWoFCWqgmuB+A0vUX8E3pxoFbVQbTQuLn6hW2Q@mail.gmail.com>	<55CFB8CE.10508@dachary.org>	<55D25642.6090001@dachary.org> <CAOi1vP8Mab1M10Gr+L-eWw=tH2hd6A8DK+jm9sxKqCQ3kfG5PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LNq4PSWA94s8KGj4QLM73an3rLe80THjP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39668 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751326AbbHRKNu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Aug 2015 06:13:50 -0400
In-Reply-To: <CAOi1vP8Mab1M10Gr+L-eWw=tH2hd6A8DK+jm9sxKqCQ3kfG5PQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LNq4PSWA94s8KGj4QLM73an3rLe80THjP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18/08/2015 11:53, Ilya Dryomov wrote:
> On Tue, Aug 18, 2015 at 12:46 AM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Ilya,
>>
>> For regular devices such as /dev/vdb2 or /dev/sda3, do you think it is=
 safe to use /sys/dev/block/M:m/partition to figure out the partition num=
ber ? Or could it vary depending on the disk driver or the partition tabl=
e layout ? Or the kernel version ?
>=20
> Yes, I think it is.  "partition" was added specifically for finding out=

> partition numbers after extended devt scheme was merged, because it
> made it impossible to use arithmetic on minor numbers.  That happened
> around 2.6.27 - 2.6.28, so it's a more recent one compared to others,
> but I don't think you care about anything pre 2.6.32.
>=20
> (You could choose not to rely on "partition" and access() "start" for
> figuring out if the thing is a partition - it's been around forever,
> but then, the only way to figure out the partition index would be to
> parse the name, which you want to avoid.)

Exactly. Really happy to get rid of the name parsing logic :-)

> Thanks,
>=20
>                 Ilya
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--LNq4PSWA94s8KGj4QLM73an3rLe80THjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXTBVwACgkQ8dLMyEl6F23xJQCeN95qW1kDJuA6H+te6A1B5B1o
O4AAni7Nb0VlOyD0XxQ9MYHdwbkCSnBs
=pd5y
-----END PGP SIGNATURE-----

--LNq4PSWA94s8KGj4QLM73an3rLe80THjP--
