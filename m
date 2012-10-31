From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 17:29:28 +0100 (CET)
Message-ID: <97eeb8be-85a7-4309-b02c-e5d4f5b0f151@mailpro>
References: <alpine.DEB.2.00.1210310856420.10356@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:41512 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab2JaQ37 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 12:29:59 -0400
In-Reply-To: <alpine.DEB.2.00.1210310856420.10356@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

>>Have you tried increasing the iodepth?=20
Yes, I have try with 100 and 200, same results.

I have also try directly from the host, with /dev/rbd1, and I have same=
 result.
I have also try with 3 differents hosts, with differents cpus models.

(note: I can reach around 40.000 iops with same fio config on a zfs isc=
si array)

My test ceph cluster nodes cpus are old (xeon E5420), but they are arou=
nd 10% usage, so I think it's ok.


Do you have an idea if I can trace something ?

Thanks,

Alexandre

----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 31 Octobre 2012 16:57:05=20
Objet: Re: slow fio random read benchmark, need help=20

On Wed, 31 Oct 2012, Alexandre DERUMIER wrote:=20
> Hello,=20
>=20
> I'm doing some tests with fio from a qemu 1.2 guest (virtio disk,cach=
e=3Dnone), randread, with 4K block size on a small size of 1G (so it ca=
n be handle by the buffer cache on ceph cluster)=20
>=20
>=20
> fio --filename=3D/dev/vdb -rw=3Drandread --bs=3D4K --size=3D1000M --i=
odepth=3D40 --group_reporting --name=3Dfile1 --ioengine=3Dlibaio --dire=
ct=3D1=20
>=20
>=20
> I can't get more than 5000 iops.=20

Have you tried increasing the iodepth?=20

sage=20

>=20
>=20
> RBD cluster is :=20
> ---------------=20
> 3 nodes,with each node :=20
> -6 x osd 15k drives (xfs), journal on tmpfs, 1 mon=20
> -cpu: 2x 4 cores intel xeon E5420@2.5GHZ=20
> rbd 0.53=20
>=20
> ceph.conf=20
>=20
> journal dio =3D false=20
> filestore fiemap =3D false=20
> filestore flusher =3D false=20
> osd op threads =3D 24=20
> osd disk threads =3D 24=20
> filestore op threads =3D 6=20
>=20
> kvm host is : 4 x 12 cores opteron=20
> ------------=20
>=20
>=20
> During the bench:=20
>=20
> on ceph nodes:=20
> - cpu is around 10% used=20
> - iostat show no disks activity on osds. (so I think that the 1G file=
 is handle in the linux buffer)=20
>=20
>=20
> on kvm host:=20
>=20
> -cpu is around 20% used=20
>=20
>=20
> I really don't see where is the bottleneck....=20
>=20
> Any Ideas, hints ?=20
>=20
>=20
> Regards,=20
>=20
> Alexandre=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
