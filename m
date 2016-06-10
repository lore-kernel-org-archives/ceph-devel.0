From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: RocksDB tuning
Date: Fri, 10 Jun 2016 02:06:40 +0000
Message-ID: <BL2PR02MB2115DF8FF9EF7CF822C838BAF4500@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
 <BLUPR0201MB1524D8A9D42F7C50646D0AE8E85E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <a3216e58-d591-50ae-f2f2-0cbb7cdaa7bb@redhat.com>
 <fb82e615-0762-0843-9a9f-cbc4686e35ba@redhat.com>
 <BL2PR02MB2115BD376A32CF2B6E54ABABF45F0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0053.outbound.protection.outlook.com ([157.56.110.53]:61344
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750756AbcFJCGp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2016 22:06:45 -0400
In-Reply-To: <BL2PR02MB2115BD376A32CF2B6E54ABABF45F0@BL2PR02MB2115.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

Sage/Mark,
I debugged the code and it seems there is no WAL write going on and working as expected. But, in the process, I found that onode size it is writing to my environment ~7K !! See this debug print.

2016-06-09 15:49:24.710149 7f7732fe3700 20 bluestore(/var/lib/ceph/osd/ceph-0)   onode #1:7d3c6423:::rbd_data.10186b8b4567.0000000000070cd4:head# is 7518

This  explains why so much data going to rocksdb I guess. Once compaction kicks in iops I am getting is *30 times* slower.

I have 15 osds on 8TB drives and I have created 4TB rbd image preconditioned with 1M. I was running 4K RW test.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Thursday, June 09, 2016 8:23 AM
To: Mark Nelson; Allen Samuels; Manavalan Krishnan; Ceph Development
Subject: RE: RocksDB tuning

Mark,
As we discussed, it seems there is ~5X write amp on the system with 4K RW. Considering the amount of data going into rocksdb (and thus kicking of compaction so fast and degrading performance drastically) , it seems it is still writing WAL (?)..I used the following rocksdb option for faster background compaction as well hoping it can keep up with upcoming writes and writes won't be stalling. But, eventually, after a min or so, it is stalling io..

bluestore_rocksdb_options = "compression=kNoCompression,max_write_buffer_number=16,min_write_buffer_number_to_merge=3,recycle_log_file_num=16,compaction_style=kCompactionStyleLevel,write_buffer_size=67108864,target_file_size_base=67108864,max_background_compactions=31,level0_file_num_compaction_trigger=8,level0_slowdown_writes_trigger=32,level0_stop_writes_trigger=64,num_levels=4,max_bytes_for_level_base=536870912,max_bytes_for_level_multiplier=8,compaction_threads=32,flusher_threads=8"

I will try to debug what is going on there..

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
Sent: Thursday, June 09, 2016 6:46 AM
To: Allen Samuels; Manavalan Krishnan; Ceph Development
Subject: Re: RocksDB tuning

On 06/09/2016 08:37 AM, Mark Nelson wrote:
> Hi Allen,
>
> On a somewhat related note, I wanted to mention that I had forgotten 
> that chhabaremesh's min_alloc_size commit for different media types 
> was committed into master:
>
> https://github.com/ceph/ceph/commit/8185f2d356911274ca679614611dc335e3
> efd187
>
>
> IE those tests appear to already have been using a 4K min alloc size 
> due to non-rotational NVMe media.  I went back and verified that 
> explicitly changing the min_alloc size (in fact all of them to be
> sure) to 4k does not change the behavior from graphs I showed 
> yesterday.  The rocksdb compaction stalls due to excessive reads 
> appear (at least on the
> surface) to be due to metadata traffic during heavy small random writes.

Sorry, this was worded poorly.  Traffic due to compaction of metadata (ie not leaked WAL data) during small random writes.

Mark

>
> Mark
>
> On 06/08/2016 06:52 PM, Allen Samuels wrote:
>> Let's make a patch that creates actual Ceph parameters for these 
>> things so that we don't have to edit the source code in the future.
>>
>>
>> Allen Samuels
>> SanDisk |a Western Digital brand
>> 2880 Junction Avenue, San Jose, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
>>
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel- 
>>> owner@vger.kernel.org] On Behalf Of Manavalan Krishnan
>>> Sent: Wednesday, June 08, 2016 3:10 PM
>>> To: Mark Nelson <mnelson@redhat.com>; Ceph Development <ceph- 
>>> devel@vger.kernel.org>
>>> Subject: RocksDB tuning
>>>
>>> Hi Mark
>>>
>>> Here are the tunings that we used to avoid the IOPs choppiness 
>>> caused by rocksdb compaction.
>>>
>>> We need to add the following options in src/kv/RocksDBStore.cc 
>>> before rocksdb::DB::Open in RocksDBStore::do_open opt.IncreaseParallelism(16);
>>>   opt.OptimizeLevelStyleCompaction(512 * 1024 * 1024);
>>>
>>>
>>>
>>> Thanks
>>> Mana
>>>
>>>
>>>>
>>>
>>> PLEASE NOTE: The information contained in this electronic mail 
>>> message is intended only for the use of the designated recipient(s) 
>>> named above.
>>> If the
>>> reader of this message is not the intended recipient, you are hereby 
>>> notified that you have received this message in error and that any 
>>> review, dissemination, distribution, or copying of this message is 
>>> strictly prohibited. If you have received this communication in 
>>> error, please notify the sender by telephone or e-mail (as shown 
>>> above) immediately and destroy any and all copies of this message in 
>>> your possession (whether hard copies or electronically stored 
>>> copies).
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the
>>> body of a message to majordomo@vger.kernel.org More majordomo info 
>>> at http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
