From: Sage Weil <sage@inktank.com>
Subject: Re: emperor leftovers
Date: Thu, 7 Nov 2013 17:15:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311071709580.17943@cobra.newdream.net>
References: <alpine.DEB.2.00.1311070659420.17943@cobra.newdream.net> <CAP8Oy=Kw7U83RpMexwU2Ush_rjWYHwqQGX8cTLUMGbRhGGj_3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47450 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab3KHBPa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 20:15:30 -0500
In-Reply-To: <CAP8Oy=Kw7U83RpMexwU2Ush_rjWYHwqQGX8cTLUMGbRhGGj_3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <patrick@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, noahwatkins@gmail.com

The portability blueprint isn't complete, but is also well underway.  That 
may merit a quick session to discuss the balance of the summit.  I'm also 
curious if the discussion on windows portability is relevant here or if 
it's better treated as a separate but related effort.  I suspect making 
things like cephfs and librados build on windows will mean providing 
alternate implemantations of things like Mutex, Cond, Thread, and so 
forth.

Others:

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw%3A_multitenancy
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw%3A_bucket_index_scalability
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rgw%3A_plugin_architecture
http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Create_and_Maintain_S3_feature_list_for_compatibility_tracking
http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Client_Security_for_CephFS
http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/create_crush_library

sage

On Thu, 7 Nov 2013, Patrick McGarry wrote:

> I have moved all of these to our new development "sideboard" [1] which
> can be used to store blueprints that don't make major releases.
> Alternately, if you have an idea and want help fleshing it out, this
> would be a great place to drop a blueprint for community
> collaboration.
> 
> [1] http://wiki.ceph.com/01Planning/Sideboard
> 
> 
> 
> Best Regards,
> 
> Patrick McGarry
> Director, Community || Inktank
> http://ceph.com  ||  http://inktank.com
> @scuttlemonkey || @ceph || @inktank
> 
> 
> On Thu, Nov 7, 2013 at 10:05 AM, Sage Weil <sage@inktank.com> wrote:
> > There are several blueprints that were put together for emperor even
> > though we didn't have the developer time to actually do them.  For anyone
> > interested in getting involved in Ceph development, these may present an
> > easy way to get involved in the process.  If you're interested in
> > adopting any of these orphan blueprints, speak up and we can make sure it
> > gets onto the firefly CDS schedule.
> >
> > In (very) approximate order of difficulty:
> >
> > http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Source_tree_restructuring
> > http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_shared_read_cache
> > http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_namespace_support
> > http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_copy-on-read_for_clones
> > http://wiki.ceph.com/01Planning/02Blueprints/Emperor/mds%3A_dumpability
> > http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd%3A_clone_from_journal_on_btrfs
> > http://wiki.ceph.com/01Planning/02Blueprints/Emperor/mds%3A_reduce_memory_consumption
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
