From: Sage Weil <sweil@redhat.com>
Subject: RE: New ObjectStore
Date: Thu, 4 Jan 2018 16:21:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801040334020.8186@piezo.novalocal>
References: <MWHPR04MB08304BB565252C3A684CB216F10D0@MWHPR04MB0830.namprd04.prod.outlook.com> <alpine.DEB.2.11.1712211637520.24928@piezo.novalocal> <MWHPR04MB08304A297CEC67D9130B6B1DF10D0@MWHPR04MB0830.namprd04.prod.outlook.com> <alpine.DEB.2.11.1712211744440.24928@piezo.novalocal>
 <MWHPR04MB08302A858CFF9215C32F3859F10D0@MWHPR04MB0830.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752486AbeADQVw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 4 Jan 2018 11:21:52 -0500
In-Reply-To: <MWHPR04MB08302A858CFF9215C32F3859F10D0@MWHPR04MB0830.namprd04.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Allen Samuels <Allen.Samuels@wdc.com>

Adding ceph-devel.

This is a discussion Allen and I were having earlier about what the future 
post-BlueStore native SPDK, nvme-focused ObjectStore backend could look 
like.  The short description is something like "log-structured btree", the 
idea being that we would do the cleaning in the software layer so that the 
nvme's garbage collection generally has nothing to do.

I would like to start thinking about this sooner rather than later so that 
we have a good idea of what we want to build and, hopefully, can time 
having a testable backend prototype with the futures-ified OSD IO path.

sage


On Thu, 21 Dec 2017, Allen Samuels wrote:
> Yes. But you mix the data AND the b-tree into the same log.
> 
> Essentially, each ObjectStore transaction generates a single contiguous 
> write to the log. Data and metadata are intermixed and formatted such 
> that you can re-read the last open stripe on a restart to restore. In 
> the log you have data pages, whole metadata pages (b-tree pages) and 
> metadata deltas (transactional edits) intermixed such that you can 
> always read the stripe from the beginning and discern which is which (as 
> well as torn stripe-writes....).
> 
> Logically, a write consists of modifying a number of in-memory blocks 
> (some data and some metadata). The data written to the log is ALWAYS the 
> deltas, thus conceptually after the log write we are left with some 
> number of "dirty" memory blocks that can only be reconstructed by going 
> back to the last non-delta version and applying the deltas from the log 
> since that time. [As a key optimization, whole block writes/deltas leave 
> you with a memory block that's NOT dirty once the log is written ;) ] 
> When memory is "full", you can bulk-up a log write with some 
> un-associated dirty blocks which allows them to be cleaned and 
> discarded. By writing deltas, you automatically get the "combining" 
> behavior (this is a strength of LSM algos) but only on the individual 
> B-tree blocks (not the entire tree), in essence, if you have multiple 
> transactions on metadata that's within the same B-tree block [a VERY 
> frequent situation] this system automatically combines those like what 
> you get with Rocks-ish LSM stuff.
> 
> You need to limit how long the delta chain for a metadata block becomes 
> (to improve restart times by bounding the amount of data that needs to 
> be read in to reconstruct the dirty block from it's accumulated deltas). 
> The cheapest thing to do is to simply ensure that all blocks get flushed 
> across a backing store stripe change. That's relatively easy to do by 
> regulating the maximum amount of dirty blocks and then simply writing 
> all dirty blocks at the start of each stripe (when you close one stripe 
> and open up the next one).
> 
> Log cleaning/compaction is relatively easy, you just read each stripe 
> from from to end, parsing as you go. You'll need to lookup each object 
> to determine if this is an old, version of the object or if it's the 
> "live" object. If it's live, you just mark it dirty (in the in-memory 
> buffer) and go on, it'll get dumped with the next write (which you might 
> have to artificially trigger).
> 
> One key issue is how you address blocks. Some schemes use physical 
> addresses for blocks, this forces the cleaning activity to dirty 
> additional metadata (the pointer to this object), however for data this 
> tends to be localized (the pointer to the data is typically writing in 
> the same stripe). Alternatively, you can create a logical/physical 
> address mapping table so that you can move blocks and update this 
> micro-table without affecting the logical addresses in the upper level 
> metadata blocks. However, this does create an additional mapping table 
> which needs to be checkpointed/recovered (separate from the other data) 
> and is frequently implemented as an in-memory table, costing 6-ish bytes 
> of DRAM per page.
> 
> Allen Samuels  
> R&D Engineering Fellow 
> 
> Western Digital(r) 
> Email:  allen.samuels@wdc.com 
> Office:  +1-408-801-7030
> Mobile: +1-408-780-6416 
> 
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com] 
> Sent: Thursday, December 21, 2017 9:45 AM
> To: Allen Samuels <Allen.Samuels@wdc.com>
> Subject: RE: New ObjectStore
> 
> log structured b-tree thing?
> 
> On Thu, 21 Dec 2017, Allen Samuels wrote:
> 
> > Whew.
> > 
> > Stay away from LSM. They optimize for developer time at the expense of run-time resource consumption.
> > 
> > Allen Samuels  
> > R&D Engineering Fellow 
> > 
> > Western Digital(r) 
> > Email:  allen.samuels@wdc.com 
> > Office:  +1-408-801-7030
> > Mobile: +1-408-780-6416 
> > 
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com] 
> > Sent: Thursday, December 21, 2017 8:41 AM
> > To: Allen Samuels <Allen.Samuels@wdc.com>
> > Subject: Re: New ObjectStore
> > 
> > On Thu, 21 Dec 2017, Allen Samuels wrote:
> > > w.r.t. today's discussion about a new ObjectStore. Moving the 
> > > fast-paths of the OSD into a reactive framework (SeaStar) is great and 
> > > will certainly improve performance significantly for small object I/O.
> > > 
> > > However, IMO, using RocksDB (LSM) as a foundational building block is 
> > > a severely sub-optimal choice and will likely serve to severely limit 
> > > the performance boost that you'll achieve with the re-write. For 
> > > large-scale systems, I'm going to make a wild-speculation and suggest 
> > > that you won't see any actual throughput improvement from the 
> > > re-write, because the write-amp for metadata will end up being the 
> > > limiting factor - you'll have PLENTY of CPU that's idle waiting for 
> > > your I/O subsystem and end up running at the same speed as today.
> > 
> > Yeah, completely agree.. the seastar objectstore (SeaStore for maximum 
> > confusion) won't use rocksdb.  We're talking about the futures kv 
> > interface possibility as a glue layer to allow a mid-term 
> > semi-futures-based bluestore.  Not sure it'll make sense, but it's an 
> > option.
> > 
> > So the new thing won't use rocksdb at all.  There don't appear to be 
> > any existing kv choices, but that's probably a good thing as it'll 
> > force us to build metadata capabilities specific to our needs.  That 
> > might be something LSM-ish, might not, I don't have a very clear 
> > picture of this yet (beyond that it should be log structured :).
> > 
> > sage
> > 
> > 
> 
> 
