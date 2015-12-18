From: Loic Dachary <loic@dachary.org>
Subject: Re: puzzling disapearance of /dev/sdc1
Date: Fri, 18 Dec 2015 17:23:50 +0100
Message-ID: <56743316.1040805@dachary.org>
References: <5672AAD7.8030004@dachary.org>
 <alpine.DEB.2.00.1512170530200.10312@cobra.newdream.net>
 <5672C258.1020700@dachary.org>
 <CAOi1vP_602U1BB0+epJ6ROJjiF7d-1uLv75M_SYPDeR2Oa47ig@mail.gmail.com>
 <5673FE37.8010408@dachary.org>
 <CAOi1vP_2s7KFvxWJZSJB-=rY0eA7GR7AqAvaKHcQfkUWtOr+hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oOPuAn0dD1BlrwgeLBf0keaEbAVHs0s9M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52657 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753815AbbLRQXx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 11:23:53 -0500
In-Reply-To: <CAOi1vP_2s7KFvxWJZSJB-=rY0eA7GR7AqAvaKHcQfkUWtOr+hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oOPuAn0dD1BlrwgeLBf0keaEbAVHs0s9M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18/12/2015 16:31, Ilya Dryomov wrote:
> On Fri, Dec 18, 2015 at 1:38 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ilya,
>>
>> It turns out that sgdisk 0.8.6 -i 2 /dev/vdb removes partitions and re=
-adds them on CentOS 7 with a 3.10.0-229.11.1.el7 kernel, in the same way=
 partprobe does. It is used intensively by ceph-disk and inevitably leads=
 to races where a device temporarily disapears. The same command (sgdisk =
0.8.8) on Ubuntu 14.04 with a 3.13.0-62-generic kernel only generates two=
 udev change events and does not remove / add partitions. The source code=
 between sgdisk 0.8.6 and sgdisk 0.8.8 did not change in a significant wa=
y and the output of strace -e ioctl sgdisk -i 2 /dev/vdb is identical in =
both environments.
>>
>> ioctl(3, BLKGETSIZE, 20971520)          =3D 0
>> ioctl(3, BLKGETSIZE64, 10737418240)     =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, HDIO_GETGEO, {heads=3D16, sectors=3D63, cylinders=3D16383, st=
art=3D0}) =3D 0
>> ioctl(3, HDIO_GETGEO, {heads=3D16, sectors=3D63, cylinders=3D16383, st=
art=3D0}) =3D 0
>> ioctl(3, BLKGETSIZE, 20971520)          =3D 0
>> ioctl(3, BLKGETSIZE64, 10737418240)     =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKGETSIZE, 20971520)          =3D 0
>> ioctl(3, BLKGETSIZE64, 10737418240)     =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>> ioctl(3, BLKSSZGET, 512)                =3D 0
>>
>> This leads me to the conclusion that the difference is in how the kern=
el reacts to these ioctl.
>=20
> I'm pretty sure it's not the kernel versions that matter here, but
> systemd versions.  Those are all get-property ioctls, and I don't think=

> sgdisk -i does anything with the partition table.
>=20
> What it probably does though is it opens the disk for write for some
> reason.  When it closes it, udevd (systemd-udevd process) picks that
> close up via inotify and issues the BLKRRPART ioctl, instructing the
> kernel to re-read the partition table.  Technically, that's different
> from what partprobe does, but it still generates those udev events you
> are seeing in the monitor.
>=20
> AFAICT udevd started doing this in v214.

That explains everything indeed.

# strace -f -e open sgdisk -i 2 /dev/vdb
=2E..
open("/dev/vdb", O_RDONLY)              =3D 4
open("/dev/vdb", O_WRONLY|O_CREAT, 0644) =3D 4
open("/dev/vdb", O_RDONLY)              =3D 4
Partition GUID code: 45B0969E-9B03-4F30-B4C6-B4B80CEFF106 (Unknown)
Partition unique GUID: 7BBAA731-AA45-47B8-8661-B4FAA53C4162
First sector: 2048 (at 1024.0 KiB)
Last sector: 204800 (at 100.0 MiB)
Partition size: 202753 sectors (99.0 MiB)
Attribute flags: 0000000000000000
Partition name: 'ceph journal'

# strace -f -e open blkid /dev/vdb2
=2E..
open("/etc/blkid.conf", O_RDONLY)       =3D 4
open("/dev/.blkid.tab", O_RDONLY)       =3D 4
open("/dev/vdb2", O_RDONLY)             =3D 4
open("/sys/dev/block/253:18", O_RDONLY) =3D 5
open("/sys/block/vdb/dev", O_RDONLY)    =3D 6
open("/dev/.blkid.tab-hVvwJi", O_RDWR|O_CREAT|O_EXCL, 0600) =3D 4

blkid does not open the device for write, hence the different behavior. S=
witching sgdisk in favor of blkid fixes the issue.

Nice catch !

> Thanks,
>=20
>                 Ilya
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--oOPuAn0dD1BlrwgeLBf0keaEbAVHs0s9M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ0MxcACgkQ8dLMyEl6F21CvgCgwYACLfWXsem0WHI9dp03BbRU
eJcAn2nRVrYl+iCz3B5465qbMz0jgOch
=uJCj
-----END PGP SIGNATURE-----

--oOPuAn0dD1BlrwgeLBf0keaEbAVHs0s9M--
