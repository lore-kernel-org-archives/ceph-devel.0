From: Ning Yao <zay11022@gmail.com>
Subject: Re: disabling buffer::raw crc cache
Date: Wed, 11 Nov 2015 18:05:05 +0800
Message-ID: <CALZt5jwOOp1gnBqO1vbmj2Kyborebz_Os79YcE1zeTMwumfp8A@mail.gmail.com>
References: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com>
	<CANE=7sWCUw5PiKwQqqq__6XpyF89jk1v_rsNgnfX10UtkRxXpQ@mail.gmail.com>
	<D2683AC6.8AB2%evgeniy.firsov@sandisk.com>
	<CALZt5jyuAH_aYYyzSEmn03QXaJQsfLiF=HMB6FJ5xEq6LMhFag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35341 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbKKKFH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 05:05:07 -0500
Received: by wmdw130 with SMTP id w130so106234506wmd.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2015 02:05:05 -0800 (PST)
In-Reply-To: <CALZt5jyuAH_aYYyzSEmn03QXaJQsfLiF=HMB6FJ5xEq6LMhFag@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Cc: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>the code logic would touch crc cache is bufferlist::crc32c and invali=
date_crc.
>Also for pg_log::_write_log(), but seems it is always miss and use at
>once, no need to cache crc actually?
Oh, no, it will be hit in FileJournal writing
Regards
Ning Yao


2015-11-11 18:03 GMT+08:00 Ning Yao <zay11022@gmail.com>:
>>>the code logic would touch crc cache is bufferlist::crc32c and inval=
idate_crc.
> Also for pg_log::_write_log(), but seems it is always miss and use at
> once, no need to cache crc actually?
>
> So we may need to add some option to enable or disable it, or some
> identifier to instruct bufferlist wheher crc should be cached when
> initiating a new bufferlist. I think it may still be useful on the
> platform without hardware crc acceleration or large chunks writing (a=
s
> it may relate to the length of buffer::ptr). So we can bypass the
> small  buffer::ptr without crc cache Or also don't cache the things
> like pg_info, attrs as they are always not reused in FileJournal
> writing?
> Regards
> Ning Yao
>
>
> 2015-11-11 16:25 GMT+08:00 Evgeniy Firsov <Evgeniy.Firsov@sandisk.com=
>:
>> Rb-tree construction, insertion, which needs memory allocation, mute=
x
>> lock, unlock is more CPU expensive then streamlined crc calculation =
of
>> sometimes 100 bytes or less.
>>
>> On 11/11/15, 12:03 AM, "=E6=B1=A0=E4=BF=A1=E6=B3=BD" <xmdxcxz@gmail.=
com> wrote:
>>
>>>Ah, I confuse that why the crc cache logic would exhaust so much cpu=
=2E
>>>
>>>2015-11-11 15:27 GMT+08:00 Evgeniy Firsov <Evgeniy.Firsov@sandisk.co=
m>:
>>>> Hello, Guys!
>>>>
>>>> While running CPU bound 4k block workload, I found that disabling =
crc
>>>> cache in the buffer::raw gives around 7% performance improvement.
>>>>
>>>> If there is no strong use case which benefit from that cache, we w=
ould
>>>> remove it entirely, otherwise conditionally enable it based on the
>>>>object
>>>> size.
>>>>
>>>> =E2=80=B9
>>>> Evgeniy
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>>--
>>>Regards,
>>>xinze
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
