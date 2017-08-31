From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: Bluestore memory usage on our test cluster
Date: Thu, 31 Aug 2017 06:07:14 +0200 (CEST)
Message-ID: <1274099168.2413904.1504152434455.JavaMail.zimbra@oxygem.tv>
References: <ec2dfba7-f026-9f7a-ffe9-1893a499b21b@redhat.com> <CABbLZY3HEowq1WvSty0dS_Wr=+TAGcAgf9NM_b3C=v5oje2fgA@mail.gmail.com> <d455dbea-4dd2-4d33-9d3a-b042b4dd035d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:41554 "EHLO
        mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdHaEHZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Aug 2017 00:07:25 -0400
In-Reply-To: <d455dbea-4dd2-4d33-9d3a-b042b4dd035d@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Varada Kari <varada.kari@gmail.com>, Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

>>Yep. FWIW, the last time I looked at jemalloc it was both faster and 
>>resulted in higher memory use vs tcmalloc.

It could be great to test with jemmaloc 4.X and 5.X builded -with-malloc-conf=purge:decay to compare.
(the plan was to enable it by default in jemmaloc 5.X, don't known if it's already done).


also, glibc 2.26 now support native thread cache

some small benchmarks show it faster than jemalloc
https://www.phoronix.com/scan.php?page=news_item&px=Glibc-2.26-Redis-Test


I'll try to test them in coming months.

Alexandre

----- Mail original -----
De: "Mark Nelson" <mnelson@redhat.com>
À: "Varada Kari" <varada.kari@gmail.com>
Cc: "Sage Weil" <sweil@redhat.com>, "Josh Durgin" <jdurgin@redhat.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
Envoyé: Jeudi 31 Août 2017 04:49:01
Objet: Re: Bluestore memory usage on our test cluster

Yep. FWIW, the last time I looked at jemalloc it was both faster and 
resulted in higher memory use vs tcmalloc. That may have simply been 
due to more thread cache being used, but I didn't have any way at the 
time to verify. 

I think we still need to audit and make sure there isn't a bunch of 
memory allocated outside of the mempools. 

Mark 

On 08/30/2017 09:25 PM, Varada Kari wrote: 
> Hi Mark, 
> 
> One thing pending in the wish-list is building profiler hooks to 
> jemalloc like we have for tcmalloc now, that will enable us to do a fair 
> comparison with tcmalloc that time and check if this due to 
> fragmentation in the allocators. 
> 
> Varada 
>> On 31-Aug-2017, at 1:18 AM, Mark Nelson <mnelson@redhat.com 
>> <mailto:mnelson@redhat.com>> wrote: 
>> 
>> Based on the recent conversation about bluestore memory usage, I did a 
>> survey of all of the bluestore OSDs in one of our internal test 
>> clusters. The one with the highest RSS usage at the time was osd.82: 
>> 
>> 6017 ceph 20 0 4488440 2.648g 5004 S 3.0 16.9 5598:01 
>> ceph-osd 
>> 
>> In the grand scheme of bluestore memory usage, I've seen higher RSS 
>> usage, but usually with bluestore_cache cranked up higher. On these 
>> nodes, I believe Sage said the bluestore_cache size is being set to 
>> 512MB to keep memory usage down. 
>> 
>> To dig into this more, mempool data from the osd can be dumped via: 
>> 
>> sudo ceph daemon osd.82 dump_mempools 
>> 
>> A slightly compressed version of that data follows. Note that the 
>> allocated space for blueestore_cache_* isn't terribly high. 
>> buffer_anon and osd_pglog together are taking up more space: 
>> 
>> bloom_filters: 0MB 
>> bluestore_alloc: 13.5MB 
>> blustore_cache_data: 0MB 
>> bluestore_cache_onode: 234.7MB 
>> bluestore_cache_other: 277.3MB 
>> bluestore_fsck: 0MB 
>> bluestore_txc: 0MB 
>> bluestore_writing_deferred: 5.4MB 
>> bluestore_writing: 11.1MB 
>> bluefs: 0.1MB 
>> buffer_anon: 386.1MB 
>> buffer_meta: 0MB 
>> osd: 4.4MB 
>> osd_mapbl: 0MB 
>> osd_pglog: 181.4MB 
>> osdmap: 0.7MB 
>> osdmap_mapping: 0MB 
>> pgmap: 0MB 
>> unittest_1: 0MB 
>> unittest_2: 0MB 
>> 
>> total: 1114.8MB 
>> 
>> A heap dump from tcmalloc shows a fair amount of data yet to be 
>> returned to the OS: 
>> 
>> sudo ceph tell osd.82 heap start_profiler 
>> sudo ceph tell osd.82 heap dump 
>> 
>> osd.82 dumping heap profile now. 
>> ------------------------------------------------ 
>> MALLOC: 2364583720 ( 2255.0 MiB) Bytes in use by application 
>> MALLOC: + 0 ( 0.0 MiB) Bytes in page heap freelist 
>> MALLOC: + 360267096 ( 343.6 MiB) Bytes in central cache freelist 
>> MALLOC: + 10953808 ( 10.4 MiB) Bytes in transfer cache freelist 
>> MALLOC: + 114290480 ( 109.0 MiB) Bytes in thread cache freelists 
>> MALLOC: + 13562016 ( 12.9 MiB) Bytes in malloc metadata 
>> MALLOC: ------------ 
>> MALLOC: = 2863657120 ( 2731.0 MiB) Actual memory used (physical + swap) 
>> MALLOC: + 997007360 ( 950.8 MiB) Bytes released to OS (aka unmapped) 
>> MALLOC: ------------ 
>> MALLOC: = 3860664480 ( 3681.8 MiB) Virtual address space used 
>> MALLOC: 
>> MALLOC: 156783 Spans in use 
>> MALLOC: 35 Thread heaps in use 
>> MALLOC: 8192 Tcmalloc page size 
>> ------------------------------------------------ 
>> 
>> 
>> The heap profile is showing us about the same as top excluding bytes 
>> released to the OS. Another ~500MB is being used by tcmalloc for 
>> various cache and metadata, and ~1.1GB we can account for in the mempools. 
>> 
>> The question is where does that other 1GB go. Is it allocations that 
>> are not made via the mempools? heap fragmentation? Maybe a 
>> combination of multiple things? I don't actually know how to get heap 
>> fragmentation statistics out of tcmalloc, but jemalloc potentially 
>> would allow us to compute it via: 
>> 
>> malloc_stats_print() 
>> 
>> External fragmentation: 1.0 - (allocated/active) 
>> Virtual fragmentation: 1.0 - (active/mapped) 
>> 
>> Mark 
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
>> the body of a message to majordomo@vger.kernel.org 
>> <mailto:majordomo@vger.kernel.org> 
>> More majordomo info at http://vger.kernel.org/majordomo-info.html 
>> <http://vger.kernel.org/majordomo-info.html> 
> 
-- 
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 

