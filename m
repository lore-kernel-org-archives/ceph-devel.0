From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 15:42:14 +0100
Message-ID: <50AE39C6.5010205@profihost.ag>
References: <0a4a4396-60cd-4782-8743-b2bbba2d2488@mailpro> <50AE351F.9080505@profihost.ag> <50AE38C4.6000909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:45659 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab2KVSmX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:42:23 -0500
In-Reply-To: <50AE38C4.6000909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>

Am 22.11.2012 15:37, schrieb Mark Nelson:
> I don't think we recommend tmpfs at all for anything other than playi=
ng
> around. :)

I discussed this with somebody frmo inktank. Had to search the=20
mailinglist. It might be OK if you're working with enough replicas and =
UPS.

I see no other option while working with SSDs - the only Option would b=
e=20
to be able to deaktivate the journal at all. But ceph does not support =
this.

Stefan

> On 11/22/2012 08:22 AM, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>> can someone from inktank comment this? Might be using /dev/ram0 with=
 an
>> fs on it be better than tmpfs as we can use dio?
>>
>> Greets,
>> Stefan
>>
>>> ----- Mail original -----
>>>
>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
>>> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>
>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER"
>>> <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>,
>>> "Mark Kampe" <mark.kampe@inktank.com>
>>> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03
>>> Objet: Re: RBD fio Performance concerns
>>>
>>> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:
>>>> And RAMDISK devices are too expensive.
>>>>
>>>> It would make sense in your infra, but yes they are really expensi=
ve.
>>>
>>> We need something like tmpfs - running in local memory but support =
dio.
>>>
>>> Stefan
>>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
