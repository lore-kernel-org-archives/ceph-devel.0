From: Sage Weil <sage@newdream.net>
Subject: Re: Cache tiering [GSoC 2016]
Date: Fri, 11 Mar 2016 09:28:19 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603110920260.14377@cpach.fuggernut.com>
References: <CA+skQMsiv7A5MLZmiUZy50_pb07pRkGO-Vo=Bsho3FoAjOUH8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34221 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcCKO2k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Mar 2016 09:28:40 -0500
In-Reply-To: <CA+skQMsiv7A5MLZmiUZy50_pb07pRkGO-Vo=Bsho3FoAjOUH8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Araujo <ve.ar91@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Victor,

On Thu, 10 Mar 2016, Victor Araujo wrote:
> Hello,
> 
> I am a first year master's student in Finland. I recently discovered
> Ceph and have been getting acquainted with the concepts and the
> codebase.
> 
> I noticed the blueprint
> http://tracker.ceph.com/projects/ceph/wiki/Osd_-_Tiering_II_(Warm-%3ECold)
> and I was wondering if there is a particular piece of it  that would
> be suitable for this year's GSoC.

The 'tiering ii' is the direction we want to go in.  We need to be careful 
about designing this interface, though, and the support in the OSD to make 
use of it is delicate.  It's an important effort but it is probably not 
the best candidate for a short GSoC project.  Perhaps we can figure out a 
smaller piece of this that is appropriately scoped...

> I also noticed several other blueprints related to cache tiering, like
> http://tracker.ceph.com/projects/ceph/wiki/Improvement_on_the_cache_tiering_eviction
> suggesting improvements or other implementations like ARC. Would it
> make sense to enable some sort of cache plugins, similar to what was
> done with erasure code plugins, to allow different strategies for
> particular use cases and facilitate testing other implementations? If
> it makes sense and it could be scoped for GSoC I'd be very interested.

There are several ideas floating around for how to improve the existing 
cache tier code, but most of them are effectively tabled because we don't 
have a good sense of whether they will help or not.

Perhaps the most valuable project for the cache tiering or tiering in 
general would be to create a set of tools and best practices for 
simulating realistic workloads and better quantifying the performance of 
tiering.  Tests are hard to set up: you need reasonably sized base and 
cache tiers, cache tiers OSDs that are faster than base tier devices, 
workloads with realistic object temperature variation, tests that run long 
enough to warm up the cache, metrics that let us understand what the 
behavior is and what is working right and not right.  It's a lot of 
most-not-coding work, but without it it's hard to tell if any change we 
make is making things better or worse.

Does anybody else have ideas here?

sage
