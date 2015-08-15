From: Loic Dachary <loic@dachary.org>
Subject: Re: /sys/block and /dev and partitions
Date: Sat, 15 Aug 2015 22:56:24 +0200
Message-ID: <55CFA778.6030703@dachary.org>
References: <55CF1F99.5050807@dachary.org>	<alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>	<55CF5C4B.2010406@dachary.org> <CAOi1vP-0Kz6x=nEO=9yijNfS1QzN9hEa0GMQR94Ggv-KCrM=cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="B2qKfmMP5F5B911eaVUxv6gVkaGeqxcmr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38655 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752878AbbHOU41 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 16:56:27 -0400
In-Reply-To: <CAOi1vP-0Kz6x=nEO=9yijNfS1QzN9hEa0GMQR94Ggv-KCrM=cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B2qKfmMP5F5B911eaVUxv6gVkaGeqxcmr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

On 15/08/2015 19:42, Ilya Dryomov wrote:
> On Sat, Aug 15, 2015 at 6:35 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Sage,
>>
>> On 15/08/2015 16:28, Sage Weil wrote:
>>> On Sat, 15 Aug 2015, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> Is there a portable and consistent way to figure out if a given /dev=
/XXX
>>>> path (for instance /dev/dm-1) is a partition of a whole device ?
>>>> Although checking /sys/block/dm-1/dm/name for a number at the end (l=
ike
>>>> mpatha1 or mpatha2) would probably work, it feels like a fragile hac=
k.
>>>> Looking into /sys/block/dm-1/slaves will lead to
>>>> /sys/block/dm-1/slaves/dm-0 and we can check that
>>>> /sys/block/dm-*/subsystem is class/block. But that does not necessar=
ily
>>>> mean dm-1 is a partition of dm-0, just that it's a slave of dm-0.
>>>
>>> Take a look at is_partition in ceph-disk, whih is the best I came up =
with.
>>> Basically it checks if the device name appears as /sys/block/*/$foo..=
=2E
>=20
> For regular devices, you can access() /sys/dev/block/maj:min/partition.=

> If it's there, it's a partition - no need to iterate over /sys/block.

I added http://tracker.ceph.com/issues/12706 for when someone has time to=
 rework that part of the code.

>=20
>>
>> That is consistently updated for /dev/sdb or /dev/vdb but things are d=
ifferent when using multipath. I'll rely on /sys/block/dm-?/dm/name inste=
ad until a better solution is found.
>=20
> A better way might be to rely on the fact that a dm partition will
> necessarily have its uuid prefixed by "part".  In that case, it should
> be safe to assume that the thing in slaves is a whole disk - I think
> that's what various util-linux tools do.  However, IIRC the dm uuid is
> optional, so that won't work on a dm device without a uuid.

It looks like multipath on both CentOS 7 and Ubuntu 14.04 set the uuid in=
 this way.

Is it also safe to assume that if the uuid is:

$ cat /sys/dev/block/253:?/dm/uuid
mpath-353333330000007d0
part1-mpath-353333330000007d0
part2-mpath-353333330000007d0

it means these were created by multipath because of the mpath ? When aski=
ng dmsetup with:

$ sudo dmsetup info --columns --noheading --options subsystem
mpath
part2
part1

it looks like it assumes the first part of the uuid is always the subsyst=
em. Which makes me wonder how reliable this is. What I'm really looking f=
or is a way to assert that a give dm-* is owned by multipath.

Thanks a lot !

>=20
> Thanks,
>=20
>                 Ilya
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--B2qKfmMP5F5B911eaVUxv6gVkaGeqxcmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXPp3gACgkQ8dLMyEl6F20GtgCdG+zinYuecWlSXKgCBpgQqWtf
VP8AmQFjnm7Eqn56sho1eMgcR10dnlol
=WpPH
-----END PGP SIGNATURE-----

--B2qKfmMP5F5B911eaVUxv6gVkaGeqxcmr--
