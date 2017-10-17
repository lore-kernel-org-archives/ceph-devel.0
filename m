From: Haomai Wang <haomai@xsky.com>
Subject: Re: Work update related to rocksdb
Date: Tue, 17 Oct 2017 21:17:31 +0800
Message-ID: <CACJqLyb6e+aPaqqxKA_V3Z2OVAhwyb4nK5E3ucqzzqjcYW7m9A@mail.gmail.com>
References: <AEE495BD65FC0144A24ECB647C8270EF384559B2@shsmsx102.ccr.corp.intel.com>
 <fd7b00ef-66e4-cfae-fc76-6300b86a3b86@redhat.com> <AEE495BD65FC0144A24ECB647C8270EF38455A21@shsmsx102.ccr.corp.intel.com>
 <3ae1878e-9b70-669a-6596-e8480ae14537@redhat.com> <AEE495BD65FC0144A24ECB647C8270EF3846073B@shsmsx102.ccr.corp.intel.com>
 <AEE495BD65FC0144A24ECB647C8270EF38475E4A@shsmsx102.ccr.corp.intel.com>
 <416b7e16-6422-f572-7a2b-b7db7eabcb20@redhat.com> <AEE495BD65FC0144A24ECB647C8270EF384825EC@shsmsx102.ccr.corp.intel.com>
 <cfebf4b4-67ec-8826-997e-6b6b1faa605d@redhat.com> <alpine.DEB.2.11.1710161314220.26702@piezo.us.to>
 <c3d3264c-fef8-6d89-1fe9-0863bfb4db1d@redhat.com> <CAERxPZ+-fiP1GL1D7NyLE49hrN92GrOrouJdHPywPf7v2pLFWQ@mail.gmail.com>
 <CAERxPZL7ErKKXi8+kvQ3Q1u4arC+jCFqWDT-9OPnj=OSEHuwhw@mail.gmail.com>
 <alpine.DEB.2.11.1710170244490.26702@piezo.us.to> <CAERxPZ+surE4PjiN=uiJGUhDGr8Z2-is5R6NQqkMzFtwbFd-Cg@mail.gmail.com>
 <alpine.DEB.2.11.1710170320440.26702@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0136.outbound.protection.outlook.com ([104.47.126.136]:20695
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752600AbdJQNRn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Oct 2017 09:17:43 -0400
Received: by mail-vk0-f41.google.com with SMTP id q190so1043214vkd.13
        for <ceph-devel@vger.kernel.org>; Tue, 17 Oct 2017 06:17:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1710170320440.26702@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: xiaoyan li <wisher2003@gmail.com>, Mark Nelson <mnelson@redhat.com>, "Li, Xiaoyan" <xiaoyan.li@intel.com>, "Gohad, Tushar" <tushar.gohad@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>, rzarzyns@redhat.com

To be clarify, we test rm range before and meet several odd bugs with
rm range I guess. then from rocksdb commit history, range delete is in
heavy changing.

rocksdb community still doesn't recommend to use range delete.

On Tue, Oct 17, 2017 at 11:21 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 17 Oct 2017, xiaoyan li wrote:
>> On Tue, Oct 17, 2017 at 10:49 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Tue, 17 Oct 2017, xiaoyan li wrote:
>> >> Hi Sage and Mark,
>> >> A question here: OMAP pg logs are added by "set", are they only
>> >> deleted by rm_range_keys in BlueStore?
>> >> https://github.com/ceph/ceph/pull/18279/files
>> >
>> > Ooh, I didn't realize we weren't doing this already--we should definitely
>> > merge this patch.  But:
>> >
>> >> If yes, maybe when dedup, we don't need to compare the keys in all
>> >> memtables, we just compare keys in current memtable with rm_range_keys
>> >> in later memtables?
>> >
>> > They are currently deleted explicitly by key name by the OSD code; it
>> > doesn't call the range-based delete method.  Radoslaw had a test branch
>> > last week that tried using rm_range_keys instead but he didn't see any
>> > real difference... presumably because we didn't realize the bluestore omap
>> > code wasn't passing a range delete down to KeyValuDB!  We should retest on
>> > top of your change.
>> I will also have a check.
>> A memtable table includes two parts: key/value operations(set, delete,
>> deletesingle, merge), and range_del(includes range delete). I am
>> wondering if all the pg logs are deleted by range delete, we can just
>> check whether a key/value is deleted in range_del parts of later
>> memtables when dedup flush, this can be save a lot of comparison
>> effort.
>
> That sounds very promising!  Radoslaw, can you share your patch changing
> the PG log trimming behavior?
>
> Thanks!
> sage
>
>>
>> >
>> > Thanks!
>> > sage
>> >
>> >
>> >
>> >  >
>> >>
>> >> On Tue, Oct 17, 2017 at 10:18 AM, xiaoyan li <wisher2003@gmail.com> wrote:
>> >> > Hi Sage and Mark,
>> >> > Following tests results I give are tested based on KV sequences got
>> >> > from librbd+fio 4k or 16k random writes in 30 mins.
>> >> > In my opinion, we may use dedup flush style for onodes and deferred
>> >> > data, but use default merge flush style for other data.
>> >> >
>> >> > On Mon, Oct 16, 2017 at 9:50 PM, Mark Nelson <mnelson@redhat.com> wrote:
>> >> >>
>> >> >>
>> >> >> On 10/16/2017 08:28 AM, Sage Weil wrote:
>> >> >>>
>> >> >>> [adding ceph-devel]
>> >> >>>
>> >> >>> On Mon, 16 Oct 2017, Mark Nelson wrote:
>> >> >>>>
>> >> >>>> Hi Lisa,
>> >> >>>>
>> >> >>>> Excellent testing!   This is exactly what we were trying to understand.
>> >> >>>>
>> >> >>>> On 10/16/2017 12:55 AM, Li, Xiaoyan wrote:
>> >> >>>>>
>> >> >>>>> Hi Mark,
>> >> >>>>>
>> >> >>>>> Based on my testing, when setting min_write_buffer_number_to_merge as 2,
>> >> >>>>> the
>> >> >>>>> onodes and deferred data written into L0 SST can decreased a lot with my
>> >> >>>>> rocksdb dedup package.
>> >> >>>>>
>> >> >>>>> But for omap data, it needs to span more memtables. I tested omap data
>> >> >>>>> in
>> >> >>>>> separate column family. From the data, you can see when
>> >> >>>>> min_write_buffer_number_to_merge is set to 4, the data written into L0
>> >> >>>>> SST
>> >> >>>>> is good. That means it has to compare current memTable to flush with
>> >> >>>>> later 3
>> >> >>>>> memtables recursively.
>> >> >>>>> kFlushStyleDedup is to new flush style in my rocksdb dedup package.
>> >> >>>>> kFlushStyleMerge is current flush style in master branch.
>> >> >>>>>
>> >> >>>>> But this is just considered from data written into L0. With more
>> >> >>>>> memtables
>> >> >>>>> to compare, it sacrifices CPU and computing time.
>> >> >>>>>
>> >> >>>>> Memtable size: 256MB
>> >> >>>>> max_write_buffer_number min_write_buffer_number_to_merge
>> >> >>>>> flush_style     Omap data written into L0 SST(unit: MB)
>> >> >>>>> 16      8       kFlushStyleMerge        7665
>> >> >>>>> 16      8       kFlushStyleDedup        3770
>> >> >>>>> 8       4       kFlushStyleMerge        11470
>> >> >>>>> 8       4       kFlushStyleDedup        3922
>> >> >>>>> 6       3       kFlushStyleMerge        14059
>> >> >>>>> 6       3       kFlushStyleDedup        5001
>> >> >>>>> 4       2       kFlushStyleMerge        18683
>> >> >>>>> 4       2       kFlushStyleDedup        15394
>> >> >>>>
>> >> >>>>
>> >> >>>> Is this only omap data or all data?  It looks like the 6/3 or 8/4 is
>> >> >>>> still
>> >> >>>> probably the optimal point (And the improvements are quite noticeable!).
>> >> > This is only omap data. Dedup can decrease data written into L0 SST,
>> >> > but it needs to compare too many memtables.
>> >> >
>> >> >>>> Sadly we were hoping we might be able to get away with smaller memtables
>> >> >>>> (say
>> >> >>>> 64MB) with KFlushStyleDedup.  It looks like that might not be the case
>> >> >>>> unless
>> >> >>>> we increase the number very high.
>> >> >>>>
>> >> >>>> Sage, this is going to be even worse if we try to keep more pglog entries
>> >> >>>> around on flash OSD backends?
>> >> >>>
>> >> >>>
>> >> >>> I think there are three or more factors at play here:
>> >> >>>
>> >> >>> 1- If we reduce the memtable size, the CPU cost of insertion (baseline)
>> >> >>> and the dedup cost will go down.
>> >> >>>
>> >> >>> 2- If we switch to a small min pg log entries, then most pg log keys
>> >> >>> *will* fall into the smaller window (of small memtables * small
>> >> >>> min_write_buffer_to_merge).  The dup op keys probably won't, though...
>> >> >>> except maybe they will because the values are small and more of them will
>> >> >>> fit into the memtables.  But then
>> >> >>>
>> >> >>> 3- If we have more keys and smaller values, then the CPU overhead will be
>> >> >>> higher again.
>> >> >>>
>> >> >>> For PG logs, I didn't really expect that the dedup style would help; I was
>> >> >>> only thinking about the deferred keys.  I wonder if it would make sense to
>> >> >>> specify a handful of key prefixes to attempt dedup on, and not bother on
>> >> >>> the others?
>> >> >>
>> >> >>
>> >> >> Deferred keys seem to be a much smaller part of the problem right now than
>> >> >> pglog.  At least based on what I'm seeing at the moment with NVMe testing.
>> >> >> Regarding dedup, it's probably worth testing at the very least.
>> >> > I did following tests: all data in default column family. Set
>> >> > min_write_buffer_to_merge to 2, check the size of kinds of data
>> >> > written into L0 SST files.
>> >> > From the data, onodes and deferred data can be removed a lot in dedup style.
>> >> >
>> >> > Data written into L0 SST files:
>> >> >
>> >> > 4k random writes (unit: MB)
>> >> > FlushStyle      Omap              onodes            deferred           others
>> >> > merge       22431.56        23224.54       1530.105          0.906106
>> >> > dedup       22188.28        14161.18        12.68681         0.90906
>> >> >
>> >> > 16k random writes (unit: MB)
>> >> > FlushStyle      Omap              onodes            deferred           others
>> >> > merge           19260.20          8230.02           0                    1914.50
>> >> > dedup           19154.92          2603.90           0
>> >> >    2517.15
>> >> >
>> >> > Note here: for others type, which use "merge" operation, dedup style
>> >> > can't make it more efficient. In later, we can set it in separate CF,
>> >> > use default merge flush style.
>> >> >
>> >> >>
>> >> >>>
>> >> >>> Also, there is the question of where the CPU time is spent.
>> >> >>
>> >> >>
>> >> >> Indeed, but if we can reduce the memtable size it means we save CPU in other
>> >> >> areas.  Like you say below, it's complicated.
>> >> >>>
>> >> >>>
>> >> >>> 1- Big memtables means we spend more time in submit_transaction, called by
>> >> >>> the kv_sync_thread, which is a bottleneck.
>> >> >>
>> >> >>
>> >> >> At least on NVMe we see it pretty regularly in the wallclock traces.  I need
>> >> >> to retest with Radoslav and Adam's hugepages PR to get a feel for how bad it
>> >> >> is after that.
>> >> >>
>> >> >>>
>> >> >>> 2- Higher dedup style flush CPU usage is spent in the compaction thread(s)
>> >> >>> (I think?), which are asynchronous.
>> >> >>
>> >> >>
>> >> >> L0 compaction is single threaded though so we must be careful....
>> >> >>
>> >> >>>
>> >> >>> At the end of the day I think we need to use less CPU total, so the
>> >> >>> optimization of the above factors is a bit complicated.  OTOH if the goal
>> >> >>> is IOPS at whatever cost it'll probably mean a slightly different choice.
>> >> >>
>> >> >>
>> >> >> I guess we should consider the trends.  Lots of cores, lots of flash cells.
>> >> >> How do we balance high throughput and low latency?
>> >> >>
>> >> >>>
>> >> >>> I would *expect* that if we go from, say, 256mb tables to 64mb tables and
>> >> >>> dedup of <= 4 of them, then we'll see a modest net reduction of total CPU
>> >> >>> *and* a shift to the compaction threads.
>> >> >>
>> >> >>
>> >> >> It seems like based on Lisa's test results that's too short lived? Maybe I'm
>> >> >> not understanding what you mean?
>> >> >>
>> >> >>>
>> >> >>> And changing the pg log min entries will counterintuitively increase the
>> >> >>> costs of insertion and dedup flush because more keys will fit in the same
>> >> >>> amount of memtable... but if we reduce the memtable size at the same time
>> >> >>> we might get a win there too?  Maybe?
>> >> >>
>> >> >>
>> >> >> There's too much variability here to theorycraft it and your "maybe"
>> >> >> statement confirms for me. ;)  We need to get a better handle on what's
>> >> >> going on.
>> >> >>
>> >> >>>
>> >> >>> Lisa, do you think limiting the dedup check during flush to specific
>> >> >>> prefixes would make sense as a general capability?  If so, we could target
>> >> >>> this *just* at the high-value keys (e.g., deferred writes) and avoid
>> >> >>> incurring very much additional overhead for the key ranges that aren't
>> >> >>> sure bets.
>> >> > The easiest way to do it is to set data in different CFs, and use
>> >> > different flush style(dedup or merge) in different CFs.
>> >> >
>> >> >>
>> >> >>
>> >> >> At least in my testing deferred writes during rbd 4k random writes are
>> >> >> almost negligible:
>> >> >>
>> >> >> http://pad.ceph.com/p/performance_weekly
>> >> >>
>> >> >> I suspect it's all going to be about OMAP.  We need a really big WAL that
>> >> >> can keep OMAP around for a long time while quickly flushing object data into
>> >> >> small memtables.  On disk it's a big deal that this gets layed out
>> >> >> sequentially but on flash I'm wondering if we'd be better off with a
>> >> >> separate WAL for OMAP (a different rocksdb shard or different data store
>> >> >> entirely).
>> >> > Yes, OMAP data is main data written into L0 SST.
>> >> >
>> >> > Data written into every memtable: (uint: MB)
>> >> > IO load          omap          ondes          deferred          others
>> >> > 4k RW          37584          85253          323887          250
>> >> > 16k RW        33687          73458          0                   3500
>> >> >
>> >> > In merge flush style with min_buffer_to_merge=2.
>> >> > Data written into every L0 SST: (unit MB)
>> >> > IO load     Omap              onodes            deferred           others
>> >> > 4k RW       22188.28        14161.18        12.68681         0.90906
>> >> > 16k RW     19260.20          8230.02           0                    1914.50
>> >> >
>> >> >>
>> >> >> Mark
>> >> >>
>> >> >>
>> >> >>>
>> >> >>> sage
>> >> >>>
>> >> >>>
>> >> >>>>> The above KV operation sequences come from 4k random writes in 30mins.
>> >> >>>>> Overall, the Rocksdb dedup package can decrease the data written into L0
>> >> >>>>> SST, but it needs more comparison. In my opinion, whether to use dedup,
>> >> >>>>> it
>> >> >>>>> depends on the configuration of the OSD host: whether disk is over busy
>> >> >>>>> or
>> >> >>>>> CPU is over busy.
>> >> >>>>
>> >> >>>>
>> >> >>>> Do you have any insight into how much CPU overhead it adds?
>> >> >>>>
>> >> >>>>>
>> >> >>>>> Best wishes
>> >> >>>>> Lisa
>> >> >>
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> >
>> >> >
>> >> >
>> >> > --
>> >> > Best wishes
>> >> > Lisa
>> >>
>> >>
>> >>
>> >> --
>> >> Best wishes
>> >> Lisa
>> >>
>> >>
>>
>>
>>
>> --
>> Best wishes
>> Lisa
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
