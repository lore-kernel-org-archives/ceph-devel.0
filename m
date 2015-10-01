From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Reproducing allocator performance differences
Date: Thu, 01 Oct 2015 12:18:18 -0500
Message-ID: <560D6ADA.4000107@redhat.com>
References: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55423 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754223AbbJARSV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 1 Oct 2015 13:18:21 -0400
In-Reply-To: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Curley, Matthew" <matthew.curley@hpe.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/01/2015 10:32 AM, Curley, Matthew wrote:
> We've been trying to reproduce the allocator performance impact on 4K random reads seen in the Hackathon (and more recent tests).  At this point though, we're not seeing any significant difference between tcmalloc and jemalloc so we're looking for thoughts on what we're doing wrong.  Or at least some suggestions to try out.
>
> More detail here:
> https://drive.google.com/file/d/0B2kp18maR7axTmU5WG9WclNKQlU/view?usp=sharing
>
> Thanks for any input!

Hi Mathew,

I can point out a couple of differences in our setups:

1) I have 4 NVMe cards with 4 OSDs per card in each node, ie 16 OSDs 
total per node.  I'm also running the fio processes on the same nodes as 
the OSDs, so there is far less CPU available per OSD in my setup.

2) You have more memory per node than I do (and far more memory per OSD)

3) I'm using fio with the librbd engine, not fio+libaio on kernel RBD. 
It would be interesting to know if if this is having an effect.

4) I'm using RBD cache (and allowing writeback before flush)

5) I'm not using nobarriers

I suspect that in my setup I am very much bound by things other than the 
NVMe cards.  I think we should look at this in terms of per-node 
throughput rather than per-OSD.  What I find very interesting is that 
you are seeing much higher per-node tcmalloc performance than I am but 
fairly similar per-node jemalloc performance.  For 4K random reads I saw 
about 14K random read IOPs per node for tcmalloc+32MB TC and around 40K 
IOPS per node with tcmalloc+128MB tc or jemalloc.  It appears to me that 
for both tcmalloc and jemalloc you saw around 50K IOPS per node in the 4 
OSD per card case.

A couple of thoughts:

1) Did you happen to record any CPU usage data during your tests? 
Perhaps with only 4 OSDs per node there is less CPU contention.

2) Did you test 4K random writes?  It would be interesting to see if 
those results show the same behavior.

3) I'm going to assume that since you saw differences in performance 
with different queue depths that this is O_DIRECT?  Did you sync/drop 
cache on the OSDs before the tests?  Was the data pre-filled on the RBD 
volumes?

4) Even given the above, you have a lot more memory available for buffer 
cache.  Did you happen to look at how many of the IOs were actually 
hitting the NVMe devices?

Mark

>
> --MC
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
