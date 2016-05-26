From: Sage Weil <sweil@redhat.com>
Subject: Re: BlueFS compact log
Date: Thu, 26 May 2016 10:32:40 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605261015460.6221@cpach.fuggernut.com>
References: <BLUPR0201MB1908C286194EF1137370DA1BE2480@BLUPR0201MB1908.namprd02.prod.outlook.com> <BLUPR0201MB19086F0B353548BEE93C7AF5E2410@BLUPR0201MB1908.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354AbcEZOcU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2016 10:32:20 -0400
In-Reply-To: <BLUPR0201MB19086F0B353548BEE93C7AF5E2410@BLUPR0201MB1908.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: ceph-devel@vger.kernel.org

Hi Varada,

Sorry, I missed your earlier message.  Also adding ceph-devel cc.

On Thu, 26 May 2016, Varada Kari wrote:
> Hi Sage,
> 
> I figured out some more gaps in my implementation, but the idea what is
> proposed is the same.
> Now i am thinking about adding some throttling and crash recovery
> aspects to it.
> 
> Sorry for the delay in responding, been pulled some other tasks. trying
> to get basic implementation
> ready, will get back to you soon on this.
> 
> Varada
> 
> On Tuesday 17 May 2016 06:15 PM, Varada Kari wrote:
> > Hi Sage,
> >
> > Regrading the task to remove to compact the log in BlueFS, i am thinking
> > of the following approach. Please correct me if i had missed anything in
> > understanding.
> > Once i have some more understanding on the approach and some kind of
> > implementation ready will send it to ceph-devel for review on the proposal.
> >
> > Approach 1:
> >
> >
> > Thinking of implementing as a double buffered system.
> >
> > 1. Inode 1, will serve as a log file. There will be active and passive
> > shadow files as per bluefs_log_compact_min_size(16MB)
> > 2. BlueFS::_maybe_compact_log() will find out if we have to compact the
> > log, by looking at the active log file.
> > 3. If needs compactoin, switch to other log file and start merging the
> > contents from passive file to ino 1.
> > 4. Will create a compaction thread, where it can run in background.
> >
> >
> > tasks to handle:
> >
> > 1. get_total and get_free, have to consult both the files along with
> > actual log file.
> > 2. Any crash in between, on reboot, have to merge the contents to
> > log_file(ino 1), and replay the log before any decision is made.
> >
> > Thinking of adding fsck as part of the change to verify my logic.
> > Hope i am thinking in correct lines about the problem.

A few comments, mostly in reverse...

There is no need for an explicit fsck function because all the metadata is 
loaded into RAM (and can/should be verified) on mount.  Most of the 
metadata is implicitly validated at that point (e.g., when the allocator 
freelist is fabricated based on what isn't explicitly referenced by 
fnodes).  If there's anything we can validate that we aren't, we should 
just add it there.

I don't quite understand the 'double-buffer' idea above.  I don't think 
there is any need to have a separate fnode for the compaction because the 
metadata is in RAM and will be implicitly thrown out if we crash and 
restart (because no persisted fnode references the space we were using).

I think the process looks like this...

1. Decide we need to compact.  This can be a simple heuristic that 
compares the estimated space we need (number of fnodes * some average 
size) vs the actual log size.  I think this is already in place.

2. Allocate a new extent to continue the log, and then log an event 
that jumps the log write position to the new extent.  At this point, the 
old extent(s) won't be written to, and reflect everything should compact.

[simple version]
3. While still holding the lock, encode a bufferlist that dumps all of the 
in-memory fnodes and names.  This will become the new beginning of the 
log.  The last event will jump to the log continuation extent from #2.

4. Drop the lock so that writes can continue.

5. Queue a write to a new extent for the new beginnging of the log.  Wait 
for it to commit and flush.

6. Retake the lock.

7. Update the log_fnode to splice in the new beginning.  Queue an io to 
update the superblock.  Drop the lock.

8. Wait for things to flush.  Retake the lock, and release the old log 
beginnging extents to the allocator for reuse.


This does the log compaction in-memory with the lock held.  I think it'll 
be really complex to do it without the lock, so I'm inclined not to worry 
about that at this point.  I don't think it will stall bluefs for 
long--the IO is generally the slow part.

This is a bit wonky in that we might have a superblock fnode 
that is newer than what is in the log.  I think we just need to 
update the _replay case so that f->fnode only updates if the version 
is newer.  We might also have a case where teh superblock fnode references 
the old uncompacted log, and a new log event at teh end updates the log 
fnode to reference the new space.  That's also okay for replay, *if* we 
force a superblock update on replay.  We can just do that 
unconditionally.  (Mostly it doesn't matter... i.e. the superblock might 
have log fnode v2 that has one extent, and as the log grows we log fnodes 
that add new extents.  Replay completes and all is well even though the 
superblock's fnode is super old--it's still enough to get started 
reading the log.  But with compaction we might deallocate and clobber what 
the old thing referenced... so just updating the superblock after replay 
cleans up if we crashed before #8 happened above.


That's what I've been thinking, at least--let me know if you have 
another/better idea!  Happy to talk over video chat if that helps.

sage

