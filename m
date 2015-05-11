From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Newstore Update Part 2
Date: Mon, 11 May 2015 10:31:44 -0500
Message-ID: <5550CB60.6060002@redhat.com>
References: <554D44E3.7080600@redhat.com> <CANP1eJEYWgp=BHh314uGqH9MAm2aW3hXgPFmVk+X4s+gQzn+HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754590AbbEKPbu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 May 2015 11:31:50 -0400
In-Reply-To: <CANP1eJEYWgp=BHh314uGqH9MAm2aW3hXgPFmVk+X4s+gQzn+HQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 05/11/2015 10:21 AM, Milosz Tanski wrote:
> On Fri, May 8, 2015 at 7:21 PM, Mark Nelson <mnelson@redhat.com> wrote:
>>
>> Hi Guys,
>>
>> At the performance meeting this week we discussed the possibility of changing how newstore handles large partial overwrites.  To determine if this is useful, we look at rados bench and rbd performance of newstore at various IO sizes.  I've also included some rados bench read results as folks were interested in those.  On the graphs I've tried to mark interesting improvements/regressions and also some questions/comments. These tests were run without overlay which may help small IO performance in some cases.
>>
>> Graphs are here:
>>
>> http://nhm.ceph.com/newstore/8c8c5903_rbd_rados_tests.pdf
>>
>> Thanks,
>> Mark
>
>
> May I suggest that we try to test new store aging (no pun intended).
> I'm worried that inevitably we'll have cases crop up where newstore
> degrades after prolonged usage (real-world). Case like:
>
> 1) Behavior after a few TB has been written
> 2) Behavior of OSDs with newstore after it's 50% full.
> 3) Behavior after many write/del operations.
>
> I'm sure I'm missing many scenarios. We're dealing with quintessential
> filesystem design problem, how do deliver predictable performance
> after it's been used for a long time. Design maturing pains.


We do definitely need to do this, though I was hoping to wait until we 
have things a bit more stabilized since aging tests take so long to run 
and the results could change depending on if/how we handle object 
fragments for overwrites.

Mark
