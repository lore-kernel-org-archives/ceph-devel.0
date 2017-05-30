From: Mark Nelson <mnelson@redhat.com>
Subject: Re: wallclock trace on bigger OSD
Date: Tue, 30 May 2017 15:15:15 -0500
Message-ID: <7825c82b-fddb-b282-a689-a550d562cb25@redhat.com>
References: <d2a411da-a021-dca7-16b6-cb599d285883@redhat.com>
 <alpine.DEB.2.11.1705261817590.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdE3UPR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 May 2017 16:15:17 -0400
In-Reply-To: <alpine.DEB.2.11.1705261817590.3646@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

CCing ceph-devel since this probably good to discuss in the community now.

Background:  A single NVMe OSD running bluestore (with a 4k min_alloc 
size).  With a 512GB RBD volume, 4k random write performance is quite a 
bit lower than with a smaller 16GB RBD volume.  Several of us have 
noticed this in the past and various efforts were made to improve 
encoding performance and eliminate other bottlenecks, though it appears 
that it's still a fairly big issue.  Last week we took a GDB wallclock 
trace that showed ~95% of time in the finisher thread spent in PG::Lock 
and the tp_osd_tp threads spending significant time doing onode cache 
trimming.

We have more data now.  Looking through the code and the trace, there 
are a couple of issues here.  Not only are we spending a ton of time in 
the tp_osd_tp threads just doing cache trimming, but all of this time is 
spent in OSD::ShardedOpWQ::_process where we are keeping the PG locked 
when this work is being done.  That's very likely why finisher is 
spending ~95% of it's time waiting on the PG lock.

Igor had the right idea regarding the cache, if we give the OSD 
(virtually) unlimited onode cache space we avoid the worst of this and 
go back up to 25-30K IOPS (though still short of the 36-37K IOPs with a 
smaller RBD volume).  I've included a partial gdbtrace showing an 
example of tp_osd_tp, bstore_kv_final, bstore_kv_sync, and finisher threads:

https://pastebin.com/JvPrAyRk

We still end up spending a lot of time in run, but now it's at least 
somewhat better looking.  Despite that, we're still spending ~31% of the 
time in finisher waiting on the PG lock (in this case 64 PGs for 1 NVMe 
backed OSD).  The gist of all of this is that bluestore performance on 
NVMe is really dependent on onodes being cached. I also suspect we may 
not be able to reduce the PG per OSD ratios due to Loic's work unless we 
can also change the locking behavior here.

Mark

On 05/26/2017 01:18 PM, Sage Weil wrote:
> This is crazy!
>
>           |                     + 72.55% PrimaryLogPG::do_request
>           |                     | + 72.55% PrimaryLogPG::do_op
>           |                     |   + 45.95% PrimaryLogPG::find_object_context
>           |                     |   | + 45.95% PrimaryLogPG::get_object_context
>           |                     |   |   + 43.75% PGBackend::objects_get_attr
>           |                     |   |   | + 43.75% BlueStore::getattr
>           |                     |   |   |   + 27.15% BlueStore::Collection::trim_cache
>           |                     |   |   |   | + 27.15% BlueStore::Cache::trim
>           |                     |   |   |   |   + 27.15% BlueStore::LRUCache::_trim
>           |                     |   |   |   |     + 26.80% BlueStore::Onode::put
>
> :/
>
> On Fri, 26 May 2017, Mark Nelson wrote:
>
>> Hi Sage,
>>
>> I noticed while doing 4K random writes to fragment a big(er) RBD partition
>> than my normal setup it was going much slower (~15K iops vs ~35-38K iops).  I
>> grabbed a wallclock trace while it was going too see if it looked interesting.
>> A ton of time is in ~Extent via _trim in the tp_osd_tp threads (See Ln #5881)
>> and again in the bstore_kv_final thread (See Ln #6508).  There are some other
>> things in the bstore_kv_final thread, though the next biggest one is on 6888
>> where we are in lock_guard via BufferSpace::finish_write.
>>
>> Mark
>>
