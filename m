From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:00:27 +0100
Message-ID: <50AE3E0B.8080905@profihost.ag>
References: <8789b7e3-daa1-4f81-88a2-59329a5c382a@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41173 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab2KVTAf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:00:35 -0500
In-Reply-To: <8789b7e3-daa1-4f81-88a2-59329a5c382a@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>

Am 22.11.2012 15:52, schrieb Alexandre DERUMIER:
>>> I discussed this with somebody frmo inktank. Had to search the
>>> mailinglist. It might be OK if you're working with enough replicas =
and UPS.
>>>
>>> I see no other option while working with SSDs - the only Option wou=
ld be
>>> to be able to deaktivate the journal at all. But ceph does not supp=
ort this.
>
> Do you have a big difference with putting 1 journal by osd on each ss=
d drive ?

Not tested.

> another alternative can be (but indeed costly):
>
> - stec zeus ram ssd drive, around 2000$ for 8G (I have benched it aro=
und 100000 iops ;)
> - ddrdrive (http://www.ddrdrive.com/) (around 200000iops, don't know =
the price)
> - fusionio card (iodrive2, 360GB, around 3000=E2=82=AC , but they are=
 160GB model, maybe half the price)

All too expensive.

> - maybe ocz talos, around 600=E2=82=AC for OCZ Talos 2 R 200 Go (don'=
t have benched them, but spec say around 35000iops random)
Not usable as each OSD can do 35.000 random IOP/s in my case and have 8=
=20
of them in each node...

Stefan

> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: "Mark Nelson" <mark.nelson@inktank.com>
> Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-de=
vel@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9ba=
stien Han" <han.sebastien@gmail.com>
> Envoy=C3=A9: Jeudi 22 Novembre 2012 15:42:14
> Objet: Re: RBD fio Performance concerns
>
> Am 22.11.2012 15:37, schrieb Mark Nelson:
>> I don't think we recommend tmpfs at all for anything other than play=
ing
>> around. :)
>
> I discussed this with somebody frmo inktank. Had to search the
> mailinglist. It might be OK if you're working with enough replicas an=
d UPS.
>
> I see no other option while working with SSDs - the only Option would=
 be
> to be able to deaktivate the journal at all. But ceph does not suppor=
t this.
>
> Stefan
>
>> On 11/22/2012 08:22 AM, Stefan Priebe - Profihost AG wrote:
>>> Hi,
>>>
>>> can someone from inktank comment this? Might be using /dev/ram0 wit=
h an
>>> fs on it be better than tmpfs as we can use dio?
>>>
>>> Greets,
>>> Stefan
>>>
>>>> ----- Mail original -----
>>>>
>>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>>>> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>
>>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER"
>>>> <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>,
>>>> "Mark Kampe" <mark.kampe@inktank.com>
>>>> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03
>>>> Objet: Re: RBD fio Performance concerns
>>>>
>>>> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:
>>>>> And RAMDISK devices are too expensive.
>>>>>
>>>>> It would make sense in your infra, but yes they are really expens=
ive.
>>>>
>>>> We need something like tmpfs - running in local memory but support=
 dio.
>>>>
>>>> Stefan
>>>>
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
