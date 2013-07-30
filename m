From: Loic Dachary <loic@dachary.org>
Subject: Re: krbd & live resize
Date: Tue, 30 Jul 2013 15:40:18 +0200
Message-ID: <51F7C242.8050504@dachary.org>
References: <51F6E389.1040607@dachary.org> <51F78D74.803@ksperis.com> <51F78E0B.4030106@dachary.org> <51F7905C.6050604@ksperis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7692EAACF477E2EA4287822E"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:38301 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601Ab3G3NkU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jul 2013 09:40:20 -0400
In-Reply-To: <51F7905C.6050604@ksperis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Barbe <laurent@ksperis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7692EAACF477E2EA4287822E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Your patch can be applied to 3.8 as described here:

http://dachary.org/?p=3D2179

Thanks again

On 30/07/2013 12:07, Laurent Barbe wrote:
> Live resize has been added in 3.6.10 for krbd client.
>=20
> There is a need to do revalidate_disk() on rbd resize :
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/co=
mmit/?id=3Dd98df63ea7e87d5df4dce0cece0210e2a777ac00
>=20
> Cheers
>=20
> Laurent
>=20
>=20
> Le 30/07/2013 11:57, Loic Dachary a =E9crit :
>>
>>
>> On 30/07/2013 11:55, Laurent Barbe wrote:
>>> Hello Loic,
>>>
>>> which version of kernel do you use for krbd ?
>>
>> Linux i-csnces-0000 3.2.0-41-generic #66-Ubuntu SMP
>>
>> That may explain a few things ... :-)
>>
>>>
>>> Laurent
>>>
>>>
>>> Le 29/07/2013 23:50, Loic Dachary a =E9crit :
>>>> Hi,
>>>>
>>>> This works:
>>>>
>>>> lvcreate --name tmp --size 10G all
>>>>     Logical volume "tmp" created
>>>> mkfs.ext4 /dev/all/tmp
>>>> mount /dev/all/tmp /mnt
>>>> blockdev --getsize64 /dev/all/tmp
>>>> 10737418240
>>>> lvextend -L+1G /dev/all/tmp
>>>>     Extending logical volume tmp to 11,00 GiB
>>>>     Logical volume tmp successfully resized
>>>> blockdev --getsize64 /dev/all/tmp
>>>> 11811160064
>>>> resize2fs /dev/all/tmp
>>>> resize2fs 1.41.12 (17-May-2010)
>>>> Filesystem at /dev/all/tmp is mounted on /mnt; on-line resizing requ=
ired
>>>> old desc_blocks =3D 1, new_desc_blocks =3D 1
>>>> Performing an on-line resize of /dev/all/tmp to 2883584 (4k) blocks.=

>>>> The filesystem on /dev/all/tmp is now 2883584 blocks long.
>>>>
>>>> This does not work:
>>>>
>>>> rbd create --size 10240 tmp
>>>> rbd info tmp
>>>> rbd image 'tmp':
>>>>      size 10240 MB in 2560 objects
>>>>      order 22 (4096 KB objects)
>>>>      block_name_prefix: rb.0.12dd.238e1f29
>>>>      format: 1
>>>> rbd map tmp
>>>> mkfs.ext4 /dev/rbd1
>>>> mount /dev/rbd1 /mnt
>>>> blockdev --getsize64 /dev/rbd1
>>>> 10737418240
>>>> rbd resize --size 20000 tmp
>>>> blockdev --getsize64 /dev/rbd1
>>>> 10737418240
>>>> resize2fs /dev/rbd1
>>>> resize2fs 1.42 (29-Nov-2011)
>>>> The filesystem is already 2621440 blocks long.  Nothing to do!
>>>>
>>>> It does work after umounting:
>>>>
>>>> umount /mnt
>>>> blockdev --getsize64 /dev/rbd1
>>>> fsck -f /dev/rbd1
>>>> resize2fs /dev/rbd1
>>>> resize2fs 1.42 (29-Nov-2011)
>>>> Resizing the filesystem on /dev/rbd1 to 5120000 (4k) blocks.
>>>> The filesystem on /dev/rbd1 is now 5120000 blocks long.
>>>>
>>>> I assume there should be "something" in KRBD to allow for the same b=
ehavior as with LVM but I don't know enough about the kernel to be more s=
pecific. Maybe something similar to ioctl BLKRRPART ?
>>>>
>>>> Cheers
>>>>
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig7692EAACF477E2EA4287822E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH3wkIACgkQ8dLMyEl6F20PzQCgpxvKLdsufOixaUgK3u5qDEzt
Y0cAoLFGYqmcbQIMsULeM2NJNjrIXnye
=vl5y
-----END PGP SIGNATURE-----

--------------enig7692EAACF477E2EA4287822E--
