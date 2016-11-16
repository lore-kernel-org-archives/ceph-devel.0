From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Performance regression in BlueStore
Date: Tue, 15 Nov 2016 22:25:30 -0600
Message-ID: <ae3893e6-b54f-f38d-2dd5-8492a0c3ea81@redhat.com>
References: <1aece6d7-e7a6-daf5-00e7-3fdf40639594@mirantis.com>
 <alpine.DEB.2.11.1611152318290.2650@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932820AbcKPEZe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 15 Nov 2016 23:25:34 -0500
In-Reply-To: <alpine.DEB.2.11.1611152318290.2650@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 11/15/2016 05:22 PM, Sage Weil wrote:
> On Tue, 15 Nov 2016, Igor Fedotov wrote:
>> Hi All,
>>
>> I've been lazily investigating performance regression in BlueStore for last
>> couple of weeks.
>>
>> Here are some, pretty odd, results I'd like to share.
>>
>> Preface.
>>
>> Test scenario:
>>
>> (1) 4K random RW over pre-filled BlueStore instance using FIO.
>>
>> (2) 4K random Write over the same BlueStore instance using FIO.
>>
>> FIO executed against standalone BlueStore. 64 parallel jobs work on 32K
>> objects 4M size each.
>>
>> Min alloc size = 4K. CSum is off.
>>
>> Execution time  - 360 seconds.
>>
>> To smooth the effect of recent mempool/bluestore caching changes config file
>> has both legacy and latest caching settings:
>>
>>  bluestore_buffer_cache_size = 104857600
>>  bluestore_onode_cache_size = 32768
>>  bluestore_cache_meta_ratio = 1
>>  bluestore_cache_size = 3147483648
>>
>> Other settings are the same.
>>
>> Note: (1) & (2) were executed in different order with no significant
>> difference.
>>
>>
>> Results for specific commits (earlier commits first):
>>
>> (1) Commit: 4f09892a84da6603fdc42825fcf8c11359c1cc29 (Merge: ba5d61d 36dc236)
>> Oct 24
>>
>> R/W: aggrb: ~80Mb/s for both read and write
>>
>> Write only: aggrb: ~60 Mb/s
>>
>> (more untested commits here)
>>
>> (2) Commit: ca1be285f97c6efa2f8aa2cebaf360abb64b78f4 (rgw: support for
>> x-robots-tag header)
>>
>> R/W: aggrb: ~108Mb/s for both read and write
>>
>> Write only: aggrb: ~28 Mb/s
>>
>> (3) Commit: 81295c61c4507d26ba3f80c52dd53385a4b9e9d7 (global: introduce
>> mempool_debug config option, asok command)
>>
>> R/W: aggrb: ~109Mb/s for both read and write
>>
>> Write only: aggrb: ~28 Mb/s
>>
>> (4) Commit: 030bc063e44e27f2abcf920f4071c4f3bb5ed9ea (os/bluestore: move most
>> cache types into mempools)
>>
>> R/W: aggrb: ~98 Mb/s for both read and write
>>
>> Write only: aggrb: ~27 Mb/s
>>
>> (5) Commit: bcf20a1ca12ac0a7d4bd51e0beeda2877b4e0125 (os/bluestore:
>> restructure cache trimming in terms of mempool)
>>
>> R/W: aggrb: ~48 Mb/s for both read and write
>>
>> Write only: aggrb: ~42 Mb/s
>>
>> (more untested commits here)
>>
>> (6) Commit: eb8b4c8897d5614eccceab741d8c0d469efa7ce7 (Merge: 12d1d0c 8eb2c9d).
>> (Pretty fresh master snapshot on Nov 14)
>>
>> R/W: aggrb: ~20 Mb/s for both read and write
>>
>> Write only: aggrb: ~15 Mb/s
>>
>>
>> Summary:
>>
>> In the list above commits (2)-(5) are sequential while there are gaps between
>> (1)-(2) & (5)-(6)
>>
>> It looks like we had the best R/W performance at (2) & (3) with gradual
>> degradation afterwards. (5) looks like the most devastating one.
>>
>> Another one is somewhere between (5)-(6).
>>
>> The odd thing is that we had significant negative performance impact for
>> write-only case when R/W performance was at it's max.
>>
>>
>> Exact commit causing perf changes between (1)-(2) & (5) -(6) wasn't
>> investigated..
>>
>> Any comments?
>
> Hrm, I don't see the same regression in my environment.. I tested both
> 030bc063e44e27f2abcf920f4071c4f3bb5ed9ea and
> bcf20a1ca12ac0a7d4bd51e0beeda2877b4e0125 and got essentially identical
> results (the latter was marginally faster).  I suspect my box is neither
> saturating the CPU nor bound much by the storage, so it's strictly a
> critical path latency thing.  I'm also running a full osd and using rbd
> bench-write, like so
>
> make vstart rbd ; MON=1 OSD=1 MDS=0 ../src/vstart.sh -n -x -l --bluestore
> ; bin/rbd create foo --size 1000 ; bin/rbd bench-write foo --io-size 4096
> --io-threads 32 --io-total 100000000000 --no-rbd-cache --io-pattern rand
>
> Mark, what are you seeing?
>
> :/

I did a bisect a week or two ago and the biggest thing I saw was the 
regression due to rocksdb losing optimization flags when we made it an 
external project.  That was indeed a large regression, but it hsould be 
fixed as of last week.  Otherwise I've seen a bit of variability across 
commits, but nothing like what Igor's seeing.  Given that (at least in 
our setup) rocksdb compaction is basically the bottleneck, performance 
can vary pretty greatly.  This is especially true for short runs, 
depending on whether or not you've hit a major compaction stall in the 
test.  I imagine disabling csums probably helps, but I haven't been 
testing that way.

Igor, if you have time, it might be worth looking at perf and also the 
rocksdb compaction statistics in the OSD logs (and throughput over time 
plots) for the lowest and highest performing commits.  I'm surprised you 
are seeing such a large variation.  It would be worth knowing what's 
going on.

Mark

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
