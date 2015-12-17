From: Loic Dachary <loic@dachary.org>
Subject: Re: understanding partprobe failure
Date: Fri, 18 Dec 2015 00:23:25 +0100
Message-ID: <567343ED.2010804@dachary.org>
References: <5672A842.1030103@dachary.org>
 <CAOi1vP8+D9SpyGHMsnxWPM0Xs4yLPvK27=h8NG=Oy+Rbd=YvjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VAMqLbdGW8UDrWFd0lQv6cb2guA2FjxkX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52227 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845AbbLQXX2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 18:23:28 -0500
In-Reply-To: <CAOi1vP8+D9SpyGHMsnxWPM0Xs4yLPvK27=h8NG=Oy+Rbd=YvjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VAMqLbdGW8UDrWFd0lQv6cb2guA2FjxkX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/12/2015 16:49, Ilya Dryomov wrote:
> On Thu, Dec 17, 2015 at 1:19 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Ilya,
>>
>> I'm seeing a partprobe failure right after a disk was zapped with sgdi=
sk --clear --mbrtogpt -- /dev/vdb:
>>
>> partprobe /dev/vdb failed : Error: Partition(s) 1 on /dev/vdb have bee=
n written, but we have been unable to inform the kernel of the change, pr=
obably because it/they are in use. As a result, the old partition(s) will=
 remain in use. You should reboot now before making further changes.
>>
>> waiting 60 seconds (see the log below) and trying again succeeds. The =
partprobe call is guarded by udevadm settle to prevent udev actions from =
racing and nothing else goes on in the machine.
>>
>> Any idea how that could happen ?
>>
>> Cheers
>>
>> 2015-12-17 11:46:10,356.356 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:get_dm_uuid /dev/vdb uuid pat=
h is /sys/dev/block/253:16/dm/uuid
>> 2015-12-17 11:46:10,357.357 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:Zapping partition table on /d=
ev/vdb
>> 2015-12-17 11:46:10,358.358 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/sgd=
isk --zap-all -- /dev/vdb
>> 2015-12-17 11:46:10,365.365 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:Caution: invalid backup GPT header, but valid=
 main header; regenerating
>> 2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:backup header from main header.
>> 2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:
>> 2015-12-17 11:46:10,366.366 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:Warning! Main and backup partition tables dif=
fer! Use the 'c' and 'e' options
>> 2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:on the recovery & transformation menu to exam=
ine the two tables.
>> 2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:
>> 2015-12-17 11:46:10,367.367 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:Warning! One or more CRCs don't match. You sh=
ould repair the disk!
>> 2015-12-17 11:46:10,368.368 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:
>> 2015-12-17 11:46:11,413.413 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:*********************************************=
*******************************
>> 2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:Caution: Found protective or hybrid MBR and c=
orrupt GPT. Using GPT, but disk
>> 2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:verification and recovery are STRONGLY recomm=
ended.
>> 2015-12-17 11:46:11,414.414 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:*********************************************=
*******************************
>> 2015-12-17 11:46:11,415.415 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:Warning: The kernel is still using the old pa=
rtition table.
>> 2015-12-17 11:46:11,415.415 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:The new table will be used at the next reboot=
=2E
>> 2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:GPT data structures destroyed! You may now pa=
rtition the disk using fdisk or
>> 2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:other utilities.
>> 2015-12-17 11:46:11,416.416 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/sgd=
isk --clear --mbrtogpt -- /dev/vdb
>> 2015-12-17 11:46:12,504.504 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:Creating new GPT entries.
>> 2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:Warning: The kernel is still using the old pa=
rtition table.
>> 2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:The new table will be used at the next reboot=
=2E
>> 2015-12-17 11:46:12,505.505 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:The operation has completed successfully.
>> 2015-12-17 11:46:12,506.506 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:Calling partprobe on zapped d=
evice /dev/vdb
>> 2015-12-17 11:46:12,507.507 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udev=
adm settle --timeout=3D600
>> 2015-12-17 11:46:15,427.427 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/par=
tprobe /dev/vdb
>> 2015-12-17 11:46:16,860.860 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:DEBUG:ceph-disk:partprobe /dev/vdb failed : E=
rror: Partition(s) 1 on /dev/vdb have been written, but we have been unab=
le to inform the kernel of the change, probably because it/they are in us=
e.  As a result, the old partition(s) will remain in use.  You should reb=
oot now before making further changes.
>> 2015-12-17 11:46:16,860.860 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:(ignored, waiting 60s)
>> 2015-12-17 11:47:16,925.925 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udev=
adm settle --timeout=3D600
>> 2015-12-17 11:47:19,681.681 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/sbin/par=
tprobe /dev/vdb
>> 2015-12-17 11:47:20,125.125 INFO:tasks.workunit.client.0.target1671142=
33028.stderr:DEBUG:CephDisk:INFO:ceph-disk:Running command: /usr/bin/udev=
adm settle --timeout=3D600
>=20
> Well, evidently something was using that partition.  This is on
> openstack, right?  It probably makes it hard to debug, but trying to
> reproduce and doing some tracing is probably the only way to get an
> idea.

This is on a VMs running integration tests with a tightly controlled envi=
ronment.

> udevadm settle doesn't guarantee that a device (or one of its
> partitions) isn't going to be busy - it just waits for udevd to empty
> its queue.  Both sgdisk invocations complained about a busy device, is
> it possible something external to udev was doing something with it?

I think it may be multipath or dmcrypt temporarily holding the partition =
and triggering this error. I'll try to verify that.

Thanks !


--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--VAMqLbdGW8UDrWFd0lQv6cb2guA2FjxkX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZzQ+0ACgkQ8dLMyEl6F22CGgCgq9gme9FYQ91rAbNkjUnDth8L
QlwAnjBJZ8/5benFqmWwKJMgk2v/+CK5
=2gb+
-----END PGP SIGNATURE-----

--VAMqLbdGW8UDrWFd0lQv6cb2guA2FjxkX--
