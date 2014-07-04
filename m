From: Gregory Farnum <greg@inktank.com>
Subject: Re: Q&A Session for ReplicatedPG.cc
Date: Thu, 3 Jul 2014 17:09:22 -0700
Message-ID: <CAPYLRzhkN6KdnvbWVOXEQoOrkp2xUzE9oWECxWi77yUPUhgu3Q@mail.gmail.com>
References: <53B458C4.7000908@redhat.com>
	<53B4602B.9010904@redhat.com>
	<CAPYLRzjdXWt16GFnrJx2pPPwstUo5suOMqvZgj6djUXz=xg3_w@mail.gmail.com>
	<53B4628D.9080908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:39341 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbaGDAJX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jul 2014 20:09:23 -0400
Received: by mail-qa0-f52.google.com with SMTP id w8so776885qac.25
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jul 2014 17:09:23 -0700 (PDT)
In-Reply-To: <53B4628D.9080908@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Pabon <lpabon@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I had a little more free time while debugging and testing some monitor
stuff today and went through part of these on the gist. I've run out
of time to keep going and it started looking less and less like the
right way to tackle the knowledge transfer, so some generic advice:
* Try not to focus on the line-by-line questions for systems which you
don't have any background in. There are a lot of questions which are
all about how eviction works, and I think you just want to get an
overview of that system before trying to figure out the details of
blocking on eviction.
* Be a little braver about going out to look at other functions. Some
of them are huge and won't go anywhere, but you had several notes
asking what functions do which were only one level deep, or even had
documentation attached to them! can_skip_promote(), for instance, is
just 10 lines long (commented!) and looks at the contents of the Op in
case it doesn't need the actual data. promote_object() kicks off a
whole series of events, but it's fairly straightforward to scroll down
the functions and see how the callbacks they put in place string them
together to actually gather up data from the base pool and bring it in
to the cache pool.
* Try using Eclipse or another IDE. I know it's wussy, but trust me,
it will make following logic chains through this code base a lot
easier.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Jul 2, 2014 at 12:50 PM, Luis Pabon <lpabon@redhat.com> wrote:
> Yeah I wish there was a way to do it inline.
>
> You can add them as comments at the bottom of the Gist or as a reply to this
> email.  Whatever is easiest.
>
> - Luis
>
>
> On 07/02/2014 03:44 PM, Gregory Farnum wrote:
>>
>> I had a few minutes unexpectedly free so I was going to answer (some
>> of) these, but I can't figure out a way to answer questions inline on
>> a gist. Did you have something else in mind? :)
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> On Wed, Jul 2, 2014 at 12:40 PM, Luis Pabon <lpabon@redhat.com> wrote:
>>>
>>> Bad link.  Here is the Gist:
>>> https://gist.github.com/lpabon/5d037d1cd2c0e482aeb5
>>>
>>> - Luis
>>>
>>>
>>> On 07/02/2014 03:08 PM, Luis Pabon wrote:
>>>>
>>>> Hi guys,
>>>>      I finally have been able to allocate some time to the Read Forward
>>>> cache work.  I started looking and navigating the code and have a few
>>>> questions on the behavior and expectations of some of the functions.  I
>>>> have
>>>> created a Gist with quetions prefixed by a ''//**''.  Do you mind
>>>> spending a
>>>> few minutes on those questions? Or, you can also point me at
>>>> documentation I
>>>> can read which can answer those questions.
>>>>
>>>> Gist:  https://gist.github.com/5d037d1cd2c0e482aeb5.git
>>>>
>>>> Thank you.
>>>>
>>>> - Luis
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
