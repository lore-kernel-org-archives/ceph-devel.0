From: Loic Dachary <loic@dachary.org>
Subject: understanding partprobe failure
Date: Thu, 17 Dec 2015 13:19:14 +0100
Message-ID: <5672A842.1030103@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9qt4kiSlJ3HogmxVGwgSugvEOi1Auirsk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51877 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750936AbbLQMTS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 07:19:18 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qt4kiSlJ3HogmxVGwgSugvEOi1Auirsk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilya,

I'm seeing a partprobe failure right after a disk was zapped with sgdisk =
--clear --mbrtogpt -- /dev/vdb:

partprobe /dev/vdb failed : Error: Partition(s) 1 on /dev/vdb have been w=
ritten, but we have been unable to inform the kernel of the change, proba=
bly because it/they are in use. As a result, the old partition(s) will re=
main in use. You should reboot now before making further changes.

waiting 60 seconds (see the log below) and trying again succeeds. The par=
tprobe call is guarded by udevadm settle to prevent udev actions from rac=
ing and nothing else goes on in the machine.

Any idea how that could happen ?

Cheers

2015-12-17 11:46:10,356.356 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:get_dm_uuid /dev/vdb uuid path i=
s /sys/dev/block/253:16/dm/uuid
2015-12-17 11:46:10,357.357 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:Zapping partition table on /dev/=
vdb
2015-12-17 11:46:10,358.358 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/sgdisk=
 --zap-all -- /dev/vdb
2015-12-17 11:46:10,365.365 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:Caution: invalid backup GPT header, but valid ma=
in header; regenerating
2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:backup header from main header.
2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:
2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:Warning! Main and backup partition tables differ=
! Use the 'c' and 'e' options
2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:on the recovery & transformation menu to examine=
 the two tables.
2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:
2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:Warning! One or more CRCs don't match. You shoul=
d repair the disk!
2015-12-17 11:46:10,368.368 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:
2015-12-17 11:46:11,413.413 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:************************************************=
****************************
2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:Caution: Found protective or hybrid MBR and corr=
upt GPT. Using GPT, but disk
2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:verification and recovery are STRONGLY recommend=
ed.
2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:************************************************=
****************************
2015-12-17 11:46:11,415.415 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:Warning: The kernel is still using the old parti=
tion table.
2015-12-17 11:46:11,415.415 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:The new table will be used at the next reboot.
2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:GPT data structures destroyed! You may now parti=
tion the disk using fdisk or
2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:other utilities.
2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/sgdisk=
 --clear --mbrtogpt -- /dev/vdb
2015-12-17 11:46:12,504.504 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:Creating new GPT entries.
2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:Warning: The kernel is still using the old parti=
tion table.
2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:The new table will be used at the next reboot.
2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:The operation has completed successfully.
2015-12-17 11:46:12,506.506 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:Calling partprobe on zapped devi=
ce /dev/vdb
2015-12-17 11:46:12,507.507 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udevadm=
 settle --timeout=3D600
2015-12-17 11:46:15,427.427 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/partpr=
obe /dev/vdb
2015-12-17 11:46:16,860.860 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:partprobe /dev/vdb failed : Erro=
r: Partition(s) 1 on /dev/vdb have been written, but we have been unable =
to inform the kernel of the change, probably because it/they are in use. =
 As a result, the old partition(s) will remain in use.  You should reboot=
 now before making further changes.
2015-12-17 11:46:16,860.860 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:(ignored, waiting 60s)
2015-12-17 11:47:16,925.925 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udevadm=
 settle --timeout=3D600
2015-12-17 11:47:19,681.681 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/partpr=
obe /dev/vdb
2015-12-17 11:47:20,125.125 INFO:tasks.workunit.client.0.target1671142330=
28.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udevadm=
 settle --timeout=3D600
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--9qt4kiSlJ3HogmxVGwgSugvEOi1Auirsk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZyqEIACgkQ8dLMyEl6F22SvQCdHSagrSKjJ+ligejhPzAF2tqx
npAAnjWZO1/fllu8OjZa39OtEQ/+icSz
=Oh1z
-----END PGP SIGNATURE-----

--9qt4kiSlJ3HogmxVGwgSugvEOi1Auirsk--
