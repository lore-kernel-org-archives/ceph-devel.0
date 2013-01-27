From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: page allocation failures on osd nodes
Date: Sun, 27 Jan 2013 23:52:04 +0300
Message-ID: <CABYiri8RdxnappbKOER0qAja99HSUoh1rvtGwTXzG6JJDsFLuQ@mail.gmail.com>
References: <CABYiri-9QoO1PdbyN29MrwsEg10XTD_HDpamaiNGSCuYDNnULg@mail.gmail.com>
 <CABYiri-RToE33ESDw7jmiL=de3oggE0Q9YWU9csLDSvRmVQieg@mail.gmail.com>
 <CAKMAVE80tW5ewwBVxeS-ZbaRuBY-Msg5i2a_Px_F+PaS_4jpHw@mail.gmail.com> <CABYiri-BxsBCdvTdO74K=htTL++hvLsgMxpoVi6Mx-D8RXdASQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:48107 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab3A0UwZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 27 Jan 2013 15:52:25 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so2187272oag.31
        for <ceph-devel@vger.kernel.org>; Sun, 27 Jan 2013 12:52:25 -0800 (PST)
In-Reply-To: <CABYiri-BxsBCdvTdO74K=htTL++hvLsgMxpoVi6Mx-D8RXdASQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Jan 26, 2013 at 12:41 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On Sat, Jan 26, 2013 at 3:40 AM, Sam Lang <sam.lang@inktank.com> wrote:
>> On Fri, Jan 25, 2013 at 10:07 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>>> Sorry, I have written too less yesterday because of being sleepy.
>>> That`s obviously a cache pressure since dropping caches resulted in
>>> disappearance of this errors for a long period. I`m not very familiar
>>> with kernel memory mechanisms, but shouldn`t kernel try to allocate
>>> memory on the second node if this not prohibited by process` cpuset
>>> first and only then report allocation failure(as can be seen only node
>>> 0 involved in the failures)? I really have no idea where
>>> numa-awareness may be count in case of osd daemons.
>>
>> Hi Andrey,
>>
>> You said that the allocation failure doesn't occur if you flush
>> caches, but the kernel should evict pages from the cache as needed so
>> that the osd can allocate more memory (unless their dirty, but it
>> doesn't look like you have many dirty pages in this case).  It looks
>> like you have plenty of reclaimable pages as well.  Does the osd
>> remain running after that error occurs?
>
> Yes, it keeps running flawlessly without even a bit in an osdmap, but
> unfortunately logging wasn`t turned on for this moment. As soon as
> I`ll end massive test for ``suicide timeout'' bug I`ll check you idea
> with dd and also rerun test as below with ``debug osd = 20''.
>
> My thought is that kernel has ready-to-be-free memory on node1 and for
> strange reason osd process trying to reserve pages from node0 (where
> it is obviously allocated memory on start, since node1` memory
> starting only from high numbers over 32G), then kernel refuses to free
> cache on the specific node(it`s a quite misty, at least for me, why
> kernel just does not invalidate some buffers, even they are more
> preferably to stay in RAM than tail of LRU` ones?).
>
> Allocation looks like following on the most nodes:
> MemTotal:       66081396 kB
> MemFree:          278216 kB
> Buffers:           15040 kB
> Cached:         62422368 kB
> SwapCached:            0 kB
> Active:          2063908 kB
> Inactive:       60876892 kB
> Active(anon):     509784 kB
> Inactive(anon):       56 kB
> Active(file):    1554124 kB
> Inactive(file): 60876836 kB
>
> OSD-node free memory, with two osd processes on each node, libvirt
> prints ``Free'' field there:
>
>
>     0:     207500 KiB
>     1:      72332 KiB
> --------------------
> Total:     279832 KiB
>
>     0:     208528 KiB
>     1:      80692 KiB
> --------------------
> Total:     289220 KiB
>
> Since it is known that kernel reserve more memory on the node with
> higher memory pressure, seems very legit - osd processes works mostly
> with node 0` memory, so there is a bigger gap than on node 1 where
> exists almost only fs cache.
>
>

Ahem. once on almost empty node same trace produced by qemu
process(which was actually pinned to the specific numa node), so seems
that`s generally is a some scheduler/mm bug, not directly related to
the osd processes. In other words, the less percentage of memory
actually is an RSS, the more is a probability of such allocation
failure.

I have printed timestamps of failure events on selected nodes, just
for reference:
http://xdel.ru/downloads/ceph-log/allocation-failure/stat.txt

>>
>> I wonder if you see the same error if you do a long write intensive
>> workload on the local disk for the osd in question, maybe dd
>> if=/dev/zero of=/data/osd.0/foo
>>
>> -sam
>>
>>
>>>
>>> On Fri, Jan 25, 2013 at 2:42 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>>>> Hi,
>>>>
>>>> Those traces happens only constant high constant writes and seems to
>>>> be very rarely. OSD processes do not consume more memory after this
>>>> event and peaks are not distinguishable by monitoring. I have able to
>>>> catch it having four-hour constant writes on the cluster.
>>>>
>>>> http://xdel.ru/downloads/ceph-log/allocation-failure/
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
