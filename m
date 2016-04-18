From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Flexible placement
Date: Mon, 18 Apr 2016 13:08:36 -0400
Message-ID: <20160418170836.GB20078@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47251 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbcDRRIj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Apr 2016 13:08:39 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 18/04/2016, Sage Weil wrote:
> If we're just talking about locality here, isn't this tradeoff
> already available to the user by controlling the object size?
> And/or setting the placement key so that two objects are always
> placed together in the cluster.

Object locator is a way to get locality. One worry I have with object
locator is that it's entirely client driven.

> The non-uniformity is a real problem, but let's not assume it's the
> same problem as flexible placement.  If you want linear striping,
> for exmaple, that gives you a perfect distribution but it falls
> apart as soon as there is any rebalancing.
>
> Are there some concrete examples of what these flexible placements
> might be?  I still don't see how they are different that PGs.  I.e.,
> you can split placement into two stages: mapping objects to PGs, and
> mapping PGs to devices.  If both of those are pluggable, what does
> that not capture?

So, given that I think we seem to be using language slightly
differently, I think you're asking if there are any concrete ideas I
know of that don't fit well into the OID => Hash => Device List model,
and depending on how you define 'concrete' I think there might
be. Part of what we'd like to investigate as part of Blue Sky work is
instrumenting a cluster to provide usage data and use that to feed
into a machine learning or annealing system to try and gradually
optimize placement for its workload. In that case you could have
classifiers running over object names sortinf them into categories
with different placement rules, each of which might use a different
hashing strategy to sort objects into OSDs. Data movement could be
required by change in classification as well as hash or rule
set. There IS a hash in here, but trying to narrow it down to the
single pipeline of HERE is the hash and HERE is the list of devices
might be a bad fit.

> (You could map every object to a distinct set of devices, and this
> is frequently suggested, but I don't think it is practical.  In a
> large system, you'll have all-to-all replication streams, and
> *every* possible coincident failure will lead to data loss.)

So. In practice, many placements people will want to use will have the
pattern Object => Hash => Set of devices. Even systems that do
something weird like fiddle with the hash to make it periodic in some
substring of the object name would fit that paradigm.  I don't call
the Hash a 'PG' because when I think 'PG' I think of the /very
specific/ combination of hash and stablemod and whatnot that we happen
to use in Ceph. Or, I also think of the specific class in the OSD that
enforces an ordering o operations and a very specific sort of
replication behaviors.

So, when I say 'other than CRUSH/PG' I mean 'other than the CRUSH
algorithm couypled with the PG hash'.

That said, I don't want to rule out allowing direct Object->Device
mapping. I would like an abstraction where, when we have a hash
feeding into a device list generator, the details need not be
something the client has to concern itself with. That seems to me like
good abstraction.

That way when someone wants a specialized algorithm that goes from
OIDs to names directly (even if it's only useful in very specific
contexts with very specific use cases) we could still write it up,
plug it into the system, and go to town.

> > -   Transactional storage. As mentioned above, cross-object
> >     transactional semantics are a thing people may have desired.
>
> This would just be a new pool type, right?  We definitely need to
> clean up the OSD :: PG interface(s) to enable it.

I suspect for sanity you'd want to mark your entire pool as
Transactional. We'd still need the actual backend implementation to
support it.

> I was assuming that we'd just have multiple instances of the OSD
> class in the same process (as we used to back in the early days with
> fakesyn for testing). Is there any real difference here except
> naming?

I imagined a single OSD object holding several LogicalOSD objects
(mapped from OSD number). I'm not hell bent on this, but OSD and
OSDService have an awful lot of stuff in them and if we could share
most of it between the LogicalOSDs, it would be an efficiency win.

> DataSetInterface still looks like PG (or whatever we name it), a
> minimal interface for passing data and control (peering) messages
> down.

That is correct. It's mostly PG's object operation executing
functions. The main thing was that I was surprised how much stuff in
PG looks to be used by operations downstack that could be hidden away
from the OSD with advantages for allowing freedom in implementing
faster, less lockful data pipelines.

> This sounds like two basic points:
>
> 1) Let's clean up the PG interface already.  Then we can add new
> pool types that aren't primary-driven and/or pglog-based.  Class
> names will shift around as part of this.

That is most of what I was getting at.

> 2) Let's put many OSD's in the same process.  There will be some
> similar naming changes.

That is also most of what I"m getting at. I'm not particularly picky
about names.

> What I don't see is where this means we should move away from PG, or
> an object -> PG -> device mapping strategy.  Am I missing something
> key, or are we just using different words?

Partly, it's that we're using different names. I think when you use
'PG' you use it to mean any hash-like altorithm to cut down the space
of objects to something that can be more tractably dealt with. I use
it to mean a very specific algorithm we happen to use right now.

Partly, I don't want to make the use of a hash like that compulsary. I
wouldn't mind placement functions being able to surface it when there
are useful optimizations that can be made that way. However, part of
the benefit of the NaCl-based Flexible Placement design is that
administrators can put in all sorts of weird things we've never
thought of. If we are to redesign some of our abstractions to support
it and other goals we want (which I think we must), it seems a shame
not to make them as flexible as we reasonably can. After all, we are
building the future of storage, and the Future is full of a lot of
things we haven't thought of.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
