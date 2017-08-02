From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: recommended rocksdb/rockswal sizes when using SSD/HDD
Date: Wed, 2 Aug 2017 18:00:11 -0500
Message-ID: <95dbc334-b208-deb6-8e0b-3af54ae8edcb@gmail.com>
References: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
 <alpine.DEB.2.11.1708022129210.20435@piezo.novalocal>
 <4c48ba58-0ee2-e565-bb56-b8c2cb860a2f@gmail.com>
 <07A48381-2F88-4EB9-ACD1-5763B746643C@teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34712 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdHBXAO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 19:00:14 -0400
Received: by mail-io0-f175.google.com with SMTP id o9so719821iod.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Aug 2017 16:00:14 -0700 (PDT)
In-Reply-To: <07A48381-2F88-4EB9-ACD1-5763B746643C@teradata.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "McFarland, Bruce" <Bruce.McFarland@Teradata.com>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 08/02/2017 05:49 PM, McFarland, Bruce wrote:
> *From: *Mark Nelson <mark.a.nelson@gmail.com>
> *Date: *Wednesday, August 2, 2017 at 3:23 PM
> *To: *Sage Weil <sage@newdream.net>, "McFarland, Bruce" 
> <Bruce.McFarland@Teradata.com>
> *Cc: *Ceph Development <ceph-devel@vger.kernel.org>
> *Subject: *Re: recommended rocksdb/rockswal sizes when using SSD/HDD
> 
> On 08/02/2017 04:32 PM, Sage Weil wrote:
> 
>     On Wed, 2 Aug 2017, McFarland, Bruce wrote:
> 
>         I’m using SDD for the rocksdb/rockswal partitions and putting
>         the data
> 
>         on HDD’s. What is the recommended sizing for these partitions.
>         I’ve read
> 
>         various sizes discussed on the perf call and know that the code
>         defaults
> 
>         of 128MB for rocksdb is small and limits performance. What are the
> 
>         recommended sizes for these partitions?
> 
>     tl;dr: 1GB for block.wal.  For block.db, as much as you have.
> 
>     For an RBD-only pool, my guess is you want around 1-2% of your total
> 
>     storage, but I'm guessing... we need to deploy a real-ish RBD
>     workload and
> 
>     see what the ratio is in practice.  Mark can probably give us a
>     worst-case
> 
>     value (after a long-running 4kb random-write workload).
> 
>     Omap data will go to block.db (if it will fit), so for RGW clusters
>     there
> 
>     may be more.  OTOH, the object metadata will be smaller (immutable
> 
>     objects, sequentially written), so it depends on how big your RGW
>     objects
> 
>     are.  We have no real-world data on this yet.
> 
> While this wasn't 4k writes to 4MB rbd blocks, I noticed that with 4kb
> 
> rados bench objects I was able to fill up an 8GB DB partition and start
> 
> to see write slowdowns (without bloom filters in place) associated with
> 
> HDD disk reads from rocksdb after about 670K objects (target was 2M
> 
> objects).  When increased to 98GB, I was able to write out the 2M
> 
> objects without slowdown.  That would indicate that in that test at
> 
> least, the final amount of DB space being used for each 4K object after
> 
> counting for our own overhead and rocksdb's space amp (We are heavily
> 
> tuning to favor write amp!) could be as high as 12.5KB (there's other
> 
> stuff in the DB besides object metadata, so it's probably lower than
> 
> this in reality).
> 
> I don't think rocksdb's space amplification is necessarily going to be a
> 
> constant factor either (even assuming a similar ratio of key
> 
> prefixes/etc).  With LSM a key may with older versions potentially can
> 
> be in multiple files and fragmentation is also going to affect SA.  We
> 
> also are leaking at least some WAL data into the DB (though a much lower
> 
> amount with our current settings than I was originally worried about).
> 
> The good news is that bloom filters help pretty dramatically when
> 
> metadata roles over to HDD.  I think maybe the general message should be
> 
> that the bigger the flash db partition the better, but it's still worth
> 
> investing in power-loss-protection and write durability when using the
> 
> SSD as a WAL (And DB).
> 
> Mark
> 
> My current test case is using cephFS and not rbd (which avoids 
> formatting with xfs on top of it) or rgw. The tests write ~ 3.7M 
> objects. Based on some of the Mark’s work he generated 96GB of metadata 
> for 6M objects so I’m convinced I’ve grown block.db onto the hdd. I’m 
> using ~400GB SSD and still maintaining the 5:1 hdd to ssd ratio. Our 
> systems have a lot of RAM so I’m also going to increase the rocksdb 
> cache to 3GB based on the comments in recent perf calls.
> 
> I’m curious about the SSD bluestore_min_alloc_size_ssd and what the 
> trade offs for either increasing or decreasing. Does that primarily only 
> effect my metadata size? Our systems are over powered and have lots of 
> cores and memory with only 10 osd/node. If there are any performance 
> trade offs that the downside is an increase in CPU bandwidth or memory 
> usage that’s something we would want to pursue and why I’m considering 
> some tests increasing the bluestore cache beyond 3GB.
> 
> Thanks for verifying sizing.

 From our nifty new options.cc:

"A smaller allocation size generally means less data is read and then 
rewritten when a copy-on-write operation is triggered (e.g., when 
writing to something that was recently snapshotted).  Similarly, less 
data is journaled before performing an overwrite (writes smaller than 
min_alloc_size must first pass through the BlueStore journal).  Larger 
values of min_alloc_size reduce the amount of metadata required to 
describe the on-disk layout and reduce overall fragmentation."

I suspect if you have lots of RAM and CPU available you might want to 
enable rocksdb compression (at least for L1+, but maybe L0 too).  There 
will be extra overhead, and the potential maximum speed of the database 
may be lower, but you may never need the extra speed since you are 
governed by the performance of the spinning disks anyway.  It will 
almost certainly eat up more CPU though.

Also, it may be that for use cases where the metadata spills over to the 
spinning disk, it's worth increasing the rocksdb block cache and 
throwing more bits at the bloom filter to avoid false positives.  We 
already are pretty aggressively given the bloom filters extra bits, but 
when misses mean disk seeks and if you have the RAM to spare, it could 
be worth it.

Mark

> 
> Bruce
> 
>     sage
> 
