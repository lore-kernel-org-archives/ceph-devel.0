From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: disabling buffer::raw crc cache
Date: Wed, 11 Nov 2015 16:42:51 +0800
Message-ID: <CANE=7sUPPpwew5ZmqCjRpDsz4Lsa9UtT6qdUFXr3XzY0uMWNyQ@mail.gmail.com>
References: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com>
	<CANE=7sWCUw5PiKwQqqq__6XpyF89jk1v_rsNgnfX10UtkRxXpQ@mail.gmail.com>
	<D2683AC6.8AB2%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33409 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbbKKImw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 03:42:52 -0500
Received: by oixx65 with SMTP id x65so715742oix.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 00:42:51 -0800 (PST)
In-Reply-To: <D2683AC6.8AB2%evgeniy.firsov@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

the code logic would touch crc cache is bufferlist::crc32c and invalida=
te_crc.
we call bufferlist::crc32 when sending or receiving message and
writing filejournal.
I miss something critical?

I am agree with you that the benefit from that cache cache is every lim=
it.

2015-11-11 16:25 GMT+08:00 Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>:
> Rb-tree construction, insertion, which needs memory allocation, mutex
> lock, unlock is more CPU expensive then streamlined crc calculation o=
f
> sometimes 100 bytes or less.
>
> On 11/11/15, 12:03 AM, "=E6=B1=A0=E4=BF=A1=E6=B3=BD" <xmdxcxz@gmail.c=
om> wrote:
>
>>Ah, I confuse that why the crc cache logic would exhaust so much cpu.
>>
>>2015-11-11 15:27 GMT+08:00 Evgeniy Firsov <Evgeniy.Firsov@sandisk.com=
>:
>>> Hello, Guys!
>>>
>>> While running CPU bound 4k block workload, I found that disabling c=
rc
>>> cache in the buffer::raw gives around 7% performance improvement.
>>>
>>> If there is no strong use case which benefit from that cache, we wo=
uld
>>> remove it entirely, otherwise conditionally enable it based on the
>>>object
>>> size.
>>>
>>> =E2=80=B9
>>> Evgeniy
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>--
>>Regards,
>>xinze
>



--=20
Regards,
xinze
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
