From: Wido den Hollander <wido@pcextreme.nl>
Subject: Re: simple performance tests
Date: Wed, 16 Jun 2010 11:49:35 +0200
Message-ID: <1276681775.2492.3.camel@wido-laptop.pcextreme.nl>
References: <hva4nu$2nr$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from support.pcextreme.nl ([89.18.190.50]:54464 "EHLO
	support.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab0FPJth (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jun 2010 05:49:37 -0400
In-Reply-To: <hva4nu$2nr$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi,

You were running all the Ceph components on the same host? E.g, mon, md=
s
and osd on the same machine?

Imho that is not the way to test Ceph.

I've done some benchmarking myself with 6 physical machines for OSD's
(different hw in each machine) and i was seeing about 30 ~ 40MB/sec ove=
r
a Gigabit network.

Ofcourse, that could be a lot better, but i think they are focussing on
stability right now rather then performance.

Also, a local FS will be faster than a network filesystem, since the
local filesystem doesn't have to take multiple clients into the
equasion.

Try benchmarking Ceph against NFS and you will start seeing different
results.

--=20
Met vriendelijke groet,

Wido den Hollander
Hoofd Systeembeheer / CSO
Telefoon Support Nederland: 0900 9633 (45 cpm)
Telefoon Support Belgi=C3=AB: 0900 70312 (45 cpm)
Telefoon Direct: (+31) (0)20 50 60 104
=46ax: +31 (0)20 50 60 111
E-mail: support@pcextreme.nl
Website: http://www.pcextreme.nl
Kennisbank: http://support.pcextreme.nl/
Netwerkstatus: http://nmc.pcextreme.nl


On Wed, 2010-06-16 at 09:15 +0000, Thomas Mueller wrote:
> hi
>=20
> i've done some performance tests on a small system.
>=20
> HW:
> * Supermicro X7SPA-HF (with IMPI and KVMoverIP integrated))
> * Atom D510 1.6GHz DualCore and HT
> * WD RE3 500GB 7200umin disks
> * 4GB RAM
>=20
> SW:
> * Debian 5.0 "Lenny"
> * Kernel 2.6.32 (backports.org)
> * ceph/unstable
> * ceph-client-standalone/unstable-backport
>=20
> values are MB/s. all tests are local.
>=20
> dbench 1 results:
> * 1 disk, btrfs: 115
> * 2 disks, btrfs data/metadata raid0: 115
> * 1 osd/disk, 1 mds, 1 mon: 7
> * 2 osd/disk, 1 mds, 1mon: 6.2117
> * 1 disk, btrfs, samba: 14.02
> * 2 disks, btrfs data/metadata raid0, samba: 13.781
>=20
> dbench 10 results:
> * 1 disk, btrfs: 271.724
> * 2 disks, btrfs data/metadata raid0: 270.043
> * 1 osd/disk, 1 mds, 1 mon: -
> * 2 osd/disk, 1 mds, 1mon: 12.1862
> * 1 disk, btrfs, samba: 20.22
> * 2 disks, btfs data/metadata raid0, samba: 20.26
>=20
> dd bs=3D1M count=3D8192 if=3D/dev/zero
> * 1 disk, btrfs: 126
> * 2 disks, btrfs data/metadata raid0:  271
> * 1 osd/disk, 1 mds, 1 mon: -
> * 2 osd/disk, 1 mds, 1mon: 51.2
> * 1 disk, btrfs, samba: 95.2
> * 2 disks, btrfs data/metadata raid0, samba: 85.9
>=20
> will add a AOC-USAS-H8iR (LSI) RAID card to the mix if  i get the cab=
les=20
> needed.
>=20
> i'm a bit suprised about the low rates of ceph. i'll try to to the sa=
me=20
> tests on a more powerfull machine.=20
>=20
> - Thomas
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
