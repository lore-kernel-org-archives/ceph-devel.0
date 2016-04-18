From: Sage Weil <sage@newdream.net>
Subject: Re: Flexible placement
Date: Mon, 18 Apr 2016 14:14:43 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604181355330.4797@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com> <20160418170836.GB20078@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56905 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbcDRSOn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 14:14:43 -0400
In-Reply-To: <20160418170836.GB20078@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Mon, 18 Apr 2016, Adam C. Emerson wrote:
> On 18/04/2016, Sage Weil wrote:
> > If we're just talking about locality here, isn't this tradeoff
> > already available to the user by controlling the object size?
> > And/or setting the placement key so that two objects are always
> > placed together in the cluster.
> 
> Object locator is a way to get locality. One worry I have with object
> locator is that it's entirely client driven.

How could it not be client-driven?  If the client doesn't know the 
placement, it can't read or write the object.  Unless you have 
proxy/redirect at the OSD level, but I think then you're talking about 
tiering v2.
 
> > The non-uniformity is a real problem, but let's not assume it's the
> > same problem as flexible placement.  If you want linear striping,
> > for exmaple, that gives you a perfect distribution but it falls
> > apart as soon as there is any rebalancing.
> >
> > Are there some concrete examples of what these flexible placements
> > might be?  I still don't see how they are different that PGs.  I.e.,
> > you can split placement into two stages: mapping objects to PGs, and
> > mapping PGs to devices.  If both of those are pluggable, what does
> > that not capture?
> 
> So, given that I think we seem to be using language slightly
> differently, I think you're asking if there are any concrete ideas I
> know of that don't fit well into the OID => Hash => Device List model,

s/Hash/Hash Range/ (== placement group or pool shard)

> and depending on how you define 'concrete' I think there might
> be. Part of what we'd like to investigate as part of Blue Sky work is
> instrumenting a cluster to provide usage data and use that to feed
> into a machine learning or annealing system to try and gradually
> optimize placement for its workload. In that case you could have
> classifiers running over object names sortinf them into categories
> with different placement rules, each of which might use a different
> hashing strategy to sort objects into OSDs. Data movement could be
> required by change in classification as well as hash or rule
> set. There IS a hash in here, but trying to narrow it down to the
> single pipeline of HERE is the hash and HERE is the list of devices
> might be a bad fit.

I think I'm still confused.  If we're not moving PG's or hash *ranges* in 
large chunks, that means we have to individually consider each object in 
the event of any topology change (a new osd came up, or the placement 
policy changed, please wait while I iterate over my 13 million object to 
see what has moved).  One of the primary functions of PGs is the bound the 
amount of map change checking I have to do--recalculating a crush mapping 
100x is cheap.  Swapping out crush for a more gneeral NaCl thing would be 
the same.  Moving away from placement *groups* makes it all fall apart.

In your example above, you're talking abuot using the placement policy to 
manage fine-grained changes.. do you mean using that to move individual 
objects around?  This feels like entirely the wrong layer for that sort of 
thing--we lose the ability for the client to know where things.

If it's policy driven, the policy is published as a pool property and has 
to be compact and fast.  If it's fine-grained, then we need something that 
is totally different (e.g., a metadata index).

> > (You could map every object to a distinct set of devices, and this
> > is frequently suggested, but I don't think it is practical.  In a
> > large system, you'll have all-to-all replication streams, and
> > *every* possible coincident failure will lead to data loss.)
> 
> So. In practice, many placements people will want to use will have the
> pattern Object => Hash => Set of devices. Even systems that do
> something weird like fiddle with the hash to make it periodic in some
> substring of the object name would fit that paradigm.  I don't call
> the Hash a 'PG' because when I think 'PG' I think of the /very
> specific/ combination of hash and stablemod and whatnot that we happen
> to use in Ceph. Or, I also think of the specific class in the OSD that
> enforces an ordering o operations and a very specific sort of
> replication behaviors.

FWIW I'm thinking PG == hash range == shard of the pool.  The ordering is 
a pool property; I think we can mostly ignore the current 
entangled interface and implementation.

> So, when I say 'other than CRUSH/PG' I mean 'other than the CRUSH
> algorithm couypled with the PG hash'.
> 
> That said, I don't want to rule out allowing direct Object->Device
> mapping. I would like an abstraction where, when we have a hash
> feeding into a device list generator, the details need not be
> something the client has to concern itself with. That seems to me like
> good abstraction.

I guess my point is that a direct object -> device mapping is 
fundamentally flawed, because

1) a mapping or policy change means recalculationg O(num objects) mappings
2) all-to-all connectivity between OSDs
3) guaranteed data loss on any n- or (m+1)-failure.

and if we can't/won't actually go there, is there anything we should do 
beyond more generalized object -> pg and pg -> device list mappings.

> That way when someone wants a specialized algorithm that goes from
> OIDs to names directly (even if it's only useful in very specific
> contexts with very specific use cases) we could still write it up,
> plug it into the system, and go to town.

I think that in those cases, we let them use a wacky object -> PG mapping, 
and then have a linear/flat PG -> device mapping so they can still get 
some uniformity.

This isn't completely general, but I'd want to see an example of something 
it can't express.  Maybe those entanglement erasure codes that Veronica 
was talking about at FAST?

Or maybe the key step is to not assume the PG is a hash range, but instead 
consider it an arbitrary bucket in the pool.
 
> > I was assuming that we'd just have multiple instances of the OSD
> > class in the same process (as we used to back in the early days with
> > fakesyn for testing). Is there any real difference here except
> > naming?
> 
> I imagined a single OSD object holding several LogicalOSD objects
> (mapped from OSD number). I'm not hell bent on this, but OSD and
> OSDService have an awful lot of stuff in them and if we could share
> most of it between the LogicalOSDs, it would be an efficiency win.

Yeah, whatever gets us the sharing we need, wehther it's OSDProcess + OSD 
or OSD + LogicalOSD.
 
> > DataSetInterface still looks like PG (or whatever we name it), a
> > minimal interface for passing data and control (peering) messages
> > down.
> 
> That is correct. It's mostly PG's object operation executing
> functions. The main thing was that I was surprised how much stuff in
> PG looks to be used by operations downstack that could be hidden away
> from the OSD with advantages for allowing freedom in implementing
> faster, less lockful data pipelines.

Okay, yeah.  There's a lot fo cleanup to be done, but it's mostly 
mechanical.

> > This sounds like two basic points:
> >
> > 1) Let's clean up the PG interface already.  Then we can add new
> > pool types that aren't primary-driven and/or pglog-based.  Class
> > names will shift around as part of this.
> 
> That is most of what I was getting at.
> 
> > 2) Let's put many OSD's in the same process.  There will be some
> > similar naming changes.
> 
> That is also most of what I"m getting at. I'm not particularly picky
> about names.
> 
> > What I don't see is where this means we should move away from PG, or
> > an object -> PG -> device mapping strategy.  Am I missing something
> > key, or are we just using different words?
> 
> Partly, it's that we're using different names. I think when you use
> 'PG' you use it to mean any hash-like altorithm to cut down the space
> of objects to something that can be more tractably dealt with. I use
> it to mean a very specific algorithm we happen to use right now.
> 
> Partly, I don't want to make the use of a hash like that compulsary. I
> wouldn't mind placement functions being able to surface it when there
> are useful optimizations that can be made that way. However, part of
> the benefit of the NaCl-based Flexible Placement design is that
> administrators can put in all sorts of weird things we've never
> thought of. If we are to redesign some of our abstractions to support
> it and other goals we want (which I think we must), it seems a shame
> not to make them as flexible as we reasonably can. After all, we are
> building the future of storage, and the Future is full of a lot of
> things we haven't thought of.

Okay, I think this makes sense.  It means that the pg split becomes 
somewhat specific to the current hash range approach.

Hmm, I think Veronica's helical entanglement codes might actually be a 
good example application to look at here to see if we're making something 
flexible enough.

	http://dl.acm.org/citation.cfm?id=2718696

sage
