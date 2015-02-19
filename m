From: Sage Weil <sweil@redhat.com>
Subject: Re: [ceph-calamari] disk failure prediction
Date: Thu, 19 Feb 2015 06:58:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502190644490.3074@cobra.newdream.net>
References: <alpine.DEB.2.00.1502181514400.24259@cobra.newdream.net> <54E5A539.1060803@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60074 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbbBSO60 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 19 Feb 2015 09:58:26 -0500
In-Reply-To: <54E5A539.1060803@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: ceph-devel@vger.kernel.org, ceph-calamari@ceph.com

On Thu, 19 Feb 2015, John Spray wrote:
> 
> On 18/02/2015 23:20, Sage Weil wrote:
> > We wouldn't see
> > quite the same results since our "raid sets" are effectively entire pools
>
> I think we could do better than pool-wide, e.g. if multiple drives in one
> chassis are at risk (where PG stores at most one copy per chassis), we can
> identify that as less severe than the general case where multiple at-risk
> drives might be in the same PG.  Making it CRUSH-aware like this would be a
> good hook for users to take advantage of the ceph/calamari SMART monitoring
> rather than rolling their own.

Yeah, sounds good.  The big question in my mind is whether we should try 
to pull this into the osd/mon or have calamari do it.  It seems like a 
good fit for calamari...

BTW, a bit more color on the original paper (after talking to Paul): the 
EMC workload in the paper was backup/archival with heavy heavy write, and 
any time there was a read failure it triggered a rewrite and triggered a 
relocated sector.  Other studies have shown some pretty different results.  
For example, one showed that the best preditor was actually not SMART at 
all but (carefully measured) read latency.

In any case, it seems like the bits that are gathering and aggregating 
SMART should be general, and we should make it easy to plug in various 
policies (or delegate to an external agent) for responding to that data. 

sage
