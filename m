From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Fri, 12 Apr 2013 11:08:36 -0500
Message-ID: <51683184.9010301@inktank.com>
References: <loom.20130412T055215-88@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:37309 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043Ab3DLQIZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 12:08:25 -0400
Received: by mail-ie0-f176.google.com with SMTP id x12so3472899ief.7
        for <ceph-devel@vger.kernel.org>; Fri, 12 Apr 2013 09:08:24 -0700 (PDT)
In-Reply-To: <loom.20130412T055215-88@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthias Urlichs <matthias@urlichs.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/11/2013 10:59 PM, Matthias Urlichs wrote:
> As I understand it, in Ceph one can cluster storage nodes, but otherwise
> every node is essentially identical, so if three storage nodes have a file,
> ceph randomly uses one of them.

Ceph clusters have the concept of pools, where each pool has a certain 
number of placement groups.  Placement groups are just collections of 
mappings to OSDs.  Each PG has a primary OSD and a number of secondary 
ones, based on the replication level you set when you make the pool. 
When an object gets written to the cluster, CRUSH will determine which 
PG the data should be sent to.  The data will first hit the primary OSD 
and then replicated out to the other OSDs in the same placement group.

Currently reads always come from the primary OSD in the placement group 
rather than a secondary even if the secondary is closer to the client. 
I'm guessing there are probably some tricks that could be played here to 
best determine which machines should service which clients, but it's not 
exactly an easy problem.  In many cases spreading reads out over all of 
the OSDs in the cluster is better than trying to optimize reads to only 
hit local OSDs.  Ideally you probably want to prefer local OSDs first, 
but not exclusively.

>
> This is not efficient use of network resources in a distributed data center.
> Or even in a multi-rack situation.
>
> I want to prefer accessing nodes which are "local".
> The client in rack A should prefer to read from the storage nodes that are
> also in rack A.
> Ditto for rack B.
> Ditto for s/rack/data center/.
>
> As far as I understand, the Ceph clients can't do that.
> (Nor can Ceph nodes among each other, but I care less about that, as most
> traffic is reading data.)
>
> I think this is an important feature for many high-reliability situations.
>
> What would be the next steps to get this feature, assuming I don't have time
> to implement it myself? Persistently annoy this mailing list that people
> need it? Offer to pay for implementing it? Shut up and look for some other
> solution -- which I already did, but I didn't find any that's as good as
> Ceph, otherwise?

I don't really have that much insight into the product roadmap, but I 
assume that if you spoke to some of our business folks about paying for 
development work you'd at least get a response.

>
> I've opened a feature request for this, half a year ago, which hasn't seen
> any comments yet: http://tracker.ceph.com/issues/3249

Sadly there's a lot of things we'd like to do and not enough time to do 
them. :(  If we get a lot of requests for this from other people too, it 
might bump the priority up.

>
> -- Matthias Urlichs
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

