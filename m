From: Loic Dachary <loic@dachary.org>
Subject: Re: /sys/block and /dev and partitions
Date: Mon, 17 Aug 2015 23:46:42 +0200
Message-ID: <55D25642.6090001@dachary.org>
References: <55CF1F99.5050807@dachary.org>	<alpine.DEB.2.00.1508150727060.32106@cobra.newdream.net>	<55CF5C4B.2010406@dachary.org>	<CAOi1vP-0Kz6x=nEO=9yijNfS1QzN9hEa0GMQR94Ggv-KCrM=cw@mail.gmail.com>	<55CFA778.6030703@dachary.org> <CAOi1vP--kcWVtWoFCWqgmuB+A0vUX8E3pxoFbVQbTQuLn6hW2Q@mail.gmail.com> <55CFB8CE.10508@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jmkCCt2fl6AKEBXmHdmOqPuQ3MMkXRskB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39395 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751809AbbHQVqr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 17:46:47 -0400
In-Reply-To: <55CFB8CE.10508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jmkCCt2fl6AKEBXmHdmOqPuQ3MMkXRskB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

For regular devices such as /dev/vdb2 or /dev/sda3, do you think it is sa=
fe to use /sys/dev/block/M:m/partition to figure out the partition number=
 ? Or could it vary depending on the disk driver or the partition table l=
ayout ? Or the kernel version ?

Cheers

On 16/08/2015 00:10, Loic Dachary wrote:
>=20
>=20
> On 16/08/2015 00:00, Ilya Dryomov wrote:
>> On Sat, Aug 15, 2015 at 11:56 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>> Hi Ilya,
>>>
>>> On 15/08/2015 19:42, Ilya Dryomov wrote:
>>>> On Sat, Aug 15, 2015 at 6:35 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>>>> Hi Sage,
>>>>>
>>>>> On 15/08/2015 16:28, Sage Weil wrote:
>>>>>> On Sat, 15 Aug 2015, Loic Dachary wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Is there a portable and consistent way to figure out if a given /=
dev/XXX
>>>>>>> path (for instance /dev/dm-1) is a partition of a whole device ?
>>>>>>> Although checking /sys/block/dm-1/dm/name for a number at the end=
 (like
>>>>>>> mpatha1 or mpatha2) would probably work, it feels like a fragile =
hack.
>>>>>>> Looking into /sys/block/dm-1/slaves will lead to
>>>>>>> /sys/block/dm-1/slaves/dm-0 and we can check that
>>>>>>> /sys/block/dm-*/subsystem is class/block. But that does not neces=
sarily
>>>>>>> mean dm-1 is a partition of dm-0, just that it's a slave of dm-0.=

>>>>>>
>>>>>> Take a look at is_partition in ceph-disk, whih is the best I came =
up with.
>>>>>> Basically it checks if the device name appears as /sys/block/*/$fo=
o...
>>>>
>>>> For regular devices, you can access() /sys/dev/block/maj:min/partiti=
on.
>>>> If it's there, it's a partition - no need to iterate over /sys/block=
=2E
>>>
>>> I added http://tracker.ceph.com/issues/12706 for when someone has tim=
e to rework that part of the code.
>>>
>>>>
>>>>>
>>>>> That is consistently updated for /dev/sdb or /dev/vdb but things ar=
e different when using multipath. I'll rely on /sys/block/dm-?/dm/name in=
stead until a better solution is found.
>>>>
>>>> A better way might be to rely on the fact that a dm partition will
>>>> necessarily have its uuid prefixed by "part".  In that case, it shou=
ld
>>>> be safe to assume that the thing in slaves is a whole disk - I think=

>>>> that's what various util-linux tools do.  However, IIRC the dm uuid =
is
>>>> optional, so that won't work on a dm device without a uuid.
>>>
>>> It looks like multipath on both CentOS 7 and Ubuntu 14.04 set the uui=
d in this way.
>>>
>>> Is it also safe to assume that if the uuid is:
>>>
>>> $ cat /sys/dev/block/253:?/dm/uuid
>>> mpath-353333330000007d0
>>> part1-mpath-353333330000007d0
>>> part2-mpath-353333330000007d0
>>>
>>> it means these were created by multipath because of the mpath ? When =
asking dmsetup with:
>>
>> Yes, I think so.  I'm pretty sure these "part<id>-" and "mpath-"
>> prefixes were devised for exactly this purpose.
>>
>=20
> Excellent !
>=20
>> Thanks,
>>
>>                 Ilya
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--jmkCCt2fl6AKEBXmHdmOqPuQ3MMkXRskB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXSVkIACgkQ8dLMyEl6F21cOwCeP8qhry4Jr+cdrhsljisY8qyV
k8IAmgP5dVB3AYrLCLSwUR3aO4Xplg6y
=Kyaw
-----END PGP SIGNATURE-----

--jmkCCt2fl6AKEBXmHdmOqPuQ3MMkXRskB--
