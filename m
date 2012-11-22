From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:57:19 +0100
Message-ID: <5BB19DE7-8084-4894-B328-3EBC7C784BCD@profihost.ag>
References: <50AE44B9.7070804@profihost.ag> <824b8945-bd67-489d-9791-30804ef90d81@mailpro> <CAOLwVUm0QU07sHFrm-aWY709Dcm3d1V0uEbfmCrO+PB1ps93gw@mail.gmail.com> <015F5CFF-41D7-40B6-85CF-129D8FB23D94@profihost.ag> <CAOLwVUnJhU25xFPxkDkyPanJ3qm6gfrojQMByCP09rdytCOtmQ@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58026 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab2KVSoE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:44:04 -0500
In-Reply-To: <CAOLwVUnJhU25xFPxkDkyPanJ3qm6gfrojQMByCP09rdytCOtmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?S=C3=A9bastien_Han?= <han.sebastien@gmail.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, Mark Nelson <mark.nelson@inktank.com>

Otherwise you would have the same problem with the disk crashes

Am 22.11.2012 um 16:55 schrieb S=C3=A9bastien Han <han.sebastien@gmail.=
com>:

> Hum sorry, you're right. Forget about what I said :)
>=20
>=20
> On Thu, Nov 22, 2012 at 4:54 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> I thought the Client would then write to the 2nd is this wrong?
>>=20
>> Stefan
>>=20
>> Am 22.11.2012 um 16:49 schrieb S=C3=A9bastien Han <han.sebastien@gma=
il.com>:
>>=20
>>>>> But who cares? it's also on the 2nd node. or even on the 3rd if y=
ou have
>>>>> replicas 3.
>>>=20
>>> Yes but you could also suffer a crash while writing the first repli=
ca.
>>> If the journal is in tmpfs, there is nothing to replay.
>>>=20
>>>=20
>>>=20
>>> On Thu, Nov 22, 2012 at 4:35 PM, Alexandre DERUMIER <aderumier@odis=
o.com> wrote:
>>>>=20
>>>>>> But who cares? it's also on the 2nd node. or even on the 3rd if =
you have
>>>>>> replicas 3.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
