From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD performance - tuning hints
Date: Fri, 31 Aug 2012 09:46:30 +0200 (CEST)
Message-ID: <1ab6cbb8-de0c-4d24-953b-98eced2f4ae2@mailpro>
References: <503F91EF.7020807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:52012 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab2HaHq5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 03:46:57 -0400
In-Reply-To: <503F91EF.7020807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Dieter Kasper <d.kasper@kabelmail.de>, ceph-devel@vger.kernel.org, Andreas Bluemle <andreas.bluemle@itxperts.de>

>>RBD waits for the data to be on disk on all replicas. It's pretty eas=
y
>>to relax this to in memory on all replicas, but there's no option for
>>that right now.

Ok, thanks, I miss that.

When you say disk, you mean journal ?



----- Mail original -----=20

De: "Josh Durgin" <josh.durgin@inktank.com>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "Dieter Kasper" <d.kasper@kabelmail.de>, ceph-devel@vger.kernel.org=
, "Andreas Bluemle" <andreas.bluemle@itxperts.de>=20
Envoy=C3=A9: Jeudi 30 Ao=C3=BBt 2012 18:16:47=20
Objet: Re: RBD performance - tuning hints=20

On 08/30/2012 09:12 AM, Alexandre DERUMIER wrote:=20
>>> well, you have to compare=20
>>> - pure a SSD (via PCIe or SAS-6G) vs.=20
>>> - Ceph-Journal, which goes 2x over 10GbE with IP=20
>>> Client -> primary-copy -> 2nd-copy=20
>>> (=3D redundancy over Ethernet distance)=20
>=20
> Sure but the first osd ack to the client,before replicating to the ot=
hers osd.=20
>=20
> Client -> primary-copy -> 2nd-copy=20
> <-ack=20
> primary-copy -> 2nd-copy=20
> -> 3st-copy=20
>=20
> Or I'm wrong ?=20

RBD waits for the data to be on disk on all replicas. It's pretty easy=20
to relax this to in memory on all replicas, but there's no option for=20
that right now.=20

Josh=20

>=20
> ----- Mail original -----=20
>=20
> De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
> Cc: ceph-devel@vger.kernel.org, "Andreas Bluemle" <andreas.bluemle@it=
xperts.de>=20
> Envoy=C3=A9: Jeudi 30 Ao=C3=BBt 2012 18:02:05=20
> Objet: Re: RBD performance - tuning hints=20
>=20
> On Thu, Aug 30, 2012 at 05:46:35PM +0200, Alexandre DERUMIER wrote:=20
>> Thanks=20
>>=20
>>>> 8x SSD, 200GB each=20
>>=20
>> 20000 iops seem pretty low,no ?=20
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
>>=20
>>=20
>> for @intank:=20
>>=20
>> Is their a bottleneck somewhere in ceph ?=20
> Maybe "SimpleMessenger dispatching: cause of performance problems?"=20
> from Thu, 16 Aug 2012 18:08:39 +0200=20
> by <andreas.bluemle@itxperts.de>=20
> can be an answer.=20
> Especially if a small number of OSDs is used.=20
>=20
>>=20
>> I said that, because I would like to know if it's scale by adding ne=
w nodes.=20
>>=20
>> Does Intank have already done some random iops benchmark ? (I always=
 see sequential throughput bench in the mailing list)=20
>>=20
>>=20
>> ----- Mail original -----=20
>>=20
>> De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
>> Cc: ceph-devel@vger.kernel.org=20
>> Envoy=C3=A9: Jeudi 30 Ao=C3=BBt 2012 17:33:42=20
>> Objet: Re: RBD performance - tuning hints=20
>>=20
>> On Thu, Aug 30, 2012 at 05:28:02PM +0200, Alexandre DERUMIER wrote:=20
>>> Thanks for the report !=20
>>>=20
>>> vs your first benchmark, it's with RBD 4M or 64K ?=20
>> with 4MB (see attached config info)=20
>>=20
>> Cheers,=20
>> -Dieter=20
>>=20
>>>=20
>>> (how much ssd by node?)=20
>> 8x SSD, 200GB each=20
>>=20
>>>=20
>>>=20
>>>=20
>>> ----- Mail original -----=20
>>>=20
>>> De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
>>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
>>> Cc: ceph-devel@vger.kernel.org=20
>>> Envoy=C3=A9: Jeudi 30 Ao=C3=BBt 2012 16:56:34=20
>>> Objet: Re: RBD performance - tuning hints=20
>>>=20
>>> Hi Alexandre,=20
>>>=20
>>> with the 4 filestore parameter below some fio values could be incre=
ased:=20
>>> filestore max sync interval =3D 30=20
>>> filestore min sync interval =3D 29=20
>>> filestore flusher =3D false=20
>>> filestore queue max ops =3D 10000=20
>>>=20
>>> ###### IOPS=20
>>> fio_read_4k_64: 9373=20
>>> fio_read_4k_128: 9939=20
>>> fio_randwrite_8k_16: 12376=20
>>> fio_randwrite_4k_16: 13315=20
>>> fio_randwrite_512_32: 13660=20
>>> fio_randwrite_8k_32: 17318=20
>>> fio_randwrite_4k_32: 18057=20
>>> fio_randwrite_8k_64: 19693=20
>>> fio_randwrite_512_64: 20015 <<<=20
>>> fio_randwrite_4k_64: 20024 <<<=20
>>> fio_randwrite_8k_128: 20547 <<<=20
>>> fio_randwrite_4k_128: 20839 <<<=20
>>> fio_randwrite_512_128: 21417 <<<=20
>>> fio_randread_8k_128: 48872=20
>>> fio_randread_4k_128: 50002=20
>>> fio_randread_512_128: 51202=20
>>>=20
>>> ###### MB/s=20
>>> fio_randread_2m_32: 628=20
>>> fio_read_4m_64: 630=20
>>> fio_randread_8m_32: 633=20
>>> fio_read_2m_32: 637=20
>>> fio_read_4m_16: 640=20
>>> fio_randread_4m_16: 652=20
>>> fio_write_2m_32: 660=20
>>> fio_randread_4m_32: 677=20
>>> fio_read_4m_32: 678=20
>>> (...)=20
>>> fio_write_4m_64: 771=20
>>> fio_randwrite_2m_64: 789=20
>>> fio_write_8m_128: 796=20
>>> fio_write_4m_32: 802=20
>>> fio_randwrite_4m_128: 807 <<<=20
>>> fio_randwrite_2m_32: 811 <<<=20
>>> fio_write_2m_128: 833 <<<=20
>>> fio_write_8m_64: 901 <<<=20
>>>=20
>>> Best Regards,=20
>>> -Dieter=20
>>>=20
>>>=20
>>> On Wed, Aug 29, 2012 at 10:50:12AM +0200, Alexandre DERUMIER wrote:=
=20
>>>> Nice results !=20
>>>> (can you make same benchmark from a qemu-kvm guest with virtio-dri=
ver ?=20
>>>> I have made some bench some month ago with stephan priebe, and we =
never be able to have more than 20000iops, with a full ssd 3nodes clust=
er)=20
>>>>=20
>>>>>> How can I set the variables when the Journal data have go to the=
 OSD ? (after X seconds and/or when Y %-full)=20
>>>> I think you can try to tune these values=20
>>>>=20
>>>> filestore max sync interval =3D 30=20
>>>> filestore min sync interval =3D 29=20
>>>> filestore flusher =3D false=20
>>>> filestore queue max ops =3D 10000=20
>>>>=20
>>>>=20
>>>>=20
>>>> ----- Mail original -----=20
>>>>=20
>>>> De: "Dieter Kasper" <d.kasper@kabelmail.de>=20
>>>> =C3=80: ceph-devel@vger.kernel.org=20
>>>> Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>=20
>>>> Envoy=C3=A9: Mardi 28 Ao=C3=BBt 2012 19:48:42=20
>>>> Objet: RBD performance - tuning hints=20
>>>>=20
>>>> Hi,=20
>>>>=20
>>>> on my 4-node system (SSD + 10GbE, see bench-config.txt for details=
)=20
>>>> I can observe a pretty nice rados bench performance=20
>>>> (see bench-rados.txt for details):=20
>>>>=20
>>>> Bandwidth (MB/sec): 961.710=20
>>>> Max bandwidth (MB/sec): 1040=20
>>>> Min bandwidth (MB/sec): 772=20
>>>>=20
>>>>=20
>>>> Also the bandwidth performance generated with=20
>>>> fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs --si=
ze=3D2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --group=
_reporting --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}=20
>>>>=20
>>>> .... is acceptable, e.g.=20
>>>> fio_write_4m_16 795 MB/s=20
>>>> fio_randwrite_8m_128 717 MB/s=20
>>>> fio_randwrite_8m_16 714 MB/s=20
>>>> fio_randwrite_2m_32 692 MB/s=20
>>>>=20
>>>>=20
>>>> But, the write IOPS seems to be limited around 19k ...=20
>>>> RBD 4M 64k (=3D optimal_io_size)=20
>>>> fio_randread_512_128 53286 55925=20
>>>> fio_randread_4k_128 51110 44382=20
>>>> fio_randread_8k_128 30854 29938=20
>>>> fio_randwrite_512_128 18888 2386=20
>>>> fio_randwrite_512_64 18844 2582=20
>>>> fio_randwrite_8k_64 17350 2445=20
>>>> (...)=20
>>>> fio_read_4k_128 10073 53151=20
>>>> fio_read_4k_64 9500 39757=20
>>>> fio_read_4k_32 9220 23650=20
>>>> (...)=20
>>>> fio_read_4k_16 9122 14322=20
>>>> fio_write_4k_128 2190 14306=20
>>>> fio_read_8k_32 706 13894=20
>>>> fio_write_4k_64 2197 12297=20
>>>> fio_write_8k_64 3563 11705=20
>>>> fio_write_8k_128 3444 11219=20
>>>>=20
>>>>=20
>>>> Any hints for tuning the IOPS (read and/or write) would be appreci=
ated.=20
>>>>=20
>>>> How can I set the variables when the Journal data have go to the O=
SD ? (after X seconds and/or when Y %-full)=20
>>>>=20
>>>>=20
>>>> Kind Regards,=20
>>>> -Dieter=20
>>>>=20
>>>>=20
>>>>=20
>>>> --=20
>>>>=20
>>>> --=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>> Alexandre D e rumier=20
>>>>=20
>>>> Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20
>>>>=20
>>>>=20
>>>> Fixe : 03 20 68 88 85=20
>>>>=20
>>>> Fax : 03 20 68 90 88=20
>>>>=20
>>>>=20
>>>> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
>>>> 12 rue Marivaux 75002 Paris=20
>>>> --=20
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in=20
>>>> the body of a message to majordomo@vger.kernel.org=20
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> --=20
>>>=20
>>> --=20
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>> Alexandre D e rumier=20
>>>=20
>>> Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20
>>>=20
>>>=20
>>> Fixe : 03 20 68 88 85=20
>>>=20
>>> Fax : 03 20 68 90 88=20
>>>=20
>>>=20
>>> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
>>> 12 rue Marivaux 75002 Paris=20
>>>=20
>>=20
>>=20
>>=20
>> --=20
>>=20
>> --=20
>>=20
>>=20
>>=20
>>=20
>>=20
>> Alexandre D e rumier=20
>>=20
>> Ing=C3=A9nieur Syst=C3=A8mes et R=C3=A9seaux=20
>>=20
>>=20
>> Fixe : 03 20 68 88 85=20
>>=20
>> Fax : 03 20 68 90 88=20
>>=20
>>=20
>> 45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix=20
>> 12 rue Marivaux 75002 Paris=20
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in=20
>> the body of a message to majordomo@vger.kernel.org=20
>> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20
>=20
>=20




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
