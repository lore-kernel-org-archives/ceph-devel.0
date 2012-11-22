From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 15:52:57 +0100 (CET)
Message-ID: <8789b7e3-daa1-4f81-88a2-59329a5c382a@mailpro>
References: <50AE39C6.5010205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:37939 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388Ab2KVTFh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:05:37 -0500
In-Reply-To: <50AE39C6.5010205@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?utf-8?Q?S=C3=A9bastien?= Han <han.sebastien@gmail.com>, Mark Nelson <mark.nelson@inktank.com>

>>I discussed this with somebody frmo inktank. Had to search the
>>mailinglist. It might be OK if you're working with enough replicas an=
d UPS.
>>
>>I see no other option while working with SSDs - the only Option would=
 be
>>to be able to deaktivate the journal at all. But ceph does not suppor=
t this.

Do you have a big difference with putting 1 journal by osd on each ssd =
drive ?


another alternative can be (but indeed costly):

- stec zeus ram ssd drive, around 2000$ for 8G (I have benched it aroun=
d 100000 iops ;)
- ddrdrive (http://www.ddrdrive.com/) (around 200000iops, don't know th=
e price)
- fusionio card (iodrive2, 360GB, around 3000=E2=82=AC , but they are 1=
60GB model, maybe half the price)
- maybe ocz talos, around 600=E2=82=AC for OCZ Talos 2 R 200 Go (don't =
have benched them, but spec say around 35000iops random)





----- Mail original -----=20

De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
=C3=80: "Mark Nelson" <mark.nelson@inktank.com>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, "ceph-devel" <ceph-deve=
l@vger.kernel.org>, "Mark Kampe" <mark.kampe@inktank.com>, "S=C3=A9bast=
ien Han" <han.sebastien@gmail.com>=20
Envoy=C3=A9: Jeudi 22 Novembre 2012 15:42:14=20
Objet: Re: RBD fio Performance concerns=20

Am 22.11.2012 15:37, schrieb Mark Nelson:=20
> I don't think we recommend tmpfs at all for anything other than playi=
ng=20
> around. :)=20

I discussed this with somebody frmo inktank. Had to search the=20
mailinglist. It might be OK if you're working with enough replicas and =
UPS.=20

I see no other option while working with SSDs - the only Option would b=
e=20
to be able to deaktivate the journal at all. But ceph does not support =
this.=20

Stefan=20

> On 11/22/2012 08:22 AM, Stefan Priebe - Profihost AG wrote:=20
>> Hi,=20
>>=20
>> can someone from inktank comment this? Might be using /dev/ram0 with=
 an=20
>> fs on it be better than tmpfs as we can use dio?=20
>>=20
>> Greets,=20
>> Stefan=20
>>=20
>>> ----- Mail original -----=20
>>>=20
>>> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>=20
>>> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>=20
>>> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER"=20
>>> <aderumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>,=20
>>> "Mark Kampe" <mark.kampe@inktank.com>=20
>>> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03=20
>>> Objet: Re: RBD fio Performance concerns=20
>>>=20
>>> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:=20
>>>> And RAMDISK devices are too expensive.=20
>>>>=20
>>>> It would make sense in your infra, but yes they are really expensi=
ve.=20
>>>=20
>>> We need something like tmpfs - running in local memory but support =
dio.=20
>>>=20
>>> Stefan=20
>>>=20
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
