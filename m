From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Re: [ceph-users] v0.80 Firefly released
Date: Fri, 09 May 2014 17:48:56 -0400
Message-ID: <536D4D48.5040307@cloudapt.com>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net> <536A54C6.4060202@cern.ch> <CAPYLRzhyt3i0sXOGrqZxzrH02+VOjBeMS37xk8ua2K2C2oydkw@mail.gmail.com> <536A78F3.8020607@cloudapt.com> <CABYiri9GJjbOEzzHjUAa1nBmah0nr1AoY17q1Vb=cwih+aE+WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:61496 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429AbaEIVtA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 May 2014 17:49:00 -0400
Received: by mail-ie0-f172.google.com with SMTP id as1so4729000iec.31
        for <ceph-devel@vger.kernel.org>; Fri, 09 May 2014 14:48:59 -0700 (PDT)
In-Reply-To: <CABYiri9GJjbOEzzHjUAa1nBmah0nr1AoY17q1Vb=cwih+aE+WA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Gregory Farnum <greg@inktank.com>, Dan van der Ster <daniel.vanderster@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Andrey,

In initial testing, it looks like it may work rather efficiently.

1) Upgrade all mon, osd, and clients to Firefly. Restart everything so 
no legacy ceph code is running.


2) Add "mon osd allow primary affinity = true" to ceph.conf, distribute 
ceph.conf to nodes.


3) Inject it into the monitors to make it immediately active:

# ceph tell mon.* injectargs '--mon_osd_allow_primary_affinity true'

Ignore the "mon.a: injectargs: failed to parse arguments: true" 
warnings, this appears to be a bug [0].


4) Check to see how many PGs have OSD 0 as their primary:

ceph pg dump | awk '{ print $15 " " $14 " " $1}' | egrep "^0" | wc -l


5) Set primary affinity to zero on osd.0:

# ceph osd primary-affinity osd.0 0

If you didn't set mon_osd_allow_primary_affinity properly above, you'll 
get a helpful error message.


6) Confirm it worked by comparing how many PGs have osd.0 as their primary.

ceph pg dump | awk '{ print $15 }' | egrep "^0" | wc -l

On my small dev cluster, the number goes to 0 in less than 10 seconds.


7) Perform maintenance and watch ceph -w. If you didn't get all your 
clients updated, you'll likely see a bunch of errors in ceph -w like:

2014-05-09 21:12:42.534900 osd.0 [WRN] client.130959 x.x.x.x:0/1015056 
misdirected client.130959.0:619497 pg 4.90eaebe to osd.0 not [6,1,0] in 
e1650/1650

8) After you are done with maintenance, reset the primary affinity:

# ceph osd primary-affinity osd.0 1


I have not scaled up my testing, but it looks like this has the 
potential to work well in preventing unnecessary read starvation in 
certain situations.


0: http://tracker.ceph.com/issues/8323#note-1


Cheers,
Mike Dawson

On 5/8/2014 8:20 AM, Andrey Korolyov wrote:
> Mike, would you mind to write your experience if you`ll manage to get
> this flow through first? I hope I`ll be able to conduct some tests
> related to 0.80 only next week, including maintenance combined with
> primary pointer relocation - one of most crucial things remaining in
> Ceph for the production performance.
>
> On Wed, May 7, 2014 at 10:18 PM, Mike Dawson <mike.dawson@cloudapt.com> wrote:
>>
>> On 5/7/2014 11:53 AM, Gregory Farnum wrote:
>>>
>>> On Wed, May 7, 2014 at 8:44 AM, Dan van der Ster
>>> <daniel.vanderster@cern.ch> wrote:
>>>>
>>>> Hi,
>>>>
>>>>
>>>> Sage Weil wrote:
>>>>
>>>> * *Primary affinity*: Ceph now has the ability to skew selection of
>>>>     OSDs as the "primary" copy, which allows the read workload to be
>>>>     cheaply skewed away from parts of the cluster without migrating any
>>>>     data.
>>>>
>>>>
>>>> Can you please elaborate a bit on this one? I found the blueprint [1] but
>>>> still don't quite understand how it works. Does this only change the
>>>> crush
>>>> calculation for reads? i.e writes still go to the usual primary, but
>>>> reads
>>>> are distributed across the replicas? If so, does this change the
>>>> consistency
>>>> model in any way.
>>>
>>>
>>> It changes the calculation of who becomes the primary, and that
>>> primary serves both reads and writes. In slightly more depth:
>>> Previously, the primary has always been the first OSD chosen as a
>>> member of the PG.
>>> For erasure coding, we added the ability to specify a primary
>>> independent of the selection ordering. This was part of a broad set of
>>> changes to prevent moving the EC "shards" around between different
>>> members of the PG, and means that the primary might be the second OSD
>>> in the PG, or the fourth.
>>> Once this work existed, we realized that it might be useful in other
>>> cases, because primaries get more of the work for their PG (serving
>>> all reads, coordinating writes).
>>> So we added the ability to specify a "primary affinity", which is like
>>> the CRUSH weights but only impacts whether you become the primary. So
>>> if you have 3 OSDs that each have primary affinity = 1, it will behave
>>> as normal. If two have primary affinity = 0, the remaining OSD will be
>>> the primary. Etc.
>>
>>
>> Is it possible (and/or advisable) to set primary affinity low while
>> backfilling / recovering an OSD in an effort to prevent unnecessary slow
>> reads that could be directed to less busy replicas? I suppose if the cost of
>> setting/unsetting primary affinity is low and clients are starved for reads
>> during backfill/recovery from the osd in question, it could be a win.
>>
>> Perhaps the workflow for maintenance on osd.0 would be something like:
>>
>> - Stop osd.0, do some maintenance on osd.0
>> - Read primary affinity of osd.0, store it for later
>> - Set primary affinity on osd.0 to 0
>> - Start osd.0
>> - Enjoy a better backfill/recovery experience. RBD clients happier.
>> - Reset primary affinity on osd.0 to previous value
>>
>> If the cost of setting primary affinity is low enough, perhaps this strategy
>> could be automated by the ceph daemons.
>>
>> Thanks,
>> Mike Dawson
>>
>>
>>> -Greg
>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
