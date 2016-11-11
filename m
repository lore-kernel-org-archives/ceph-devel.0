From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bluestore with rocksdb vs ZS
Date: Fri, 11 Nov 2016 15:27:04 +0300
Message-ID: <19f22655-a4a5-433b-3d54-4784f84f2837@mirantis.com>
References: <BY2PR02MB39674DF9B9B8848C6A17C8AF4B90@BY2PR02MB396.namprd02.prod.outlook.com>
 <fe4d4d36-693b-76b5-6cc2-a2b57a24173f@mirantis.com>
 <BY2PR02MB396475AD2EA210858957AD8F4B90@BY2PR02MB396.namprd02.prod.outlook.com>
 <ead268ca-c8e0-c61c-3df0-519383b19284@mirantis.com>
 <BY2PR02MB39611A9FF851334E0536911F4B80@BY2PR02MB396.namprd02.prod.outlook.com>
 <0e6f8164-67a1-140d-4147-47e1ce48b198@mirantis.com>
 <BY2PR02MB396CA1594D1B254027BCBFFF4B80@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:35284 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756416AbcKKM1K (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2016 07:27:10 -0500
Received: by mail-it0-f52.google.com with SMTP id e187so325575393itc.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 04:27:10 -0800 (PST)
In-Reply-To: <BY2PR02MB396CA1594D1B254027BCBFFF4B80@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Somnath,

thanks a lot for your responses.

IMHO that performance degradation on large image and pretty limited 
onode cache size are related. With small image you can use most of 
onodes from the bluestore cache and hence there is no need to read them 
from the db on each write request.

And for the large image most probably you have minor cache hit ratio and 
hence need db read on most write requests.

W.r.t. cache size - I suppose that in general case it should be adjusted 
according to your task's working set. I.e. all onodes in your 
benchmarking unfortunately. Otherwise it's rather a waste of memory and 
cpu. Curious to know what's the hit/miss/add statistics for bluestore 
cache for long-term large-image random write testing with your settings.

Also please note that bluestore_onode_cache_size & 
bluestore_buffer_cache_size are no more present - please see at

https://github.com/ceph/ceph/commit/bcf20a1ca12ac0a7d4bd51e0beeda2877b4e0125

for replacement.

Hope this is helpful.

Kind regards,

Igor



On 10.11.2016 19:44, Somnath Roy wrote:
> Igor,
> <<inline
>
> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Thursday, November 10, 2016 6:44 AM
> To: Somnath Roy; ceph-devel@vger.kernel.org
> Subject: Re: Bluestore with rocksdb vs ZS
>
> Somnath,
>
>
> On 10.11.2016 6:52, Somnath Roy wrote:
>> Igor,
>> Please see my response inline.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
>> Sent: Wednesday, November 09, 2016 4:26 PM
>> To: Somnath Roy; ceph-devel@vger.kernel.org
>> Subject: Re: Bluestore with rocksdb vs ZS
>>
>> Somnath,
>>
>> thanks a lot for your update.
>>
>> The numbers in your response are for non-ceph case, right?
>>
>> And for "single osd - steady state" case you observed (as per slide 5)
>> 2K IOPS * 4K = 8Mb/s BW (and even less)? Comparing to 80Mb/s = 20K
>> IOPS
>> * 4K  your hardware can provide for 4K random write.
>>
>> [Somnath] No, it is much more worse. Steady state iops for 4k
>> min_alloc + rocks = ~500 , 4k min_alloc + zs , 16K min_alloc + rocks =
>> ~1K, ZS + 512kb rbd obect is ~1.8K
> [Igor] Yeah, I just provided max estimation for ZS  + 512 K obj. Main point here is that OSD performance is >10x times slower comparing to your system performance.
>> Is that correct or I missed something? Then if my calculations are correct I can easily explain why you're not getting steady state - one needs 4Tb / 8 Mb = 512K seconds to reach that state, i.e. the state when onodes are completely filled and not growing any more.
>>
>> [Somnath] The performance on slide 5 we are getting after reaching to
>> steady state. Before reaching steady state as other slide was showing
>> we are > 5X faster for 4k min_alloc + rocks. Regarding reaching to
>> steady state , we cheated not to do actual data write , but it was
>> writing all metadata. This is achieved by setting max_alloc_size = 4k
>> and it was much much faster as data write of 4K not happening :-)
> [Igor] Not sure I understand why data write isn't happening. IMHO you just have smaller granularity for your extents/blobs (similar to real 4K
> writes) but benefit from large write blocks processing (You mentioned 1M writes to achieve steady state, right?) Anyway - I just wanted to point out that for 2-5K IOPS and 4K writes getting to steady state takes much longer than 7 hours.  I.e. not getting steady state within 7 hours at slide 3 is OK.
>
> [Somnath] We short circuited not to do data write , it's a hacked code to expedite preconditioning. Regarding performance, we are getting 12-13K iops for a small image , but, I would say in your single osd set up try to create a bigger image like 1TB or so and see what performance you are getting after doing say 1M preconditioning and then writing 100 4K RW.
>
>> Again if I'm correct - could you please share your ceph config & fio job files (ones for slide 5 are enough for the first look) - probably you should tune bluestore onode cache and collection/cache shards counts. I experienced similar degradation due to bluestore misconfiguration.
>>
>> [Somnath] Here is the bluestore options we used..
>>
>> 	bluestore_rocksdb_options = "max_write_buffer_number=16,min_write_buffer_number_to_merge=2,recycle_log_file_num=16,compaction_threads=8,flusher_threads=4,max_background_compactions=8,max_background_flushes=4,max_bytes_for_level_base=5368709120,write_buffer_size=83886080,level0_file_num_compaction_trigger=2,level0_slowdown_writes_trigger=400,level0_stop_writes_trigger=800,stats_dump_period_sec=10"
>>
>>        osd_op_num_threads_per_shard = 2
>>        osd_op_num_shards = 20
>>           rocksdb_cache_size = 129496729
>>           bluestore_min_alloc_size = 16384
>>           #bluestore_min_alloc_size = 4096
>>           bluestore_csum = false
>>           bluestore_csum_type = none	
>>          bluestore_max_ops = 0
>>          bluestore_max_bytes = 0
>>           #bluestore_buffer_cache_size = 104857600
>>           bluestore_onode_cache_size = 30000
>>           
>>
>> And one more questions - againsе what ceph interface did you run FIO tests. Recently added ObjectStore one? Or RBD?
>>
>> [Somnath] It's on top of rbd
>>
> [Igor] I'm curious how many collections do you actually have for single OSD case. To minimize request contention your osd_op_num_shards, amount of collections and amount of fio jobs have to be similar or close enough.
> Otherwise IMHO you might experience performance degradation since the probability that some requests waste time pending at collection/cache_shard lock is pretty high.
> As far as I understand currently you have 32 jobs, 20 shards and ?
> collections (IMHO 8 due to default for osd_pool_default_pg_num param?).
> May be adjusting these values will help a bit.
>
> [Somnath] Yes, we increased pg_num to 256 or 512 (need to check exact)
>
> Another point - In your case you probably have 1M onodes for 4Tb image and 4Mb object size. Hence your blyestore_onode_cahce_size = 30000 might be ineffective. Most probably most of onodes lookup will miss the cache.
>
> [Somnath] I don't think in real world we can't serve everything from onode cache , so, IMHO, this ratio probably make sense.
>
> And final point - are you using the same physical storage device for block/db/wal purposes. Just different logical partitions, right? What's about using different ones - wouldn't that increase the IOPS/BW?
>
> [Somnath] Yes, same drive different logical partition. We tried separate device for db/wal and it didn't improve performance much , so, device doesn't seem to be a bottleneck. I tried NVRAM as WAL for 16K min_alloc and it is giving 10% bump. This is mostly because of lower latency I guess.
>
> Thanks,
> Igor
>> Igor
>>
>>
>>
>> On 11/10/2016 2:39 AM, Somnath Roy wrote:
>>> Sure, it is running on SanDisk Infiniflash HW. Each Drive BW while test is running was ~400 MB/s and iops is ~20K , 100% 4K random write.
>>> In case of 16 OSD test, it was 16 drive Infiniflash JBOF with 2 hosts attached to it. The hosts were HW zoned to 8 drives each.
>>> The entire box BW is limited to max 12GB/s read/write, when it is fully populated i.e 64 drives . Since it is 16 drives , box will give 16 X 400 MB/s = ~6.4 GB/s.
>>> 100% Read iops for this 16 drive box is ~800K and 100% write iops is ~300K iops.
>>> Drives were having separate partition for Bluestore data/wal/db.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
>>> Sent: Wednesday, November 09, 2016 3:26 PM
>>> To: Somnath Roy; ceph-devel@vger.kernel.org
>>> Subject: Re: Bluestore with rocksdb vs ZS
>>>
>>> Hi Somnath,
>>>
>>> could you please describe the storage hardware used in your
>>> benchmarking: what drives, how are they organized, etc... What are the performance characteristics of the storage subsystem without Ceph?
>>>
>>> Thanks in advance,
>>>
>>> Igor
>>>
>>>
>>> On 11/10/2016 1:57 AM, Somnath Roy wrote:
>>>> Hi,
>>>> Here is the slide we presented in today's performance meeting.
>>>>
>>>> https://drive.google.com/file/d/0B7W-S0z_ymMJZXI3bkZLX3Z2U0E/view?us
>>>> p=
>>>> sharing
>>>>
>>>> Feel free to come back if anybody has any query.
>>>>
>>>> Thanks & Regards
>>>> Somnath
>>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html

