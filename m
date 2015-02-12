From: Alex Elder <elder@ieee.org>
Subject: Re: RBD Kernel panic rbd_dev_refresh
Date: Thu, 12 Feb 2015 17:34:10 -0600
Message-ID: <54DD3872.4010500@ieee.org>
References: <CAPZO0-PBVXKoCu3N0USFSO=8NmTj9k2Ys82zJBnFVv2Q4xEFkA@mail.gmail.com> <CABt9es8smjGVa36NPJ4XHNthsesVg14sT0np5v0xpmWojkHDUA@mail.gmail.com> <loom.20150212T171651-371@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:43887 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbbBLXeR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 18:34:17 -0500
Received: by pdev10 with SMTP id v10so15207747pde.10
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 15:34:17 -0800 (PST)
In-Reply-To: <loom.20150212T171651-371@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 02/12/2015 10:19 AM, Ilya Dryomov wrote:
> On Thu, Feb 12, 2015 at 4:24 PM, Hannes Landeholm <hannes@jumpstarter.io> wrote:
>> We don't have any debug symbols but here is a dump of the .ko at this address:
>>
>> https://gist.github.com/hannes-landeholm/b4664e2e7e37ad13177c
>>
>> It's likely this line (rbd_dev_refresh+0xcb)
>>
>> 3d5b:       4c 89 60 50             mov    %r12,0x50(%rax)
>>
>> %rax here is null which causes the invalid write to address 0000000000000050.
>>
>> I'm pretty sure it's the following line in rbd.c which is the offender
>> if you look at the context (below spinlock and shr, above call to
>> revalidate_disk).
>>
>> set_capacity(rbd_dev->disk, size);

I concur with Hannes.  rbd_dev->disk.part0.nr_sectors is at offset
0x50 from the rbd_dev pointer.

> I'll file a ticket and look into this.

Looking at the code, there is a race between checking the REMOVING
flag and the disk getting removed.  The cost of set_capacity is
low and could be done inside the spinlock, but that doesn't help
the revalidate_disk() call.  You probably need either to coordinate
with a semaphore or another rbd_dev->flags bit.

					-Alex


> Thanks,
>
>                  Ilya
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

