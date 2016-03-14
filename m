From: Victor Araujo <ve.ar91@gmail.com>
Subject: Re: Cache tiering [GSoC 2016]
Date: Mon, 14 Mar 2016 23:57:58 +0200
Message-ID: <CA+skQMs-JzKJgY2h_MYNz2Y7Gz97-U92aKHpDGM3EY7eHt5Zjw@mail.gmail.com>
References: <CA+skQMsiv7A5MLZmiUZy50_pb07pRkGO-Vo=Bsho3FoAjOUH8w@mail.gmail.com>
	<alpine.DEB.2.11.1603110920260.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35718 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcCNV57 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 17:57:59 -0400
Received: by mail-wm0-f53.google.com with SMTP id l68so127410358wml.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2016 14:57:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603110920260.14377@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Thank you very much for your reply.

In the literature I reviewed the lack of large-scale traces to create
synthetic workloads like in [1] is highlighted. I will keep an eye on
these topics for the future.

I think the "End-to-end performance visualization" idea for this
year's GSoC would be a good start for me.

[1] http://web.stanford.edu/~cdel/Storage_I-O_google_poster.pdf



On Fri, Mar 11, 2016 at 4:28 PM, Sage Weil <sage@newdream.net> wrote:

> Hi Victor,
>
> On Thu, 10 Mar 2016, Victor Araujo wrote:
>> Hello,
>>
>> I am a first year master's student in Finland. I recently discovered
>> Ceph and have been getting acquainted with the concepts and the
>> codebase.
>>
>> I noticed the blueprint
>> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Tiering_II_(Warm-%3ECold)
>> and I was wondering if there is a particular piece of it that would
>> be suitable for this year's GSoC.
>
> The 'tiering ii' is the direction we want to go in. We need to be careful
> about designing this interface, though, and the support in the OSD to make
> use of it is delicate. It's an important effort but it is probably not
> the best candidate for a short GSoC project. Perhaps we can figure out a
> smaller piece of this that is appropriately scoped...
>
>> I also noticed several other blueprints related to cache tiering, like
>> http://tracker.ceph.com/projects/ceph/wiki/Improvement_on_the_cache_tiering_eviction
>> suggesting improvements or other implementations like ARC. Would it
>> make sense to enable some sort of cache plugins, similar to what was
>> done with erasure code plugins, to allow different strategies for
>> particular use cases and facilitate testing other implementations? If
>> it makes sense and it could be scoped for GSoC I'd be very interested.
>
> There are several ideas floating around for how to improve the existing
> cache tier code, but most of them are effectively tabled because we don't
> have a good sense of whether they will help or not.
>
> Perhaps the most valuable project for the cache tiering or tiering in
> general would be to create a set of tools and best practices for
> simulating realistic workloads and better quantifying the performance of
> tiering. Tests are hard to set up: you need reasonably sized base and
> cache tiers, cache tiers OSDs that are faster than base tier devices,
> workloads with realistic object temperature variation, tests that run long
> enough to warm up the cache, metrics that let us understand what the
> behavior is and what is working right and not right. It's a lot of
> most-not-coding work, but without it it's hard to tell if any change we
> make is making things better or worse.
>
> Does anybody else have ideas here?
>
> sage
