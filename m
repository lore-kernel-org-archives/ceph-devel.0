From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 15:22:23 +0100
Message-ID: <50AE351F.9080505@profihost.ag>
References: <0a4a4396-60cd-4782-8743-b2bbba2d2488@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:53631 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049Ab2KVTtM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:49:12 -0500
In-Reply-To: <0a4a4396-60cd-4782-8743-b2bbba2d2488@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>

Hi,

can someone from inktank comment this? Might be using /dev/ram0 with an=
=20
fs on it be better than tmpfs as we can use dio?

Greets,
Stefan

> ----- Mail original -----
>
> De: "Stefan Priebe - Profihost AG" <s.priebe@profihost.ag>
> =C3=80: "S=C3=A9bastien Han" <han.sebastien@gmail.com>
> Cc: "Mark Nelson" <mark.nelson@inktank.com>, "Alexandre DERUMIER" <ad=
erumier@odiso.com>, "ceph-devel" <ceph-devel@vger.kernel.org>, "Mark Ka=
mpe" <mark.kampe@inktank.com>
> Envoy=C3=A9: Jeudi 22 Novembre 2012 14:29:03
> Objet: Re: RBD fio Performance concerns
>
> Am 22.11.2012 14:22, schrieb S=C3=A9bastien Han:
>> And RAMDISK devices are too expensive.
>>
>> It would make sense in your infra, but yes they are really expensive=
=2E
>
> We need something like tmpfs - running in local memory but support di=
o.
>
> Stefan
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
