From: Sage Weil <sage@inktank.com>
Subject: Re: erasure coding (sorry)
Date: Mon, 22 Apr 2013 11:31:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304221125260.15710@cobra.newdream.net>
References: <20130418162842.0c61d1e2@dieter-t420s> <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net> <517060B2.80706@inktank.com> <51706120.2060702@inktank.com> <20130418173113.74a53769@dieter-t420s> <8232544E-56F5-40BF-899D-2A2D4735FD54@asgaard.org>
 <5174F08F.2070001@dachary.org> <0AEB5F22-B38F-4702-95A1-B18938FE7F7C@asgaard.org> <alpine.DEB.2.00.1304220805100.14056@cobra.newdream.net> <51757CEB.4090701@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35619 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab3DVSbE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 14:31:04 -0400
In-Reply-To: <51757CEB.4090701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

On Mon, 22 Apr 2013, Loic Dachary wrote:
> Hi Sage,
> 
> On 04/22/2013 05:09 PM, Sage Weil wrote:
> > On Mon, 22 Apr 2013, Christopher LILJENSTOLPE wrote:
> >> Supposedly, on 2013-Apr-22, at 01.10 PDT(-0700), someone claiming to be Loic Dachary scribed:
> >>
> >>> Hi Christopher,
> >>>
> >>> You wrote "A modified client/library could be used to store objects that should be sharded, vs "standard" ceph treatment.  In this model, each shard would be written to a seperate PG, and each PG would we stored on exactly one OSD.  " but there is no way for a client to enforce the fact that two objects are stored in separate PG.
> >>
> >> Poorly worded.  The idea is that each shard becomes a seperate object, and the encoder/sharder would use CRUSH to identify the OSDs to hold the shards.  However, the OSDs would treat the shard as an n=1 replication and just store locally.  
> >>
> >> Actually, looking at this this morning, this is actually harder than the prefered alternative (i.e. grafting a encode/decode into the (e)OSD.  It was meant to cover the alternative approaches.  I didn't like this one, but it now appears to be more difficult, and non-deterministic of the placement.  
> >>
> >> One question on CRUSH (it's been too long since I read the paper), if x is the same for two objects, and, using an n=3 returns R={OSD18,OSD45,OSD97}, if an object is handed to OSD45 that matches x, but has an n=1, would OSD45 store it, or would it forward it to OSD18 to store?  If it would this idea is DOA.  Also, if x is held invariant, but n changes, does the same R set get returned (truncated to n members)?
> > 
> > It would go to osd18, the first item in the sequence that CRUSH generates.
> >            
> > As Loic observes, not having control of placement from above the librados
> > level makes this more or less a non-started.  The only thing that might   
> > work at that layer is to set up ~5 or more pools, each with a distinct set
> > of OSDs, and put each shard/fragment in a different pool.  I don't think  
> > that is a particularly good approach.
> > 
> > If we are going to do parity encoding (and I think we should!), I think we
> > should fully integrate it into the OSD.
> >            
> > The simplest approach:
> >            
> >  - we create a new PG type for 'parity' or 'erasure' or whatever (type    
> >    fields already exist)
> >  - those PGs use the parity ('INDEP') crush mode so that placement is
> >    intelligent
> 
> I assume you do not mean CEPH_FEATURE_INDEP_PG_MAP as used in
> 
> https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L5237
> 
> but CRUSH_RULE_CHOOSE_INDEP as used in
> 
> https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L331
> 
> when firstn == 0 because it was set in
> 
> https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L523

Right.


> I see that it would be simpler to write
> 
>    step choose indep 0 type row
> 
> and then rely on intelligent placement. Is there a reason why it would not be possible to use firstn instead of indep ?

The indep placement avoids moving around a shard between ranks, because a 
mapping of [0,1,2,3,4] will change to [0,6,2,3,4] (or something) if osd.1 
fails and the shards on 2,3,4 won't need to be copied around.

> >  - all reads and writes go to the 'primary'               
> >  - the primary does the shard encoding and distributes the write pieces to
> >    the other replicas
> 
> Although I understand how that would work when a PG receives a CEPH_OSD_OP_WRITEFULL
> 
> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L2504
> 
> It may be inconvenient and expensive to recompute the parity encoded version if an object is written with a series of CEPH_OSD_OP_WRITE. The simplest way would be to decode the existing object, modify it according to what CEPH_OSD_OP_WRITE requires, encode it.

Yeah.  Making small writes remotely efficient is a huge challenge.

OTOH, if we have some sort of symlink/redirect, and we do writes to 
replicated objects and only write erasure/parity data in full objects, 
then we avoid that complexity.

> 
> >  - same for reads
> >            
> > There will be a pile of patches to move code around between PG and 
> > ReplicatedPG, which will be annoying, but hopefully not too painful.  The 
> > class structure and data types were set up with this in mind long ago.
> > 
> > Several key challenges:
> > 
> >  - come up with a scheme for internal naming to keep shards distinct
> >  - safely rewriting a stripe when there is a partial overwrite.  probably 
> >    want to write new stripes to distinct new objects (cloning old data as 
> >    needed) and clean up the old ones once enough copies are present.
> 
> Do you mean RBD stripes ? 

I'm thinking stipes of a logical object across the object's shards.  
Mostly in terms of something like RAID4; I'm not sure what terminology is 
typically used for erasure coding systems.  I'm assuming that stripes of 
the object would be coded to so that partial object reads/updates of 
large objects are vaguely efficient...

Ideally, the implementation would have a field indicating what coding 
technique is used (parity, erasure, whatever).  Different optimizations 
are best for different coding strategies, but the minimum useful feature 
in this case wouldn't optimize anything anyway :)

> >  - recovery logic
> 
> If recovery is done from the scheduled scrubber in the ErasureCodedPG , I'm not sure if OSD.cc must be modified or is truly independent of the PG type 
> 
> https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L3818
> 
> I'll keep looking, thanks a lot for the hints :-)
> 
> Cheers
> 
> > sage
> > 
> > 
> >>
> >> 	Thx
> >> 	Christopher
> >>
> >>
> >>
> >>>
> >>> Am I missing something ?
> >>>
> >>> On 04/22/2013 09:23 AM, Christopher LILJENSTOLPE wrote:
> >>>> Supposedly, on 2013-Apr-18, at 14.31 PDT(-0700), someone claiming to be Plaetinck, Dieter scribed:
> >>>>
> >>>>> On Thu, 18 Apr 2013 16:09:52 -0500
> >>>>> Mark Nelson <mark.nelson@inktank.com> wrote:
> >>>>
> >>>>>>
> >>>>>
> >>>>> @Bryan: I did come across cleversafe.  all the articles around it seemed promising,
> >>>>> but unfortunately it seems everything related to the cleversafe open source project
> >>>>> somehow vanished from the internet.  (e.g. http://www.cleversafe.org/) quite weird...
> >>>>>
> >>>>> @Sage: interesting. I thought it would be more relatively simple if one assumes
> >>>>> the restriction of immutable files.  I'm not familiar with those ceph specifics you're mentioning.
> >>>>> When building an erasure codes-based system, maybe there's ways to reuse existing ceph
> >>>>> code and/or allow some integration with replication based objects, without aiming for full integration or
> >>>>> full support of the rados api, based on some tradeoffs.
> >>>>>
> >>>>> @Josh, that sounds like an interesting approach.  Too bad that page doesn't contain any information yet :)
> >>>>
> >>>> Greetings - it does now - see what you all think?
> >>>>
> >>>> 	Christopher
> >>>>
> >>>>>
> >>>>> Dieter
> >>>>
> >>>>
> >>>> --
> >>>> ???
> >>>> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
> >>>> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
> >>>> Check my calendar availability: https://tungle.me/cdl
> >>>
> >>> -- 
> >>> Lo?c Dachary, Artisan Logiciel Libre
> >>
> >>
> >> --
> >> ???
> >> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
> >> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
> >> Check my calendar availability: https://tungle.me/cdl
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> 
> 
