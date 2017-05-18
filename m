From: Ning Yao <zay11022@gmail.com>
Subject: Re: RBD client wallclock profile during 4k random writes
Date: Fri, 19 May 2017 00:33:01 +0800
Message-ID: <CALZt5jytJPkvOuaF6QUH2QYRVbK7D3oVMUkmXnQuPqP61KpqoQ@mail.gmail.com>
References: <9e13c0f0-cde1-b8ec-d469-da5d87c5ba74@redhat.com>
 <CA+aFP1BBTvbNca1qEQeWyPYbiU497+cDqqO0OpCHnQNUy5+xdw@mail.gmail.com>
 <59cdc3c9-e6b0-bd9f-9826-33874a7423e1@redhat.com> <b7cd8ab2-42a9-dd42-4b09-4910365a8674@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37896 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753332AbdERQdD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 18 May 2017 12:33:03 -0400
Received: by mail-it0-f49.google.com with SMTP id e65so31525151ita.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 May 2017 09:33:02 -0700 (PDT)
In-Reply-To: <b7cd8ab2-42a9-dd42-4b09-4910365a8674@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>
Cc: dillaman@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

2017-05-11 8:21 GMT+08:00 Mark Nelson <mnelson@redhat.com>:
>
>
> On 05/10/2017 06:24 PM, Mark Nelson wrote:
>>
>>
>>
>> On 05/10/2017 05:31 PM, Jason Dillaman wrote:
>>>
>>> On Wed, May 10, 2017 at 6:10 PM, Mark Nelson <mnelson@redhat.com> wrote:
>>>>
>>>> 1) 7 - tp_librbd, line 82
>>>>
>>>> Lots of stuff going on here, but the big thing is all the time spent in
>>>> librbd::ImageCtx::write_to_cache.  70.2% of the total time in this
>>>> thread is
>>>> spent in ObjectCacher::writex with lots of nested stuff, but if you
>>>> look all
>>>> the way down on line 1293, another 11.8% of the time is spent in
>>>> Locker()
>>>> and 1.5% of the time spent in ~Locker().
>>>
>>>
>>> Yes -- the ObjectCacher is long overdue for a re-write since it's
>>> single threaded. It looks like you were essentially performing
>>> writethrough as well. I'd imagine you would just be better off
>>> disabling the rbd cache when doing high-performance random write
>>> workloads since you are going to get zero benefit from the cache with
>>> that workload -- at least that's what I usually recommend.
>>>
>>
>> Often I do turn rbd cache off for bluestore testing.  This was an older
>> conf file where I inadvertently hadn't disabled it.  Still, it's an
>> unfortunate choice that has to be made, potentially by someone other
>> than the user running the workload. :/
>
>
> Yep, disabling rbd cache bumped 4K write IOPS from ~14K to ~31K, and closer
> ~36-37K with a higher IO depth at around 410% CPU usage.
>
> trace without rbd cache here:
>
> https://pastebin.com/t8FFsWNb
>
> looking a lot better, though thread 5 (tp_librbd) is still pegging. Still a
> little bit of locking in various places.  a bit more time shifted into
> _calc_target.
>
> async msgr is as expected a lot busier than it used to be.
>

So it seems calc pg mapping is an expensive operation. And
furthermore, if we always need to retry the loop because of collision
and rejection.

What about using a mapping cache table to look up the pg mapping
directly once it is calculated? I think We can re-calucate the pg
mapping until the osdmap epoch is changed, otherwise, pg mapping
should be consistent during one osdmap.

Regards
Ning Yao
