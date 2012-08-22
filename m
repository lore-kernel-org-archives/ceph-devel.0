From: Sage Weil <sage@inktank.com>
Subject: Re: wip-crush
Date: Wed, 22 Aug 2012 09:33:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208220929390.32470@cobra.newdream.net>
References: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net> <5034F0B4.3060107@hastexo.com> <C4813C81-696A-4261-A4E7-991C719C0DB2@ornl.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48226 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661Ab2HVQd4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 12:33:56 -0400
In-Reply-To: <C4813C81-696A-4261-A4E7-991C719C0DB2@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 22 Aug 2012, Atchley, Scott wrote:
> On Aug 22, 2012, at 10:46 AM, Florian Haas wrote:
> 
> > On 08/22/2012 03:10 AM, Sage Weil wrote:
> >> I pushed a branch that changes some of the crush terminology.  Instead of 
> >> having a crush type called "pool" that requires you to say things like 
> >> "pool=default" in the "ceph osd crush set ..." command, it uses "root" 
> >> instead.  That hopefully reinforces that it is a tree/hierarchy.
> >> 
> >> There is also a patch that changes "bucket" to "node" throughout, since 
> >> bucket is a term also used by radosgw.
> >> 
> >> Thoughts?  I think the main pain in making this transition is that old 
> >> clusters have maps that have a type 'pool' and new ones won't, and the 
> >> docs will need to walk people through both...
> > 
> > "pool" in a crushmap being completely unrelated to a RADOS pool is
> > something that I've heard customers/users report as confusing, as well.
> > So changing that is probably a good thing. Naming it "root" is probably
> > a good choice as well, as it happens to match
> > http://ceph.com/wiki/Custom_data_placement_with_CRUSH.
> > 
> > As for changing "bucket" to node... a "node" is normally simply a
> > physical server (at least in HA terminology, which many potential Ceph
> > users will be familiar with), and CRUSH uses "host" for that. So that's
> > another recipe for confusion. How about using something super-generic,
> > like "element" or "item"?
> > 
> > Cheers,
> > Florian
> 
> My guess is that he is trying to use data structure tree nomenclature 
> (root, node, leaf). I agree that node is an overloaded term (as is 
> pool).

Yeah...

> As for an alternative to bucket which indicates the item is a 
> collection, what about subtree or branch?

I think fixing the overloading of 'pool' in the default crush map is the 
biggest pain point.  I can live with crush 'buckets' staying the same (esp 
since that's what the papers and code use pervasively) if we can't come up 
with a better option.

On the pool part, though, the challenge is how to transition.  Existing 
clusters have maps that use 'pool', and new clusters will use 'root' (or 
whatever).  Some options:

 - document both.  this kills much of the benefit of switching, but is 
   probably inevitable since people will be running different versions. 
 - make the upgrade process transparently rename the type.  this lets 
   all the tools use the new names.
 - make the tools silently translate old names to new names.  this is 
   kludgey in that it makes the code make assumptions about the names of 
   the data it is working with, but would cover everyone except those who 
   created their own crush maps from scratch.
 - ?

sage
