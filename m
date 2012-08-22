From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Ceph performance improvement
Date: Wed, 22 Aug 2012 14:42:50 +0200 (CEST)
Message-ID: <ea767064-49c4-404f-97f5-73f53f739214@mailpro>
References: <5034D210.8060109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:35576 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932386Ab2HVMuG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 08:50:06 -0400
In-Reply-To: <5034D210.8060109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org, Denis Fondras <ceph@ledeuns.net>

>>Not sure what version of glibc Wheezy has, but try to make sure you h=
ave=20
>>one that supports syncfs (you'll also need a semi-new kernel, 3.0+=20
>>should be fine).=20

Hi, glibc from wheezy don't have syncfs support.

----- Mail original -----=20

De: "Mark Nelson" <mark.nelson@inktank.com>=20
=C3=80: "Denis Fondras" <ceph@ledeuns.net>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 22 Ao=C3=BBt 2012 14:35:28=20
Objet: Re: Ceph performance improvement=20

On 08/22/2012 03:54 AM, Denis Fondras wrote:=20
> Hello all,=20

Hello!=20

David had some good comments in his reply, so I'll just add in a couple=
=20
of extra thoughts...=20

>=20
> I'm currently testing Ceph. So far it seems that HA and recovering ar=
e=20
> very good.=20
> The only point that prevents my from using it at datacenter-scale is=20
> performance.=20
>=20
> First of all, here is my setup :=20
> - 1 OSD/MDS/MON on a Supermicro X9DR3-F/X9DR3-F (1x Intel Xeon E5-260=
3 -=20
> 4 cores and 8GB RAM) running Debian Sid/Wheezy and Ceph version 0.49=20

Not sure what version of glibc Wheezy has, but try to make sure you hav=
e=20
one that supports syncfs (you'll also need a semi-new kernel, 3.0+=20
should be fine).=20

> (commit:ca6265d0f4d68a5eb82b5bfafb450e8e696633ac). It has 1x 320GB dr=
ive=20
> for the system, 1x 64GB SSD (Crucial C300 - /dev/sda) for the journal=
=20
> and 4x 3TB drive (Western Digital WD30EZRX). Everything but the boot=20
> partition is BTRFS-formated and 4K-aligned.=20
> - 1 client (P4 3.00GHz dual-core, 1GB RAM) running Debian Sid/Wheezy =
and=20
> Ceph version 0.49 (commit:ca6265d0f4d68a5eb82b5bfafb450e8e696633ac).=20
> Both servers are linked over a 1Gb Ethernet switch (iperf shows about=
=20
> 960Mb/s).=20
>=20
> Here is my ceph.conf :=20
> ------cut-here------=20
> [global]=20
> auth supported =3D cephx=20
> keyring =3D /etc/ceph/keyring=20
> journal dio =3D true=20
> osd op threads =3D 24=20
> osd disk threads =3D 24=20
> filestore op threads =3D 6=20
> filestore queue max ops =3D 24=20
> osd client message size cap =3D 14000000=20
> ms dispatch throttle bytes =3D 17500000=20
>=20

default values are quite a bit lower for most of these. You may want to=
=20
play with them and see if it has an effect.=20

> [mon]=20
> mon data =3D /home/mon.$id=20
> keyring =3D /etc/ceph/keyring.$name=20
>=20
> [mon.a]=20
> host =3D ceph-osd-0=20
> mon addr =3D 192.168.0.132:6789=20
>=20
> [mds]=20
> keyring =3D /etc/ceph/keyring.$name=20
>=20
> [mds.a]=20
> host =3D ceph-osd-0=20
>=20
> [osd]=20
> osd data =3D /home/osd.$id=20
> osd journal =3D /home/osd.$id.journal=20
> osd journal size =3D 1000=20
> keyring =3D /etc/ceph/keyring.$name=20
>=20
> [osd.0]=20
> host =3D ceph-osd-0=20
> btrfs devs =3D /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152=
201=20
> btrfs options =3D rw,noatime=20

Just fyi, we are trying to get away from btrfs devs.=20

> ------cut-here------=20
>=20
> Here are some figures :=20
> * Test with "dd" on the OSD server (on drive=20
> /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201) :=20
> # dd if=3D/dev/zero of=3Dtestdd bs=3D4k count=3D4M=20
> 17179869184 bytes (17 GB) written, 123,746 s, 139 MB/s=20

Good job using a data file that is much bigger than main memory! That=20
looks pretty accurate for a 7200rpm spinning disk. For dd benchmarks,=20
you should probably throw in conv=3Dfdatasync at the end though.=20

>=20
> =3D> iostat (on the OSD server) :=20
> avg-cpu: %user %nice %system %iowait %steal %idle=20
> 0,00 0,00 0,52 41,99 0,00 57,48=20
>=20
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn=20
> sdf 247,00 0,00 125520,00 0 125520=20
>=20
> * Test with unpacking and deleting OpenBSD/5.1 src.tar.gz to the OSD=20
> server (on drive=20
> /dev/disk/by-id/scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201) :=20
> # time tar xzf src.tar.gz=20
> real 0m9.669s=20
> user 0m8.405s=20
> sys 0m4.736s=20
>=20
> # time rm -rf *=20
> real 0m3.647s=20
> user 0m0.036s=20
> sys 0m3.552s=20
>=20
> =3D> iostat (on the OSD server) :=20
> avg-cpu: %user %nice %system %iowait %steal %idle=20
> 10,83 0,00 28,72 16,62 0,00 43,83=20
>=20
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn=20
> sdf 1369,00 0,00 9300,00 0 9300=20
>=20
> * Test with "dd" from the client using RBD :=20
> # dd if=3D/dev/zero of=3Dtestdd bs=3D4k count=3D4M=20
> 17179869184 bytes (17 GB) written, 406,941 s, 42,2 MB/s=20

RBD caching should definitely be enabled for a test like this. I'd be=20
surprised if you got 42MB/s without it though...=20

>=20
> =3D> iostat (on the OSD server) :=20
> avg-cpu: %user %nice %system %iowait %steal %idle=20
> 4,57 0,00 30,46 27,66 0,00 37,31=20
>=20
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn=20
> sda 317,00 0,00 57400,00 0 57400=20
> sdf 237,00 0,00 88336,00 0 88336=20
>=20
> * Test with unpacking and deleting OpenBSD/5.1 src.tar.gz from the=20
> client using RBD :=20
> # time tar xzf src.tar.gz=20
> real 0m26.955s=20
> user 0m9.233s=20
> sys 0m11.425s=20
>=20
> # time rm -rf *=20
> real 0m8.545s=20
> user 0m0.128s=20
> sys 0m8.297s=20
>=20
> =3D> iostat (on the OSD server) :=20
> avg-cpu: %user %nice %system %iowait %steal %idle=20
> 4,59 0,00 24,74 30,61 0,00 40,05=20
>=20
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn=20
> sda 239,00 0,00 54772,00 0 54772=20
> sdf 441,00 0,00 50836,00 0 50836=20
>=20
> * Test with "dd" from the client using CephFS :=20
> # dd if=3D/dev/zero of=3Dtestdd bs=3D4k count=3D4M=20
> 17179869184 bytes (17 GB) written, 338,29 s, 50,8 MB/s=20
>=20
> =3D> iostat (on the OSD server) :=20
> avg-cpu: %user %nice %system %iowait %steal %idle=20
> 2,26 0,00 20,30 27,07 0,00 50,38=20
>=20
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn=20
> sda 710,00 0,00 58836,00 0 58836=20
> sdf 722,00 0,00 32768,00 0 32768=20
>=20
>=20
> * Test with unpacking and deleting OpenBSD/5.1 src.tar.gz from the=20
> client using CephFS :=20
> # time tar xzf src.tar.gz=20
> real 3m55.260s=20
> user 0m8.721s=20
> sys 0m11.461s=20
>=20

Ouch, that's taking a while! In addition to the comments that David=20
made, be aware that you are also testing the metadata server with=20
cephFS. Right now that's not getting a lot of attention as we are=20
primarily focusing on RADOS performance at the moment. For this kind of=
=20
test though, distributed filesystems will never be as good as local dis=
ks...=20

> # time rm -rf *=20
> real 9m2.319s=20
> user 0m0.320s=20
> sys 0m4.572s=20
>=20
> =3D> iostat (on the OSD server) :=20
> avg-cpu: %user %nice %system %iowait %steal %idle=20
> 14,40 0,00 15,94 2,31 0,00 67,35=20
>=20
> Device: tps kB_read/s kB_wrtn/s kB_read kB_wrtn=20
> sda 174,00 0,00 10772,00 0 10772=20
> sdf 527,00 0,00 3636,00 0 3636=20
>=20
> =3D> from top :=20
> PID USER PR NI VIRT RES SHR S %CPU %MEM TIME+ COMMAND=20
> 4070 root 20 0 992m 237m 4384 S 90,5 3,0 18:40.50 ceph-osd=20
> 3975 root 20 0 777m 635m 4368 S 59,7 8,0 7:08.27 ceph-mds=20
>=20
>=20
> Adding an OSD doesn't change much of these figures (and it is always =
for=20
> a lower end when it does).=20

Are you putting both journals on the SSD when you add an OSD? If so,=20
what's the throughput your SSD can sustain?=20

> Neither does migrating the MON+MDS on the client machine.=20
>=20
> Are these figures right for this kind of hardware ? What could I try =
to=20
> make it a bit faster (essentially on the CephFS multiple little files=
=20
> side of things like uncompressing Linux kernel source or OpenBSD sour=
ces) ?=20
>=20
> I see figures of hundreds of megabits on some mailing-list threads, I=
'd=20
> really like to see this kind of numbers :D=20

With a single OSD and 1x replication on 10GbE I can sustain about=20
110MB/s with 4MB writes if the journal is on an alternate disk. I've=20
also got some hardware though that does much worse than that (I think=20
due to raid controller interference). 50MB/s does seem kind of low for=20
cephFS in your dd test.=20

You may want to check and see how big the IOs going to disk are on the=20
OSD node, and how quickly you are filling up the journal vs writing out=
=20
to disk. "collectl -sD -oT" will give you a nice report. Iostat can=20
probably tell you all of the same stuff with the right flags.=20

>=20
> Thank you in advance for any pointer,=20
> Denis=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20



--=20

--=20



=09

Alexandre D e rumier=20

Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20


=46ixe : 03 20 68 88 85=20

=46ax : 03 20 68 90 88=20


45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
12 rue Marivaux 75002 Paris=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
