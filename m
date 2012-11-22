From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:35:18 +0100 (CET)
Message-ID: <824b8945-bd67-489d-9791-30804ef90d81@mailpro>
References: <50AE44B9.7070804@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:39074 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab2KVSkg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:40:36 -0500
In-Reply-To: <50AE44B9.7070804@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>

>>But who cares? it's also on the 2nd node. or even on the 3rd if you h=
ave=20
>>replicas 3.=20
Yes, but rebuilding a dead node use cpu and ios. (but it should be benc=
hed too, to see the impact on the production)



----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>=20
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Mark Kampe" <mark.kampe=
@inktank.com>, "S=C3=A9bastien Han" <han.sebastien@gmail.com>, "Mark Ne=
lson" <mark.nelson@inktank.com>=20
Envoy=C3=A9: Jeudi 22 Novembre 2012 16:28:57=20
Objet: Re: RBD fio Performance concerns=20

Am 22.11.2012 16:26, schrieb Alexandre DERUMIER:=20
>>> Haven't tested that. But does this makes sense? I mean data goes to=
 Disk=20
>>> journal - same disk then has to copy the Data from part A to part B=
=2E=20
>>>=20
>>> Why is this an advantage?=20
>=20
> Well, if you are cpu limited, I don't think you can use all 8*35000io=
ps by node.=20
> So, maybe a benchmark can tell us if the difference is really big.=20
>=20
> Using tmpfs and ups can be ok, but if you have a kernel panic or hard=
ware problem, you'll lost your journal.=20

But who cares? it's also on the 2nd node. or even on the 3rd if you hav=
e=20
replicas 3.=20

Stefan=20


> ----- Mail original -----=20
>=20
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
> =C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
> Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-de=
vel@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9ba=
stien Han" <han.sebastien@gmail.com>=20
> Envoy=C3=A9: Jeudi 22 Novembre 2012 16:01:56=20
> Objet: Re: RBD fio Performance concerns=20
>=20
> Am 22.11.2012 15:46, schrieb Mark Nelson:=20
>> I haven't played a whole lot with SSD only OSDs yet (other than noti=
ng=20
>> last summer that iop performance wasn't as high as I wanted it). Is =
a=20
>> second partition on the SSD for the journal not an option for you?=20
>=20
> Haven't tested that. But does this makes sense? I mean data goes to D=
isk=20
> journal - same disk then has to copy the Data from part A to part B.=20
>=20
> Why is this an advantage?=20
>=20
> Stefan=20
>=20
>> Mark=20
>>=20
>> On 11/22/2012 08:42 AM, Stefan Priebe - Profihost AG wrote:=20
>>> Am 22.11.2012 15:37, schrieb Mark Nelson:=20
>>>> I don't think we recommend tmpfs at all for anything other than pl=
aying=20
>>>> around. :)=20
>>>=20
>>> I discussed this with somebody frmo inktank. Had to search the=20
>>> mailinglist. It might be OK if you're working with enough replicas =
and=20
>>> UPS.=20
>>>=20
>>> I see no other option while working with SSDs - the only Option wou=
ld be=20
>>> to be able to deaktivate the journal at all. But ceph does not supp=
ort=20
>>> this.=20
>>>=20
>>> Stefan=20
>>>=20
>>>> On 11/22/2012 08:22 AM, Stefan Priebe - Profihost AG wrote:=20
>>>>> Hi,=20
>>>>>=20
>>>>> can someone from inktank comment this? Might be using /dev/ram0 w=
ith an=20
>>>>> fs on it be better than tmpfs as we can use dio?=20
>>>>>=20
>>>>> Greets,=20
>>>>> Stefan=20
>>>>>=20
>>>>>> ----- Mail original -----=20
>>>>>>=20
>>>>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
>>>>>> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
>>>>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER=
"=20
>>>>>> <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>=
,=20
>>>>>> "Mark Kampe" <mark.kampe@inktank.com>=20
>>>>>> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03=20
>>>>>> Objet: Re: RBD fio Performance concerns=20
>>>>>>=20
>>>>>> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:=20
>>>>>>> And RAMDISK devices are too expensive.=20
>>>>>>>=20
>>>>>>> It would make sense in your infra, but yes they are really expe=
nsive.=20
>>>>>>=20
>>>>>> We need something like tmpfs - running in local memory but suppo=
rt=20
>>>>>> dio.=20
>>>>>>=20
>>>>>> Stefan=20
>>>>>>=20
>>>>=20
>>>>=20
>>=20
>>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
