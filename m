From: Sage Weil <sweil@redhat.com>
Subject: Re: Bluestore-Performance regression in the latest master
Date: Thu, 6 Oct 2016 21:16:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610062115250.19850@piezo.us.to>
References: <BY2PR02MB396BEF6CFDD1164D194C9D2F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933875AbcJFVQ7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 17:16:59 -0400
In-Reply-To: <BY2PR02MB396BEF6CFDD1164D194C9D2F4C70@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 6 Oct 2016, Somnath Roy wrote:
> Sage,
> I am seeing the performance with the latest master is not stable compare to 3 days old master. The peak performance is higher but it is jumping up and down. Analyzing further I suspect recent cache changes has an impact. While the performance is high , I am seeing lower disk reads (probably because of cache hits) , but the low point is much lower when it is missing the cache probably. You were saying on the standup about adding buffers in the cache in the write path , is that merged into the master ?

The buffered writes by default is not merged:

	https://github.com/ceph/ceph/pull/11301
 
> The following pull request for cache that got merged seems reasonable.
> 
> https://github.com/ceph/ceph/pull/11295

This cut the cache size down by 4x, plus whatever your sharding factor 
is/was.  Could that be it?

> Any hunch what is causing this degradation recently ? Otherwise, I need to dig down to find that out :-(
> 
> See the graph in the following link for the performance difference.
> 
> https://docs.google.com/spreadsheets/d/1JO3FaBbfT5jEdyYGB8EhHnAl5bAHe06ojLE85mPzsK4/edit?usp=sharing
> 
> The left side graph is with old master and right one is with latest master..Old one I ran for 10 hour and latest master I ran it for 2 hours.
> The new one has *4X more* latency as well..

My guess is the cache size.  I can't think of what else would have 
much of an effect on latency...

s
