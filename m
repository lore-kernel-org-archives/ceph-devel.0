From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Fri, 23 Nov 2012 14:33:51 +0100
Message-ID: <50AF7B3F.3050609@profihost.ag>
References: <3ed000f5-38d6-45dd-917e-5e29c5b7ff1a@mailpro> <50AF7798.9060303@inktank.com> <50AF790A.5070806@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:56578 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab2KWNeB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 08:34:01 -0500
In-Reply-To: <50AF790A.5070806@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>

Am 23.11.2012 14:24, schrieb Stefan Priebe - Profihost AG:
> Am 23.11.2012 14:18, schrieb Mark Nelson:
>> Agreed with Alexandre, try putting the journal on a raw partition.
>> That's pretty insane!  What controller are you using again?

uhu crazy now i have the same with tmpfs... no idea what's going on her=
e.

I've updated ceph to latest git next. Maybe i should rollback.

Stefan

>
> Makes no difference. No Controller. Just using the SATA 3.0 onboard
> Ports for each SSD.
>
> fio directly on SSD gives me 45.000 rand 4k write iops and 270Mb/s se=
q
> write speed. So that's ok.
>
> Stefan
>
>> Mark
>>
>> On 11/23/2012 05:03 AM, Alexandre DERUMIER wrote:
>>> so correcly aligned...
>>>
>>> Maybe try to use journal directly on the full partition, without xf=
s ?
>>>
>>>
>>> ----- Mail original -----
>>>
>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "ceph-devel"
>>> <ceph-devel@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>=
,
>>> "S=C3=A9bastien Han" <han.sebastien@gmail.com>
>>> Envoy=C3=A9: Vendredi 23 Novembre 2012 11:49:10
>>> Objet: Re: RBD fio Performance concerns
>>>
>>> Am 23.11.2012 11:47, schrieb Alexandre DERUMIER:
>>>>>> when i switch the journal to the OSD Disk seperate partiton on e=
ach
>>>>>> disk
>>>>>> (/dev/sdX1 for journal 1GB and /dev/sdX2 for OSD) i go down from
>>>>>> 23.000
>>>>>> iops to 200 iops random 4k.
>>>> O_o , that's seem crazy...
>>>> Are you sure that your partitions are correctly aligned ? (startin=
g
>>>> first partition at sector 2048 is best for ssd)
>>>
>>> Model: ATA INTEL SSDSC2CW24 (scsi)
>>> Disk /dev/sdb: 468862128s
>>> Sector size (logical/physical): 512B/512B
>>> Partition Table: gpt
>>>
>>> Number Start End Size File system Name Flags
>>> 1 2048s 2342911s 2340864s xfs pri
>>> 2 2342912s 468860927s 466518016s xfs pri
>>>
>>> Stefan
>>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
