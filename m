From: Sage Weil <sage@newdream.net>
Subject: Re: 2 related bluestore questions
Date: Tue, 10 May 2016 21:10:31 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605102105260.15518@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com> <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com> <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com> <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com>
 <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52012 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbcEKBKU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 May 2016 21:10:20 -0400
In-Reply-To: <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: allen.samuels@sandisk.com, ceph-devel@vger.kernel.org

On Tue, 10 May 2016, Sage Weil wrote:
> > > Making the wal part of the consistency model is more complex, but it means
> > > we can (1) log our intent to overwrite atomically with the kv txn commit,
> > > and then (2) do the async overwrite.  It will get a bit more complex
> > > because we'll be doing metadata updates as part of the wal completion, but
> > > it's not a big step from where we are now, and I think the performance
> > > benefit will be worth it.
> > May I have some example how it's supposed to work please?
> 
> At a high level,
> 
> 1- prepare kv commit.  it includes a wal_op_t that describes a 
> read/modify/write of a csum block within some existing blob.
> 2- commit the kv txn
> 3- do the wal read/modify/write
> 4- calculate new csum
> 5- in the wal 'cleanup' transaction (which removes the wal event), 
> also update blob csum_data in the onode or bnode.
> 
> In practice, I think we want to pass TransContext down from _wal_apply 
> into _do_wal_op, and put modified onode or bnode in the txc dirty list.  
> (We'll need to clear it after the current _txc_finalize call so that it 
> doesn't have the first phase's dirty stuff still there.)  Then, in 
> _kv_sync_thread, where the
> 
>       // cleanup sync wal keys
> 
> stuff is, we probably want to have a helper that captures the wal event 
> removal *and* any other stuff we need to do.. like update onodes and 
> bnodes.  It'll look similar to _txc_finalize, I think.
> 
> Then the main piece is how to modify the bluestore_wal_op_t to describe 
> which blob metadata we're modifying and how to do the 
> whole read/modify/write operation.  I think
> 
>  - we need to bundle the csum data for anything we read.  we can probably 
> just put a blob_t in here, since it includes the extents and csum metadata 
> all together.
>  - we need to describe where the blob exists (which onode or bnode owns 
> it, and what its id is) so that do_wal_op can find it and update it.
>    * we might want to optimize the normal path so that we can use the 
> in-memory copy without doing a lookup
> 
> It probably means a mostly rewritten wal_op_t type.  I think the ops we 
> need to capture are
> 
>  - overwrite
>  - read / modify / write (e.g., partial blocks)
>  - read / modify / write (and update csum metadata)
>  - read / modify / compress / write (and update csum metadata)
>  - read / write elsewhere (e.g., the current copy op, used for cow)
> 
> Since compression is thrown in there, we probably need to be able to 
> allocate in the do_wal_op path too.  I think that'll be okay... it's 
> making the wal finalize kv look more and more like the current 
> txc_finalize.  That probably means if we're careful we can use the same 
> code for both?


I took a stab at a revised wal_op_t here:

	https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/os/bluestore/bluestore_types.h#L595-L605

This is enough to implement the basic wal overwrite case here:

	https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/os/bluestore/BlueStore.cc#L5522-L5578

It's overkill for that, but something like this ought to be sufficiently 
general to express the more complicated wal (and compaction/gc/cleanup) 
operations, where we are reading bits of data from lots of different 
previous blobs, verifying checksums, and then assembling the results into 
a new buffer that gets written somewhere else.  The read_extent_map and 
write_map offsets are logical offsets in a buffer we assemble and then 
write to b_off~b_len in the specific blob.  I didn't get to the _do_wal_op 
part that actually does it, but it would do the final write, csum 
calculation, and metadata update.  Probably... the allocation would happen 
then too, if the specified blob didn't already have pextents.  Tha way 
we can do compression at that stage as well?

What do you think?

sage

