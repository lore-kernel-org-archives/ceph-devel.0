From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: RBD performance - tuning hints
Date: Thu, 30 Aug 2012 18:02:05 +0200
Message-ID: <20120830160205.GD32184@oder.kd-bie.de>
References: <20120830153342.GC32184@oder.kd-bie.de>
 <3c89c8b9-5c18-4bf8-8650-bb6b5d11e12c@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:34031 "EHLO
	smtpa1.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2H3QDN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 12:03:13 -0400
Content-Disposition: inline
In-Reply-To: <3c89c8b9-5c18-4bf8-8650-bb6b5d11e12c@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>

On Thu, Aug 30, 2012 at 05:46:35PM +0200, Alexandre DERUMIER wrote:
> Thanks
>=20
> >> 8x SSD, 200GB each=20
>=20
> 20000 iops seem pretty low,no ?
well, you have to compare
- pure a SSD (via PCIe or SAS-6G)	vs.
- Ceph-Journal, which goes 2x over 10GbE with IP
  Client -> primary-copy -> 2nd-copy
  (=3D redundancy over Ethernet distance)

I'm curious about the answer from Inktank,

-Dieter

>=20
>=20
> for @intank:
>=20
> Is their a bottleneck somewhere in ceph ?
Maybe "SimpleMessenger dispatching: cause of performance problems?"
from Thu, 16 Aug 2012 18:08:39 +0200
by <andreas.bluemle@itxperts.de>
can be an answer.
Especially if a small number of OSDs is used.

>=20
> I said that, because I would like to know if it's scale by adding new=
 nodes.
>=20
> Does Intank have already done some random iops benchmark ? (I always =
see sequential throughput bench in the mailing list)
>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org=20
> Envoy=E9: Jeudi 30 Ao=FBt 2012 17:33:42=20
> Objet: Re: RBD performance - tuning hints=20
>=20
> On Thu, Aug 30, 2012 at 05:28:02PM +0200, Alexandre DERUMIER wrote:=20
> > Thanks for the report !=20
> >=20
> > vs your first benchmark, it's with RBD 4M or 64K ?=20
> with 4MB (see attached config info)=20
>=20
> Cheers,=20
> -Dieter=20
>=20
> >=20
> > (how much ssd by node?)=20
> 8x SSD, 200GB each=20
>=20
> >=20
> >=20
> >=20
> > ----- Mail original -----=20
> >=20
> > De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> > =C0: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> > Cc: ceph-devel@vger.kernel.org=20
> > Envoy=E9: Jeudi 30 Ao=FBt 2012 16:56:34=20
> > Objet: Re: RBD performance - tuning hints=20
> >=20
> > Hi Alexandre,=20
> >=20
> > with the 4 filestore parameter below some fio values could be incre=
ased:=20
> > filestore max sync interval =3D 30=20
> > filestore min sync interval =3D 29=20
> > filestore flusher =3D false=20
> > filestore queue max ops =3D 10000=20
> >=20
> > ###### IOPS=20
> > fio_read_4k_64: 9373=20
> > fio_read_4k_128: 9939=20
> > fio_randwrite_8k_16: 12376=20
> > fio_randwrite_4k_16: 13315=20
> > fio_randwrite_512_32: 13660=20
> > fio_randwrite_8k_32: 17318=20
> > fio_randwrite_4k_32: 18057=20
> > fio_randwrite_8k_64: 19693=20
> > fio_randwrite_512_64: 20015 <<<=20
> > fio_randwrite_4k_64: 20024 <<<=20
> > fio_randwrite_8k_128: 20547 <<<=20
> > fio_randwrite_4k_128: 20839 <<<=20
> > fio_randwrite_512_128: 21417 <<<=20
> > fio_randread_8k_128: 48872=20
> > fio_randread_4k_128: 50002=20
> > fio_randread_512_128: 51202=20
> >=20
> > ###### MB/s=20
> > fio_randread_2m_32: 628=20
> > fio_read_4m_64: 630=20
> > fio_randread_8m_32: 633=20
> > fio_read_2m_32: 637=20
> > fio_read_4m_16: 640=20
> > fio_randread_4m_16: 652=20
> > fio_write_2m_32: 660=20
> > fio_randread_4m_32: 677=20
> > fio_read_4m_32: 678=20
> > (...)=20
> > fio_write_4m_64: 771=20
> > fio_randwrite_2m_64: 789=20
> > fio_write_8m_128: 796=20
> > fio_write_4m_32: 802=20
> > fio_randwrite_4m_128: 807 <<<=20
> > fio_randwrite_2m_32: 811 <<<=20
> > fio_write_2m_128: 833 <<<=20
> > fio_write_8m_64: 901 <<<=20
> >=20
> > Best Regards,=20
> > -Dieter=20
> >=20
> >=20
> > On Wed, Aug 29, 2012 at 10:50:12AM +0200, Alexandre DERUMIER wrote:=
=20
> > > Nice results !=20
> > > (can you make same benchmark from a qemu-kvm guest with virtio-dr=
iver ?=20
> > > I have made some bench some month ago with stephan priebe, and we=
 never be able to have more than 20000iops, with a full ssd 3nodes clus=
ter)=20
> > >=20
> > > >>How can I set the variables when the Journal data have go to th=
e OSD ? (after X seconds and/or when Y %-full)=20
> > > I think you can try to tune these values=20
> > >=20
> > > filestore max sync interval =3D 30=20
> > > filestore min sync interval =3D 29=20
> > > filestore flusher =3D false=20
> > > filestore queue max ops =3D 10000=20
> > >=20
> > >=20
> > >=20
> > > ----- Mail original -----=20
> > >=20
> > > De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> > > =C0: ceph-devel@vger.kernel.org=20
> > > Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>=20
> > > Envoy=E9: Mardi 28 Ao=FBt 2012 19:48:42=20
> > > Objet: RBD performance - tuning hints=20
> > >=20
> > > Hi,=20
> > >=20
> > > on my 4-node system (SSD + 10GbE, see bench-config.txt for detail=
s)=20
> > > I can observe a pretty nice rados bench performance=20
> > > (see bench-rados.txt for details):=20
> > >=20
> > > Bandwidth (MB/sec): 961.710=20
> > > Max bandwidth (MB/sec): 1040=20
> > > Min bandwidth (MB/sec): 772=20
> > >=20
> > >=20
> > > Also the bandwidth performance generated with=20
> > > fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs --s=
ize=3D2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --grou=
p_reporting --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}=20
> > >=20
> > > .... is acceptable, e.g.=20
> > > fio_write_4m_16 795 MB/s=20
> > > fio_randwrite_8m_128 717 MB/s=20
> > > fio_randwrite_8m_16 714 MB/s=20
> > > fio_randwrite_2m_32 692 MB/s=20
> > >=20
> > >=20
> > > But, the write IOPS seems to be limited around 19k ...=20
> > > RBD 4M 64k (=3D optimal_io_size)=20
> > > fio_randread_512_128 53286 55925=20
> > > fio_randread_4k_128 51110 44382=20
> > > fio_randread_8k_128 30854 29938=20
> > > fio_randwrite_512_128 18888 2386=20
> > > fio_randwrite_512_64 18844 2582=20
> > > fio_randwrite_8k_64 17350 2445=20
> > > (...)=20
> > > fio_read_4k_128 10073 53151=20
> > > fio_read_4k_64 9500 39757=20
> > > fio_read_4k_32 9220 23650=20
> > > (...)=20
> > > fio_read_4k_16 9122 14322=20
> > > fio_write_4k_128 2190 14306=20
> > > fio_read_8k_32 706 13894=20
> > > fio_write_4k_64 2197 12297=20
> > > fio_write_8k_64 3563 11705=20
> > > fio_write_8k_128 3444 11219=20
> > >=20
> > >=20
> > > Any hints for tuning the IOPS (read and/or write) would be apprec=
iated.=20
> > >=20
> > > How can I set the variables when the Journal data have go to the =
OSD ? (after X seconds and/or when Y %-full)=20
> > >=20
> > >=20
> > > Kind Regards,=20
> > > -Dieter=20
> > >=20
> > >=20
> > >=20
> > > --=20
> > >=20
> > > --=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > Alexandre D e rumier=20
> > >=20
> > > Ing=E9nieur Syst=E8mes et R=E9seaux=20
> > >=20
> > >=20
> > > Fixe : 03 20 68 88 85=20
> > >=20
> > > Fax : 03 20 68 90 88=20
> > >=20
> > >=20
> > > 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix=20
> > > 12 rue Marivaux 75002 Paris=20
> > > --=20
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in=20
> > > the body of a message to majordomo@vger.kernel.org=20
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html=
=20
> >=20
> >=20
> >=20
> >=20
> > --=20
> >=20
> > --=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > Alexandre D e rumier=20
> >=20
> > Ing=E9nieur Syst=E8mes et R=E9seaux=20
> >=20
> >=20
> > Fixe : 03 20 68 88 85=20
> >=20
> > Fax : 03 20 68 90 88=20
> >=20
> >=20
> > 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix=20
> > 12 rue Marivaux 75002 Paris=20
> >=20
>=20
>=20
>=20
> --=20
>=20
> --=20
>=20
>=20
>=20
> =09
>=20
> Alexandre D e rumier=20
>=20
> Ing=E9nieur Syst=E8mes et R=E9seaux=20
>=20
>=20
> Fixe : 03 20 68 88 85=20
>=20
> Fax : 03 20 68 90 88=20
>=20
>=20
> 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix=20
> 12 rue Marivaux 75002 Paris=20
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
