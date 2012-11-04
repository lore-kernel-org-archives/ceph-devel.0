From: Sage Weil <sage@inktank.com>
Subject: Re: BUG: kvm crashing in void
 librbd::AioCompletion::complete_request
Date: Sun, 4 Nov 2012 06:06:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211040604530.30792@cobra.newdream.net>
References: <50967583.8000109@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42675 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2KDOGy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 09:06:54 -0500
In-Reply-To: <50967583.8000109@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 4 Nov 2012, Stefan Priebe wrote:
> Hello,
> 
> while benchmarking the new v2 rbd format i saw several crashes of KVM. First i
> thought this was kernel related but i was just happening faster with one
> kernel than the other.

Can you try the wip-rbd-read branch?  It has a bunch of fixes that aren't 
in master yet.  I haven't seen this specific crash (I don't think), but I 
was reliable hitting other issues with master that wip-rbd-read reslves.

Alternatively, you could cherry-pick 
b1d866efbdf7e8a7bc083b1f3ea56f24e10c8fcd, which I'm guessing is your 
problem.

Thanks!
sage


> 
> The KVM crash / exit looks like this:
> librbd/AioCompletion.cc: In function 'void
> librbd::AioCompletion::complete_request(CephContext*, ssize_t)' thread
> 7f73db67c780 time 2012-11-04 14:59:44.997009
> librbd/AioCompletion.cc: 43: FAILED assert(bl.length() == read_buf_len)
>  ceph version 0.53-585-ga01b112 (a01b112d71a0b6a1bb206d53867d13536d17bbf6)
>  1: (librbd::AioCompletion::complete_request(CephContext*, long)+0xa89)
> [0x7f73d9337319]
>  2: (librbd::C_AioRead::finish(int)+0x174) [0x7f73d93374e4]
>  3: (Context::complete(int)+0xa) [0x7f73d933796a]
>  4: (librbd::C_CacheRead::finish(int)+0xe) [0x7f73d933683e]
>  5: (Context::complete(int)+0xa) [0x7f73d933796a]
>  6: (librbd::ImageCtx::aio_read_from_cache(object_t, ceph::buffer::list*,
> unsigned long, unsigned long, Context*)+0x3a0) [0x7f73d9347bd0]
>  7: (librbd::aio_read(librbd::ImageCtx*, std::vector<std::pair<unsigned long,
> unsigned long>, std::allocator<std::pair<unsigned long, unsigned long> > >
> const&, char*, ceph::buffer::list*, librbd::AioCompletion*)+0x765)
> [0x7f73d9354995]
>  8: (librbd::aio_read(librbd::ImageCtx*, unsigned long, unsigned long, char*,
> ceph::buffer::list*, librbd::AioCompletion*)+0xa2) [0x7f73d9354f92]
>  9: (()+0x9f2de) [0x7f73db73d2de]
>  10: (()+0x9f490) [0x7f73db73d490]
>  11: (()+0x83c45) [0x7f73db721c45]
>  12: (()+0x850ea) [0x7f73db7230ea]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
> interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> 
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
