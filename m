From: "Stephen Perkins" <perkins@netmass.com>
Subject: RE: Best insertion point for storage shim
Date: Fri, 31 Aug 2012 09:37:49 -0500
Message-ID: <002f01cd8786$31b62340$952269c0$@netmass.com>
References: <00b201cd8210$077de070$1679a150$@netmass.com> <alpine.DEB.2.00.1208240938070.29719@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 142.122.233.72.static.reverse.ltdomains.com ([72.233.122.142]:61038
	"EHLO stgateway01.netmass.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999Ab2HaOh6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Aug 2012 10:37:58 -0400
In-Reply-To: <alpine.DEB.2.00.1208240938070.29719@cobra.newdream.net>
Content-Language: en-us
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Sage Weil' <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi all,

Excellent points all.  Many thanks for the clarification. 

*Tommi* - Yep... I wrote file but had object in mind.  However... now that
you bring the distinction... I may actually mean file.  (see below)  I don't
know Zooko personally, but will definitely pass it on if I meet him! 

*Scott* - Agreed.

As to the performance... I am also in agreement.  My thoughts were to make
the operation lazy.  By this, I mean that items that are not due to change
much (think archive items) could be converted from N Copies to an Erasure
coded equivalent.  The Lazy piece of that would help reduce the processing
overhead.  The encoded items could also be "on demand" decoded back to N
items if such items are accessed over a given threshold.  This is not
exactly tiered storage... but has many of the same characteristics.

Sage... it may be that your second approach of having N storage pools and
writing to them is the best approach.  The reasoning is that I'm not sure
that RADOS will have any idea of "which" objects would be candidates for
lazy erasure coding.  If done closer to a POSIX level, then files and
directories that have not been accessed recently could become candidates for
the coding. 

My personal desire is to have this available for archiving large file based
datasets in an economical fashion.  The files would be "generated" by
commercial file archiving software (with the source data contained on other
systems) and would be stored on a ceph cluster via either CephFS or an RBD
device with a standard file system on it. 

Then, because of domain specific knowledge about the data (i.e. it is
archive data), I would know that much of the data will probably never be
touched again.  IMHO, that would be good candidate data for erasure coding.

One approach would be to have a standard cephFS mounted and configured with
RADOS to keep N copies of data.  The second would be to have a new RScephFS
(Reed-Solomon encoded) mount point (possibly using Sage's many storage pools
approach) .  Then.. .using available tiering software, files could be
"moved" from one mount point to the other based on some criteria.  Pointers
on the original mount point make this basically invisible.  If a files is
access too many times, it can be "moved" back to the cephFS mount point.

Would this require 2 clusters because of the need to have RADOS keep N
copies on one and 1 copy on the other? 

I appreciate the discussion... it is helping me fashion what I'm really
interested in...

- Steve

-----Original Message-----
From: Sage Weil [mailto:sage@inktank.com] 
Sent: Friday, August 24, 2012 11:43 AM
To: Stephen Perkins
Cc: ceph-devel@vger.kernel.org
Subject: Re: Best insertion point for storage shim

On Fri, 24 Aug 2012, Stephen Perkins wrote:
> Hi all,
> 
> I'd like to get feedback from folks as to where the best place would 
> be to insert a "shim" into the RADOS object storage.
> 
> Currently, you can configure RADOS to use copy based storage to store 
> redundant copies of a file (I like 3 redundant copies so I will use 
> that as an example).  So... each file is stored in three locations on
independent
> hardware.   The redundancy has a cost of 3x the storage.
> 
> I would assume that it is "possible" to configure RADOS to store only 
> 1 copy of a file (bear with me here).
> 
> I'd like to see where it may be possible to insert a "shim" in the 
> storage such that I can take the file to be stored and apply some 
> erasure coding to it. Therefore, the file now becomes multiple files 
> that are handed off to RADOS.
> 
> The shim would also have to take read file requests and read some 
> small portion of the fragments and recombine.
> 
> Basically... what I am asking is...  where would be the best place to 
> start looking at adding this:
> 	https://tahoe-lafs.org/trac/tahoe-lafs#
> 	
> (just the erasure coded part).
> 
> Here is the real rationale.  Extreme availability at only 1.3 or 1.6 
> time
> redundancy:
> 
> 	http://www.zdnet.com/videos/whiteboard/dispersed-storage/156114
> 
> Thoughts appreciated,

The good news is that CRUSH has a mode that is intended for erasure/parity
coding, and there are fields reserved in many ceph structures to support
this type of thing.  The bad news is that in order to make it work it needs
to live inside of rados, not on top of it.  The reason is that you need to
separate the fragments across devices/failure domains/etc, which happens at
the PG level; users of librados have no control over that (objects are
randomly hashed into PGs, and then PGs are mapped to devices).

And in order to implement it properly, a lot of code shuffling and wading
through OSD internals will be necessary.  There are some basic abstractions
in place, but they are largely ignored and need to be shifted around because
replication has been the only implementation for some time now.

I think the only way to layer this on top of rados and align your fragments
with failure domains would be to create N different pools with distinct
devices, and store one fragment in each pool...

sage

