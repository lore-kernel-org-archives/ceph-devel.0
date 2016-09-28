From: Sage Weil <sage@newdream.net>
Subject: Re: Memory Pooling and Containers
Date: Wed, 28 Sep 2016 13:27:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609281316210.19847@piezo.us.to>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34501 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbcI1N1m (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2016 09:27:42 -0400
In-Reply-To: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 27 Sep 2016, Allen Samuels wrote:
> As we discussed in the Bluestore standup this morning. This is intended 
> to start a discussion about creating some internal memory pooling 
> technology to try to get a better handle on the internal usage of memory 
> by Ceph. Let's start by discussing the requirements...
> 
> Here is my list of requirements:
> 
> (1) Should be able to create an arbitrary number of "pools" of memory.
>
> (2) Developers should be able to declare that a particular container 
> (i.e., STL or boost-like container) is wholly contained within a pool.
>
> (3) Beyond declarations (and possibly constructor initialization), no 
> explicit code is required to be written by developers to support (2). 
> All container manipulation primitives properly update the accounting.
>
> (4) Beyond construction/destruction costs, no container operation is 
> burdened by additional code -- only implicit malloc/free operations are 
> burdened with accounting.
>
> (5) The system tracks the aggregate amount of memory consumed in each 
> pool and it's relatively cheap to interrogate the current total 
> consumption.

Yes

> (6) The system tracks the aggregate amount of memory consumed by each 
> container in each pool -- but this is expensive to interrogate and is 
> intended to be used primarily for debugging purposes.

This one sounds like a nice-to-have to me.  If there is a performance cost 
I would skip it.

> (7) generic object new/delete is possible, but not freed of the 
> accounting requirements -- especially #6, i.e..
>
> (8) No backpressure is built into the scheme, i.e., nobody has to worry 
> about suddenly being "out" of memory or being delayed -- just because 
> some particular pool is filling up. That's a higher level problem to 
> solve. No memory is "reserved" either -- If you overcommit, that's also 
> not solved at this layer. IMO, this is a crappy place to be doing ingest 
> and flow control.
>
> (9) Implementation must be multi-thread and multi-socket aware. It 
> should expect high levels of thread concurrency and avoid unnecessary 
> global data manipulation (expect internal sharding of data structures -- 
> something like an arena-based malloc scheme).

Yes
 
> Requirement 5 allows a "trimming" system to be developed. I think there 
> are really two styles for this:
> 
> (a) Time-based, i.e., periodically some thread wakes up and checks 
> memory usage within a pool. If it doesn't like it, then it's responsible 
> for "fixing" it, i.e., trimming as needed.
>
> (b) event-based. No reason that we couldn't setup an event or condition 
> variable per-pool and have the malloc/free code trigger that 
> condition/variable. It adds one or two compare/branches to each malloc / 
> free operation (which is pretty cheap), but doesn't have the latency 
> costs of (a). The downside is that this implicitly assumes a single 
> global-thread is responsible for cleaning each pool which works well 
> when there are a relatively small number of pools.
> 
> Here is my list of anti-requirements:
> 
> (1) No hierarchical relationship between the pools. [IMO, this is kewl, 
> but unnecessary and tends to screw up your cache, i.e., destroys #9.
>
> (2) No physical colocation of the allocated pool memory. The pool is 
> "logical", i.e., an accounting mirage only.
>
> (3) No reason to dynamically create/destroy memory pools. They can be 
> statically declared (this dramatically simplifies the code that uses 
> this system).

Yes.  Great summary!

> Let the discussion begin!!
> /////////////////////////
> 
> Here is my proposed external interface to the design:
> 
> First, look at the slab_xxxx containers that I just submitted. You can 
> find them at 
> https://github.com/allensamuels/ceph/blob/master/src/include/slab_containers.h
> 
> I would propose to extend those containers as the basis for the memory 
> pooling.
> 
> First, there's a global enum that defines the memory pools -- yes, 
> they're static and a small number
> 
> enum mpool_index {
>    MPOOL_ONE,
>    MPOOL_TWO,
> ...
>    MPOOL_LAST
> };
> 
> And a global object for each pool:
> 
> class mpool; // TBD ... see below.
> 
> Extern mpool[MPOOL_LAST]; // Actual definition of each pool
> 
> Each slab_xxx container template is augmented to expect receive an 
> additional "enum mpool_index" parameter.
> 
> That's ALL THAT'S required for the developer. In other words, if each 
> definition of an STL container uses a typedef with the right mpool 
> index, then you're done. The machinery takes care of everything else :)

FWIW I'm not sure if there's much reason to pass MPOOL_FOO instead of 
g_mpool[MPOOL_FOO] to the allocator instance.  The former hard-codes 
the global instance; the latter means you could manage the memory pool 
however you like (e.g., as part of the CephContext for librados).  That's 
a small detail, though.

> Standalone objects, i.e., naked new/delete are easily done by making the 
> equivalent of a slab_intrusive_list and maybe a macro or two. There's 
> some tricky initialization for this one (see below).
> 
> -------------------------------------------
> 
> Implementation
> 
> -------------------------------------------
> 
> Requirement 6 is what drives this implementation.
> 
> I would extend each slab_xxxx container to also virtually inherit from a 
> Pool_Member interface, this interface allows the memory pool global 
> machinery to implement #6.
> 
> I propose that the ctor/dtor for Pool_Member (one for each container) 
> put itself on a list within the respective memory pool. This MUST be a 
> synchronized operation but we can shard the list to reduce the 
> collisions (use the low 4-5 bits of the creating thread pointer to index 
> the shard -- minimizes ctor expense but increases the dtor expense -- 
> which is often done in "trim"). This assumes that the rate of container 
> creation/destruction within a memory pool is not super high -- we could 
> make this be a compile-time option if it becomes too expensive.
> 
> The per-pool sharded lists allow the debug routines to visit each 
> container and do things like ask "how many elements do you have?" -- 
> "How big is each element" -- "Give me a printable string of the 
> type-signature for this container". Once you have this list you can 
> generate lots of interesting debug reports. Because you can sort by 
> individual containers as well as group containers by their type 
> signatures (i.e., combined the consumption of all "map<a,b>" containers 
> as a group). You can report out both by Byte as well as by Element count 
> consumption.

Yeah, this sounds pretty nice.  But I think it's important to be able to 
compile it out.  I think we will have a lot of creations/destructions.  
For example, in BlueStore, Onodes have maps of Extents, those map to 
Blobs, and those have a BufferSpace with a map of Buffers for cached 
data.  I expect that blobs and even onodes will be coming in and out of 
cache a lot.
 
> This kind of information usually allows you to quickly figure out where 
> the memory is being consumed. A bit of script wizardry would recognize 
> that some containers contain other containers. For example, no reason a 
> simple Python script couldn't recognize that each oNode might have a 
> bunch of vector<pextents> within it and tell you things like the average 
> number of pextents / oNodes. Average DRAM consumption per oNode (which 
> is a pretty complicated combination of pextents, lextents, buffer::ptr, 
> etc.)
> 
> Comments: ?????

It would be nice to build this on top of existing allocator libraries if 
we can.  For example, something in boost.  I took a quick peek the other 
day and didn't find something that allowed simple interrogation about 
utilization, though, which was surprising.  It would be nice to have 
something useful (perhaps without #6) that could be done relatively 
quickly and address all of the other requirements.

sage
