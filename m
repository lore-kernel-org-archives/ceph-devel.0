From: Gregory Farnum <greg@inktank.com>
Subject: Re: RBD performance - tuning hints
Date: Thu, 30 Aug 2012 11:10:27 -0700
Message-ID: <CAPYLRzjkVd1QTP3AiDBmyZVWKVizDcS+Gbp367WqCutV55Xusg@mail.gmail.com>
References: <20120830160205.GD32184@oder.kd-bie.de>
	<5831c8ed-f98d-45f9-8837-178cee74fa9f@mailpro>
	<20120830164859.GE32184@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49298 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab2H3SK2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Aug 2012 14:10:28 -0400
Received: by ieje11 with SMTP id e11so986162iej.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Aug 2012 11:10:27 -0700 (PDT)
In-Reply-To: <20120830164859.GE32184@oder.kd-bie.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Bluemle <andreas.bluemle@itxperts.de>, Samuel Just <sam.just@inktank.com>

On Thu, Aug 30, 2012 at 9:48 AM, Dieter Kasper <d.kasper@kabelmail.de> =
wrote:
> On Thu, Aug 30, 2012 at 06:12:11PM +0200, Alexandre DERUMIER wrote:
>> >>well, you have to compare
>> >>- pure a SSD (via PCIe or SAS-6G)        vs.
>> >>- Ceph-Journal, which goes 2x over 10GbE with IP
>> >>  Client -> primary-copy -> 2nd-copy
>> >>  (=3D redundancy over Ethernet distance)
>>
>> Sure but the first osd ack to the client,before replicating to the o=
thers osd.
> no
>
>>
>> Client -> primary-copy -> 2nd-copy
>>        <-ack
>>          primary-copy -> 2nd-copy
>>                       -> 3st-copy
>>
>> Or I'm wrong ?
> yes,
> please have a look at the attached file: ceph-replication-acks.png
> The client usually will continue on 'ACK' and not wait for the 'commi=
t'.
>
> BTW. all my journals are in RAM (/dev/ramX)
> 32x 2GB =3D 32GB of data with replica 2x
>
> If "filestore min/max sync interval" is set to 99999999
> data should 'never' be written to OSD
> ('never' at least during the tests if the written data is < 32GB)

I believe it actually will start syncing to disk when the journal is
half full (right, Sam?) =97=A0and even if it doesn't sync, there's a
reasonable chance that some of the data will be written out to disk in
the background (though that shouldn't slow anything down, of course).
:)
-Greg


>
> In such a configuration only the Ceph-Code and the Interconnect (10Gb=
E/IP) would be the brakeman.
>
> Cheers,
> -Dieter
>
>
>>
>>
>> ----- Mail original -----
>>
>> De: "Dieter Kasper" <d.kasper@kabelmail.de>
>> =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
>> Cc: ceph-devel@vger.kernel.org, "Andreas Bluemle" <andreas.bluemle@i=
txperts.de>
>> Envoy=E9: Jeudi 30 Ao=FBt 2012 18:02:05
>> Objet: Re: RBD performance - tuning hints
>>
>> On Thu, Aug 30, 2012 at 05:46:35PM +0200, Alexandre DERUMIER wrote:
>> > Thanks
>> >
>> > >> 8x SSD, 200GB each
>> >
>> > 20000 iops seem pretty low,no ?
>> well, you have to compare
>> - pure a SSD (via PCIe or SAS-6G) vs.
>> - Ceph-Journal, which goes 2x over 10GbE with IP
>> Client -> primary-copy -> 2nd-copy
>> (=3D redundancy over Ethernet distance)
>>
>> I'm curious about the answer from Inktank,
>>
>> -Dieter
>>
>> >
>> >
>> > for @intank:
>> >
>> > Is their a bottleneck somewhere in ceph ?
>> Maybe "SimpleMessenger dispatching: cause of performance problems?"
>> from Thu, 16 Aug 2012 18:08:39 +0200
>> by <andreas.bluemle@itxperts.de>
>> can be an answer.
>> Especially if a small number of OSDs is used.
>>
>> >
>> > I said that, because I would like to know if it's scale by adding =
new nodes.
>> >
>> > Does Intank have already done some random iops benchmark ? (I alwa=
ys see sequential throughput bench in the mailing list)
>> >
>> >
>> > ----- Mail original -----
>> >
>> > De: "Dieter Kasper" <d.kasper@kabelmail.de>
>> > =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
>> > Cc: ceph-devel@vger.kernel.org
>> > Envoy=E9: Jeudi 30 Ao=FBt 2012 17:33:42
>> > Objet: Re: RBD performance - tuning hints
>> >
>> > On Thu, Aug 30, 2012 at 05:28:02PM +0200, Alexandre DERUMIER wrote=
:
>> > > Thanks for the report !
>> > >
>> > > vs your first benchmark, it's with RBD 4M or 64K ?
>> > with 4MB (see attached config info)
>> >
>> > Cheers,
>> > -Dieter
>> >
>> > >
>> > > (how much ssd by node?)
>> > 8x SSD, 200GB each
>> >
>> > >
>> > >
>> > >
>> > > ----- Mail original -----
>> > >
>> > > De: "Dieter Kasper" <d.kasper@kabelmail.de>
>> > > =C0: "Alexandre DERUMIER" <aderumier@odiso.com>
>> > > Cc: ceph-devel@vger.kernel.org
>> > > Envoy=E9: Jeudi 30 Ao=FBt 2012 16:56:34
>> > > Objet: Re: RBD performance - tuning hints
>> > >
>> > > Hi Alexandre,
>> > >
>> > > with the 4 filestore parameter below some fio values could be in=
creased:
>> > > filestore max sync interval =3D 30
>> > > filestore min sync interval =3D 29
>> > > filestore flusher =3D false
>> > > filestore queue max ops =3D 10000
>> > >
>> > > ###### IOPS
>> > > fio_read_4k_64: 9373
>> > > fio_read_4k_128: 9939
>> > > fio_randwrite_8k_16: 12376
>> > > fio_randwrite_4k_16: 13315
>> > > fio_randwrite_512_32: 13660
>> > > fio_randwrite_8k_32: 17318
>> > > fio_randwrite_4k_32: 18057
>> > > fio_randwrite_8k_64: 19693
>> > > fio_randwrite_512_64: 20015 <<<
>> > > fio_randwrite_4k_64: 20024 <<<
>> > > fio_randwrite_8k_128: 20547 <<<
>> > > fio_randwrite_4k_128: 20839 <<<
>> > > fio_randwrite_512_128: 21417 <<<
>> > > fio_randread_8k_128: 48872
>> > > fio_randread_4k_128: 50002
>> > > fio_randread_512_128: 51202
>> > >
>> > > ###### MB/s
>> > > fio_randread_2m_32: 628
>> > > fio_read_4m_64: 630
>> > > fio_randread_8m_32: 633
>> > > fio_read_2m_32: 637
>> > > fio_read_4m_16: 640
>> > > fio_randread_4m_16: 652
>> > > fio_write_2m_32: 660
>> > > fio_randread_4m_32: 677
>> > > fio_read_4m_32: 678
>> > > (...)
>> > > fio_write_4m_64: 771
>> > > fio_randwrite_2m_64: 789
>> > > fio_write_8m_128: 796
>> > > fio_write_4m_32: 802
>> > > fio_randwrite_4m_128: 807 <<<
>> > > fio_randwrite_2m_32: 811 <<<
>> > > fio_write_2m_128: 833 <<<
>> > > fio_write_8m_64: 901 <<<
>> > >
>> > > Best Regards,
>> > > -Dieter
>> > >
>> > >
>> > > On Wed, Aug 29, 2012 at 10:50:12AM +0200, Alexandre DERUMIER wro=
te:
>> > > > Nice results !
>> > > > (can you make same benchmark from a qemu-kvm guest with virtio=
-driver ?
>> > > > I have made some bench some month ago with stephan priebe, and=
 we never be able to have more than 20000iops, with a full ssd 3nodes c=
luster)
>> > > >
>> > > > >>How can I set the variables when the Journal data have go to=
 the OSD ? (after X seconds and/or when Y %-full)
>> > > > I think you can try to tune these values
>> > > >
>> > > > filestore max sync interval =3D 30
>> > > > filestore min sync interval =3D 29
>> > > > filestore flusher =3D false
>> > > > filestore queue max ops =3D 10000
>> > > >
>> > > >
>> > > >
>> > > > ----- Mail original -----
>> > > >
>> > > > De: "Dieter Kasper" <d.kasper@kabelmail.de>
>> > > > =C0: ceph-devel@vger.kernel.org
>> > > > Cc: "Dieter Kasper (KD)" <d.kasper@kabelmail.de>
>> > > > Envoy=E9: Mardi 28 Ao=FBt 2012 19:48:42
>> > > > Objet: RBD performance - tuning hints
>> > > >
>> > > > Hi,
>> > > >
>> > > > on my 4-node system (SSD + 10GbE, see bench-config.txt for det=
ails)
>> > > > I can observe a pretty nice rados bench performance
>> > > > (see bench-rados.txt for details):
>> > > >
>> > > > Bandwidth (MB/sec): 961.710
>> > > > Max bandwidth (MB/sec): 1040
>> > > > Min bandwidth (MB/sec): 772
>> > > >
>> > > >
>> > > > Also the bandwidth performance generated with
>> > > > fio --filename=3D/dev/rbd1 --direct=3D1 --rw=3D$io --bs=3D$bs =
--size=3D2G --iodepth=3D$threads --ioengine=3Dlibaio --runtime=3D60 --g=
roup_reporting --name=3Dfile1 --output=3Dfio_${io}_${bs}_${threads}
>> > > >
>> > > > .... is acceptable, e.g.
>> > > > fio_write_4m_16 795 MB/s
>> > > > fio_randwrite_8m_128 717 MB/s
>> > > > fio_randwrite_8m_16 714 MB/s
>> > > > fio_randwrite_2m_32 692 MB/s
>> > > >
>> > > >
>> > > > But, the write IOPS seems to be limited around 19k ...
>> > > > RBD 4M 64k (=3D optimal_io_size)
>> > > > fio_randread_512_128 53286 55925
>> > > > fio_randread_4k_128 51110 44382
>> > > > fio_randread_8k_128 30854 29938
>> > > > fio_randwrite_512_128 18888 2386
>> > > > fio_randwrite_512_64 18844 2582
>> > > > fio_randwrite_8k_64 17350 2445
>> > > > (...)
>> > > > fio_read_4k_128 10073 53151
>> > > > fio_read_4k_64 9500 39757
>> > > > fio_read_4k_32 9220 23650
>> > > > (...)
>> > > > fio_read_4k_16 9122 14322
>> > > > fio_write_4k_128 2190 14306
>> > > > fio_read_8k_32 706 13894
>> > > > fio_write_4k_64 2197 12297
>> > > > fio_write_8k_64 3563 11705
>> > > > fio_write_8k_128 3444 11219
>> > > >
>> > > >
>> > > > Any hints for tuning the IOPS (read and/or write) would be app=
reciated.
>> > > >
>> > > > How can I set the variables when the Journal data have go to t=
he OSD ? (after X seconds and/or when Y %-full)
>> > > >
>> > > >
>> > > > Kind Regards,
>> > > > -Dieter
>> > > >
>> > > >
>> > > >
>> > > > --
>> > > >
>> > > > --
>> > > >
>> > > >
>> > > >
>> > > >
>> > > >
>> > > > Alexandre D e rumier
>> > > >
>> > > > Ing=E9nieur Syst=E8mes et R=E9seaux
>> > > >
>> > > >
>> > > > Fixe : 03 20 68 88 85
>> > > >
>> > > > Fax : 03 20 68 90 88
>> > > >
>> > > >
>> > > > 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix
>> > > > 12 rue Marivaux 75002 Paris
>> > > > --
>> > > > To unsubscribe from this list: send the line "unsubscribe ceph=
-devel" in
>> > > > the body of a message to majordomo@vger.kernel.org
>> > > > More majordomo info at http://vger.kernel.org/majordomo-info.h=
tml
>> > >
>> > >
>> > >
>> > >
>> > > --
>> > >
>> > > --
>> > >
>> > >
>> > >
>> > >
>> > >
>> > > Alexandre D e rumier
>> > >
>> > > Ing=E9nieur Syst=E8mes et R=E9seaux
>> > >
>> > >
>> > > Fixe : 03 20 68 88 85
>> > >
>> > > Fax : 03 20 68 90 88
>> > >
>> > >
>> > > 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix
>> > > 12 rue Marivaux 75002 Paris
>> > >
>> >
>> >
>> >
>> > --
>> >
>> > --
>> >
>> >
>> >
>> >
>> >
>> > Alexandre D e rumier
>> >
>> > Ing=E9nieur Syst=E8mes et R=E9seaux
>> >
>> >
>> > Fixe : 03 20 68 88 85
>> >
>> > Fax : 03 20 68 90 88
>> >
>> >
>> > 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix
>> > 12 rue Marivaux 75002 Paris
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>> --
>>
>> --
>>
>>
>>
>>
>>
>> Alexandre D e rumier
>>
>> Ing=E9nieur Syst=E8mes et R=E9seaux
>>
>>
>> Fixe : 03 20 68 88 85
>>
>> Fax : 03 20 68 90 88
>>
>>
>> 45 Bvd du G=E9n=E9ral Leclerc 59100 Roubaix
>> 12 rue Marivaux 75002 Paris
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Principal Consultant, Data Center Storage Architecture and Technology
> FTS CTO
> FUJITSU TECHNOLOGY SOLUTIONS GMBH
> Mies-van-der-Rohe-Stra=DFe 8 / 4F
> 80807 M=FCnchen
> Germany
>
> Telephone:      +49 89 62060     1898
> Telefax:        +49 89 62060 329 1898
> Mobile:         +49 170 8563173
> Email:          dieter.kasper@ts.fujitsu.com
> Internet:       http://ts.fujitsu.com
> Company Details: http://ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
