From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] include: ceph: Fix encode and decode type conversions
Date: Thu, 18 Feb 2016 17:02:25 +0100
Message-ID: <CAOi1vP8NycKxd2sp2qMS7AoZxTSnFSGdxOj9_sXU=sykqsR6hw@mail.gmail.com>
References: <1455505313-1298-1-git-send-email-deepa.kernel@gmail.com>
	<6833154.QUCaxj5s9M@wuerfel>
	<CABeXuvq1=LTOYybAUkwA=07NkoVJTBvnaZH+K_fhhMGKfWSH+A@mail.gmail.com>
	<13047587.yVxNh7PhNK@wuerfel>
	<CABeXuvqAgzCYGDh51rZK-MEh88T0gsxO4dRcFZVL-JWYXjtQzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36964 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425080AbcBRQC2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Feb 2016 11:02:28 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so32335486wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 18 Feb 2016 08:02:27 -0800 (PST)
In-Reply-To: <CABeXuvqAgzCYGDh51rZK-MEh88T0gsxO4dRcFZVL-JWYXjtQzg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>

On Thu, Feb 18, 2016 at 10:35 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Thu, Feb 18, 2016 at 1:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 17 February 2016 22:02:11 Deepa Dinamani wrote:
>>>
>>> I checked the server side code.
>>> So the server side also reads whatever is sent over wire as u32 and
>>> then assigns it to a time_t.
>>
>> I think the more important question is whether the server actually
>> does anything with the timestamp other than pass it back to the
>> client. If not, the interpretation it totally up to the client
>> and the type on the server has no meaning (as long as it can store
>> at least as many bits as the wire protocol, and passes all bits
>> back the same way).
>
> Timestamps do get interpreted and written to on the server according to the
> files in the mds directory.
>
>>> Do you have any documentation about the wire protocol?
>>>
>>> To me, the wire protocol seems to have been designed to support only
>>> positive time values(u32).
>>
>> I think assigning to a time_t usually just means that this wasn't
>> completely thought through when it got implemented (which we already
>> know from the fact that it started out using a 32-bit number from
>> the time). It's totally possible that this code originated on a 32-bit
>> machine and was meant to encode a signed number and that the behavior
>> changed without anyone noticing when it got ported to a 64-bit
>> architecture for the first time.
>>
>>> This means ceph can represent times from 1970 - 2106 as long as both
>>> server and client are 64 bit machines.
>>> Or, client is 64 bit and server does not operate on time values.
>>> And, on 32 bit machines implementation will be broken in 2038.
>>
>>> I will change back the above code to not use any casts(as they are a
>>> no-op) as on the server side and note the above
>>> things in the file and changelog:
>>>
>>>  static inline void ceph_decode_timespec(struct timespec *ts,
>>>                                          const struct ceph_timespec *tv)
>>>  {
>>>  -       ts->tv_sec = (__kernel_time_t)le32_to_cpu(tv->tv_sec);
>>>  -       ts->tv_nsec = (long)le32_to_cpu(tv->tv_nsec);
>>>  +       ts->tv_sec = le32_to_cpu(tv->tv_sec);
>>>  +       ts->tv_nsec = le32_to_cpu(tv->tv_nsec);
>>>   }
>>
>> Ok. I really like to have an explicit range-extension as well, but
>> as you say, your patch above does not change behavior.
>
> You mean change the functions and data types on both sides?
> Not sure if this is meant for me or the Ceph team.
>
>> I would write this as
>>
>>         ts->tv_sec = (__u64)le32_to_cpu(tv->tv_sec);
>>         ts->tv_nsec = le32_to_cpu(tv->tv_nsec);
>>
>> which is again the same thing, but leaves less ambiguity.
>
> Will do.

If we are going to touch this function at all, let's drop all casts and
just add a comment along the lines of "the lack of cast/sign-extension
here is intentional, this function has a counterpart on the server side
which also lacks cast/sign-extension, etc".  To someone who is not up
on these subtleties, the __u64 cast is going to be more confusing than
explicit...

Thanks,

                Ilya
