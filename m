From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: reproducable osd crash
Date: Thu, 21 Jun 2012 15:07:34 +0200
Message-ID: <4FE31C96.6050901@profihost.ag>
References: <4FE319DF.3020106@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:37760 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759567Ab2FUNHh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 09:07:37 -0400
In-Reply-To: <4FE319DF.3020106@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


When i start now the OSD again it seems to hang for forever. Load goes=20
up to 200 and I/O Waits rise vom 0% to 20%.

Am 21.06.2012 14:55, schrieb Stefan Priebe - Profihost AG:
> Hello list,
>
> i'm able to reproducably crash osd daemons.
>
> How i can reproduce:
>
> Kernel: 3.5.0-rc3
> Ceph: 0.47.3
> FS: btrfs
> Journal: 2GB tmpfs per OSD
> OSD: 3x servers with 4x Intel SSD OSDs each
> 10GBE Network
> rbd_cache_max_age: 2.0
> rbd_cache_size: 33554432
>
> Disk is set to writeback.
>
> Start a KVM VM via PXE with the disk attached in writeback mode.
>
> Then run randwrite stress more than 2 time. Mostly OSD 22 in my case
> crashes.
>
> # fio --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k =
--size=3D200G
> --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; fio
> --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=
=3D200G
> --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; fio
> --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k --size=
=3D200G
> --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; halt
>
> Strangely exactly THIS OSD also has the most log entries:
> 64K ceph-osd.20.log
> 64K ceph-osd.21.log
> 1,3M ceph-osd.22.log
> 64K ceph-osd.23.log
>
> But all OSDs are set to debug osd =3D 20.
>
> dmesg shows:
> ceph-osd[5381]: segfault at 3f592c000 ip 00007fa281d8eb23 sp
> 00007fa27702d260 error 4 in libtcmalloc.so.0.0.0[7fa281d6a000+3d000]
>
> I uploaded the following files:
> priebe_fio_randwrite_ceph-osd.21.log.bz2 =3D> OSD which was OK and di=
dn't
> crash
> priebe_fio_randwrite_ceph-osd.22.log.bz2 =3D> Log from the crashed OS=
D
> =FCu
> priebe_fio_randwrite_core.ssdstor001.27204.bz2 =3D> Core dump
> priebe_fio_randwrite_ceph-osd.bz2 =3D> osd binary
>
> Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
