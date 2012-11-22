From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:26:36 +0100 (CET)
Message-ID: <1e160089-914f-4227-afb8-33cfaf883cdb@mailpro>
References: <50AE3E64.90702@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:50626 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab2KVSag convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:30:36 -0500
In-Reply-To: <50AE3E64.90702@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>

>>Haven't tested that. But does this makes sense? I mean data goes to D=
isk=20
>>journal - same disk then has to copy the Data from part A to part B.=20
>>
>>Why is this an advantage?=20

Well, if you are cpu limited, I don't think you can use all 8*35000iops=
 by node.
So, maybe a benchmark can tell us if the difference is really big.

Using tmpfs and ups can be ok, but if you have a kernel panic or hardwa=
re problem, you'll lost your journal.=20



----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9bast=
ien Han" <han.sebastien@gmail.com>=20
Envoy=C3=A9: Jeudi 22 Novembre 2012 16:01:56=20
Objet: Re: RBD fio Performance concerns=20

Am 22.11.2012 15:46, schrieb Mark Nelson:=20
> I haven't played a whole lot with SSD only OSDs yet (other than notin=
g=20
> last summer that iop performance wasn't as high as I wanted it). Is a=
=20
> second partition on the SSD for the journal not an option for you?=20

Haven't tested that. But does this makes sense? I mean data goes to Dis=
k=20
journal - same disk then has to copy the Data from part A to part B.=20

Why is this an advantage?=20

Stefan=20

> Mark=20
>=20
> On 11/22/2012 08:42 AM, Stefan Priebe - Profihost AG wrote:=20
>> Am 22.11.2012 15:37, schrieb Mark Nelson:=20
>>> I don't think we recommend tmpfs at all for anything other than pla=
ying=20
>>> around. :)=20
>>=20
>> I discussed this with somebody frmo inktank. Had to search the=20
>> mailinglist. It might be OK if you're working with enough replicas a=
nd=20
>> UPS.=20
>>=20
>> I see no other option while working with SSDs - the only Option woul=
d be=20
>> to be able to deaktivate the journal at all. But ceph does not suppo=
rt=20
>> this.=20
>>=20
>> Stefan=20
>>=20
>>> On 11/22/2012 08:22 AM, Stefan Priebe - Profihost AG wrote:=20
>>>> Hi,=20
>>>>=20
>>>> can someone from inktank comment this? Might be using /dev/ram0 wi=
th an=20
>>>> fs on it be better than tmpfs as we can use dio?=20
>>>>=20
>>>> Greets,=20
>>>> Stefan=20
>>>>=20
>>>>> ----- Mail original -----=20
>>>>>=20
>>>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
>>>>> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
>>>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER"=
=20
>>>>> <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>,=
=20
>>>>> "Mark Kampe" <mark.kampe@inktank.com>=20
>>>>> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03=20
>>>>> Objet: Re: RBD fio Performance concerns=20
>>>>>=20
>>>>> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:=20
>>>>>> And RAMDISK devices are too expensive.=20
>>>>>>=20
>>>>>> It would make sense in your infra, but yes they are really expen=
sive.=20
>>>>>=20
>>>>> We need something like tmpfs - running in local memory but suppor=
t=20
>>>>> dio.=20
>>>>>=20
>>>>> Stefan=20
>>>>>=20
>>>=20
>>>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
