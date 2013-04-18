From: Sage Weil <sage@inktank.com>
Subject: Re: [fuse-devel] fuse_lowlevel_notify_inval_inode deadlock
Date: Thu, 18 Apr 2013 12:12:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304181208100.1128@cobra.newdream.net>
References: <Pine.LNX.4.64.1108171208490.11873@cobra.newdream.net> <878vqpg7zq.fsf@tucsk.pomaz.szeredi.hu> <Pine.LNX.4.64.1108241218040.31664@cobra.newdream.net> <alpine.DEB.2.00.1304171730380.23728@cobra.newdream.net> <CAFboF2wXUjbcqN19BJy5764ndao3LbOf1Cj44wN+w_zSphriPQ@mail.gmail.com>
 <alpine.DEB.2.00.1304172140060.626@cobra.newdream.net> <CAFboF2x8mcnOT_T47tOD34y7xZW_6D_-0jQw7GUMSbh0Edz4sA@mail.gmail.com> <alpine.DEB.2.00.1304181000400.344@cobra.newdream.net> <846B62AA-126D-41D7-9507-F44213AF07B9@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48846 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab3DRTMr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 15:12:47 -0400
In-Reply-To: <846B62AA-126D-41D7-9507-F44213AF07B9@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anand Avati <avati@redhat.com>
Cc: Anand Avati <anand.avati@gmail.com>, "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>, greg.farnum@inktank.com, ceph-devel@vger.kernel.org

On Thu, 18 Apr 2013, Anand Avati wrote:
> On Apr 18, 2013, at 10:05 AM, Sage Weil <sage@inktank.com> wrote:
> > On Wed, 17 Apr 2013, Anand Avati wrote:
> >> On Wed, Apr 17, 2013 at 9:45 PM, Sage Weil <sage@inktank.com> wrote:
> >> 
> >>> On Wed, 17 Apr 2013, Anand Avati wrote:
> >>>> On Wed, Apr 17, 2013 at 5:43 PM, Sage Weil <sage@inktank.com> wrote:
> >>>>      We've hit a new deadlock with fuse_lowlevel_notify_inval_inode,
> >>>>      this time
> >>>>      on the read side:
> >>>> 
> >>>>      - ceph-fuse queues an invalidate (in a separate thread)
> >>>>      - kernel initiates a read
> >>>>      - invalidate blocks in kernel, waiting on a page lock
> >>>>      - the read blocks in ceph-fuse
> >>>> 
> >>>>      Now, assuming we're reading the stack traces properly, this is
> >>>>      more or
> >>>>      less what we see with writes, except with reads, and the obvious
> >>>>      "don't
> >>>>      block the read" would resolve it.
> >>>> 
> >>>>      But!  If that is the only way to avoid deadlock, I'm afraid it
> >>>>      is
> >>>>      difficult to implement reliable cache invalidation at all.  The
> >>>>      reason we
> >>>>      are invalidating is because the server told us to: we are no
> >>>>      longer
> >>>>      allowed to do reads and cached data is invalid.  The obvious
> >>>>      approach is
> >>>>      to
> >>>> 
> >>>>      1- stop processing new reads
> >>>>      2- let in-progress reads complete
> >>>>      3- invalidate the cache
> >>>>      4- ack to server
> >>>> 
> >>>>      ...but that will deadlock as above, as any new read will lock
> >>>>      pages before
> >>>>      blcoking.  If we don't block, then the read may repopulate pages
> >>>>      we just
> >>>>      invalidated.  We could
> >>>> 
> >>>>      1- invalidate
> >>>>      2- if any reads happened while we were invalidating, goto 1
> >>>>      3- ack
> >>>> 
> >>>>      but then we risk starvation and livelock.
> >>>> 
> >>>>      How do other people solve this problem?  It seems like another
> >>>>      upcall that
> >>>>      would let you block new reads (and/or writes) from starting
> >>>>      while the
> >>>>      invalidate is in progress would do the trick, but I'm not
> >>>>      convinced I'm
> >>>>      not missing something much simpler.
> >>>> 
> >>>> 
> >>>> Do you really need to call fuse_lowlevel_notify_inval_inode() while still
> >>>> holding the mutex in cfuse? It should be sufficient if you -
> >>>> 
> >>>> 0 - Receive inval request from server
> >>>> 1 - mutex_lock() in cfuse
> >>>> 2 - invalidate cfuse cache
> >>>> 3 - mutex_unlock() in cfuse
> >>>> 4 - fuse_lowlevel_notify_inval_inode()
> >>>> 5 - ack to server
> >>>> 
> >>>> The only necessary ordering seems to be 0->[2,4]->5. Placing 4 within the
> >>>> mutex boundaries looks unnecessary and self-imposed. In-progress reads
> >>> which
> >>>> took the page lock before fuse_lowlevel_notify_inval_inode() would either
> >>>> read data cached in cfuse (in case they reached the cache before 1), or
> >>> get
> >>>> sent over to server as though data was never cached. There wouldn't be a
> >>>> livelock either. Did I miss something?
> >>> 
> >>> It's the concurrent reads I'm concerned about:
> >>> 
> >>> 3.5 - read(2) is called, locks some pages, and sends a message through the
> >>> fuse connection
> >>> 
> >>> 3.9 or 4.1 - ceph-fuse gets the reads request.  It can either handle it,
> >>> repopulating a region of the page cache it possibly just partially
> >>> invalidated (rendering the invalidate a failure),
> >> 
> >> I think the problem lies here, that handling the read before 5 is returning
> >> old data (which effectively renders the invalidation a failure). Step 0
> >> needs to guarantee that new data about to be written is already staged in
> >> the server and made available for read. However the write request itself
> >> needs to be blocked from completing till step 5 from all other clients
> >> completes.
> > 
> > It sounds like you're thinking of a weaker consistency model.  The mds is 
> > telling us to stop reads and invalidate our cache *before* anybody is 
> > allowed to write. At the end of this process, we ack, we should have an 
> > empty page cache for this file and any reads should be blocked until 
> > further notice.
> 
> Yes, the consistency model I was talking about is weaker than "block new reads, purge all cache, wait until further notified". If you are striping data and if the read request spans multiple stripes, then I guess you do need a stricter version.
> 
> >>> or block, possibly preventing the invalidate from ever completing.
> >>> 
> >> 
> >> Hmm, where would it block? Din't we mutex_unlock() in 3 already? and the
> >> server should be prepared to serve staged data even before Step 0.
> >> Invalidating might be *delayed* till the in-progress reads finishes. But
> >> that only delays the completion of write(), but no deadlocks anywhere. Hope
> >> I din't miss something :-)
> > 
> > You can ignore the mutex_lock stuff; I don't think it's necessary to see 
> > the issue.  Simply consider a racing read (that has pages locked) and 
> > invalidate (that is walking through the address_space mapping locking and 
> > discarding pages).  We can't block the read without risking deadlock with 
> > the invalidate, and we can't continue with the read without making the 
> > invalidate unsuccessful/unreliable.  We can actually do reads at this 
> > point from the ceph client vs server perspective since we haven't acked 
> > the revocation yet.. but with the fuse vs ceph-fuse interaction we are 
> > choosing betweeen deadlock or potential livelock (if we do the read and 
> > then try the invalidate a second time).
> 
> For the consistency model you are looking at - (halt all new reads, 
> clear all page cache, perform write) this sure seems to be a deadlock vs 
> live-lock situation.  Why isn't your consistency requirements a problem 
> for the ceph in-kernel client? What extra machinery does it have which 
> FUSE does not? I supposed you implement the "halt new reads" in 
> f_op->[aio_]read even before taking page locks?

Exactly.

I think to get the proper semantics in the fuse case (and also to solve 
the striping problem you describe below), there would need to be an upcall 
to quiece read (and probably something similar to write, depending on how 
the writeback stuff works out) before doing the invalidate.

What does gluster do in this case?  Are they using direct_io mode?  Or a 
different consistency model?

sage


> ceph-fuse is always processing "parts" of an application read() call 
> (sometimes the "part" could be large enough to match the full read() 
> request, but not always) and can apply consistency enforcement to only 
> individual parts. For e.g, a few cached pages could satisfy first half 
> of a read request and second half might be the only part ceph-fuse even 
> gets to witness at all. If invalidate() is called after the first half 
> is copied from page cache to user buffer, you still have an inconsistent 
> read. Similarly a request split up because of the fuse channel size 
> limitation can result in the two halfs of the reads landing before and 
> after a single write spanning the full read region.
> 
> Enabling direct_io mode bypasses the page cache and solves the 
> "half-cache-copy" problem, but still is subject to the split-reads 
> problem. I suppose implementing a "cork" in fuse_file_aio_read() is the 
> only safe solution?
> 
> Avati
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
