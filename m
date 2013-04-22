From: Sage Weil <sage@inktank.com>
Subject: Re: erasure coding (sorry)
Date: Mon, 22 Apr 2013 08:09:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304220805100.14056@cobra.newdream.net>
References: <20130418162842.0c61d1e2@dieter-t420s> <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net> <517060B2.80706@inktank.com> <51706120.2060702@inktank.com> <20130418173113.74a53769@dieter-t420s> <8232544E-56F5-40BF-899D-2A2D4735FD54@asgaard.org>
 <5174F08F.2070001@dachary.org> <0AEB5F22-B38F-4702-95A1-B18938FE7F7C@asgaard.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33080 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab3DVPJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 11:09:13 -0400
In-Reply-To: <0AEB5F22-B38F-4702-95A1-B18938FE7F7C@asgaard.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher LILJENSTOLPE <cdl@asgaard.org>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

On Mon, 22 Apr 2013, Christopher LILJENSTOLPE wrote:
> Supposedly, on 2013-Apr-22, at 01.10 PDT(-0700), someone claiming to be Loic Dachary scribed:
> 
> > Hi Christopher,
> >
> > You wrote "A modified client/library could be used to store objects that should be sharded, vs "standard" ceph treatment.  In this model, each shard would be written to a seperate PG, and each PG would we stored on exactly one OSD.  " but there is no way for a client to enforce the fact that two objects are stored in separate PG.
> 
> Poorly worded.  The idea is that each shard becomes a seperate object, and the encoder/sharder would use CRUSH to identify the OSDs to hold the shards.  However, the OSDs would treat the shard as an n=1 replication and just store locally.  
> 
> Actually, looking at this this morning, this is actually harder than the prefered alternative (i.e. grafting a encode/decode into the (e)OSD.  It was meant to cover the alternative approaches.  I didn't like this one, but it now appears to be more difficult, and non-deterministic of the placement.  
> 
> One question on CRUSH (it's been too long since I read the paper), if x is the same for two objects, and, using an n=3 returns R={OSD18,OSD45,OSD97}, if an object is handed to OSD45 that matches x, but has an n=1, would OSD45 store it, or would it forward it to OSD18 to store?  If it would this idea is DOA.  Also, if x is held invariant, but n changes, does the same R set get returned (truncated to n members)?

It would go to osd18, the first item in the sequence that CRUSH generates.
           
As Loic observes, not having control of placement from above the librados
level makes this more or less a non-started.  The only thing that might   
work at that layer is to set up ~5 or more pools, each with a distinct set
of OSDs, and put each shard/fragment in a different pool.  I don't think  
that is a particularly good approach.

If we are going to do parity encoding (and I think we should!), I think we
should fully integrate it into the OSD.
           
The simplest approach:
           
 - we create a new PG type for 'parity' or 'erasure' or whatever (type    
   fields already exist)
 - those PGs use the parity ('INDEP') crush mode so that placement is
   intelligent
 - all reads and writes go to the 'primary'               
 - the primary does the shard encoding and distributes the write pieces to
   the other replicas
 - same for reads
           
There will be a pile of patches to move code around between PG and 
ReplicatedPG, which will be annoying, but hopefully not too painful.  The 
class structure and data types were set up with this in mind long ago.

Several key challenges:

 - come up with a scheme for internal naming to keep shards distinct
 - safely rewriting a stripe when there is a partial overwrite.  probably 
   want to write new stripes to distinct new objects (cloning old data as 
   needed) and clean up the old ones once enough copies are present.
 - recovery logic

sage


> 
> 	Thx
> 	Christopher
> 
> 
> 
> >
> > Am I missing something ?
> >
> > On 04/22/2013 09:23 AM, Christopher LILJENSTOLPE wrote:
> >> Supposedly, on 2013-Apr-18, at 14.31 PDT(-0700), someone claiming to be Plaetinck, Dieter scribed:
> >>
> >>> On Thu, 18 Apr 2013 16:09:52 -0500
> >>> Mark Nelson <mark.nelson@inktank.com> wrote:
> >>
> >>>>
> >>>
> >>> @Bryan: I did come across cleversafe.  all the articles around it seemed promising,
> >>> but unfortunately it seems everything related to the cleversafe open source project
> >>> somehow vanished from the internet.  (e.g. http://www.cleversafe.org/) quite weird...
> >>>
> >>> @Sage: interesting. I thought it would be more relatively simple if one assumes
> >>> the restriction of immutable files.  I'm not familiar with those ceph specifics you're mentioning.
> >>> When building an erasure codes-based system, maybe there's ways to reuse existing ceph
> >>> code and/or allow some integration with replication based objects, without aiming for full integration or
> >>> full support of the rados api, based on some tradeoffs.
> >>>
> >>> @Josh, that sounds like an interesting approach.  Too bad that page doesn't contain any information yet :)
> >>
> >> Greetings - it does now - see what you all think?
> >>
> >> 	Christopher
> >>
> >>>
> >>> Dieter
> >>
> >>
> >> --
> >> ???
> >> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
> >> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
> >> Check my calendar availability: https://tungle.me/cdl
> >
> > -- 
> > Lo?c Dachary, Artisan Logiciel Libre
> 
> 
> --
> ???
> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
> Check my calendar availability: https://tungle.me/cdl
