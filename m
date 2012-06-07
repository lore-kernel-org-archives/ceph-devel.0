From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 7 Jun 2012 20:40:25 +0200
Message-ID: <4677329D-FDDA-4959-BA1F-2E94DBF6FDAC@filoo.de>
References: <21601270.dfB0BsVfyn@pc10>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:55359 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2FGSrJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 14:47:09 -0400
In-Reply-To: <21601270.dfB0BsVfyn@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Guido,

unfortunately this sounds very familiar to me. We have been on a long r=
oad with similar "weird" errors.
Our setup is something like "start a couple of VM's ( qemu-*), let them=
 create a 1G-file each and randomly seek and write 4MB blocks filled wi=
th md5sums of the block as payload, to be verifiable after completely w=
ritten.
=46urthermore create some 10000 files every-now-and-then and try to rem=
ove them after the verify-run.
This produced the same things than you are experiencing - zero'ed block=
s -  with the main difference, that my tests are now clean with 0.47-2 =
and friends. After a couple of hundreds of runs.
Our setup is with XFS as OSD-data partition, as we had too many errors =
with btrfs in the past.
My assumption now would be, that there are some relations to your files=
ystem=85?!

Would be cool if you are able to change your setup to XFS. At least tha=
t would be a starting-point for further investigations.

Regards,

Oliver.

Am 07.06.2012 um 20:04 schrieb Guido Winkelmann:

> Hi,
>=20
> I'm using Ceph with RBD to provide network-transparent disk images fo=
r KVM-
> based virtual servers. The last two days, I've been hunting some weir=
d elusive=20
> bug where data in the virtual machines would be corrupted in weird wa=
ys. It=20
> usually manifests in files having some random data - usually zeroes -=
 at the=20
> start before the actual contents that should be in there start.
>=20
> To track this down, I wrote a simple io tester. It does the following=
:
>=20
> - Create 1 Megabyte of random data
> - Calculate the SHA256 hash of that data
> - Write the data to a file on the harddisk, in a given directory, usi=
ng the=20
> hash as the filename
> - Repeat until the disk is full
> - Delete the last file (because it is very likely to be incompletely =
written)
> - Read and delete all the files just written while checking that thei=
r sha256=20
> sums are equal to their filenames
>=20
> When running this io tester in a VM that uses a qcow2 file on a local=
 harddisk=20
> for its virtual disk, no errors are found. When the same VM is runnin=
g using=20
> rbd, the io tester finds on average about one corruption every 200 Me=
gabytes,=20
> reproducably.
>=20
> (As in an interesting aside, the io tester also prints how long it to=
ok to=20
> read or write 100 MB, and it turns out reading the data back in again=
 is about=20
> three times slower than writing them in the first place...)
>=20
> Ceph is version 0.47.2. Qemu KVM is 1.0, compiled with the spec file =
from=20
> http://pkgs.fedoraproject.org/gitweb/?p=3Dqemu.git;a=3Dsummary
> (And compiled after ceph 0.47.2 was installed on that machine, so it =
would use=20
> the correct headers...)
> Both the Ceph cluster and the KVM host machines are running on Fedora=
 16, with=20
> a fairly recent 3.3.x kernel.
> The ceph cluster uses btrf for the osd's data dirs. The journal is on=
 a tmpfs.=20
> (This is not a production setup - luckily.)
> The virtual machine is using ext4 as its filesystem.
> There were no obvious other problems with either the ceph cluster or =
the KVM=20
> host machines.
>=20
> I have attached a copy of the ceph.conf in use, in case it might be h=
elpful.
>=20
> This is a huge problem, and any help in tracking it down would be muc=
h=20
> appreciated.
>=20
> Regards,
>=20
> 	Guido<ceph.conf>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
