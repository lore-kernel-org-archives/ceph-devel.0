From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: slow fio random read benchmark, need help
Date: Wed, 31 Oct 2012 18:22:22 +0100 (CET)
Message-ID: <c8213ed0-5a34-4dc3-9d30-4e29d59e1ee3@mailpro>
References: <CAMiztYLY364EXVQu6d6+He-FXd_AsDOqxkTO_DzKk24iJjwTcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:49070 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab2JaRWw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 13:22:52 -0400
In-Reply-To: <CAMiztYLY364EXVQu6d6+He-FXd_AsDOqxkTO_DzKk24iJjwTcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I use a small file size (1G), to be sure it can be handle in buffer. (I=
 don't see any read access on disks with iostat during the test)
But I think the problem is not the disk hardware ios, but a bottleneck =
somewhere in the ceph protocol
(All benchs I have see in the ceph mailing never reach more than 20.000=
 iops with full ssd ceph cluster and bigger cpus)

>>If you can get 40K random read IOPS out of 18 spindles, I=20
>>have to ask why you think most of those operations made=20
>>it to disk. It sounds to me like they were being satisfied=20
>>out of cache.=20

(40k was on zfs san, handle in zfs arc memory buffer, so no read access=
 on disk too)


>>Are you sure that fio is doing what you think it is doing?=20
Yes, sure, I have already bench a lot of san array with fio.
I have also done same test with a sheepdog cluster (same hardware), I c=
an reach 20.000-30.000io/s if the buffer cache is big enough.



I would like to know where is the bottleneck, before build an ceph clus=
ter with more powerfull servers and full ssds osd.


Does Intank have some random read/write io benchmarks ? =20
(I see a lot of sequential benchs with high bandwith results, but not s=
o much random io/s results)


Regards,

Alexandre

----- Mail original -----=20

De: "Mark Kampe" <mark.kampe@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>=20
Envoy=C3=A9: Mercredi 31 Octobre 2012 17:56:26=20
Objet: Re: slow fio random read benchmark, need help=20

I'm a little confused by the math here:=20

15K RPM =3D 250 rotations/second=20
3 hosts * 6 OSDs/host =3D 18 spindles=20
18 spindles * 250 rotations/second =3D 4500 tracks/second (sans seeks)=20

4K direct random reads against large files should have negligible=20
cache hits. But large numbers of parallel operations (greater=20
iodepth) may give us multiple (coincidental) reads per track,=20
which could push us a little above one read per track, and=20
enable some good head scheduling (keeping the seeks small)=20
but even so the seeks are probably going to cut that number=20
by half or worse.=20

If you can get 40K random read IOPS out of 18 spindles, I=20
have to ask why you think most of those operations made=20
it to disk. It sounds to me like they were being satisfied=20
out of cache.=20

Are you sure that fio is doing what you think it is doing?=20


On Wed, Oct 31, 2012 at 9:29 AM, Alexandre DERUMIER < aderumier@odiso.c=
om > wrote:=20



>>Have you tried increasing the iodepth?=20
Yes, I have try with 100 and 200, same results.=20

I have also try directly from the host, with /dev/rbd1, and I have same=
 result.=20
I have also try with 3 differents hosts, with differents cpus models.=20

(note: I can reach around 40.000 iops with same fio config on a zfs isc=
si array)=20

My test ceph cluster nodes cpus are old (xeon E5420), but they are arou=
nd 10% usage, so I think it's ok.=20


Do you have an idea if I can trace something ?=20

Thanks,=20

Alexandre=20

----- Mail original -----=20

De: "Sage Weil" < sage@inktank.com >=20
=C3=80: "Alexandre DERUMIER" < aderumier@odiso.com >=20
Cc: "ceph-devel" < ceph-devel@vger.kernel.org >=20
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
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20





--=20
Mark.Kampe@inktank.com=20
VP, Engineering=20
Mobile: +1-213-400-8857=20
Office: +1-323-375-3863=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
