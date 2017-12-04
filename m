From: Igor Fedotov <ifedotov@suse.de>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_osd:_fine-grained_statistics_for_?=
 =?UTF-8?Q?object_space_usage?=
Date: Mon, 4 Dec 2017 14:23:41 +0300
Message-ID: <bebb571e-2eab-48f3-0ea6-bb3470074a47@suse.de>
References: <201711300849388246138@zte.com.cn>
 <alpine.DEB.2.11.1711300304240.8333@piezo.novalocal>
 <CAJ4mKGb8uFJ738YU9BKT3S3h7ePhVFbLkz+KyEQn+e2S8BbArQ@mail.gmail.com>
 <alpine.DEB.2.11.1711302125440.12766@piezo.novalocal>
 <d277e426-90a4-593b-fdbd-8ba19919de43@suse.de>
 <alpine.DEB.2.11.1712011427180.2819@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754170AbdLDLXq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Dec 2017 06:23:46 -0500
In-Reply-To: <alpine.DEB.2.11.1712011427180.2819@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Xie Xingguo <xie.xingguo@zte.com.cn>



On 12/1/2017 5:34 PM, Sage Weil wrote:
> On Fri, 1 Dec 2017, Igor Fedotov wrote:
>> On 12/1/2017 12:27 AM, Sage Weil wrote:
>>> On Thu, 30 Nov 2017, Gregory Farnum wrote:
>>>> On Wed, Nov 29, 2017 at 7:06 PM Sage Weil <sweil@redhat.com> wrote:
>>>> It would take some doing but this might be a good time to start adding
>>>> delayed work. We could get the stat updates as part of the objectstore
>>>> callback and incorporate them into future disk ops, and part of the
>>>> startup/replay process could be querying for stat updates to objects
>>>> we haven’t committed yet.
>>>>
>>>> ...except we don’t really have an OSD-level or pg replay phase any
>>>> more, do we. Hrmm. And doing it in the transaction would require some
>>>> sort of set-up/query phase to the transaction, then finalization and
>>>> submission, which isn’t great since it impacts checksumming and other
>>>> stuff (although *hopefully* not actual allocation).
>>> Hmm, and there is a larger problem here: we can't really make this
>>> ObjectStore implementation specific because it may vary across OSDs (some
>>> may be BlueStore, some may be FileStore).
>> IMO first of all we should determine what parameter(s) would we track. Object
>> logical space usage (as we do now) or physical allocations or both.
>> For logical space tracking it's probably not an issue to have uniform results
>> among different stores - FileStore replicates what we have at OSD, BlueStore
>> do the same on its own data structures.
>> or physical allocation tracking we must handle different results from
>> different store types as they are really not the same. I.e. object physical
>> size (with 3 replications) should be  calculated as
>>    size = size_rep1 + size_rep2 + size_rep3
>> not
>>    size = size_primary * 3
> This level of detail is appealing, but the cost is high.  It would
> require a two-phase update to implement, as Greg suggested: first
> doing the actual update, and then later a follow-up that adjusts
> the stats.
>> Also wondering if mixed object store environments have any non-academic
>> value?
> Definitely.  It happens in hybrid clusters (some HDD, some SSD, where you
> may end up with backends tuned for each), and more commonly for any
> existing cluster that is in the (slow) process of migrating from one
> backend to anoterh (e.g., filestore -> bluestore).  We have to design for
> heterogeneity being the norm if we want to scale.
>
> I see three paths:
>
> 1- We drop this and give up on a fine-grained mapping between logical
> usage and physical usage.  PG stats would reflect the logical sizes
> of objects (as they have historically) and OSDs would report actual
> utilization (after replication, compression, etc.).
>
> 2- We add a ton of complexity to a pipeline we are trying to simplify and
> optimize to provide this detail.
>
> 3- We extend the OSD-side reporting.  Currently (see #1), we only report
> total stats for the entire OSD.  We could maintain ObjectStore-level
> summations by pool.  This would be split tolerant but would still provide
> us a value we can divide against the PG count (or total cluster values)
> in order to tell how efficiently pools are compressing or how sparse
> they are or whatever.
So let me reinterpret (or append to) this suggestion.
- We can start doing per-collection(= per-pg) logical and allocated size 
tracking at BlueStore level. BlueStore to alter corresponding collection 
metadata
on object update by inserting additional collection related 'set 
collection metadata' transaction. PG's involvement isn't needed in this 
scenario until operation completion and hence there is no requirement to 
have two-stage write operation.
- BlueStore should provide this collection metadata by a new OS API call 
(e..g get_collection_meta) and/or extended onreadable_sync notification 
event. I'd prefer to have the latter to avoid additional overhead on 
get_collection_meta call (e.g. collecttion_lookup, locks etc) as we need 
its results after each object update operation.
- PG instance at each OSD node retrieves collection statistics from OS 
when needed or tracks  it in RAM only.
- Two statistics reports  to be distinguished:
   a. Cluster-wide PG report - processing OSD retrieves statistics from 
both local and remote PGs and sums it on per-PG basis. E.g. total per-PG 
physical space usage can be obtained this way.
   b. OSD-wide PG report (or just simple OSD summary report) - OSD 
collects PG statistics from local PGs only. E.g. logical/physical space 
usage at specific OSD can be examined this way.

> 4- We keep what we have now with a duplicated interval_set at the OSD
> level.  Maybe make it a pool option whether we want to track it?  Or add a
> pool property specifying the level of granularity so that it can be
> rounded to 64k blocks or something?  Scrub could reconcile the ObjectStore
> view opportunistically so that e.g. a bunch of 4k discards will eventually
> result in the coarse-grained 64k block appearing as a hole.
>
> #3 still doesn't get us a valid st_blocks for cephfs, but it seems like it
> gets us most of what we want?
>
> sage

