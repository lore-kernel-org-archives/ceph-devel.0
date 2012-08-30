From: Dieter Kasper <d.kasper@kabelmail.de>
Subject: Re: RBD performance - tuning hints
Date: Thu, 30 Aug 2012 18:48:59 +0200
Message-ID: <20120830164859.GE32184@oder.kd-bie.de>
References: <20120830160205.GD32184@oder.kd-bie.de>
 <5831c8ed-f98d-45f9-8837-178cee74fa9f@mailpro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5/uDoXvLw7AC5HRs"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtpa1.mediabeam.com ([194.25.41.13]:47837 "EHLO
	smtpa2.mediabeam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab2H3QuE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 12:50:04 -0400
Content-Disposition: inline
In-Reply-To: <5831c8ed-f98d-45f9-8837-178cee74fa9f@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtpa.mediabeam.com id q7UGnwOq031137

On Thu, Aug 30, 2012 at 06:12:11PM +0200, Alexandre DERUMIER wrote:
> >>well, you have to compare
> >>- pure a SSD (via PCIe or SAS-6G)        vs.
> >>- Ceph-Journal, which goes 2x over 10GbE with IP
> >>  Client -> primary-copy -> 2nd-copy
> >>  (=3D redundancy over Ethernet distance)
>=20
> Sure but the first osd ack to the client,before replicating to the othe=
rs osd.
no=20

>=20
> Client -> primary-copy -> 2nd-copy
>        <-ack
>          primary-copy -> 2nd-copy
>                       -> 3st-copy
>=20
> Or I'm wrong ?
yes,
please have a look at the attached file: ceph-replication-acks.png
The client usually will continue on 'ACK' and not wait for the 'commit'.

BTW. all my journals are in RAM (/dev/ramX)
32x 2GB =3D 32GB of data with replica 2x

If "filestore min/max sync interval" is set to 99999999
data should 'never' be written to OSD
('never' at least during the tests if the written data is < 32GB)

In such a configuration only the Ceph-Code and the Interconnect (10GbE/IP=
) would be the brakeman.

Cheers,
-Dieter


>=20
>=20
> ----- Mail original -----=20
>=20
> De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org, "Andreas Bluemle" <andreas.bluemle@itxp=
erts.de>=20
> Envoy=E9: Jeudi 30 Ao=FBt 2012 18:02:05=20
> Objet: Re: RBD performance - tuning hints=20
>=20
> On Thu, Aug 30, 2012 at 05:46:35PM +0200, Alexandre DERUMIER wrote:=20
> > Thanks=20
> >=20
> > >> 8x SSD, 200GB each=20
> >=20
> > 20000 iops seem pretty low,no ?=20
> well, you have to compare=20
> - pure a SSD (via PCIe or SAS-6G) vs.=20
> - Ceph-Journal, which goes 2x over 10GbE with IP=20
> Client -> primary-copy -> 2nd-copy=20
> (=3D redundancy over Ethernet distance)=20
>=20
> I'm curious about the answer from Inktank,=20
>=20
> -Dieter=20
>=20
> >=20
> >=20
> > for @intank:=20
> >=20
> > Is their a bottleneck somewhere in ceph ?=20
> Maybe "SimpleMessenger dispatching: cause of performance problems?"=20
> from Thu, 16 Aug 2012 18:08:39 +0200=20
> by <andreas.bluemle@itxperts.de>=20
> can be an answer.=20
> Especially if a small number of OSDs is used.=20
>=20
> >=20
> > I said that, because I would like to know if it's scale by adding new=
 nodes.=20
> >=20
> > Does Intank have already done some random iops benchmark ? (I always =
see sequential throughput bench in the mailing list)=20
> >=20
> >=20
> > ----- Mail original -----=20
> >=20
> > De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> > =C0: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> > Cc: ceph-devel@vger.kernel.org=20
> > Envoy=E9: Jeudi 30 Ao=FBt 2012 17:33:42=20
> > Objet: Re: RBD performance - tuning hints=20
> >=20
> > On Thu, Aug 30, 2012 at 05:28:02PM +0200, Alexandre DERUMIER wrote:=20
> > > Thanks for the report !=20
> > >=20
> > > vs your first benchmark, it's with RBD 4M or 64K ?=20
> > with 4MB (see attached config info)=20
> >=20
> > Cheers,=20
> > -Dieter=20
> >=20
> > >=20
> > > (how much ssd by node?)=20
> > 8x SSD, 200GB each=20
> >=20
> > >=20
> > >=20
> > >=20
> > > ----- Mail original -----=20
> > >=20
> > > De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> > > =C0: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> > > Cc: ceph-devel@vger.kernel.org=20
> > > Envoy=E9: Jeudi 30 Ao=FBt 2012 16:56:34=20
> > > Objet: Re: RBD performance - tuning hints=20
> > >=20
> > > Hi Alexandre,=20
> > >=20
> > > with the 4 filestore parameter below some fio values could be incre=
ased:=20
> > > filestore max sync interval =3D 30=20
> > > filestore min sync interval =3D 29=20
> > > filestore flusher =3D false=20
> > > filestore queue max ops =3D 10000=20
> > >=20
> > > ###### IOPS=20
> > > fio_read_4k_64: 9373=20
> > > fio_read_4k_128: 9939=20
> > > fio_randwrite_8k_16: 12376=20
> > > fio_randwrite_4k_16: 13315=20
> > > fio_randwrite_512_32: 13660=20
> > > fio_randwrite_8k_32: 17318=20
> > > fio_randwrite_4k_32: 18057=20
> > > fio_randwrite_8k_64: 19693=20
> > > fio_randwrite_512_64: 20015 <<<=20
> > > fio_randwrite_4k_64: 20024 <<<=20
> > > fio_randwrite_8k_128: 20547 <<<=20
> > > fio_randwrite_4k_128: 20839 <<<=20
> > > fio_randwrite_512_128: 21417 <<<=20
> > > fio_randread_8k_128: 48872=20
> > > fio_randread_4k_128: 50002=20
> > > fio_randread_512_128: 51202=20
> > >=20
> > > ###### MB/s=20
> > > fio_randread_2m_32: 628=20
> > > fio_read_4m_64: 630=20
> > > fio_randread_8m_32: 633=20
> > > fio_read_2m_32: 637=20
> > > fio_read_4m_16: 640=20
> > > fio_randread_4m_16: 652=20
> > > fio_write_2m_32: 660=20
> > > fio_randread_4m_32: 677=20
> > > fio_read_4m_32: 678=20
> > > (...)=20
> > > fio_write_4m_64: 771=20
> > > fio_randwrite_2m_64: 789=20
> > > fio_write_8m_128: 796=20
> > > fio_write_4m_32: 802=20
> > > fio_randwrite_4m_128: 807 <<<=20
> > > fio_randwrite_2m_32: 811 <<<=20
> > > fio_write_2m_128: 833 <<<=20
> > > fio_write_8m_64: 901 <<<=20
> > >=20
> > > Best Regards,=20
> > > -Dieter=20
> > >=20
> > >=20
> > > On Wed, Aug 29, 2012 at 10:50:12AM +0200, Alexandre DERUMIER wrote:=
=20
> > > > Nice results !=20
> > > > (can you make same benchmark from a qemu-kvm guest with virtio-dr=
iver ?=20
> > > > I have made some bench some month ago with stephan priebe, and we=
 never be able to have more than 20000iops, with a full ssd 3nodes cluste=
r)=20
> > > >=20
> > > > >>How can I set the variables when the Journal data have go to th=
e OSD ? (after X seconds and/or when Y %-full)=20
> > > > I think you can try to tune these values=20
> > > >=20
> > > > filestore max sync interval =3D 30=20
> > > > filestore min sync interval =3D 29=20
> > > > filestore flusher =3D false=20
> > > > filestore queue max ops =3D 10000=20
> > > >=20
> > > >=20
> > > >=20
> > > > ----- Mail original -----=20
> > > >=20
> > > > De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> > > > =C0: ceph-devel@vger.kernel.org=20
> > > > Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>=20
> > > > Envoy=E9: Mardi 28 Ao=FBt 2012 19:48:42=20
> > > > Objet: RBD performance - tuning hints=20
> > > >=20
> > > > Hi,=20
> > > >=20
> > > > on my 4-node system (SSD + 10GbE, see bench-config.txt for detail=
s)=20
> > > > I can observe a pretty nice rados bench performance=20
> > > > (see bench-rados.txt for details):=20
> > > >=20
> > > > Bandwidth (MB/sec): 961.710=20
> > > > Max bandwidth (MB/sec): 1040=20
> > > > Min bandwidth (MB/sec): 772=20
> > > >=20
> > > >=20
> > > > Also the bandwidth performance generated with=20
> > > > fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs --s=
ize=3D2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --group_=
reporting --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}=20
> > > >=20
> > > > .... is acceptable, e.g.=20
> > > > fio_write_4m_16 795 MB/s=20
> > > > fio_randwrite_8m_128 717 MB/s=20
> > > > fio_randwrite_8m_16 714 MB/s=20
> > > > fio_randwrite_2m_32 692 MB/s=20
> > > >=20
> > > >=20
> > > > But, the write IOPS seems to be limited around 19k ...=20
> > > > RBD 4M 64k (=3D optimal_io_size)=20
> > > > fio_randread_512_128 53286 55925=20
> > > > fio_randread_4k_128 51110 44382=20
> > > > fio_randread_8k_128 30854 29938=20
> > > > fio_randwrite_512_128 18888 2386=20
> > > > fio_randwrite_512_64 18844 2582=20
> > > > fio_randwrite_8k_64 17350 2445=20
> > > > (...)=20
> > > > fio_read_4k_128 10073 53151=20
> > > > fio_read_4k_64 9500 39757=20
> > > > fio_read_4k_32 9220 23650=20
> > > > (...)=20
> > > > fio_read_4k_16 9122 14322=20
> > > > fio_write_4k_128 2190 14306=20
> > > > fio_read_8k_32 706 13894=20
> > > > fio_write_4k_64 2197 12297=20
> > > > fio_write_8k_64 3563 11705=20
> > > > fio_write_8k_128 3444 11219=20
> > > >=20
> > > >=20
> > > > Any hints for tuning the IOPS (read and/or write) would be apprec=
iated.=20
> > > >=20
> > > > How can I set the variables when the Journal data have go to the =
OSD ? (after X seconds and/or when Y %-full)=20
> > > >=20
> > > >=20
> > > > Kind Regards,=20
> > > > -Dieter=20
> > > >=20
> > > >=20
> > > >=20
> > > > --=20
> > > >=20
> > > > --=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > >=20
> > > > Alexandre D e rumier=20
> > > >=20
> > > > Ing=E9nieur Syst=E8mes et R=E9seaux=20
> > > >=20
> > > >=20
> > > > Fixe : 03 20 68 88 85=20
> > > >=20
> > > > Fax : 03 20 68 90 88=20
> > > >=20
> > > >=20
> > > > 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix=20
> > > > 12 rue Marivaux 75002 Paris=20
> > > > --=20
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in=20
> > > > the body of a message to majordomo@vger.kernel.org=20
> > > > More majordomo info at http://vger.kernel.org/majordomo-info.html=
=20
> > >=20
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
> > >=20
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
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> > the body of a message to majordomo@vger.kernel.org=20
> > More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
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
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Principal Consultant, Data Center Storage Architecture and Technology
FTS CTO
FUJITSU TECHNOLOGY SOLUTIONS GMBH
Mies-van-der-Rohe-Stra=DFe 8 / 4F
80807 M=FCnchen
Germany

Telephone:      +49 89 62060     1898
Telefax:	+49 89 62060 329 1898
Mobile: 	+49 170 8563173
Email:  	dieter.kasper@ts.fujitsu.com
Internet:       http://ts.fujitsu.com
Company Details: http://ts.fujitsu.com/imprint.html

--5/uDoXvLw7AC5HRs
Content-Type: image/png
Content-Disposition: attachment; filename="ceph-replication-acks.png"
Content-Transfer-Encoding: base64

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

--5/uDoXvLw7AC5HRs--

