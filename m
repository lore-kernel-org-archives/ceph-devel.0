From: Gregory Meno <gmeno@redhat.com>
Subject: Re: [ceph-calamari] disk failure prediction
Date: Thu, 19 Feb 2015 10:59:48 -0500 (EST)
Message-ID: <1616949710.23204723.1424361588930.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.00.1502181514400.24259@cobra.newdream.net> <54E5A539.1060803@redhat.com> <alpine.DEB.2.00.1502190644490.3074@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:50690 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbbBSP7u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Feb 2015 10:59:50 -0500
In-Reply-To: <alpine.DEB.2.00.1502190644490.3074@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <john.spray@redhat.com>, ceph-calamari@ceph.com, ceph-devel@vger.kernel.org





----- Original Message -----
> From: "Sage Weil" <sweil@redhat.com>
> To: "John Spray" <john.spray@redhat.com>
> Cc: ceph-calamari@ceph.com, ceph-devel@vger.kernel.org
> Sent: Thursday, February 19, 2015 9:58:21 AM
> Subject: Re: [ceph-calamari] disk failure prediction
> 
> On Thu, 19 Feb 2015, John Spray wrote:
> > 
> > On 18/02/2015 23:20, Sage Weil wrote:
> > > We wouldn't see
> > > quite the same results since our "raid sets" are effectively entire pools
> >
> > I think we could do better than pool-wide, e.g. if multiple drives in one
> > chassis are at risk (where PG stores at most one copy per chassis), we can
> > identify that as less severe than the general case where multiple at-risk
> > drives might be in the same PG.  Making it CRUSH-aware like this would be a
> > good hook for users to take advantage of the ceph/calamari SMART monitoring
> > rather than rolling their own.
> 
> Yeah, sounds good.  The big question in my mind is whether we should try
> to pull this into the osd/mon or have calamari do it.  It seems like a
> good fit for calamari...

I agree that calamari is a good place for this. We have the ability to target 
nodes by capability and the ability to distribute modules/install packages
to run checks. What is missing in my opinion is a service that aggregate the 
data and easy routing to the api.

Also we should be able to connect more dots for the consumer of this data
now that calamari is beginning to understand CRUSH and how it maps
to the physical entities that make up a cluster. 

> 
> BTW, a bit more color on the original paper (after talking to Paul): the
> EMC workload in the paper was backup/archival with heavy heavy write, and
> any time there was a read failure it triggered a rewrite and triggered a
> relocated sector.  Other studies have shown some pretty different results.
> For example, one showed that the best preditor was actually not SMART at
> all but (carefully measured) read latency.
> 
> In any case, it seems like the bits that are gathering and aggregating
> SMART should be general, and we should make it easy to plug in various
> policies (or delegate to an external agent) for responding to that data.

Allowing an easy way to add specific checks and alerting 
in calamari would be easier to manage than making it part of ceph.

We had discussed a plugin system for calamari in the past. it may be easier 
to just document how to do it with a good example and then iterate to 
make it easier. I want to focus on more data gathering and alerting in 
calamari in general going forward.


-Gregory
