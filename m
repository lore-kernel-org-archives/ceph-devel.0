From: Mark Nelson <mnelson@redhat.com>
Subject: Re: RBD client wallclock profile during 4k random writes
Date: Wed, 10 May 2017 19:21:23 -0500
Message-ID: <b7cd8ab2-42a9-dd42-4b09-4910365a8674@redhat.com>
References: <9e13c0f0-cde1-b8ec-d469-da5d87c5ba74@redhat.com>
 <CA+aFP1BBTvbNca1qEQeWyPYbiU497+cDqqO0OpCHnQNUy5+xdw@mail.gmail.com>
 <59cdc3c9-e6b0-bd9f-9826-33874a7423e1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbdEKAV0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 10 May 2017 20:21:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D4B664D94
        for <ceph-devel@vger.kernel.org>; Thu, 11 May 2017 00:21:26 +0000 (UTC)
In-Reply-To: <59cdc3c9-e6b0-bd9f-9826-33874a7423e1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 05/10/2017 06:24 PM, Mark Nelson wrote:
>
>
> On 05/10/2017 05:31 PM, Jason Dillaman wrote:
>> On Wed, May 10, 2017 at 6:10 PM, Mark Nelson <mnelson@redhat.com> wrote:
>>> 1) 7 - tp_librbd, line 82
>>>
>>> Lots of stuff going on here, but the big thing is all the time spent in
>>> librbd::ImageCtx::write_to_cache.  70.2% of the total time in this
>>> thread is
>>> spent in ObjectCacher::writex with lots of nested stuff, but if you
>>> look all
>>> the way down on line 1293, another 11.8% of the time is spent in
>>> Locker()
>>> and 1.5% of the time spent in ~Locker().
>>
>> Yes -- the ObjectCacher is long overdue for a re-write since it's
>> single threaded. It looks like you were essentially performing
>> writethrough as well. I'd imagine you would just be better off
>> disabling the rbd cache when doing high-performance random write
>> workloads since you are going to get zero benefit from the cache with
>> that workload -- at least that's what I usually recommend.
>>
>
> Often I do turn rbd cache off for bluestore testing.  This was an older
> conf file where I inadvertently hadn't disabled it.  Still, it's an
> unfortunate choice that has to be made, potentially by someone other
> than the user running the workload. :/

Yep, disabling rbd cache bumped 4K write IOPS from ~14K to ~31K, and 
closer ~36-37K with a higher IO depth at around 410% CPU usage.

trace without rbd cache here:

https://pastebin.com/t8FFsWNb

looking a lot better, though thread 5 (tp_librbd) is still pegging. 
Still a little bit of locking in various places.  a bit more time 
shifted into _calc_target.

async msgr is as expected a lot busier than it used to be.

>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
