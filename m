From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:28:57 +0100
Message-ID: <50AE44B9.7070804@profihost.ag>
References: <1e160089-914f-4227-afb8-33cfaf883cdb@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44062 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965216Ab2KVT3G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:29:06 -0500
In-Reply-To: <1e160089-914f-4227-afb8-33cfaf883cdb@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>

Am 22.11.2012 16:26, schrieb Alexandre DERUMIER:
>>> Haven't tested that. But does this makes sense? I mean data goes to=
 Disk
>>> journal - same disk then has to copy the Data from part A to part B=
=2E
>>>
>>> Why is this an advantage?
>
> Well, if you are cpu limited, I don't think you can use all 8*35000io=
ps by node.
> So, maybe a benchmark can tell us if the difference is really big.
>
> Using tmpfs and ups can be ok, but if you have a kernel panic or hard=
ware problem, you'll lost your journal.

But who cares? it's also on the 2nd node. or even on the 3rd if you hav=
e=20
replicas 3.

Stefan


> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: "Mark Nelson" <mark.nelson@inktank.com>
> Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-de=
vel@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9ba=
stien Han" <han.sebastien@gmail.com>
> Envoy=C3=A9: Jeudi 22 Novembre 2012 16:01:56
> Objet: Re: RBD fio Performance concerns
>
> Am 22.11.2012 15:46, schrieb Mark Nelson:
>> I haven't played a whole lot with SSD only OSDs yet (other than noti=
ng
>> last summer that iop performance wasn't as high as I wanted it). Is =
a
>> second partition on the SSD for the journal not an option for you?
>
> Haven't tested that. But does this makes sense? I mean data goes to D=
isk
> journal - same disk then has to copy the Data from part A to part B.
>
> Why is this an advantage?
>
> Stefan
>
>> Mark
>>
>> On 11/22/2012 08:42 AM, Stefan Priebe - Profihost AG wrote:
>>> Am 22.11.2012 15:37, schrieb Mark Nelson:
>>>> I don't think we recommend tmpfs at all for anything other than pl=
aying
>>>> around. :)
>>>
>>> I discussed this with somebody frmo inktank. Had to search the
>>> mailinglist. It might be OK if you're working with enough replicas =
and
>>> UPS.
>>>
>>> I see no other option while working with SSDs - the only Option wou=
ld be
>>> to be able to deaktivate the journal at all. But ceph does not supp=
ort
>>> this.
>>>
>>> Stefan
>>>
>>>> On 11/22/2012 08:22 AM, Stefan Priebe - Profihost AG wrote:
>>>>> Hi,
>>>>>
>>>>> can someone from inktank comment this? Might be using /dev/ram0 w=
ith an
>>>>> fs on it be better than tmpfs as we can use dio?
>>>>>
>>>>> Greets,
>>>>> Stefan
>>>>>
>>>>>> ----- Mail original -----
>>>>>>
>>>>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>>>>>> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>
>>>>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER=
"
>>>>>> <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>=
,
>>>>>> "Mark Kampe" <mark.kampe@inktank.com>
>>>>>> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03
>>>>>> Objet: Re: RBD fio Performance concerns
>>>>>>
>>>>>> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:
>>>>>>> And RAMDISK devices are too expensive.
>>>>>>>
>>>>>>> It would make sense in your infra, but yes they are really expe=
nsive.
>>>>>>
>>>>>> We need something like tmpfs - running in local memory but suppo=
rt
>>>>>> dio.
>>>>>>
>>>>>> Stefan
>>>>>>
>>>>
>>>>
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
