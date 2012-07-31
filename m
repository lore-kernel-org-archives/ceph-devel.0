From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: another performance-related thread
Date: Tue, 31 Jul 2012 10:17:00 -0500
Message-ID: <5017F6EC.5050209@inktank.com>
References: <CABYiri94jQb4z9UMgKP1S686pcn7o6v26tbgMp7h1WCivRwL-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49898 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921Ab2GaPRL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 11:17:11 -0400
Received: by yenl2 with SMTP id l2so6155211yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 08:17:11 -0700 (PDT)
In-Reply-To: <CABYiri94jQb4z9UMgKP1S686pcn7o6v26tbgMp7h1WCivRwL-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

Hi Andrey!

On 07/31/2012 10:03 AM, Andrey Korolyov wrote:
> Hi,
>
> I`ve finally managed to run rbd-related test on relatively powerful
> machines and what I have got:
>
> 1) Reads on almost fair balanced cluster(eight nodes) did very well,
> utilizing almost all disk and bandwidth (dual gbit 802.3ad nics, sata
> disks beyond lsi sas 2108 with wt cache gave me ~1.6Gbyte/s on linear
> and sequential reads, which is close to overall disk throughput)

Does your 2108 have the RAID or JBOD firmware?  I'm guessing the RAID 
firmware given that you are able to change the caching behavior?  How do 
you have the arrays setup for the OSDs?

> 2) Writes get much worse, both on rados bench and on fio test when I
> ran fio simularly on 120 vms - at it best, overall performance is
> about 400Mbyte/s, using rados bench -t 12 on three host nodes
>
> fio config:
>
> rw=(randread|randwrite|seqread|seqwrite)
> size=256m
> direct=1
> directory=/test
> numjobs=1
> iodepth=12
> group_reporting
> name=random-ead-direct
> bs=1M
> loops=12
>
> for 120 vm set, Mbyte/s
> linear reads:
> MEAN: 14156
> STDEV: 612.596
> random reads:
> MEAN: 14128
> STDEV: 911.789
> linear writes:
> MEAN: 2956
> STDEV: 283.165
> random writes:
> MEAN: 2986
> STDEV: 361.311
>
> each node holds 15 vms and for 64M rbd cache all possible three states
> - wb, wt and no-cache has almost same numbers at the tests. I wonder
> if it possible to raise write/read ratio somehow. Seems that osd
> underutilize itself, e.g. I am not able to get single-threaded rbd
> write to get above 35Mb/s. Adding second osd on same disk only raising
> iowait time, but not benchmark results.

I've seen high IO wait times (especially with small writes) via rados 
bench as well.  It's something we are actively investigating.  Part of 
the issue with rados bench is that every single request is getting 
written to a seperate file, so especially at small IO sizes there is a 
lot of underlying filesystem metadata traffic.  For us, this is 
happening on 9260 controllers with RAID firmware.  I think we may see 
some improvement by switching to 2X08 cards with the JBOD (ie IT) 
firmware, but we haven't confirmed it yet.

We actually just purchased a variety of alternative RAID and SAS 
controllers to test with to see how universal this problem is. 
Theoretically RBD shouldn't suffer from this as badly as small writes to 
the same file should get buffered.  The same is true for CephFS when 
doing buffered IO to a single file due to the Linux buffer cache.  Small 
writes to many files will likely suffer in the same way that rados bench 
does though.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Mark Nelson
Performance Engineer
Inktank
