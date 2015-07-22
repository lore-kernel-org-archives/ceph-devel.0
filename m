From: Sage Weil <sweil@redhat.com>
Subject: RE: The design of the eviction improvement
Date: Wed, 22 Jul 2015 05:56:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507220551290.8878@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C53489FFC64@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1507201530200.8878@cobra.newdream.net> <06E7D85B3BA36C4DB207FEDE871C53489FFF18@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1507210620270.8878@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C5348A001B4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56773 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbbGVM4d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Jul 2015 08:56:33 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348A001B4@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 22 Jul 2015, Wang, Zhiqiang wrote:
> > The part that worries me now is the speed with which we can load and 
> > manage such a list.  Assuming it is several hundred MB, it'll take a 
> > while to load that into memory and set up all the pointers (assuming a 
> > conventional linked list structure).  Maybe tens of seconds...
> 
> I'm thinking of maintaining the lists at the PG level. That's to say, we 
> have an active/inactive list for every PG. We can load the lists in 
> parallel during rebooting. Also, the ~100 MB lists are split among 
> different OSD nodes. Perhaps it does not need such long time to load 
> them?
> 
> > 
> > I wonder if instead we should construct some sort of flat model where 
> > we load slabs of contiguous memory, 10's of MB each, and have the 
> > next/previous pointers be a (slab,position) pair.  That way we can 
> > load it into memory in big chunks, quickly, and be able to operate on 
> > it (adjust links) immediately.
> > 
> > Another thought: currently we use the hobject_t hash only instead of 
> > the full object name.  We could continue to do the same, or we could 
> > do a hash pair (hobject_t hash + a different hash of the rest of the 
> > object) to keep the representation compact.  With a model lke the 
> > above, that could get the object representation down to 2 u32's.  A 
> > link could be a slab + position (2 more u32's), and if we have prev + 
> > next that'd be just 6x4=24 bytes per object.
> 
> Looks like for an object, the head and the snapshot version have the 
> same hobject hash. Thus we have to use the hash pair instead of just the 
> hobject hash. But I still have two questions if we use the hash pair to 
> represent an object.
>
> 1) Does the hash pair uniquely identify an object? That's to say, is it 
> possible for two objects to have the same hash pair?

With two hashes collisions would be rare but could happen

> 2) We need a way to get the full object name from the hash pair, so that 
> we know what objects to evict. But seems like we don't have a good way 
> to do this?

Ah, yeah--I'm a little stuck in the current hitset view of things.  I 
think we can either embed the full ghobject_t (which means we lose the 
fixed-size property, and the per-object overhead goes way up.. probably 
from ~24 bytes to more like 80 or 100).  Or, we can enumerate objects 
starting at the (hobject_t) hash position to find the object.  That's 
somewhat inefficient for FileStore (it'll list a directory of a hundred or 
so objects, probably, and iterate over them to find the right one), but 
for NewStore it will be quite fast (NewStore has all objects sorted into 
keys in rocksdb, so we just start listing at the right offset).  Usually 
we'll get the object right off, unless there are hobject_t hash collisions 
(already reasonably rare since it's a 2^32 space for the pool).

Given that, I would lean toward the 2-hash fixed-sized records (of these 2 
options)...

sage

