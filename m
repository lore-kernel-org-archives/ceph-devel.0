From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueStore
Date: Fri, 25 Mar 2016 08:45:30 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603250840001.26068@cpach.fuggernut.com>
References: <CY1PR0201MB18973994D4CD6F28980B1240E8820@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58002 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbcCYMpn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 25 Mar 2016 08:45:43 -0400
In-Reply-To: <CY1PR0201MB18973994D4CD6F28980B1240E8820@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 24 Mar 2016, Allen Samuels wrote:
> Just wanted to drop a quick note and ask for some feedback.
> 
> We've been digging into the BlueStore code and there's a list of things that
> we either missed, don't understand or believe need to be addressed before
> BlueStore can be production ready.
> 
> (1) Block Allocator.
> 
> As I've described earlier, the memory performance of the current allocator
> is a concern. IMO this MUST be fixed before production status.

Agreed.  Let's make it a goal to settle on the approach by the end 
of the hackathon next Friday.

> (2) BlueFS Cache Memory Consumption
> 
> There doesn't appear to be a way to limit the memory consumption of cached
> BlueFS files.

The only data cache is the page cache address_space assocated with the 
block device, which is handled by the kernel.  You're right that there 
isn't a way to prevent it from consuming otherwise unused memory, but it 
won't prevent that memory from being reclaimed and used by anything else, 
so I don't think that is a problem.

Eventually we may need finer-grained control of the cache, but I don't 
think we are anywhere close to that point yet...

> (3) BlueFS Journal Compaction
> 
> Current implementation periodically re-compacts the BlueFS journal (log) and
> inhibits other write operations during this time. Not clear if this has a
> significant impact on front-end latency or not.

The plan has always been to make this an async process, but it wasn't 
trivial enough to do in the first pass.  Some but not all of the 
infrastructure is there.

> (4) WAL Throttling
> 
> There doesn't appear to be a mechanism to limit the amount of outstanding
> WAL data. Some limit is needed here.

There are throttle_wal_{ops,bytes} throttles.  Nothing very sophisticated.  
Sam and Somnath, we should revisit the overall throttling approach given 
what you've learned with FileStore.

> (5) Compression
> 
> While technically not required to make bluestore production ready. I think
> there will be enough revision of the code and data structures in order to
> support compression that we really really want to get this into BlueStore
> before it goes "GA", so that we don't have to re-stabilize it.

Agreed, and I would combine (5.5) Checksums with this as the data 
structures and overall IO flow are essentially the same.

> (6) Erasure Coding Overwrites
> 
> As previously documented, this feature requires support in BlueStore.
> Fortunately, implementing support is easy and non-disruptive. Hence, one
> might argue that it doesn't belong on this list.

Yeah, this one should be quite straightforward.  We can add it sooner 
rather than later, but there won't be any users (aside from the 
unit/functional tests), so I'm fine waiting.

sage
