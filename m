From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: Re: recommended rocksdb/rockswal sizes when using SSD/HDD
Date: Wed, 2 Aug 2017 17:23:37 -0500
Message-ID: <4c48ba58-0ee2-e565-bb56-b8c2cb860a2f@gmail.com>
References: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
 <alpine.DEB.2.11.1708022129210.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:38604 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdHBWXj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 18:23:39 -0400
Received: by mail-it0-f43.google.com with SMTP id h199so647075ith.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Aug 2017 15:23:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708022129210.20435@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "McFarland, Bruce" <Bruce.McFarland@Teradata.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 08/02/2017 04:32 PM, Sage Weil wrote:
> On Wed, 2 Aug 2017, McFarland, Bruce wrote:
>> I’m using SDD for the rocksdb/rockswal partitions and putting the data
>> on HDD’s. What is the recommended sizing for these partitions. I’ve read
>> various sizes discussed on the perf call and know that the code defaults
>> of 128MB for rocksdb is small and limits performance. What are the
>> recommended sizes for these partitions?
> 
> tl;dr: 1GB for block.wal.  For block.db, as much as you have.
> 
> For an RBD-only pool, my guess is you want around 1-2% of your total
> storage, but I'm guessing... we need to deploy a real-ish RBD workload and
> see what the ratio is in practice.  Mark can probably give us a worst-case
> value (after a long-running 4kb random-write workload).
> 
> Omap data will go to block.db (if it will fit), so for RGW clusters there
> may be more.  OTOH, the object metadata will be smaller (immutable
> objects, sequentially written), so it depends on how big your RGW objects
> are.  We have no real-world data on this yet.


While this wasn't 4k writes to 4MB rbd blocks, I noticed that with 4kb 
rados bench objects I was able to fill up an 8GB DB partition and start 
to see write slowdowns (without bloom filters in place) associated with 
HDD disk reads from rocksdb after about 670K objects (target was 2M 
objects).  When increased to 98GB, I was able to write out the 2M 
objects without slowdown.  That would indicate that in that test at 
least, the final amount of DB space being used for each 4K object after 
counting for our own overhead and rocksdb's space amp (We are heavily 
tuning to favor write amp!) could be as high as 12.5KB (there's other 
stuff in the DB besides object metadata, so it's probably lower than 
this in reality).

I don't think rocksdb's space amplification is necessarily going to be a 
constant factor either (even assuming a similar ratio of key 
prefixes/etc).  With LSM a key may with older versions potentially can 
be in multiple files and fragmentation is also going to affect SA.  We 
also are leaking at least some WAL data into the DB (though a much lower 
amount with our current settings than I was originally worried about).

The good news is that bloom filters help pretty dramatically when 
metadata roles over to HDD.  I think maybe the general message should be 
that the bigger the flash db partition the better, but it's still worth 
investing in power-loss-protection and write durability when using the 
SSD as a WAL (And DB).

Mark


> 
> sage
> 
