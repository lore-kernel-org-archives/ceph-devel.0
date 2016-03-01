From: Haomai Wang <haomai@xsky.com>
Subject: Re: Interest in Implementing Cache layer on top of NVME Driver [GSoC]
Date: Tue, 1 Mar 2016 22:01:29 +0800
Message-ID: <CACJqLyaAz7s6Yp2N0crYnO-c_WcE7kygze0x=4i9oHSiptvJ5g@mail.gmail.com>
References: <CAFjGuFTQ3P_GrcTuYBR5jRxXcZu4v1DeEH23NqfER-w=SB69-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0091.outbound.protection.outlook.com ([104.47.126.91]:9760
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753862AbcCAOBn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Mar 2016 09:01:43 -0500
Received: by mail-vk0-f48.google.com with SMTP id c3so167939572vkb.3
        for <ceph-devel@vger.kernel.org>; Tue, 01 Mar 2016 06:01:37 -0800 (PST)
In-Reply-To: <CAFjGuFTQ3P_GrcTuYBR5jRxXcZu4v1DeEH23NqfER-w=SB69-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rajath Shashidhara <rajath.shashidhara@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 1, 2016 at 4:26 PM, Rajath Shashidhara
<rajath.shashidhara@gmail.com> wrote:
> Hello,
>
> I am a GSoC' 2016 aspirant. I have browsed through your ideas page and I
> find that the above project best aligns with my experience and interest.
>
> During the course of my academics, I have developed an interest in
> development of performance critical software development. I am familiar with
> the parallel and distributed computing paradigms and I would like to gain
> further experience in this field.
>
> I have experience in the development of Page buffers for efficient I/O from
> secondary storage. I lead the development of External Memory (secondary
> storage) data structures [1] for C++ over the last few months. We have
> implemented custom buffering (modifications of the LRU strategy) specific to
> each data structure. Some features of the page buffer include - support for
> page pinning, priority paging (pages with higher priority are harder to
> replace as compared to pages with low priority of comparable recent access
> time), prefetching (strategy specific to data structure). (It is an ongoing
> project and we are expanding the number of Data structures and corresponding
> optimizations)
>
> I will familiarize myself with the architecture of Ceph, the userspace NVME
> driver and the cache requirements. Please point me to the right resources
> and the documentation related to this problem. It would be great if you can
> suggest me a bug to fix or any contribution that would help me understand
> the underlying source code.

Hmm, I suppose you have a basic overview on ceph osd side.
Currently bluestore will directly manage block device, so pagecache(as
well as buffer cache) is used to cache data and metadata. But
userspace NVME driver is used to bypass kernel layer as well as
pagecache. So we can't make use of any kernel side cache.

In general, metadata cache is very important to io latency, if lack of
cache, IO mostly will hit the persist device which will cause
outstanding latency compared to cache metadata in memory even if the
backend if nvme ssd.

So we need to implement a cache layer above nvme driver to accelerate
metadata or data get.

I think it's a initial idea background, but since we also have
ObjectCacher in client side, if we can unify this it will be good. But
obviously ObjectCacher is complexity now, you may not take care of it
at first...

@sage @sam do you have any other points about this idea?

>
> Note : I have successfully completed GSoC' 2013 with Apache OpenOffice.
>
> Thank you,
> Rajath Shashidhara
>
> [1] https://github.com/ExternalMemoryDS/external-mem-ds
