From: Mark Nelson <mnelson@redhat.com>
Subject: Re: recommended rocksdb/rockswal sizes when using SSD/HDD
Date: Thu, 3 Aug 2017 09:25:43 -0500
Message-ID: <3b012efd-0a0b-4f46-7da1-7de46d62f175@redhat.com>
References: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
 <alpine.DEB.2.11.1708022129210.20435@piezo.novalocal>
 <4c48ba58-0ee2-e565-bb56-b8c2cb860a2f@gmail.com>
 <4E87CD84-891B-4115-ACFA-CEC5C562EBB7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751773AbdHCOZq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 3 Aug 2017 10:25:46 -0400
In-Reply-To: <4E87CD84-891B-4115-ACFA-CEC5C562EBB7@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike A <mike.almateia@gmail.com>, Mark Nelson <mark.a.nelson@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "McFarland, Bruce" <Bruce.McFarland@Teradata.com>, Ceph Development <ceph-devel@vger.kernel.org>



On 08/03/2017 08:07 AM, Mike A wrote:
>
>> 3 авг. 2017 г., в 1:23, Mark Nelson <mark.a.nelson@gmail.com> написал(а):
>>
>>
>>
>> On 08/02/2017 04:32 PM, Sage Weil wrote:
>>> On Wed, 2 Aug 2017, McFarland, Bruce wrote:
>>>> I’m using SDD for the rocksdb/rockswal partitions and putting the data
>>>> on HDD’s. What is the recommended sizing for these partitions. I’ve read
>>>> various sizes discussed on the perf call and know that the code defaults
>>>> of 128MB for rocksdb is small and limits performance. What are the
>>>> recommended sizes for these partitions?
>>> tl;dr: 1GB for block.wal.  For block.db, as much as you have.
>>> For an RBD-only pool, my guess is you want around 1-2% of your total
>>> storage, but I'm guessing... we need to deploy a real-ish RBD workload and
>>> see what the ratio is in practice.  Mark can probably give us a worst-case
>>> value (after a long-running 4kb random-write workload).
>>> Omap data will go to block.db (if it will fit), so for RGW clusters there
>>> may be more.  OTOH, the object metadata will be smaller (immutable
>>> objects, sequentially written), so it depends on how big your RGW objects
>>> are.  We have no real-world data on this yet.
>>
>>
>> While this wasn't 4k writes to 4MB rbd blocks, I noticed that with 4kb rados bench objects I was able to fill up an 8GB DB partition and start to see write slowdowns (without bloom filters in place) associated with HDD disk reads from rocksdb after about 670K objects (target was 2M objects).  When increased to 98GB, I was able to write out the 2M objects without slowdown. That would indicate that in that test at least, the final amount of DB space being used for each 4K object after counting for our own overhead and rocksdb's space amp (We are heavily tuning to favor write amp!) could be as high as 12.5KB (there's other stuff in the DB besides object metadata, so it's probably lower than this in reality).
>>
>> I don't think rocksdb's space amplification is necessarily going to be a constant factor either (even assuming a similar ratio of key prefixes/etc).  With LSM a key may with older versions potentially can be in multiple files and fragmentation is also going to affect SA.  We also are leaking at least some WAL data into the DB (though a much lower amount with our current settings than I was originally worried about).
>>
>> The good news is that bloom filters help pretty dramatically when metadata roles over to HDD.  I think maybe the general message should be that the bigger the flash db partition the better, but it's still worth investing in power-loss-protection and write durability when using the SSD as a WAL (And DB).
>>
>> Mark
>>
> Thanks for that info.
>
> If I have 12 SSD 4tb disks and random 4K workload, is it enough have a one 32Gb NVDIMM storage for rocksdb and WAL for all 12 disks?
> With your information I see that it’s not.

"enough" is tough to answer, because it's definitely enough for WAL, and 
you will certainly see benefit by having some of the metadata hit the 
NVDIMMs (especially  L0 since L0 compactions are single threaded and 
often where things slow down).  For RBD with a large block size, you may 
even get a significant amount of the metadata on NVDIMM, but if you are 
writing out lots of small objects (ie say 4KB RGW), you'll very quickly 
chew through those NVDIMMs.  Even so, every little bit will help.

> Each 4Tb disks can hold around 960K 4K objects and need around 12Gb storage space.
> it’s sufficient for best perfomance to place a rocksDB on the same SSD disk, with which rocksDB is working?--

Placing the WAL on nvdimm should help for small writes since we are 
still defaulting to 16K min_alloc_size even on SSDs (4KB is a tradeoff 
between fewer WAL write traffic at the cost of more metadata).  Intel 
has shown some test results with optane where they can achieve higher 
performance by moving the WAL off their P3700 cards and putting it on 
optane instead.

As far as the DB itself goes, probably the biggest benefit is to try and 
keep L0 on nvdimm.  The Bloom filter settings we are using now in master 
appear to be doing a pretty good job of keeping metadata reads during 
writes down now, so I suspect it's mostly an issue of avoiding the 
compaction work and L0 is the worst.

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
