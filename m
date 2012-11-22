From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 16:55:39 +0100
Message-ID: <CAOLwVUnJhU25xFPxkDkyPanJ3qm6gfrojQMByCP09rdytCOtmQ@mail.gmail.com>
References: <50AE44B9.7070804@profihost.ag> <824b8945-bd67-489d-9791-30804ef90d81@mailpro>
 <CAOLwVUm0QU07sHFrm-aWY709Dcm3d1V0uEbfmCrO+PB1ps93gw@mail.gmail.com> <015F5CFF-41D7-40B6-85CF-129D8FB23D94@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:58497 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab2KVSe5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:34:57 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so3841816lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 10:34:56 -0800 (PST)
In-Reply-To: <015F5CFF-41D7-40B6-85CF-129D8FB23D94@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>, Mark Nelson <mark.nelson@inktank.com>

Hum sorry, you're right. Forget about what I said :)


On Thu, Nov 22, 2012 at 4:54 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> I thought the Client would then write to the 2nd is this wrong?
>
> Stefan
>
> Am 22.11.2012 um 16:49 schrieb S=E9bastien Han <han.sebastien@gmail.c=
om>:
>
>>>> But who cares? it's also on the 2nd node. or even on the 3rd if yo=
u have
>>>> replicas 3.
>>
>> Yes but you could also suffer a crash while writing the first replic=
a.
>> If the journal is in tmpfs, there is nothing to replay.
>>
>>
>>
>> On Thu, Nov 22, 2012 at 4:35 PM, Alexandre DERUMIER <aderumier@odiso=
=2Ecom> wrote:
>>>
>>>>> But who cares? it's also on the 2nd node. or even on the 3rd if y=
ou have
>>>>> replicas 3.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
