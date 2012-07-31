From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: another performance-related thread
Date: Tue, 31 Jul 2012 20:12:13 +0400
Message-ID: <501803DD.1060001@xdel.ru>
References: <CABYiri94jQb4z9UMgKP1S686pcn7o6v26tbgMp7h1WCivRwL-A@mail.gmail.com> <5017F6EC.5050209@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:62590 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754643Ab2GaQMZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 12:12:25 -0400
Received: by lahd3 with SMTP id d3so4127371lah.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 09:12:23 -0700 (PDT)
In-Reply-To: <5017F6EC.5050209@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/31/2012 07:17 PM, Mark Nelson wrote:
> Hi Andrey!
>
> On 07/31/2012 10:03 AM, Andrey Korolyov wrote:
>> Hi,
>>
>> I`ve finally managed to run rbd-related test on relatively powerful
>> machines and what I have got:
>>
>> 1) Reads on almost fair balanced cluster(eight nodes) did very well,
>> utilizing almost all disk and bandwidth (dual gbit 802.3ad nics, sata
>> disks beyond lsi sas 2108 with wt cache gave me ~1.6Gbyte/s on linear
>> and sequential reads, which is close to overall disk throughput)
>
> Does your 2108 have the RAID or JBOD firmware?  I'm guessing the RAID
> firmware given that you are able to change the caching behavior?  How
> do you have the arrays setup for the OSDs?

Exactly, I am able to change cache behavior on-the-fly using 'famous'
megacli binary. Each node contains three disks, each of them configured
as raid0 single-disk - two 7200 server sata and intel 313 for journal.
On satas I am using xfs with default mount options and on ssd I`ve put
ext4 with disabled journal and of course with discard/noatime. This 2108
comes with SuperMicro firmware 2.120.243-1482 - guessing it is RAID
variant and I didn`t tried to reflash it yet. For tests, I have forced
write-through cache on - this should be very good at small writes
aggregation. Before using such config, I have configured two disks to
RAID0 and get slightly worse results on write bench. Thanks for
suggesting to try JBOD firmware, I`ll do tests using it this week and
post results.
>> 2) Writes get much worse, both on rados bench and on fio test when I
>> ran fio simularly on 120 vms - at it best, overall performance is
>> about 400Mbyte/s, using rados bench -t 12 on three host nodes
>>
>> fio config:
>>
>> rw=(randread|randwrite|seqread|seqwrite)
>> size=256m
>> direct=1
>> directory=/test
>> numjobs=1
>> iodepth=12
>> group_reporting
>> name=random-ead-direct
>> bs=1M
>> loops=12
>>
>> for 120 vm set, Mbyte/s
>> linear reads:
>> MEAN: 14156
>> STDEV: 612.596
>> random reads:
>> MEAN: 14128
>> STDEV: 911.789
>> linear writes:
>> MEAN: 2956
>> STDEV: 283.165
>> random writes:
>> MEAN: 2986
>> STDEV: 361.311
>>
>> each node holds 15 vms and for 64M rbd cache all possible three states
>> - wb, wt and no-cache has almost same numbers at the tests. I wonder
>> if it possible to raise write/read ratio somehow. Seems that osd
>> underutilize itself, e.g. I am not able to get single-threaded rbd
>> write to get above 35Mb/s. Adding second osd on same disk only raising
>> iowait time, but not benchmark results.
>
> I've seen high IO wait times (especially with small writes) via rados
> bench as well.  It's something we are actively investigating.  Part of
> the issue with rados bench is that every single request is getting
> written to a seperate file, so especially at small IO sizes there is a
> lot of underlying filesystem metadata traffic.  For us, this is
> happening on 9260 controllers with RAID firmware.  I think we may see
> some improvement by switching to 2X08 cards with the JBOD (ie IT)
> firmware, but we haven't confirmed it yet.

For 24 HT cores I have seen 2 percent iowait at most(at writes), so
almost surely there is no IO bottleneck at all(except breaking the rule
'one osd per physical disk', when iowait raising up to 50 percent on
entire system). Rados bench is not an universal measurement tool,
thought - using VM` IO requests instead of manipulating rados objects
will lead to almost fair result, by my opinion.

>
> We actually just purchased a variety of alternative RAID and SAS
> controllers to test with to see how universal this problem is.
> Theoretically RBD shouldn't suffer from this as badly as small writes
> to the same file should get buffered.  The same is true for CephFS
> when doing buffered IO to a single file due to the Linux buffer
> cache.  Small writes to many files will likely suffer in the same way
> that rados bench does though.
>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

