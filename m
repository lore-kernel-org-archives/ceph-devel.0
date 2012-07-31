From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: another performance-related thread
Date: Tue, 31 Jul 2012 23:49:58 +0400
Message-ID: <501836E6.1060809@xdel.ru>
References: <CABYiri94jQb4z9UMgKP1S686pcn7o6v26tbgMp7h1WCivRwL-A@mail.gmail.com> <5017FF6C.8000509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58381 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751735Ab2GaTuD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 15:50:03 -0400
Received: by lahd3 with SMTP id d3so4252839lah.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 12:50:01 -0700 (PDT)
In-Reply-To: <5017FF6C.8000509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/31/2012 07:53 PM, Josh Durgin wrote:
> On 07/31/2012 08:03 AM, Andrey Korolyov wrote:
>> Hi,
>>
>> I`ve finally managed to run rbd-related test on relatively powerful
>> machines and what I have got:
>>
>> 1) Reads on almost fair balanced cluster(eight nodes) did very well,
>> utilizing almost all disk and bandwidth (dual gbit 802.3ad nics, sata
>> disks beyond lsi sas 2108 with wt cache gave me ~1.6Gbyte/s on linear
>> and sequential reads, which is close to overall disk throughput)
>> 2) Writes get much worse, both on rados bench and on fio test when I
>> ran fio simularly on 120 vms - at it best, overall performance is
>> about 400Mbyte/s, using rados bench -t 12 on three host nodes
>
> How are your osd journals configured? What's your ceph.conf for the
> osds?
>
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
> Are these write tests using direct I/O? That will bypass the cache for
> writes, which would explain the similar numbers with different cache
> modes.

I have previously forgot that direct flag may affect rbd cache behaviout.

Without it on wb cache, read rate remained same and writes increased by
~ 0.15:
random writes:
MEAN: 3370
STDEV: 939.99

linear writes:
MEAN: 3561
STDEV: 824.954

