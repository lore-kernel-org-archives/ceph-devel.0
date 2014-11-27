From: Mustafa Muhammad <mustafaa.alhamdaani@gmail.com>
Subject: Re: civetweb threads
Date: Thu, 27 Nov 2014 20:35:14 +0300
Message-ID: <CAMWPydSvRkcvijt8q_6rHUM1DwG+X7FVZ6gKTFuH3+NhBT7qsA@mail.gmail.com>
References: <CAMWPydT+q9Ds=mRNgXfhR2RA64=7UuMmczEjeg4Cdz3P5gaGuw@mail.gmail.com>
	<CAMWPydSJf0Wu9y1JJRTkBuRq80GPvWB7zWABM6rtQusOsPpy-A@mail.gmail.com>
	<CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:38691 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbaK0RfP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Nov 2014 12:35:15 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so7001411wgh.37
        for <ceph-devel@vger.kernel.org>; Thu, 27 Nov 2014 09:35:14 -0800 (PST)
In-Reply-To: <CABBk=J-oNuOnSfEU847y+cya+sdVmh02FSvP37AJvjrpjuupfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 15, 2014 at 7:18 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
> On Sat, Nov 15, 2014 at 3:55 AM, Mustafa Muhammad
> <mustafaa.alhamdaani@gmail.com> wrote:
>> On Sat, Nov 15, 2014 at 10:28 AM, Mustafa Muhammad
>> <mustafaa.alhamdaani@gmail.com> wrote:
>>> Hi,
>>> I am using civetweb in my radosgw, if I use "rgw thread pool size"
>>> that is more than 1024, civetweb doesn't work.
>>> e.g.
>>> rgw thread pool size = 1024
>>> rgw frontends = "civetweb port=80"
>>>
>>> #ps aux -L | grep rados | wc -l
>>> 1096
>>>
>>> everything works fine
>>>
>>>
>>> If I use:
>>> rgw thread pool size = 1025
>>> rgw frontends = "civetweb port=80"
>>>
>>> # ps aux -L | grep rados | wc -l
>>> 43
>>>
>>> And http server is not listening.
>>>
>>> If I don't use civetweb:
>>> rgw thread pool size = 10240
>>>
>>> # ps aux -L | grep rados | wc -l
>>> 10278
>>>
>>> Regards
>>>
>>> Mustafa Muhammad
>>
>> I found the problem, it is hardcoded here:
>> https://github.com/ceph/civetweb/blob/master/src/civetweb.c
>> as:
>> #define MAX_WORKER_THREADS 1024
>>
>> I increased it to 20480 an compiled from source, problem solved.
>> I should we make a patch, right?
>
> Please do, preferably a github pull request. Also, if you could open a
> ceph tracker issue with the specific would be great.
Hi,
I opened an issue upstream:
https://github.com/bel2125/civetweb/issues/50
And this default is going to change to 64k using this pull request:
https://github.com/bel2125/civetweb/commit/23bdcc98dd72ac421ed0a9e82d66977089fbfe63

I should make a pull request and issue here too, right?
I tried to register with ceph issue tracker, but misspelled the email
address (wrote @gmai.com), now I can't take the name "mustafa" again
(I waited the request to expire, but until now I can't register).
Who can delete that wrong registration request so I can take this
username again?

Regards
Mustafa
>
> Thanks,
> Yehuda
