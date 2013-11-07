From: Patrick McGarry <patrick@inktank.com>
Subject: Re: emperor leftovers
Date: Thu, 7 Nov 2013 10:30:33 -0500
Message-ID: <CAP8Oy=Kw7U83RpMexwU2Ush_rjWYHwqQGX8cTLUMGbRhGGj_3Q@mail.gmail.com>
References: <alpine.DEB.2.00.1311070659420.17943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:39734 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab3KGPae (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 10:30:34 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so745753pbb.29
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 07:30:33 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311070659420.17943@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

I have moved all of these to our new development "sideboard" [1] which
can be used to store blueprints that don't make major releases.
Alternately, if you have an idea and want help fleshing it out, this
would be a great place to drop a blueprint for community
collaboration.

[1] http://wiki.ceph.com/01Planning/Sideboard



Best Regards,

Patrick McGarry
Director, Community || Inktank
http://ceph.com  ||  http://inktank.com
@scuttlemonkey || @ceph || @inktank


On Thu, Nov 7, 2013 at 10:05 AM, Sage Weil <sage@inktank.com> wrote:
> There are several blueprints that were put together for emperor even
> though we didn't have the developer time to actually do them.  For anyone
> interested in getting involved in Ceph development, these may present an
> easy way to get involved in the process.  If you're interested in
> adopting any of these orphan blueprints, speak up and we can make sure it
> gets onto the firefly CDS schedule.
>
> In (very) approximate order of difficulty:
>
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Source_tree_restructuring
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_shared_read_cache
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_namespace_support
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rbd%3A_copy-on-read_for_clones
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/mds%3A_dumpability
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd%3A_clone_from_journal_on_btrfs
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/mds%3A_reduce_memory_consumption
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
