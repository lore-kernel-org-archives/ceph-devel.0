From: Sage Weil <sage@newdream.net>
Subject: Re: 2 related bluestore questions
Date: Wed, 11 May 2016 10:35:37 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605110959220.15518@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605091417590.336@cpach.fuggernut.com> <6168022b-e3c0-b8f2-e8c7-3b4b82f9dc6e@mirantis.com> <alpine.DEB.2.11.1605100841400.15518@cpach.fuggernut.com> <b6240191-0849-d60c-ebb6-147b5785e3e7@mirantis.com>
 <alpine.DEB.2.11.1605101121090.15518@cpach.fuggernut.com> <alpine.DEB.2.11.1605102105260.15518@cpach.fuggernut.com> <89f6b406-848f-71c2-7f70-c64606a8e049@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55085 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcEKOf1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 10:35:27 -0400
In-Reply-To: <89f6b406-848f-71c2-7f70-c64606a8e049@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: allen.samuels@sandisk.com, ceph-devel@vger.kernel.org

On Wed, 11 May 2016, Igor Fedotov wrote:
> Sage,
> 
> thanks a lot for detailed overview.
> 
> Below is a brief proposal on Extent Manager extension to support WAL.
> Please tell me what's your final decision its fortune? Are there any plans to
> use it or we completely rebase to the code you are woring on. Is there any
> sense for me to to continue working on it or I should switch to something in
> your stream.

I would prefer to work from my stream to flesh out the read and write 
code, and then move to an ExtentManager modularization once we understand 
the dependencies of the write logic on other BlueStore state.  FWIW I've 
been pushing some of the mapping logic into the bluestore_types.h types 
and adding unit tests for those, so that hopefully it is more minimal.

> Here is the idea that's pretty simple:
> 1) Add new method(s)  to BlockOpInterface to add WAL record. EX to call it
> when corresponding overwrite (or whatever other case) is detected.
> 2) Add method(s) to ExtentManger to process WAL record. They are to be called
> from _wal_apply/_do_wal_op and EM to perform corresponding RMW tasks. It does
> that using other regular BlockOpInterface methods ( read/write/allocate etc)
> thus Bluestore environment should be ready to handle them during the WAL phase
> as it does during the initial write hanlding one. But it looks like we need
> that anyway - EM doesn't create any additional complexities here.

I think your logical-level wal write suggestion will make this work, but 
I'd like to get it wired up so that the wal operations can have metadata 
side-effects before worrying about the interface.

> And a couple of general notes on WAL apply handling that I realized recently
> and we should probably care of.
> 1) when WAL is applied on compressed blobs one should always allocate and use
> a new blob. Even for the case when resulting buffer fit into the existing
> blob. The rationale for that is that if we crash after the write phase  we and
> before KV update we can't properly execute WAL replay. Source data is altered
> and we are unable to repeat RMW.

Definitely.

> 2) Similarly during WAL replay after the failure one should disable checksum
> verification for existing data read if any. The rationale is the same - we can
> crash after the write and before KV update thus previous checksum in KV is
> invalid.

Yeah, I've been mulling this one over.  What we could do is make 
the checksum verification on the read portion try both the previous 
checksum and the to-be-written checksum and see if either of them matches.  
The problem is that the write could be torn at a block boundary, so we 
might have to try a bunch of different combinations.  Or, we could just 
disable the csum check in the wal replay r/m/w path.

I don't really like the idea of amplifying a 4k write into a 
min_alloc_size (e.g., 64k) read + write elsewhere.  Even on a spinning 
disk, which doesn't really care about the 4k vs 64k, the new write will 
generally be in a different track so it'll be an additional seek.  :(

sage



> 
> Thanks,
> Igor.
> 
> On 11.05.2016 4:10, Sage Weil wrote:
> > On Tue, 10 May 2016, Sage Weil wrote:
> > > > > Making the wal part of the consistency model is more complex, but it
> > > > > means
> > > > > we can (1) log our intent to overwrite atomically with the kv txn
> > > > > commit,
> > > > > and then (2) do the async overwrite.  It will get a bit more complex
> > > > > because we'll be doing metadata updates as part of the wal completion,
> > > > > but
> > > > > it's not a big step from where we are now, and I think the performance
> > > > > benefit will be worth it.
> > > > May I have some example how it's supposed to work please?
> > > At a high level,
> > > 
> > > 1- prepare kv commit.  it includes a wal_op_t that describes a
> > > read/modify/write of a csum block within some existing blob.
> > > 2- commit the kv txn
> > > 3- do the wal read/modify/write
> > > 4- calculate new csum
> > > 5- in the wal 'cleanup' transaction (which removes the wal event),
> > > also update blob csum_data in the onode or bnode.
> > > 
> > > In practice, I think we want to pass TransContext down from _wal_apply
> > > into _do_wal_op, and put modified onode or bnode in the txc dirty list.
> > > (We'll need to clear it after the current _txc_finalize call so that it
> > > doesn't have the first phase's dirty stuff still there.)  Then, in
> > > _kv_sync_thread, where the
> > > 
> > >        // cleanup sync wal keys
> > > 
> > > stuff is, we probably want to have a helper that captures the wal event
> > > removal *and* any other stuff we need to do.. like update onodes and
> > > bnodes.  It'll look similar to _txc_finalize, I think.
> > > 
> > > Then the main piece is how to modify the bluestore_wal_op_t to describe
> > > which blob metadata we're modifying and how to do the
> > > whole read/modify/write operation.  I think
> > > 
> > >   - we need to bundle the csum data for anything we read.  we can probably
> > > just put a blob_t in here, since it includes the extents and csum metadata
> > > all together.
> > >   - we need to describe where the blob exists (which onode or bnode owns
> > > it, and what its id is) so that do_wal_op can find it and update it.
> > >     * we might want to optimize the normal path so that we can use the
> > > in-memory copy without doing a lookup
> > > 
> > > It probably means a mostly rewritten wal_op_t type.  I think the ops we
> > > need to capture are
> > > 
> > >   - overwrite
> > >   - read / modify / write (e.g., partial blocks)
> > >   - read / modify / write (and update csum metadata)
> > >   - read / modify / compress / write (and update csum metadata)
> > >   - read / write elsewhere (e.g., the current copy op, used for cow)
> > > 
> > > Since compression is thrown in there, we probably need to be able to
> > > allocate in the do_wal_op path too.  I think that'll be okay... it's
> > > making the wal finalize kv look more and more like the current
> > > txc_finalize.  That probably means if we're careful we can use the same
> > > code for both?
> > 
> > I took a stab at a revised wal_op_t here:
> > 
> > 	https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/os/bluestore/bluestore_types.h#L595-L605
> > 
> > This is enough to implement the basic wal overwrite case here:
> > 
> > 	https://github.com/liewegas/ceph/blob/wip-bluestore-write/src/os/bluestore/BlueStore.cc#L5522-L5578
> > 
> > It's overkill for that, but something like this ought to be sufficiently
> > general to express the more complicated wal (and compaction/gc/cleanup)
> > operations, where we are reading bits of data from lots of different
> > previous blobs, verifying checksums, and then assembling the results into
> > a new buffer that gets written somewhere else.  The read_extent_map and
> > write_map offsets are logical offsets in a buffer we assemble and then
> > write to b_off~b_len in the specific blob.  I didn't get to the _do_wal_op
> > part that actually does it, but it would do the final write, csum
> > calculation, and metadata update.  Probably... the allocation would happen
> > then too, if the specified blob didn't already have pextents.  Tha way
> > we can do compression at that stage as well?
> > 
> > What do you think?
> > 
> > sage
> > 
> 
> 
