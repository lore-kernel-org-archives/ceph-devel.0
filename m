From: Igor Fedotov <ifedotov@suse.de>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_osd:_fine-grained_statistics_for_?=
 =?UTF-8?Q?object_space_usage?=
Date: Tue, 5 Dec 2017 23:48:49 +0300
Message-ID: <72707128-ae25-2881-fd43-e8cd2b607d4e@suse.de>
References: <201711300849388246138@zte.com.cn>
 <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal>
 <CAJ4mKGb8uFJ738YU9BKT3S3h7ePhVFbLkz+KyEQn+e2S8BbArQ@mail.gmail.com>
 <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal>
 <d277e426-90a4-593b-fdbd-8ba19919de43@suse.de>
 <alpine.DEB.2.11.1712011427180.2819@piezo.novalocal>
 <bebb571e-2eab-48f3-0ea6-bb3470074a47@suse.de>
 <alpine.DEB.2.11.1712041424370.22619@piezo.novalocal>
 <CAJ4mKGa3RxHMrEWrZeMsYpMxYiVqiyrrFHO9_pGJJJ4kK970dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37431 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbdLEUs4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 15:48:56 -0500
In-Reply-To: <CAJ4mKGa3RxHMrEWrZeMsYpMxYiVqiyrrFHO9_pGJJJ4kK970dw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Xie Xingguo <xie.xingguo@zte.com.cn>



On 12/5/2017 1:15 AM, Gregory Farnum wrote:
> On Mon, Dec 4, 2017 at 6:24 AM, Sage Weil <sweil@redhat.com> wrote:
>> It's pretty straightforward to maintain collection-level metadata in the
>> common case, but I don't see how we can *also* support an O(1) split
>> operation.
> You're right we can't know the exact answer, but we already solve this
> problem for PG object counts and things by doing a fuzzy estimate
> (just dividing the PG values in two) until a scrub happens. I don't
> think having to do the same here is a reason to avoid it entirely.
>
>
>> This is why I suggested per-pool metadata.  Pool-level
>> information will still let us roll things up into a 'ceph df' type summary
>> of how well data in a particular pool is compressing, how sparse it is,
>> and so on, which should be sufficient for capacity planning purposes.
>> We'll also have per-OSD (by pool) information, which will tell us how
>> efficient, e.g., FileStore vs BlueStore is for a given data set (pool).
>>
>> What we don't get is per-PG granularity.  I don't think this matters much,
>> which a user doesn't really care about individual PGs anyway.
>>
>> We also don't get perfect accuracy when the cluster is degraded.  If
>> one or more PGs in a pool is undergoing backfill or whatever, the
>> OSD-level summations will be off.  We can *probably* figure out how to
>> correct for that by scaling the result based on what we know about the PG
>> recovery progress (e.g., how far along backfill on a PG is, and ignoring
>> the log-based recovery as an insignificant).
> Users don't care much about per-PG granularity in general, but as you
> note it breaks down in recovery. More than that, our *balancers* care
> very much about exactly what's in each PG, don't they?
>
>>> - PG instance at each OSD node retrieves collection statistics from OS when
>>> needed or tracks  it in RAM only.
>>> - Two statistics reports  to be distinguished:
>>>    a. Cluster-wide PG report - processing OSD retrieves statistics from both
>>> local and remote PGs and sums it on per-PG basis. E.g. total per-PG physical
>>> space usage can be obtained this way.
>>>    b. OSD-wide PG report (or just simple OSD summary report) - OSD collects PG
>>> statistics from local PGs only. E.g. logical/physical space usage at specific
>>> OSD can be examined this way.
>> ...and if we're talking about OSD-level stats, then I don't think any
>> different update path is needed.  We would just statfs() to return a pool
>> summation for each pool that exists on the OSD as well as the current
>> osd_stat_t (or whatever it is).
>>
>> Does that seem reasonable?
> I'm saying it's a "replay" mechanism or a two-phase commit, but I
> really don't think having delayed stat updates would take much doing.
> We can modify our in-memory state as soon as the ObjectStore replies
> back to us, and add a new "stats-persisted-thru" value to the pg_info.
> On any subsequent writes, we update the pg stats according to what we
> already know. Then on OSD boot, we compare that value to the last pg
> write, and query any objects which changed in the unaccounted pg log
> entries. It's a short, easy pass, right? And we're not talking new
> blocking queues or anything.
That's what I was thinking about too. Here is a very immature POC for 
this approach, seems doable so far:

https://github.com/ceph/ceph/pull/19350


> -Greg

