From: Loic Dachary <loic@dachary.org>
Subject: Re: Problems whilst running ceph-disk/run-tox.sh
Date: Tue, 16 Feb 2016 22:25:53 +0700
Message-ID: <56C33F81.4080708@dachary.org>
References: <56C334FD.1010601@ecoracks.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37720 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbcBPP0D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Feb 2016 10:26:03 -0500
In-Reply-To: <56C334FD.1010601@ecoracks.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wjw@ecoracks.nl, Ceph Development <ceph-devel@vger.kernel.org>

Hi,

It is possible that tests pick /etc/ceph/ceph.conf although they should=
 not. Do you have such a file on your machine ?

Cheers

On 16/02/2016 21:41, Willem Jan Withagen (EcoRacks) wrote:
> Hi,
>=20
> Apart from the trouble this testscript is giving on general....
>=20
> I'd like to shre two observations:
> In  TestCephDisk.test_list_dmcrypt_data
> =3D=3D=3D=3D=3D=3D=3D=3D
>         for seq in xrange(TMP_MAX):
>             name =3D names.next()
>             file =3D _os.path.join(dir, prefix + name + suffix)
>             try:
>>               _os.mkdir(file, 0700)
> E               OSError: [Errno 13] Permission denied:
> '/var/lib/ceph/tmp/mnt.j5qCU5'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> Which was due to the previous run (as root) , so directories were own=
ed
> by root.
>=20
> And once I fixed that one, by chown-ing stuff:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> E               assert [{'partitions...: '/dev/Xda'}] =3D=3D
> [{'partitions'...: '/dev/Xda'}]
> E                 At index 0 diff: {'partitions': [{'mount': None,
> 'type': 'data', 'is_partition': True, 'state': 'unprepared', 'fs_type=
':
> None, 'uuid': '56244cf5-83ef-4984-888a-2d8b8e0e04b2', 'dmcrypt':
> {'holders': ['dm-0'], 'type': 'plain'}, 'ptype':
> '4fbd7e29-9d25-41b8-afd0-5ec00ceff05d', 'path': '/dev/Xda1'}], 'path'=
:
> '/dev/Xda'} !=3D {'partitions': [{'type': 'data', 'state': 'active',
> 'dmcrypt': {'holders': ['dm-0'], 'type': 'plain'}, 'mount': '/', 'uui=
d':
> '56244cf5-83ef-4984-888a-2d8b8e0e04b2', 'is_partition': True, 'fs_typ=
e':
> 'xfs', 'ceph_fsid': None, 'whoami': None, 'ptype':
> '4fbd7e29-9d25-41b8-afd0-5ec00ceff05d', 'path': '/dev/Xda1'}], 'path'=
:
> '/dev/Xda'}
> E                 Full diff:
> E                 - [{'partitions': [{'dmcrypt': {'holders': ['dm-0']=
,
> 'type': 'plain'},
> E                 + [{'partitions': [{'ceph_fsid': None,
> E                 +                   'dmcrypt': {'holders': ['dm-0']=
,
> 'type': 'plain'},
> E                 -                   'fs_type': None,
> E                 ?                              ^^^^
> E                 +                   'fs_type': 'xfs',
> E                 ?                              ^^^^^
> E                 'is_partition': True,
> E                 -                   'mount': None,
> E                 ?                            ^^^^
> E                 +                   'mount': '/',
> E                 ?                            ^^^
> E                 'path': '/dev/Xda1',
> E                 'ptype': '4fbd7e29-9d25-41b8-afd0-5ec00ceff05d',
> E                 -                   'state': 'unprepared',
> E                 ?                             ^^^^ -----
> E                 +                   'state': 'active',
> E                 ?                             ^^^^^
> E                 'type': 'data',
> E                 -                   'uuid':
> '56244cf5-83ef-4984-888a-2d8b8e0e04b2'}],
> E               =20
> ?                                                                 --
> E                 +                   'uuid':
> '56244cf5-83ef-4984-888a-2d8b8e0e04b2',
> E                 +                   'whoami': None}],
> E                 'path': '/dev/Xda'}]
>=20
> tests/test_main.py:347: AssertionError
> ----------------------------- Captured stderr call
> -----------------------------
> DEBUG:ceph_disk.main:main_list: /dev/Xda1 ptype =3D
> 4fbd7e29-9d25-41b8-afd0-5ec00ceff05d uuid =3D
> 56244cf5-83ef-4984-888a-2d8b8e0e04b2
> INFO:ceph_disk.main:Running command: /usr/sbin/blkid -s TYPE /dev/dm-=
0
> DEBUG:ceph_disk.main:Mounting /dev/dm-0 on /var/lib/ceph/tmp/mnt.jzy7=
4c
> with options
> INFO:ceph_disk.main:Running command: /usr/bin/mount -t xfs -o  --
> /dev/dm-0 /var/lib/ceph/tmp/mnt.jzy74c
> mount: only root can use "--options" option
> DEBUG:ceph_disk.main:main_list: {'Xda': ['Xda1']}, uuid_map =3D
> {'56244cf5-83ef-4984-888a-2d8b8e0e04b2': '/dev/Xda1'}, space_map =3D =
{}
> INFO:ceph_disk.main:list_dev(dev =3D /dev/Xda1, ptype =3D
> 4fbd7e29-9d25-41b8-afd0-5ec00ceff05d)
> INFO:ceph_disk.main:Running command: /usr/sbin/blkid -s TYPE /dev/dm-=
0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Thusfar I've grown used to the fact that script can be run as non-roo=
t.
> Not sure if that was just coincidence, or by design.
>=20
> And if by design, it would be nice to separate root and non-root scri=
pts...
>=20
> --WjW
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
