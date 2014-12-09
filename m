From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: crush: straw is dead, long live straw2
Date: Mon, 08 Dec 2014 16:21:07 -0800
Message-ID: <54864073.5070907@inktank.com>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33149 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbaLIA1u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Dec 2014 19:27:50 -0500
In-Reply-To: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 12/08/2014 03:48 PM, Sage Weil wrote:
>   - Use floating point log function.  This is problematic for the kernel
> implementation (no floating point), is slower than the lookup table, and
> makes me worry about whether the floating point calculations are
> consistent across architectures (the mapping has to be completely
> deterministic).

This also won't work for QEMU, which may not restore floating point
modes while doing I/O (leading to crashes like 
http://tracker.ceph.com/issues/3521).

>   - Use some approximation of the logarithm with fixed-point arithmetic.
> I spent a bit of time search and found
>
>   http://www.researchgate.net/publication/230668515_A_fixed-point_implementation_of_the_natural_logarithm_based_on_a_expanded_hyperbolic_CORDIC_algorithm
>
> but it also involves a couple of lookup tables and (judging by figure 1)
> is probably slower than the 256 KB table.
>
> We could probably expand out taylor series and get something half decent,
> but any precision we lose will translate to OSD utilizations that are off
> from the input weights--something that costs real disk space and we
> probably want to avoid.
>
>   - Stick with the 128KB lookup table.  Performance sensitive clients can
> precalculate all PG mappings when they get OSDMap updates if they are
> concerned about leave the CRUSH calculation in the IO path.
>
> Any other suggestions?

It could be a lookup table generated (or chosen) at runtime to a
particular size configured by the crushmap, but that's probably more
complex than it's worth.

> Here is my implementation of the lookup-table based approach:
>
> 	https://github.com/ceph/ceph/commit/1d462c9f6a262de3a51533193ed2dff34c730727
> 	https://github.com/ceph/ceph/commits/wip-crush-straw2
>
> You'll notice that included in there is a unit test that verifies that
> changing a single item's weight does not effect the distribution of inputs
> among other items in the bucket.  :)

