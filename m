From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: reproducable osd crash
Date: Fri, 22 Jun 2012 08:43:10 +0200
Message-ID: <B37E1F82-25E3-4ED4-B3E9-59BC2EC44CB6@profihost.ag>
References: <4FE319DF.3020106@profihost.ag>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:55617 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab2FVGnP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 02:43:15 -0400
In-Reply-To: <4FE319DF.3020106@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Does anybody have an idea? This is right now a showstopper to me.

Am 21.06.2012 um 14:55 schrieb Stefan Priebe - Profihost AG <s.priebe@p=
rofihost.ag>:

> Hello list,
>=20
> i'm able to reproducably crash osd daemons.
>=20
> How i can reproduce:
>=20
> Kernel: 3.5.0-rc3
> Ceph: 0.47.3
> FS: btrfs
> Journal: 2GB tmpfs per OSD
> OSD: 3x servers with 4x Intel SSD OSDs each
> 10GBE Network
> rbd_cache_max_age: 2.0
> rbd_cache_size: 33554432
>=20
> Disk is set to writeback.
>=20
> Start a KVM VM via PXE with the disk attached in writeback mode.
>=20
> Then run randwrite stress more than 2 time. Mostly OSD 22 in my case =
crashes.
>=20
> # fio --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k =
--size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=3D=
file1; fio --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D=
4k --size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting --name=
=3Dfile1; fio --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=
=3D4k --size=3D200G --numjobs=3D50 --runtime=3D90 --group_reporting --n=
ame=3Dfile1; halt
>=20
> Strangely exactly THIS OSD also has the most log entries:
> 64K     ceph-osd.20.log
> 64K     ceph-osd.21.log
> 1,3M    ceph-osd.22.log
> 64K     ceph-osd.23.log
>=20
> But all OSDs are set to debug osd =3D 20.
>=20
> dmesg shows:
> ceph-osd[5381]: segfault at 3f592c000 ip 00007fa281d8eb23 sp 00007fa2=
7702d260 error 4 in libtcmalloc.so.0.0.0[7fa281d6a000+3d000]
>=20
> I uploaded the following files:
> priebe_fio_randwrite_ceph-osd.21.log.bz2 =3D> OSD which was OK and di=
dn't crash
> priebe_fio_randwrite_ceph-osd.22.log.bz2 =3D> Log from the crashed OS=
D
> =C3=BCu
> priebe_fio_randwrite_core.ssdstor001.27204.bz2 =3D> Core dump
> priebe_fio_randwrite_ceph-osd.bz2 =3D> osd binary
>=20
> Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
