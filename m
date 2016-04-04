From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: hackathon recap
Date: Mon, 4 Apr 2016 23:30:54 +0800
Message-ID: <CACJqLyZJx9xbqHsFn4CP3-8w=JBZ8i4fXN3LpYwbF51O=hjbHw@mail.gmail.com>
References: <alpine.DEB.2.11.1604040951240.19675@cpach.fuggernut.com>
	<CACJqLybuo97ho=NhDri-f5UxuPKw+-0ZTgs0=A=Orp1Yr=4C8A@mail.gmail.com>
	<alpine.DEB.2.11.1604041119580.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34006 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbcDDPaz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 11:30:55 -0400
Received: by mail-vk0-f45.google.com with SMTP id e185so184280678vkb.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2016 08:30:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604041119580.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Apr 4, 2016 at 11:25 PM, Sage Weil <sweil@redhat.com> wrote:
> On Mon, 4 Apr 2016, Haomai Wang wrote:
>> > - Multi-stream SSDs and GC control APIs
>> >
>> > Jianjian presented about new APIs to contorl when the SSD is doing garbage
>> > collection (stop, start, start but suspend on IO) and streams to segregate
>> > writes into different erase blocks.
>>
>> Where these new apis from? for specified vendor?
>
> They are working their way through the standards bodies (for NVMe and
> SAS/SATA?).  The are probably available in some form from specific
> vendors (Samsung) now?
>
>> > - DPDK and SPDK
>> >
>> > We spent a lot of time going over some background about what DPDK and SPDK
>> > do and don't do.  Takeaways/questions include
>> >
>> >  - Which TCP stack are we using with Haomai's DPDK AsyncMessenger
>> > integration?  Should we support multiple options?
>>
>> yes, it will be a backend of AsyncMessenger. Just like impled options:
>> ms type = async
>> ms async transport type = dpdk
>> ms dpdk host ipv4 addr = 10.253.102.119
>> ms dpdk gateway ipv4 addr = 10.253.102.1
>> ms dpdk netmask ipv4 addr = 255.255.255.0
>>
>> these options will enable dpdk backend.
>>
>> Current, I don't find any problem between kernel tcp/ip stack with
>> dpdk userspace tcp/ip. Even passed test_msgr which injects lots of
>> errors.
>
> Which userspace tcp/ip stack is it?  Seastar?  ODP?

main part from seastar

>
>> >  - How much benefit should we expect?  Current estimate (based on
>> > SanDisk's numbers) were that each op consumes around 250us of CPU time,
>> > about 80 of that is actual IO time on an NVMe device, and the max time
>> > we're likely to cut from bypassing the kernel block stack is on the order
>> > of 20-30us.  Successful users of DPDK/SPDK benefit mostly from
>> > restructuring the rest of the stack to avoid legacy threading models.
>>
>> From now, because of some known bottlenecks need to solve. The most
>> advantage is combining dpdk and spdk which actually make
>> spdk(userspace nvme driver) effective. Because spdk still use poll
>> mode and require physical address while queuing io request. Without
>> dpdk, we always need to alloc a physical address aware memory and do
>> copy. With dpdk as network stack, we could use memory from NIC to SSD.
>> Thanks to the dpdk mbuf design, dpdk stack permit a lots of inflight
>> mbuf and alloc new memory if hungry.
>
> Is this a new buffer::raw type?

Yes

>
>> The current status is osd could boot up with serveal dedicated dpdk
>> network thread, and the last one run spdk polling. I really want to
>> make make dpdk network thread can take over
>> OSD::ShardedOpWQ::_process(just discard thread pool and let dpdk
>> thread poll this function) and let each dpdk thread own a shard of
>> PGs, then poll BlueStore::kv_thread, and last for spdk completion reap
>> threads. The main gap now is:
>> 1. Signal/Wait pair ....
>> 2. Async Read ...
>> 3. discard potential slowness in fast path.
>>
>> If so, lots of locks could be discarded. My initial idea is not change
>> so much in current path. But it seemed the Signal/Wait and async read
>> couldn't bypass. Look forward to future/promise and async read :-)
>
> This would be very cool.  Sam, I assume/hope this aligns with what you're
> working on?
>
> sage



-- 
Best Regards,

Wheat
