From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Fri, 23 Nov 2012 14:32:58 +0100 (CET)
Message-ID: <14a664d8-65e0-4efd-9892-d6d70d3c5caa@mailpro>
References: <50AF790A.5070806@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:48476 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800Ab2KWNd3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 08:33:29 -0500
In-Reply-To: <50AF790A.5070806@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>

maybe try to play with io scheduler ? maybe noop can help ?
 (I'm out of idea)


----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9bast=
ien Han" <han.sebastien@gmail.com>=20
Envoy=C3=A9: Vendredi 23 Novembre 2012 14:24:26=20
Objet: Re: RBD fio Performance concerns=20

Am 23.11.2012 14:18, schrieb Mark Nelson:=20
> Agreed with Alexandre, try putting the journal on a raw partition.=20
> That's pretty insane! What controller are you using again?=20

Makes no difference. No Controller. Just using the SATA 3.0 onboard=20
Ports for each SSD.=20

fio directly on SSD gives me 45.000 rand 4k write iops and 270Mb/s seq=20
write speed. So that's ok.=20

Stefan=20

> Mark=20
>=20
> On 11/23/2012 05:03 AM, Alexandre DERUMIER wrote:=20
>> so correcly aligned...=20
>>=20
>> Maybe try to use journal directly on the full partition, without xfs=
 ?=20
>>=20
>>=20
>> ----- Mail original -----=20
>>=20
>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
>> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "ceph-devel"=20
>> <ceph-devel@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>,=
=20
>> "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
>> Envoy=C3=A9: Vendredi 23 Novembre 2012 11:49:10=20
>> Objet: Re: RBD fio Performance concerns=20
>>=20
>> Am 23.11.2012 11:47, schrieb Alexandre DERUMIER:=20
>>>>> when i switch the journal to the OSD Disk seperate partiton on ea=
ch=20
>>>>> disk=20
>>>>> (/dev/sdX1 for journal 1GB and /dev/sdX2 for OSD) i go down from=20
>>>>> 23.000=20
>>>>> iops to 200 iops random 4k.=20
>>> O_o , that's seem crazy...=20
>>> Are you sure that your partitions are correctly aligned ? (starting=
=20
>>> first partition at sector 2048 is best for ssd)=20
>>=20
>> Model: ATA INTEL SSDSC2CW24 (scsi)=20
>> Disk /dev/sdb: 468862128s=20
>> Sector size (logical/physical): 512B/512B=20
>> Partition Table: gpt=20
>>=20
>> Number Start End Size File system Name Flags=20
>> 1 2048s 2342911s 2340864s xfs pri=20
>> 2 2342912s 468860927s 466518016s xfs pri=20
>>=20
>> Stefan=20
>>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
