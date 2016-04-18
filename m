From: Sage Weil <sage@newdream.net>
Subject: Flexible placement
Date: Mon, 18 Apr 2016 09:45:11 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604172057000.4797@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54919 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbcDRNpL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 09:45:11 -0400
Content-ID: <alpine.DEB.2.11.1604180926381.4797@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Fri, 15 Apr 2016, Adam C. Emerson wrote:
> # Flexible Placement #
> 
> This is a large topic which should be discussed on its own, but it
> motivates the interface designs below, so we shall briefly mention why
> it's interesting.
> 
> CRUSH/PG is a fine placement system for several workloads, but it has
> two well-known limitations.
> 
> ## Motivation ##
> 
> -   Data distribution can be much less uniform than one might like,
>     giving uneven use of disks. This has caused some Ceph developers
>     to experiment with Monte Carlo based placement algorithms.
> -   Data distribution can be much more uniform than one would
>     like. This is the fundamental cause of Ceph's slow sequential read
>     performance. More generally, unrelated workloads contend
>     with each other due to a lack of affinity for related data. The effects are
>     especially pronounced on spinning disk (due to seek times), but
>     still exist on Flash (due to bus/network contention.)  This is a
>     tension between competing goods. CRUSH gains wide dispersion and
>     uniformity to defend against correlated failures but this imposes
>     a tradeoff.

If we're just talking about locality here, isn't this tradeoff already 
available to the user by controlling the object size?  And/or setting the 
placement key so that two objects are always placed together in the 
cluster.

The non-uniformity is a real problem, but let's not assume it's the same 
problem as flexible placement.  If you want linear striping, for exmaple, 
that gives you a perfect distribution but it falls apart as soon as there 
is any rebalancing.

Are there some concrete examples of what these flexible placements might 
be?  I still don't see how they are different that PGs.  I.e., you can 
split placement into two stages: mapping objects to PGs, and mapping PGs 
to devices.  If both of those are pluggable, what does that not capture?

(You could map every object to a distinct set of devices, and this is 
frequently suggested, but I don't think it is practical.  In a large 
system, you'll have all-to-all replication streams, and *every* possible 
coincident failure will lead to data loss.)

> ## Goal ##
> 
> Ceph should support placement methods other than CRUSH/PG. Currently,
> the OSD dispatches operations based on placement group ID, which will
> need to be varied,
> 
> We also need some way to get new types of functions into the cluster.
> 
> ## Proposal ##
> 
> Our proposal is, in a way, CRUSH taken to its logical
> conclusion. Instead of distributing CRUSH rules, we propose to
> distribute general computable functions from (oid, volume/dataset) pairs to
> sequences of OSDs with their supporting data structures.  One of our
> ongoing research projects has been an in-process executor for these
> functions based on Google's NaCl. The benefits are:
> -   Administrators can fine-tune placement functions to fit their
>     workloads well.
> -   They can also experiment easily without having to recompile all of
>     Ceph and make heavy architectural changes.
> -   Entirely new placement strategies can be deployed without having
>     to upgrade every machine in the cluster. Or any machine in the
>     cluster, once they've been upgraded to a Flexible Placement
>     capable version.
> -   Possibilities for annealing and machine learning to gradually
>     adapt placement in response to load data become available
> -   NaCl builds on LLVM which has a rich set of tools for optimizations
>     like partial evaluation.
> -   NaCl is fast.

NaCl sounds great.  It sounds like this still fits right into the object 
-> PG -> device list mapping strategy, though.

> # Flexible Semantics #
> 
> Another motivating example. Originally, Ceph did replication and only
> replication under a very specific consistency model. There has been
> desire for more flexibility.
> -   Erasure Coding. it still follows the Ceph consistency model
>     (though leaves out many operations) but is very different in
>     back-end dispatch, enough so that it inspired a major rewrite of
>     the OSD's bottom half.
> -   Append-only immutable objects have been discussed.
> -   Many people have asked for relaxed consistency to improve
>     performance. This is not be suitable for all workloads, but people
>     have repeatedly asked for the ability to set up low-latency,
>     relaxed-consistency volumes that still provide Ceph's ability to
>     easily use new storage and scale well.
> -   Transactional storage. As mentioned above, cross-object
>     transactional semantics are a thing people may have desired.

This would just be a new pool type, right?  We definitely need to clean up 
the OSD :: PG interface(s) to enable it.

> # Interfaces #
> 
> Right now our class hierarchy is a bit of a mess. Eventually we'll do
> something about `PG` and `ReplicatedPG`, refactor, support
> asynchronous I/O, reduce lock contention, support in core affinity,
> and build Jerusalem here in England's green and pleasant land.
> 
> While we're stringing up our bows of burning gold, we should support
> non-PG based placement and flexible semantics. Right now, parts of the
> PG and the OSD (since the OSD manages the collection of PGs, spins
> them up, and manages thread pools shared by sets of PGs) are
> intertwined. Thus, we need to abstract out both pieces.
> 
> As we also want to support having multiple "logical" OSDs running in a
> single `ceph-osd` process, this would be a natural time to add that
> capability.
> 
> Both these are sketches and should be considered a work in progress.
> 
> ## `DataSetInterface` ##
> 
> Here is a sketch of what a flexible abstraction based on PG could look
> like, at least parts of one. Not being informed about Scrub,
> Recovery, or Cache Tiering, having only focused on the object
> operation path, we won't include those details here.
> 
> We also leave out functions called from the PG itself or other objects
> invoked from ownstack.
> 
> ```c++
> class DataSetInterface {
> protected:
>   LogicalOSD& losd; // LogicalOSD is a means to have different
>                     // stores/semantics run in the same process.
> 
>   MapPartRef curmap; // Subset of map relevant to this DSI
> public:
>   // The OSD (things Up the Stack, generally) should not call 'lock'
>   // on us. If we have locking of some sort things down the stack that
>   // we have some relationship with (friend or whatever) could lock or
>   // unlock us, but that should not be baked in as part of the interface.
> 
>   // Things like the info struct and details about loading the Place
>   // wouldn't actually be here. As there is an intimate relation
>   // between the LogicalOSD and an implementation of DataSetInterface (it
>   // holds all those loaded in memory and controls dispatch), they
>   // would not need to be part of the generic interface.
> 
>   const coll_t coll; // The subdivision of the Store we control
> 
>   // In the PG case we always know we're the primary or not for
>   // anything within the same pgid. That is not expected to be the
>   // case generally.
>   bool is_primary(const OpRequest&) = 0;
>   // No 'is_replica' since 'replica' may not be applicable
>   // generally. It's a bit off even in the erasure coded case.
>   bool is_acting(const OpRequest&) = 0;
>   bool is_inactive() = 0;
> 
>  public:
>   // No identifier. The descendent will take that.
>   DataSetInterface(LogicalOSD& o, OSDMapRef curmap);
>   virtual ~DataSetInterface();
> 
>   DataSetInterface(const DataSetInterface&) = delete;
>   DataSetInterface& operator =(const DataSetInterface&) = delete;
>   DataSetInterface(DataSetInterface&&) = delete;
>   DataSetInterface& operator =(DataSetInterface&&) = delete;
> 
>   virtual void on_removal(ObjectStore::Transaction *t) = 0;
> 
>   // Yes, there's no 'queue' and no 'do_op' or any of
>   // that. This is intentional. There's no dequeue or do_op because
>   // those functions are either called only by the PG currently OR
>   // they're called in OSD functions called by the PG as part of the
>   // thread switch. They should not be part of the public interface.
> 
>   // There's no queue because we can either put queue here or we can
>   // put queue in LogicalOSD. (We could do both, but that seems bad to
>   // me.) If there is some combination of locking and checking that
>   // must be done before queueing an operation, it seems that it's
>   // better to do it in LogicalOSD so that it doesn't leak out and
>   // become part of the abstraction for other implementations.
> };
> ```
> 
> ## `LogicalOSD` ##
> 
> The OSD class itself (representing the single OSD process) should have
> a map (*perhaps* a Boost.Intrusive.Set?) mapping OSD IDs to to
> `LogicalOSD` instances.
> 
> ```c++
> class LogicalOSD {
>   OSD& osd;
>   ObjectStore& store;
> 
>   // Look up the DataSetInterface instance appropriate to the given
>   // OpRequest.
>   virtual future<DataSetInterface,int> get_place_for(const OpRequest&) = 0;
> 
>   // Every logical OSD will have its own watchers as well as slot
>   // cache. Someone familiar with flow control should check this
>   // idea. Since LogicalOSDs will, ideally, share messengers we might
>   // want them to share the same slot cache. In that case we should
>   // just re-dimension watchers within Session
>   SessionRef session_for(const entity_name_t& name);
> 
>   void queue(DataSetInterfaceRef&& pi, OpRequestRef&& to_queue);
>   void queue_front(DataSetInterfaceRef&& pi, OpRequestRef&& to_queue);
> 
>   // Dequeue and the like are currently called in the PG itself and so
>   // have no place in the interface presented to the OSD.
> 
>   void pause();
>   void resume();
>   void drain();
> };
> ```

I was assuming that we'd just have multiple instances of the OSD class in 
the same process (as we used to back in the early days with fakesyn for 
testing).  Is there any real difference here except naming?  
DataSetInterface still looks like PG (or whatever we name it), a minimal 
interface for passing data and control (peering) messages down.

This sounds like two basic points:

1) Let's clean up the PG interface already.  Then we can add new pool 
types that aren't primary-driven and/or pglog-based.  Class names will 
shift around as part of this.

2) Let's put many OSD's in the same process.  There will be some similar 
naming changes.

What I don't see is where this means we should move away from PG, or an 
object -> PG -> device mapping strategy.  Am I missing something key, or 
are we just using different words?

Thanks!
sage
