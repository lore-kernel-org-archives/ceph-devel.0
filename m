From: Sage Weil <sage@inktank.com>
Subject: Re: Best insertion point for storage shim
Date: Fri, 24 Aug 2012 09:42:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208240938070.29719@cobra.newdream.net>
References: <00b201cd8210$077de070$1679a150$@netmass.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60961 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965002Ab2HXQmc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:42:32 -0400
In-Reply-To: <00b201cd8210$077de070$1679a150$@netmass.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Perkins <perkins@netmass.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 24 Aug 2012, Stephen Perkins wrote:
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
> 
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
> 
> Thoughts appreciated,

The good news is that CRUSH has a mode that is intended for erasure/parity 
coding, and there are fields reserved in many ceph structures to support 
this type of thing.  The bad news is that in order to make it work it 
needs to live inside of rados, not on top of it.  The reason is that you 
need to separate the fragments across devices/failure domains/etc, which 
happens at the PG level; users of librados have no control over that 
(objects are randomly hashed into PGs, and then PGs are mapped to 
devices).

And in order to implement it properly, a lot of code shuffling and wading 
through OSD internals will be necessary.  There are some basic 
abstractions in place, but they are largely ignored and need to be shifted 
around because replication has been the only implementation for some time 
now.

I think the only way to layer this on top of rados and align your 
fragments with failure domains would be to create N different pools with 
distinct devices, and store one fragment in each pool...

sage
