From: Oleg Krasnianskiy <oleg.krasnianskiy@gmail.com>
Subject: Re: 4x write amplification?
Date: Thu, 11 Jul 2013 11:23:07 +0300
Message-ID: <CA+CdmLb5G5LjmWtiC9qn2Jw+yb6gLPS5ScSdjGrdTggqKhWHNg@mail.gmail.com>
References: <51DCC225.1050700@ubuntukylin.com>
	<CAPYLRzj_8WvEXs55e5DuD3kaiLH17en=HVtgCS1bm0Q84PGcQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:57188 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755838Ab3GKIXH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 04:23:07 -0400
Received: by mail-ve0-f169.google.com with SMTP id m1so6933587ves.14
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jul 2013 01:23:07 -0700 (PDT)
In-Reply-To: <CAPYLRzj_8WvEXs55e5DuD3kaiLH17en=HVtgCS1bm0Q84PGcQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Li Wang <liwang@ubuntukylin.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

2013/7/10 Gregory Farnum <greg@inktank.com>:
> On Tue, Jul 9, 2013 at 7:08 PM, Li Wang <liwang@ubuntukylin.com> wrote:
>> Hi,
>>   We did a simple throughput test on Ceph with 2 OSD nodes configured
>> with one replica policy. For each OSD node, the throughput measured by 'dd'
>> run locally is 117MB/s. Therefore, in theory, the two OSDs could provide
>> 200+MB/s throughput. However, using 'iozone' from clients we only get a peak
>> throughput at around 40MB/s. Is that because a write will incur 2 replica *
>> 2 journal write? That is, writing into journal
>> and replica doubled the traffic, respectively, which results in a total
>> 4x write amplification. Is that true, or our understanding is wrong,
>> and some performance tuning hint?
>
> Well, that write amplification is certainly happening. However, I'd
> expect to get a better ratio out of the disk than that. Couple things
> to check:
> 1) is your benchmark dispatching multiple requests at a time, or just
> one? (the latency on a single request is going to make throughput
> numbers come out badly.)
> 2) How do your disks handle two simultaneous write streams? (Most
> disks should be fine, but sometimes they struggle.)
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I have the same problem:
2 machines with several osds each, default replica count (2), btrfs on
osd partitions, default journal location (file on a osd partition),
journal size 2Gb, ceph 0.65, 1 Gbit network between machines that is
shared with the client.

dd benchmark shows ~ 110 Mb/s on osd partition.

Object write via librados: 1 object - 43 Mb/s, 3 parallel objects - 66 Mb/s.
At the same time I monitor osd partitions with iostat. Partitions are
loaded 85-110 Mb/s.

If I shutdown one node, write occurs only on one partition on one
machine. Same results:
disk is loaded 85-110 Mb/s and I get same throughput on client - 49
Mb/s for single obj and 66 Mb/s for 3 parallel objects.

We are deciding whether to use ceph in production and we are stuck due
to our weak understanding of this situation.
