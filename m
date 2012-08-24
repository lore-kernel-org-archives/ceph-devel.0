From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: Best insertion point for storage shim
Date: Fri, 24 Aug 2012 12:42:19 -0400
Message-ID: <033DC7C8-025D-40C9-A801-DBDC77E649D7@ornl.gov>
References: <00b201cd8210$077de070$1679a150$@netmass.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.14.70]:12208 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964937Ab2HXQmX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:42:23 -0400
In-Reply-To: <00b201cd8210$077de070$1679a150$@netmass.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Aug 24, 2012, at 11:49 AM, Stephen Perkins wrote:

> Hi all,
> 
> I'd like to get feedback from folks as to where the best place would be to
> insert a "shim" into the RADOS object storage.
> 
> Currently, you can configure RADOS to use copy based storage to store
> redundant copies of a file (I like 3 redundant copies so I will use that as
> an example).  So... each file is stored in three locations on independent
> hardware.   The redundancy has a cost of 3x the storage.
> 
> I would assume that it is "possible" to configure RADOS to store only 1 copy
> of a file (bear with me here).
> 
> I'd like to see where it may be possible to insert a "shim" in the storage
> such that I can take the file to be stored and apply some erasure coding to
> it. Therefore, the file now becomes multiple files that are handed off to
> RADOS.
> 
> The shim would also have to take read file requests and read some small
> portion of the fragments and recombine.

This sounds more like a modification to the POSIX file system interface rather than to the RADOS object store which knows nothing of files.

> Basically... what I am asking is...  where would be the best place to start
> looking at adding this:
> 	https://tahoe-lafs.org/trac/tahoe-lafs#
> 	
> (just the erasure coded part).
> 
> Here is the real rationale.  Extreme availability at only 1.3 or 1.6 time
> redundancy:
> 
> 	http://www.zdnet.com/videos/whiteboard/dispersed-storage/156114

The "extreme" reliability is a bit oversold. I worked on a project a decade ago that stored blocks of files over servers scattered around the globe. Each block was checksummed and optionally encrypted (they were not our servers, so we did not assume that we could trust the admins). To handle reliability, we implemented both replication (copies) and error coding (Reed-Solomon based erasure coding). There is a trade-off between the two.

Copies are nice since they do not require extra computation and they can be handled between servers so that the client only has to store once (which is what the ceph file system does). Copies also allow you to load balance over more servers and increase read access (which ceph does not do since the copies are pseudo-randomly stored and _should_ provide load-balancing on average). With good CRUSH rules, they should provide better fault-tolerance (e.g. a rack goes down, pull from a copy on another rack). The maximum failure level is N where N is the number of copies. That also means that your total usable storage is 1/Nth the raw capacity.

Error coding allows you to tolerate greater number of failures at the expense of computation and memory usage. When using error coding, you break up a file into blocks (as mentioned in the video). For a set of M blocks (this is the coding block set size), you create one or more (N) coding blocks. In the video example, 1.3 corresponds to one coding block per three data blocks (N=1 and M=3). This means it can tolerate losing one of the four blocks and still recompute the original data using any 3 of the M + N blocks. A level of 1.6 simply is two coding blocks per three data blocks which can now survive losing two of the blocks. Using three coding blocks per three data blocks (not mentioned in the video) allows you to survive three failures at the cost of 1/2 the raw capacity which is clearly
  a win over simple replication.

The downside is that calculating the erasure coding is not cheap and it requires an extra block's worth of memory until it is complete. It is best to implement the coding at the client since it has all the data, while servers do not and would have to copy the data to the server performing the computation. It is possible to pipeline the storing of blocks and hopefully mask this but it adds to the requirements of the processors for normal usage (not to mention when handling failures). Also, if you need to read a block that is not available, you are no longer reading one block (e.g. of 4 MB), but the whole coding set (M blocks of 4 MBs) which increases the network traffic M times.

Erasure coding is no magic bullet and has a use, but it is complicated and increases computing resource requirements.

Scott


