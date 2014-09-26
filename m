From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Weekly performance meeting
Date: Fri, 26 Sep 2014 08:58:56 -0400
Message-ID: <CANP1eJGTx6vwBgnKZjHmwwwDbYOTs-Q6sUjYAt7ei1YqsDdeaQ@mail.gmail.com>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
	<CACJqLyba+ODROaTno844jCt8JHuhb35A_f4qAawrmUQa+oR=Fg@mail.gmail.com>
	<CAMm-wcJVtmbgr0wW28OmVg+7B_DMszSM0E7YTUJFFNiBuC7OVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:55456 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbaIZM66 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 08:58:58 -0400
Received: by mail-lb0-f169.google.com with SMTP id u10so1036521lbd.28
        for <ceph-devel@vger.kernel.org>; Fri, 26 Sep 2014 05:58:56 -0700 (PDT)
In-Reply-To: <CAMm-wcJVtmbgr0wW28OmVg+7B_DMszSM0E7YTUJFFNiBuC7OVg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Yuan <yuandong1222@gmail.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Somnath Roy <Somnath.Roy@sandisk.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Kasper Dieter <dieter.kasper@ts.fujitsu.com>, PVonStamwitz@us.fujitsu.com, "Shu, Xinxin" <xinxin.shu@intel.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, xiaoxi.chen@intel.com, "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, jianpeng.ma@intel.com, gdror@mellanox.com, vuhuong@mellanox.com, Mark Nelson <mark.nelson@inktank.com>

On Fri, Sep 26, 2014 at 2:30 AM, Dong Yuan <yuandong1222@gmail.com> wrote:
> Some data can support Haomai's points.
>
>> 1. encode/decode plays remarkable latency, especially in
>> ObjectStore::Transaction. I'm urgen in refactor ObjectStore API to
>> avoid encode/decode codes. It seemed has be signed in note(- remove
>> serialization from ObjectStore::Transaction (ymmv))
>
> My environment, single OSD on a single SSD with filestore_blackhole = true.
>
> With All transaction encode, 10000 4K WriteFull operations by single
> thread need about 14.3s. While without transaction encode, the same
> test can be finished in about 11.5s.
>
> Considering the FileStore needs to decode the bufferlist too,
> encode/decode cost more than 20% time!
>
> Oprofile results can validate this problem too: methods used by
> encode/decode sometimes take 9 of the top 10.
>
>> 2. obvious latency for threadpool/workqueue model. Do we consider to
>> impl performance optimization workqueue to replace existing critical
>> workqueue such as op_wq in OSD.h and op_wq in FileStore.h. Now in my
>> AsyncMessenger impl, I will try to use custom and simple workqueue
>> impl to improve performance.
>
> When I analyze the latency of a 4K object WriteFull operation, I put
> static probes into codes to measure times used by OpWQ. I test 10000
> 4K object WriteFull operations and average the results.
>
> I found it spends 158us for the OpWQ for each IO, including 30us to
> enqueue, 108us in the queue, and 20us to dequeue. It takes more than
> 20% time of PG layer (not including msg and os layer) when encode is
> ignored.
>
> Maybe a more effective ThreadPool/WorkQueue Model is needed or at
> least some improvement for WorkQueues in the IO path to reduce the
> latency.

There's a number of things here. I haven't look at the code in Giant
so take my statements here with a grain of salt.

First, I have recently submitted a series of patches to kernel to add
a new preadv2 syscall that lets you do a "fast read" out of the page
cache the point being that you can skip the whole disk IO queue in
user space in the cases it's already cached (thus reducing the
latency). Obviously this doesn't do much for writes (yet, Christoph
Heldwig is working on that). Samba expressed an interest using these
new syscalls as well.

LWN article about it: http://lwn.net/Articles/612483/
Here's the latest patch:
http://thread.gmane.org/gmane.linux.kernel.aio.general/4306
The architecture that would benefit from "fast reads":
http://i.imgur.com/f8Pla7j.png
Previous version of the patch (mostly because there was a lot more
conversation there): https://lkml.org/lkml/2014/9/17/671

Second, when you have a very fast SSD device that can do up to 100k
iops the naive queueing/thread pool implementation becomes an issue.
Like you mentioned it's a lot of extra latency. The solution for this
is not easy and thankfully people have done lots of research work for
you, you'll still need lots of trial an error to get it figured out.
Here's some common strategies:

You're going to consider your queue. Obviously you're going to want to
get away from a single crude mutex. First is multiple queues each with
mutex / non-locking queues? Then if you choose non-locking how are you
going to build your queueing system. Is it going to be a single MPMC
queue (slowest), MPSC (faster, but things will get stuck behind slow
requests), MPSC with work stealing (complicated) or FastFlow style
network of SPSC (needs arbiter thread).
- How do you handle empty queue? Spin with fallback reduces latency
but it does waste CPU cycles which could be used by a different OSD
process / EC decoding.
- Eventcount versus Seamphore (for blocking / notification) after all
you don't want to spin forever. You really want an Eventcount since
you don't want to have have a mutex with you're semaphore (since
that's what you tried getting rid of). Here you get into platform
specific implementations (futexes).
- If the queue has priorities, is it okay if our priorities aren't
perfectly enforced? In general this really complicates things and you
pretty much best off having a FastFlow like queue so your arbiter
thread can do some kind of prioritization.

>
> On 26 September 2014 10:27, Haomai Wang <haomaiwang@gmail.com> wrote:
>> Thanks for sage!
>>
>> I'm on the flight at Oct 1. :-(
>>
>> Now my team is mainly worked on the performance of ceph, we have
>> observed these points:
>>
>> 1. encode/decode plays remarkable latency, especially in
>> ObjectStore::Transaction. I'm urgen in refactor ObjectStore API to
>> avoid encode/decode codes. It seemed has be signed in note(- remove
>> serialization from ObjectStore::Transaction (ymmv))
>> 2. obvious latency for threadpool/workqueue model. Do we consider to
>> impl performance optimization workqueue to replace existing critical
>> workqueue such as op_wq in OSD.h and op_wq in FileStore.h. Now in my
>> AsyncMessenger impl, I will try to use custom and simple workqueue
>> impl to improve performance.
>> 3. Large lock in client library such as ObjectCacher
>>
>>
>> On Fri, Sep 26, 2014 at 2:27 AM, Sage Weil <sweil@redhat.com> wrote:
>>> Hi everyone,
>>>
>>> A number of people have approached me about how to get more involved with
>>> the current work on improving performance and how to better coordinate
>>> with other interested parties.  A few meetings have taken place offline
>>> with good results but only a few interested parties were involved.
>>>
>>> Ideally, we'd like to move as much of this dicussion into the public
>>> forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always
>>> sufficient, however.  I'd like to also set up a regular weekly meeting
>>> using google hangouts or bluejeans so that all interested parties can
>>> share progress.  There are a lot of things we can do during the Hammer
>>> cycle to improve things but it will require some coordination of effort.
>>>
>>> Among other things, we can discuss:
>>>
>>>  - observed performance limitations
>>>  - high level strategies for addressing them
>>>  - proposed patch sets and their performance impact
>>>  - anything else that will move us forward
>>>
>>> One challenge is timezones: there are developers in the US, China, Europe,
>>> and Israel who may want to join.  As a starting point, how about next
>>> Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's
>>>
>>>   8:00 (PDT, California)
>>>  15:00 (UTC)
>>>  18:00 (IDT, Israel)
>>>  23:00 (CST, China)

I'd love to participate and contributed to the discussion and solution
but due to my obligations it's hard to commit to a weekly time so it's
my hope that a lot of this is done on the mailing list.

>>>
>>> That is surely not the ideal time for everyone but it can hopefully be a
>>> starting point.
>>>
>>> I've also created an etherpad for collecting discussion/agenda items at
>>>
>>>         http://pad.ceph.com/p/performance_weekly
>>>
>>> Is there interest here?  Please let everyone know if you are actively
>>> working in this area and/or would like to join, and update the pad above
>>> with the topics you would like to discuss.
>>>
>>> Thanks!
>>> sage
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Dong Yuan
> Email:yuandong1222@gmail.com



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
