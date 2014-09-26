From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Weekly performance meeting
Date: Fri, 26 Sep 2014 10:45:38 +0800
Message-ID: <CACJqLyZBy9=7QSM_77EBf+gvHBJu_EQozQpokisgpvF+F5sL_g@mail.gmail.com>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net>
	<CACJqLyba+ODROaTno844jCt8JHuhb35A_f4qAawrmUQa+oR=Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:62184 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbaIZCpj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Sep 2014 22:45:39 -0400
Received: by mail-we0-f170.google.com with SMTP id x48so7497910wes.29
        for <ceph-devel@vger.kernel.org>; Thu, 25 Sep 2014 19:45:38 -0700 (PDT)
In-Reply-To: <CACJqLyba+ODROaTno844jCt8JHuhb35A_f4qAawrmUQa+oR=Fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Somnath Roy <Somnath.Roy@sandisk.com>, Allen Samuels <Allen.Samuels@sandisk.com>, dieter.kasper@ts.fujitsu.com, PVonStamwitz@us.fujitsu.com, "Shu, Xinxin" <xinxin.shu@intel.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, xiaoxi.chen@intel.com, Milosz Tanski <milosz@adfin.com>, zhiqiang.wang@intel.com, jianpeng.ma@intel.com, gdror@mellanox.com, vuhuong@mellanox.com, Mark Nelson <mark.nelson@inktank.com>

Some detail optimization points:

1. FileStore/KeyValueStore worker threads will complete with a global
object("meta" collection, "infos" oid) which is used only by omap_*
methods. (https://github.com/ceph/ceph/pull/2502)
2. Sparse recovery when using fiemap(https://github.com/ceph/ceph/pull/2137)


On Fri, Sep 26, 2014 at 10:27 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> Thanks for sage!
>
> I'm on the flight at Oct 1. :-(
>
> Now my team is mainly worked on the performance of ceph, we have
> observed these points:
>
> 1. encode/decode plays remarkable latency, especially in
> ObjectStore::Transaction. I'm urgen in refactor ObjectStore API to
> avoid encode/decode codes. It seemed has be signed in note(- remove
> serialization from ObjectStore::Transaction (ymmv))
> 2. obvious latency for threadpool/workqueue model. Do we consider to
> impl performance optimization workqueue to replace existing critical
> workqueue such as op_wq in OSD.h and op_wq in FileStore.h. Now in my
> AsyncMessenger impl, I will try to use custom and simple workqueue
> impl to improve performance.
> 3. Large lock in client library such as ObjectCacher
>
>
> On Fri, Sep 26, 2014 at 2:27 AM, Sage Weil <sweil@redhat.com> wrote:
>> Hi everyone,
>>
>> A number of people have approached me about how to get more involved with
>> the current work on improving performance and how to better coordinate
>> with other interested parties.  A few meetings have taken place offline
>> with good results but only a few interested parties were involved.
>>
>> Ideally, we'd like to move as much of this dicussion into the public
>> forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always
>> sufficient, however.  I'd like to also set up a regular weekly meeting
>> using google hangouts or bluejeans so that all interested parties can
>> share progress.  There are a lot of things we can do during the Hammer
>> cycle to improve things but it will require some coordination of effort.
>>
>> Among other things, we can discuss:
>>
>>  - observed performance limitations
>>  - high level strategies for addressing them
>>  - proposed patch sets and their performance impact
>>  - anything else that will move us forward
>>
>> One challenge is timezones: there are developers in the US, China, Europe,
>> and Israel who may want to join.  As a starting point, how about next
>> Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's
>>
>>   8:00 (PDT, California)
>>  15:00 (UTC)
>>  18:00 (IDT, Israel)
>>  23:00 (CST, China)
>>
>> That is surely not the ideal time for everyone but it can hopefully be a
>> starting point.
>>
>> I've also created an etherpad for collecting discussion/agenda items at
>>
>>         http://pad.ceph.com/p/performance_weekly
>>
>> Is there interest here?  Please let everyone know if you are actively
>> working in this area and/or would like to join, and update the pad above
>> with the topics you would like to discuss.
>>
>> Thanks!
>> sage
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
