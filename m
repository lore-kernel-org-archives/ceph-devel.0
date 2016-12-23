From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore performance bottleneck
Date: Fri, 23 Dec 2016 11:08:50 -0600
Message-ID: <64caf3cd-5717-dfe1-214f-eb391bb72071@redhat.com>
References: <5E3E05AED7F0F044904275810D0CB46504C290@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612220018390.10615@piezo.novalocal>
 <5E3E05AED7F0F044904275810D0CB46504C301@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <5E3E05AED7F0F044904275810D0CB46504C315@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612220129050.10615@piezo.novalocal>
 <5E3E05AED7F0F044904275810D0CB46504C355@ULS-OP-MBXIP03.sdcorp.global.sandisk.com>
 <62d79c2e-bf7b-9c09-883d-615fedf152b8@redhat.com>
 <alpine.DEB.2.11.1612222226210.10615@piezo.novalocal>
 <aa787f6c-1b0c-fefe-5f82-b749fd0a4ae3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756234AbcLWRIv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 23 Dec 2016 12:08:51 -0500
In-Reply-To: <aa787f6c-1b0c-fefe-5f82-b749fd0a4ae3@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

>> Try this?
>>     https://github.com/ceph/ceph/pull/12634
>
> Looks like this is most likely reducing the memory usage and increasing
> performance quite a bit with smaller shard target/max values.  With
> 25/50 I'm seeing more like 2.6GB RSS memory usage and around 13K iops
> typically with some (likely rocksdb) stalls.  I'll run through the tests
> again.
>
> Mark
>

Ok, Ran through tests with both 4k and 16k min_alloc/max_alloc/blob 
sizes using master+12629+12634:

https://drive.google.com/uc?export=download&id=0B2gTBZrkrnpZQzdRU3B1SGZUbDQ

Performance is up in all tests and memory consumption is down 
(especially in the smaller target/max tests).  It looks like 100/200 is 
probably the current optimal configuration on my test setup.  4K 
min_alloc tests hover around 22.5K IOPS with ~1300% CPU usage, and 16K 
min_alloc tests hover around 25K IOPs with ~1000% CPU usage.  I think it 
will be worth spending some time looking at locking in the bitmap 
allocator given the perf traces.  Beyond that, I'm seeing rocksdb show 
up quite a bit in the top CPU consuming functions now, especially CRC32.

Mark


