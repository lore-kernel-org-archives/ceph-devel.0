From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: seastar starting points
Date: Wed, 13 Dec 2017 13:10:06 -0500
Message-ID: <20171213181006.GC7704@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1712131629430.2838@piezo.novalocal>
 <6e5bf1ee-14bc-8b12-9e8b-ba9304271853@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752584AbdLMSKH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Dec 2017 13:10:07 -0500
Content-Disposition: inline
In-Reply-To: <6e5bf1ee-14bc-8b12-9e8b-ba9304271853@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.a.nelson@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 13/12/2017, Mark Nelson wrote:
[snip]
> That's really exciting!  Josh and Greg mentioned in standup that we wouldn't
> use the seastar memory allocator at all.  Would it be
> difficult/counterproductive to carve out some memory that seastar could
> manage itself while using tcmalloc or whatever for the posix side?

Since the Seastar allocator gets a bunch of memory up-front and
divides it between cores they can do allocations and frees with no
lock contention or system calls. It's pretty fast and we almost
certainly want it, eventually.

It also has backpressure so we can know to throw things out of cache
more aggressively when we're starting to use lots of memory.

So we should plan to turn it on after integration, and maybe run some
tests with it on so eventually we can use it without breaking the
world.

> It seems to me like seastar's desire override new/delete isn't really a good
> long term solution for anyone.

It's unfortunate. It has the nice property that you can just write in
normal looking C++, instead of replacing all your news with something
like new (seastar_alloc) something_t(whatever); or passing allocators
into all your containers.

But it makes cooperation really hard.

(in some ways it makes code-sharing easier, though. Stuff that's
independent of threading and synchronization can just new and delete
and make containers without modification.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@OFTC, Actinic@Freenode
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
