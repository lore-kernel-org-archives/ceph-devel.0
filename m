From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore allocator performance testing
Date: Sun, 17 Jul 2016 06:22:46 -0500
Message-ID: <fce1cdf0-011d-b0c1-fb91-f6e43359fdaf@redhat.com>
References: <a42b6dd8-ea3e-a635-7af2-74f024f3ee1a@redhat.com>
 <CAPLK-i_wJp2p14MdUJO8BN=ubt7sPhoWP880Yg5uBxzfcUs7Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49168 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbcGQLWt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Jul 2016 07:22:49 -0400
In-Reply-To: <CAPLK-i_wJp2p14MdUJO8BN=ubt7sPhoWP880Yg5uBxzfcUs7Hw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 07/17/2016 12:09 AM, Shehbaz Jaffer wrote:
> Hi Mark,
>
> Thanks for these results, could you please share the benchmarks? Also,
> since the main reason for implementing bitmap allocator was to reduce
> memory footprint, perhaps a benchmark measuring the memory usage or
> performance under memory constrained environments would help better
> estimate the advantages of bitmap allocator.

Hi Shehbaz,

I should have some rough memory usage numbers for those runs. I can go 
back and take a look on monday.  I also don't want to discount the 
advantages of bitmap allocator in any way.  I only want to highlight 
that there may be some places we can further improve the performance of 
the code (And indeed, we need to if we want to beat filestore for both 
sequential and random writes across the board).

Here's the benchmark section of CBT yaml file:

   librbdfio:
     time: 300
     vol_size: 32768
     mode: ['read', 'write', 'randread', 'randwrite', 'rw', 'randrw']
     rwmixread: 50
     op_size: [4194304, 2097152, 1048576, 524288, 262144, 131072, 65536, 
32768, 16384, 8192, 4096]
     procs_per_volume: [1]
     volumes_per_client: [2]
     iodepth: [32]
     osd_ra: [4096]
     cmd_path: '/home/ubuntu/src/fio/fio'
     pool_profile: 'rbd'
     log_avg_msec: 100

4 clients with 2 volumes per client, so 8 RBD volumes and 2 fio parent 
processes per client.  Tests iterate by IO size (in order) in the outer 
loop and by mode in the inner loop.

Mark

>
> On Sat, Jul 16, 2016 at 10:28 AM, Mark Nelson <mnelson@redhat.com> wrote:
>> Hi All,
>>
>> Yesterday I ran through some quick tests looking at bluestore with stupid
>> allocator and bitmap allocator, then compared with some existing jewel
>> filestore benchmark results:
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZRWg2MTFhSk85b2M/view?usp=sharing
>>
>> Both allocators resulted in similar read performance characteristics (not
>> shown as I wanted to focus on writes).  For writes they were quite
>> different.  Stupid allocator was faster than bitmap allocator for sequential
>> writes, while bitmap allocator was faster than stupid allocator for most
>> sizes of random writes.  Bluestore in general was faster than filestore for
>> large writes (due to the avoidance of journal writes), but was slower to
>> varying degrees at small IO sizes.  bitmap allocator appears to result in
>> very good random write behavior down to ~32K IO sizes, so small IO
>> performance may improve as better locking behavior and Allen's encode/decode
>> proposal are implemented.
>>
>> I think it would probably be worth spending a bit of time to understand why
>> the sequential write performance with bitmap allocator is so much slower
>> than stupid allocator.
>>
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
