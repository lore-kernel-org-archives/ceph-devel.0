From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:01:56 +0100
Message-ID: <50AE3E64.90702@profihost.ag>
References: <0a4a4396-60cd-4782-8743-b2bbba2d2488@mailpro> <50AE351F.9080505@profihost.ag> <50AE38C4.6000909@inktank.com> <50AE39C6.5010205@profihost.ag> <50AE3ABF.7000709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35288 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab2KVTCF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:02:05 -0500
In-Reply-To: <50AE3ABF.7000709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>

Am 22.11.2012 15:46, schrieb Mark Nelson:
> I haven't played a whole lot with SSD only OSDs yet (other than notin=
g
> last summer that iop performance wasn't as high as I wanted it).  Is =
a
> second partition on the SSD for the journal not an option for you?

Haven't tested that. But does this makes sense? I mean data goes to Dis=
k=20
journal - same disk then has to copy the Data from part A to part B.

Why is this an advantage?

Stefan

> Mark
>
> On 11/22/2012 08:42 AM, Stefan Priebe - Profihost AG wrote:
>> Am 22.11.2012 15:37, schrieb Mark Nelson:
>>> I don't think we recommend tmpfs at all for anything other than pla=
ying
>>> around. :)
>>
>> I discussed this with somebody frmo inktank. Had to search the
>> mailinglist. It might be OK if you're working with enough replicas a=
nd
>> UPS.
>>
>> I see no other option while working with SSDs - the only Option woul=
d be
>> to be able to deaktivate the journal at all. But ceph does not suppo=
rt
>> this.
>>
>> Stefan
>>
>>> On 11/22/2012 08:22 AM, Stefan Priebe - Profihost AG wrote:
>>>> Hi,
>>>>
>>>> can someone from inktank comment this? Might be using /dev/ram0 wi=
th an
>>>> fs on it be better than tmpfs as we can use dio?
>>>>
>>>> Greets,
>>>> Stefan
>>>>
>>>>> ----- Mail original -----
>>>>>
>>>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>>>>> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>
>>>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER"
>>>>> <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>,
>>>>> "Mark Kampe" <mark.kampe@inktank.com>
>>>>> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03
>>>>> Objet: Re: RBD fio Performance concerns
>>>>>
>>>>> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:
>>>>>> And RAMDISK devices are too expensive.
>>>>>>
>>>>>> It would make sense in your infra, but yes they are really expen=
sive.
>>>>>
>>>>> We need something like tmpfs - running in local memory but suppor=
t
>>>>> dio.
>>>>>
>>>>> Stefan
>>>>>
>>>
>>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
