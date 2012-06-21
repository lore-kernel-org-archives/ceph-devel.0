From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: reproducable osd crash
Date: Thu, 21 Jun 2012 14:55:59 +0200
Message-ID: <4FE319DF.3020106@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52084 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2FUM4D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 08:56:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

i'm able to reproducably crash osd daemons.

How i can reproduce:

Kernel: 3.5.0-rc3
Ceph: 0.47.3
=46S: btrfs
Journal: 2GB tmpfs per OSD
OSD: 3x servers with 4x Intel SSD OSDs each
10GBE Network
rbd_cache_max_age: 2.0
rbd_cache_size: 33554432

Disk is set to writeback.

Start a KVM VM via PXE with the disk attached in writeback mode.

Then run randwrite stress more than 2 time. Mostly OSD 22 in my case=20
crashes.

# fio --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k --=
size=3D200G=20
--numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; fio=20
--filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=3D=
200G=20
--numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; fio=20
--filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=3D=
200G=20
--numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; halt

Strangely exactly THIS OSD also has the most log entries:
64K     ceph-osd.20.log
64K     ceph-osd.21.log
1,3M    ceph-osd.22.log
64K     ceph-osd.23.log

But all OSDs are set to debug osd =3D 20.

dmesg shows:
ceph-osd[5381]: segfault at 3f592c000 ip 00007fa281d8eb23 sp=20
00007fa27702d260 error 4 in libtcmalloc.so.0.0.0[7fa281d6a000+3d000]

I uploaded the following files:
priebe_fio_randwrite_ceph-osd.21.log.bz2 =3D> OSD which was OK and didn=
't=20
crash
priebe_fio_randwrite_ceph-osd.22.log.bz2 =3D> Log from the crashed OSD
=FCu
priebe_fio_randwrite_core.ssdstor001.27204.bz2 =3D> Core dump
priebe_fio_randwrite_ceph-osd.bz2 =3D> osd binary

Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
