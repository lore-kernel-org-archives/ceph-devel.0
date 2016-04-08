From: Sage Weil <sage@newdream.net>
Subject: Re: Started developing a deduplication feature
Date: Fri, 8 Apr 2016 11:18:25 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604081114200.19675@cpach.fuggernut.com>
References: <8737r5w89m.fsf@uni-mainz.de> <alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com> <87wpodv99m.fsf@uni-mainz.de> <871t6gkuuz.fsf@uni-mainz.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50728 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbcDHPSb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 11:18:31 -0400
In-Reply-To: <871t6gkuuz.fsf@uni-mainz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <lauhoff@uni-mainz.de>
Cc: ceph-devel@vger.kernel.org

On Fri, 8 Apr 2016, Marcel Lauhoff wrote:
> Hi list,
> short recap of the dedup topic from the CDM on Wednesday:
> 
> The main change from the original mail is not to add a PG backend, but
> rather use Object Redirects (Tiering v2).

Let's call this 'Tiering v2', since it won't be based on redirects.  
(These were extremely problematic in cache tiering because they prevent us 
from maintaining an ordering; we now proxy ops instead.)

Some point soonish we should recreate/update that old blueprint with the 
new design.

> Another backend would have to implement its own replication for
> recipes and increase the OSD code base just for dedup. Redirects are
> useful beyond deduplication.
> 
> The CAS pool design was refined: An object class should handle the ref
> counting and content addressing.

cls_refcount might be sufficient here; if not it's probably a starting 
point.

> The pool should also only
> allow access through this object class to prevent collisions with
> regular objects and support immutable objects.

We decided we can just do this via the cephx capabilities by granting 
the client(s) access to the appropriate class only.

> There was also the idea of client-side deduplication by using metadata
> that clients like RGW store. This would save the additional round trip
> that object redirects add.

Presumably the (first) user here is radosgw, which is already writing more 
or less immutable chunks and could easily dump them in a CAS pool instead 
of a normal replicated pool.

> I'll be working on the CAS pool first, since there
> is ongoing refactoring in the ReplicatedPG code base. I'll work out a
> more detailed design document for the CAS pool soon.

Sounds great.  Thanks, Marcel!
sage
