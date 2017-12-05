From: Igor Fedotov <ifedotov@suse.de>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_osd:_fine-grained_statistics_for_?=
 =?UTF-8?Q?object_space_usage?=
Date: Wed, 6 Dec 2017 00:58:36 +0300
Message-ID: <0b50c292-7f1d-1a8d-8ac3-1d4f09b557f9@suse.de>
References: <201711300849388246138@zte.com.cn>
 <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal>
 <CAJ4mKGb8uFJ738YU9BKT3S3h7ePhVFbLkz+KyEQn+e2S8BbArQ@mail.gmail.com>
 <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal>
 <d277e426-90a4-593b-fdbd-8ba19919de43@suse.de>
 <alpine.DEB.2.11.1712011427180.2819@piezo.novalocal>
 <bebb571e-2eab-48f3-0ea6-bb3470074a47@suse.de>
 <alpine.DEB.2.11.1712041424370.22619@piezo.novalocal>
 <CAJ4mKGa3RxHMrEWrZeMsYpMxYiVqiyrrFHO9_pGJJJ4kK970dw@mail.gmail.com>
 <72707128-ae25-2881-fd43-e8cd2b607d4e@suse.de>
 <CAJ4mKGYC5bbNhGG=AFPzV2MUxpoD-4xEAMK4=Q0sCCJu0uY0Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41327 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbdLEV6n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 16:58:43 -0500
In-Reply-To: <CAJ4mKGYC5bbNhGG=AFPzV2MUxpoD-4xEAMK4=Q0sCCJu0uY0Xw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Xie Xingguo <xie.xingguo@zte.com.cn>



On 12/6/2017 12:18 AM, Gregory Farnum wrote:
> On Tue, Dec 5, 2017 at 12:48 PM, Igor Fedotov <ifedotov@suse.de> wrote:
>>
>> On 12/5/2017 1:15 AM, Gregory Farnum wrote:
>>> On Mon, Dec 4, 2017 at 6:24 AM, Sage Weil <sweil@redhat.com> wrote:
>>>> It's pretty straightforward to maintain collection-level metadata in the
>>>> common case, but I don't see how we can *also* support an O(1) split
>>>> operation.
>>> You're right we can't know the exact answer, but we already solve this
>>> problem for PG object counts and things by doing a fuzzy estimate
>>> (just dividing the PG values in two) until a scrub happens. I don't
>>> think having to do the same here is a reason to avoid it entirely.
>>>
>>>
>>>> This is why I suggested per-pool metadata.  Pool-level
>>>> information will still let us roll things up into a 'ceph df' type
>>>> summary
>>>> of how well data in a particular pool is compressing, how sparse it is,
>>>> and so on, which should be sufficient for capacity planning purposes.
>>>> We'll also have per-OSD (by pool) information, which will tell us how
>>>> efficient, e.g., FileStore vs BlueStore is for a given data set (pool).
>>>>
>>>> What we don't get is per-PG granularity.  I don't think this matters
>>>> much,
>>>> which a user doesn't really care about individual PGs anyway.
>>>>
>>>> We also don't get perfect accuracy when the cluster is degraded.  If
>>>> one or more PGs in a pool is undergoing backfill or whatever, the
>>>> OSD-level summations will be off.  We can *probably* figure out how to
>>>> correct for that by scaling the result based on what we know about the PG
>>>> recovery progress (e.g., how far along backfill on a PG is, and ignoring
>>>> the log-based recovery as an insignificant).
>>> Users don't care much about per-PG granularity in general, but as you
>>> note it breaks down in recovery. More than that, our *balancers* care
>>> very much about exactly what's in each PG, don't they?
>>>
>>>>> - PG instance at each OSD node retrieves collection statistics from OS
>>>>> when
>>>>> needed or tracks  it in RAM only.
>>>>> - Two statistics reports  to be distinguished:
>>>>>     a. Cluster-wide PG report - processing OSD retrieves statistics from
>>>>> both
>>>>> local and remote PGs and sums it on per-PG basis. E.g. total per-PG
>>>>> physical
>>>>> space usage can be obtained this way.
>>>>>     b. OSD-wide PG report (or just simple OSD summary report) - OSD
>>>>> collects PG
>>>>> statistics from local PGs only. E.g. logical/physical space usage at
>>>>> specific
>>>>> OSD can be examined this way.
>>>> ...and if we're talking about OSD-level stats, then I don't think any
>>>> different update path is needed.  We would just statfs() to return a pool
>>>> summation for each pool that exists on the OSD as well as the current
>>>> osd_stat_t (or whatever it is).
>>>>
>>>> Does that seem reasonable?
>>> I'm saying it's a "replay" mechanism or a two-phase commit, but I
>>> really don't think having delayed stat updates would take much doing.
>>> We can modify our in-memory state as soon as the ObjectStore replies
>>> back to us, and add a new "stats-persisted-thru" value to the pg_info.
>>> On any subsequent writes, we update the pg stats according to what we
>>> already know. Then on OSD boot, we compare that value to the last pg
>>> write, and query any objects which changed in the unaccounted pg log
>>> entries. It's a short, easy pass, right? And we're not talking new
>>> blocking queues or anything.
>> That's what I was thinking about too. Here is a very immature POC for this
>> approach, seems doable so far:
>>
>> https://github.com/ceph/ceph/pull/19350
> To evaluate this usefully I think we'd need to see how these updates
> get committed if the OSD crashes before they're persisted? I expect
> that requires some kind of query interface...which, hrm, is actually a
> little more complicated if this is the model.
Well, here is a brief overview of the model. IMO it has to handle crashes...
1) While handling a bunch of transaction submitted via queue_transaction 
BlueStore collects statistics changes on per-collection basis and 
appends additional transactions to the bunch to persist them. I.e. at 
BlueStore level these changes are committed along with original write 
transactions. BlueStore also keeps these changes within a collection 
object until explicit reset and is able to return them to upper level 
via corresponding API call.
2) On the next transaction submission OSD/PG retrieve previous 
submission changes from BlueStore, apply them to its own statistics and 
append new transactions to make them persistent (at OSD level). 
ObjectStore API to be extended to trigger OS changes cleanup along with 
PG-related stats update - e.g. an additional flag for omap_setkeys 
transaction to request OS-level statistics changes reset. While handling 
this new bunch BlueStore appends resets persistent changes from the 
previous stage and inserts new changes if any. Step 2) might be repeated 
any number of times.

If OSD crashes between stages 1) and 2) recovery is performed 
automatically when submitting new transactions after OSD restore - 
changes are taken from BlueStore and applied while processing that new 
transaction.
The small drawback of the approach - PG stats are one step behind the 
actual values. This can be either tolerated or handled with simple 
tricks on statistics retrieval: return current PG stats + ones preserved 
at OS or track that delta at OSD separately etc...

Have I missed something?
> I was just thinking we'd compare the on-disk allocation info for an
> object to what we've persisted, but we actually only keep per-PG
> stats, right? That's not great. :/

