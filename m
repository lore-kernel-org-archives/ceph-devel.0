From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore performance snapshot - 20161006
Date: Wed, 12 Oct 2016 14:07:36 -0500
Message-ID: <1a0dc053-0077-56a3-010f-4f049a63c852@redhat.com>
References: <e3e00cbc-3e97-8582-bb93-7ac03b3da40b@redhat.com>
 <BY2PR02MB3967B0DA74162EFB241FF23F4DB0@BY2PR02MB396.namprd02.prod.outlook.com>
 <ea54fb10-2829-5a91-a644-0600f9314f2e@redhat.com>
 <BY2PR02MB396D9464C24D83649BFB2A7F4DA0@BY2PR02MB396.namprd02.prod.outlook.com>
 <bc962f08-672e-d53c-5895-37f6c6c53ca4@mirantis.com>
 <BY2PR02MB39633894AF3F82A1F7EEE34F4DD0@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755483AbcJLTHw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 12 Oct 2016 15:07:52 -0400
In-Reply-To: <BY2PR02MB39633894AF3F82A1F7EEE34F4DD0@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath,

Great news!  That's pretty much what I hoped/expected to see.  I think 
16K is probably going to be the right trade-off for Kraken unless we can 
make a dramatic breakthrough in reducing the onode size beyond what 
we've already done.  It might be that we can squeak it down to 8k, but I 
want to make sure we aren't overloading rocksdb, especially once things 
like RGW bucket metadata is added.

Mark

On 10/12/2016 11:04 AM, Somnath Roy wrote:
> Thanks Igor for explaining this...Yes, it doesn't make sense if compression is not enabled..
> BTW, for the community, I am getting ~30% performance boost, 2X cpu savings , 2x memory savings and >20% latency boost for a 10 hour run of 4K RW with min_alloc_size = 16K..
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Wednesday, October 12, 2016 7:06 AM
> To: Somnath Roy; Mark Nelson; ceph-devel
> Subject: Re: bluestore performance snapshot - 20161006
>
> Hi Somnath,
>
> IMHO blob depths were introduced to handle overlapping extents/blobs produced due to compression. Imaging following 3 8K writes with enabled compression causing extent's 8K->4K squeeze :
>
> 0~8K, 4K~8K, 8K~8K.
>
> Due to we avoid existing extent decompression during partial overwrite resulting logical extent map is something like
>
> 1) 0********8K -> 4K blob
>
> 2)          4K********12K -> 4K blob
>
>   3)                   8K********12K -> 4K blob
>
> Hence extent depth should denote maximum overlapping depth ( i.e. max amount of extents below the specific one that cover the same logical ).
>
> This is 2 for extent 3, 1 for extent 2 and 0 for extent 1.  ( GC actually uses  1-based numbering).
>
> And gc_max_blob_depth specifies a depth value when to perform extent merge - i.e. do read/decompress/compress/write for some region.
>
>
> Unfortunately it looks like there are some defects in the current GC
> implementation. The major one is that it increments blob depth when no
> compression is applied at all that's a nonsense IMHO.
>
> Hence you might face unexpected extent merge attempts when they are
> absolutely unneeded.
>
>
> I'm planning to take a look at that shortly.
>
>
> Hope this helps,
>
> Igor
>
>
>
> On 11.10.2016 22:30, Somnath Roy wrote:
>> Mark/Sage,
>> I figured out the *GC code* is causing the extra reads I am seeing , I have temporarily increased bluestore_gc_max_blob_depth to big number for not to hit that and running my benchmark now.
>> Sage,
>> Before I go through the GC code, could you quickly let me know how blob depth is determined and what is it representing ?
>>
>> Only the following config option I changed on extent/blob part.
>>
>> bluestore_extent_map_shard_max_size = 600
>> bluestore_extent_map_shard_target_size = 250
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Tuesday, October 11, 2016 7:19 AM
>> To: Somnath Roy; ceph-devel
>> Subject: Re: bluestore performance snapshot - 20161006
>>
>>
>>
>> On 10/10/2016 04:29 PM, Somnath Roy wrote:
>>> Mark,
>>> As we discussed today, here is some data point for min_alloc_size set to 16K vs default 4K..
>>> I am seeing 4K RW is stabilizing to a lower value (~25-30%) after ~1 hour run if I set min_alloc_size = 16K with both default rocksdb tuning and with my tuning I posted sometimes back.
>>>
>>> 16K min_alloc_size (after 1 and half hour)  :
>>> -----------------------
>>> ----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
>>> usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
>>>    3   1  95   2   0   0|  19M   68M|   0     0 | 160k  242k|  14k   54k
>>>   18   6  67   8   0   2| 364M  582M| 114M   74M|   0     0 | 313k  343k
>>>   18   6  66   8   0   2| 384M  614M| 122M   79M|   0     0 | 314k  344k
>>>   18   6  67   7   0   2| 337M  575M| 108M   71M|   0     0 | 316k  356k
>>>   18   5  68   7   0   2| 349M  556M| 111M   73M|   0     0 | 305k  344k
>>>   17   6  68   7   0   2| 426M  631M| 106M   69M|   0     0 | 306k  335k
>>>   19   6  66   7   0   2| 436M  661M| 129M   84M|   0     0 | 340k  365k
>>>   19   7  62  10   0   2| 450M  712M| 113M   75M|   0     0 | 330k  350k
>>>   20   7  60  11   0   2| 463M  717M| 120M   79M|   0     0 | 349k  363k
>>>   21   7  57  13   0   2| 494M  720M| 137M   89M|   0     0 | 367k  385k
>>>
>>> Default 4K min_alloc_size (after 10 hour run):
>>> --------------------------------
>>>
>>> ----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
>>> usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
>>>   44   9  31  13   0   4| 158M  259M| 173M  113M|   0     0 | 451k  469k
>>>   41   9  34  12   0   3| 146M  250M| 162M  106M|   0     0 | 435k  461k
>>>   43  10  32  12   0   4| 141M  264M| 172M  112M|   0     0 | 446k  460k
>>>   45  10  28  14   0   4| 140M  282M| 180M  117M|   0     0 | 454k  458k
>>>   44  10  27  14   0   4| 139M  261M| 181M  119M|   0     0 | 467k  457k
>>>   46  10  28  12   0   4| 137M  264M| 185M  121M|   0     0 | 465k  458k
>>>   46  10  29  11   0   4| 143M  303M| 179M  116M|   0     0 | 457k  453k
>>>   46  10  28  12   0   4| 172M  325M| 173M  112M|   0     0 | 460k  454k
>>>   44  10  26  16   0   4| 206M  302M| 169M  110M|   0     0 | 463k  466k
>>>
>>>
>>> You can see way more read/write going on if I enable 16K min_alloc_size and that is degrading performance over time for me..
>> That's really interesting!  I tend to see better performance with a higher min_alloc_size here. It doesn't really make sense to me that you'd see higher read numbers with a higher min_alloc_size unless a lot of WAL writes are leaking into the SSTs since there should be nearly 4x less metadata for rocksdb to deal with.
>>
>> Mark
>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
>>> Sent: Friday, October 07, 2016 7:04 AM
>>> To: ceph-devel
>>> Subject: bluestore performance snapshot - 20161006
>>>
>>> Hi Guys,
>>>
>>> I wanted to give folks a quick snapshot of bluestore performance on our NVMe test setup.  There's a lot of things happening very quickly in the code, so here's a limited snapshot of how we are doing.  These are short running tests, so do keep that in mind (5 minutes each).
>>>
>>> https://drive.google.com/uc?export=download&id=0B2gTBZrkrnpZRXFKRDBrTj
>>> ZiWGc
>>>
>>> The gist of it is:
>>>
>>> We are now basically faster than filestore in all short write tests.
>>> Increasing the min_alloc size (and to a lesser extent) the number of cached onodes brings 4K random write performance up even further.
>>> Likely increasing the min_alloc size will improve long running test performance as well due to drastically reduced metadata load on rocksdb.
>>>    Related to this, the amount of memory that we cache with 4k min_alloc is pretty excessive, even when limiting the number of cached onodes to 4k  The memory allocator work should allow us to make this more flexible, but I suspect that for now we will want to increase the min_alloc size to 16k to help alleviate memory consumption and metadata overhead (and improve 4k random write performance!).  The extra WAL write is probably still worth the tradeoff for now.
>>>
>>> On the read side we are seeing some regressions.  The sequential read case is interesting.  We're doing quite a bit worse in recent bluestore even vs older bluestore, and generally quite a bit worse than filestore.
>>>    Increasing the min_alloc size reduces the degredation, but we still have ground to make up.  In these tests rbd readahead is being used in an attempt to achieve client-side readahead since bluestore no longer does it on the OSD side, but appears to be fairly ineffective.  These are the settings used:
>>>
>>>           rbd readahead disable after bytes = 0
>>>           rbd readahead max bytes = 4194304
>>>
>>> By default we require 10 sequential reads to trigger it.  I don't think that should be a problem, but perhaps lowering the threshold will help.
>>> In general this is an area we still need to focus.
>>>
>>> For random reads, the degradation was previously found to be due to the async messenger.  Both filestore and bluestore performance has degraded relative to Jewel in these tests.  Haomai suspects fast dispatch as the primarily bottleneck here.
>>>
>>> So in general, the areas I think we still need to focus:
>>>
>>>
>>> 1) memory allocator work (much easier caching configuration, better
>>> memory usage, better memory fragmentation, etc)
>>> 2) Long running tests (Somnath has been doing this, thanks Somnath!)
>>> 2) Sequential read performance in bluestore (Need to understand this
>>> better)
>>> 3) Fast dispatch performance improvement (Dan's RCU work?)
>>>
>>> Mark
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>>
>> N     r  y   b X  ǧv ^ )޺{.n +   z ]z   {ay ʇڙ ,j   f   h   z  w
>    j:+v   w j m         zZ+     ݢj"  !tml=
>
