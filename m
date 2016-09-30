From: Sage Weil <sage@newdream.net>
Subject: RE: Memory Pooling and Containers
Date: Fri, 30 Sep 2016 14:22:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609301416270.19850@piezo.us.to>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com> <alpine.DEB.2.11.1609281316210.19847@piezo.us.to> <alpine.LSU.2.20.1609281413450.13361@ancalagon.suse.de>
 <BLUPR0201MB152427C4BD08DEDB9178C89AE8CF0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48138 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbcI3OWb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Sep 2016 10:22:31 -0400
In-Reply-To: <BLUPR0201MB152427C4BD08DEDB9178C89AE8CF0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Jesse Williamson <jwilliamson@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 28 Sep 2016, Allen Samuels wrote:
> Boost::pool works very well when you're allocated "same" sized objects. 
> That's not our situation, we're allocating lots of different sized 
> objects -- some small, some large. The only way that Boost::pool 
> supports that situation is to use the "ordered_free" operation to keep 
> the freelist sorted (if you don't use it then you'll get fragmentation 
> that'll prevent allocation of large objects -- even though there's 
> plenty of free memory). The implementation of the sorted freelist is 
> O(N). Which should work well for small pools, but that's the exact 
> opposite of the desired use for Ceph, we're targeting large pools (think 
> 1GB).
> 
> I didn't word it very well, but my proposal doesn't actually change the 
> underlying malloc/free algorithm, rather it's intended to put some 
> statistics around memory usage so that we can self-trim our memory 
> pools.

We were doing some heap profiling yesterday and one interesting thing is 
that the utilized heap reported by tcmalloc is about 1/2 the RSS.  We 
probably want to consider creating separate pools for the handful of 
objects that are consuming the bulk of the heap.

We did this a few years back in the MDS and IIRC it helped significantly 
with memory utilization there.

sage
