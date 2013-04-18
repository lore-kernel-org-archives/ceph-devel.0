From: Sage Weil <sage@inktank.com>
Subject: Re: [fuse-devel] fuse_lowlevel_notify_inval_inode deadlock
Date: Thu, 18 Apr 2013 10:05:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304181000400.344@cobra.newdream.net>
References: <Pine.LNX.4.64.1108171208490.11873@cobra.newdream.net> <878vqpg7zq.fsf@tucsk.pomaz.szeredi.hu> <Pine.LNX.4.64.1108241218040.31664@cobra.newdream.net> <alpine.DEB.2.00.1304171730380.23728@cobra.newdream.net> <CAFboF2wXUjbcqN19BJy5764ndao3LbOf1Cj44wN+w_zSphriPQ@mail.gmail.com>
 <alpine.DEB.2.00.1304172140060.626@cobra.newdream.net> <CAFboF2x8mcnOT_T47tOD34y7xZW_6D_-0jQw7GUMSbh0Edz4sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47685 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966557Ab3DRRFO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 13:05:14 -0400
In-Reply-To: <CAFboF2x8mcnOT_T47tOD34y7xZW_6D_-0jQw7GUMSbh0Edz4sA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anand Avati <anand.avati@gmail.com>
Cc: "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>, greg.farnum@inktank.com, ceph-devel@vger.kernel.org

On Wed, 17 Apr 2013, Anand Avati wrote:
> On Wed, Apr 17, 2013 at 9:45 PM, Sage Weil <sage@inktank.com> wrote:
> 
> > On Wed, 17 Apr 2013, Anand Avati wrote:
> > > On Wed, Apr 17, 2013 at 5:43 PM, Sage Weil <sage@inktank.com> wrote:
> > >       We've hit a new deadlock with fuse_lowlevel_notify_inval_inode,
> > >       this time
> > >       on the read side:
> > >
> > >       - ceph-fuse queues an invalidate (in a separate thread)
> > >       - kernel initiates a read
> > >       - invalidate blocks in kernel, waiting on a page lock
> > >       - the read blocks in ceph-fuse
> > >
> > >       Now, assuming we're reading the stack traces properly, this is
> > >       more or
> > >       less what we see with writes, except with reads, and the obvious
> > >       "don't
> > >       block the read" would resolve it.
> > >
> > >       But!  If that is the only way to avoid deadlock, I'm afraid it
> > >       is
> > >       difficult to implement reliable cache invalidation at all.  The
> > >       reason we
> > >       are invalidating is because the server told us to: we are no
> > >       longer
> > >       allowed to do reads and cached data is invalid.  The obvious
> > >       approach is
> > >       to
> > >
> > >       1- stop processing new reads
> > >       2- let in-progress reads complete
> > >       3- invalidate the cache
> > >       4- ack to server
> > >
> > >       ...but that will deadlock as above, as any new read will lock
> > >       pages before
> > >       blcoking.  If we don't block, then the read may repopulate pages
> > >       we just
> > >       invalidated.  We could
> > >
> > >       1- invalidate
> > >       2- if any reads happened while we were invalidating, goto 1
> > >       3- ack
> > >
> > >       but then we risk starvation and livelock.
> > >
> > >       How do other people solve this problem?  It seems like another
> > >       upcall that
> > >       would let you block new reads (and/or writes) from starting
> > >       while the
> > >       invalidate is in progress would do the trick, but I'm not
> > >       convinced I'm
> > >       not missing something much simpler.
> > >
> > >
> > > Do you really need to call fuse_lowlevel_notify_inval_inode() while still
> > > holding the mutex in cfuse? It should be sufficient if you -
> > >
> > > 0 - Receive inval request from server
> > > 1 - mutex_lock() in cfuse
> > > 2 - invalidate cfuse cache
> > > 3 - mutex_unlock() in cfuse
> > > 4 - fuse_lowlevel_notify_inval_inode()
> > > 5 - ack to server
> > >
> > > The only necessary ordering seems to be 0->[2,4]->5. Placing 4 within the
> > > mutex boundaries looks unnecessary and self-imposed. In-progress reads
> > which
> > > took the page lock before fuse_lowlevel_notify_inval_inode() would either
> > > read data cached in cfuse (in case they reached the cache before 1), or
> > get
> > > sent over to server as though data was never cached. There wouldn't be a
> > > livelock either. Did I miss something?
> >
> > It's the concurrent reads I'm concerned about:
> >
> > 3.5 - read(2) is called, locks some pages, and sends a message through the
> > fuse connection
> >
> > 3.9 or 4.1 - ceph-fuse gets the reads request.  It can either handle it,
> > repopulating a region of the page cache it possibly just partially
> > invalidated (rendering the invalidate a failure),
> 
> I think the problem lies here, that handling the read before 5 is returning
> old data (which effectively renders the invalidation a failure). Step 0
> needs to guarantee that new data about to be written is already staged in
> the server and made available for read. However the write request itself
> needs to be blocked from completing till step 5 from all other clients
> completes.

It sounds like you're thinking of a weaker consistency model.  The mds is 
telling us to stop reads and invalidate our cache *before* anybody is 
allowed to write. At the end of this process, we ack, we should have an 
empty page cache for this file and any reads should be blocked until 
further notice.

> > or block, possibly preventing the invalidate from ever completing.
> >
> 
> Hmm, where would it block? Din't we mutex_unlock() in 3 already? and the
> server should be prepared to serve staged data even before Step 0.
> Invalidating might be *delayed* till the in-progress reads finishes. But
> that only delays the completion of write(), but no deadlocks anywhere. Hope
> I din't miss something :-)

You can ignore the mutex_lock stuff; I don't think it's necessary to see 
the issue.  Simply consider a racing read (that has pages locked) and 
invalidate (that is walking through the address_space mapping locking and 
discarding pages).  We can't block the read without risking deadlock with 
the invalidate, and we can't continue with the read without making the 
invalidate unsuccessful/unreliable.  We can actually do reads at this 
point from the ceph client vs server perspective since we haven't acked 
the revocation yet.. but with the fuse vs ceph-fuse interaction we are 
choosing betweeen deadlock or potential livelock (if we do the read and 
then try the invalidate a second time).

sage


> 
> 
> > 4.2 - invalidate either completes (having possibly missed some just-read
> > pages),
> 
> 
> Pre-staging would prevent this.
> 
> 
> > or deadlocks on a locked page (depending on whether we blocked the
> > read above)
> >
> 
> Again, not sure where or why the read() is getting blocked?
> 
> 
> Another approach to the problem - when a second client opens the file in
> write mode, change this client's (and all other clients') file into
> direct_io mode, bypassing the page cache (and also disable all ceph-fuse
> caching). This would require a new reverse invalidation method to toggle
> the inode mode as direct or buffered, and check for this inode flag (along
> with file->f_flags for O_DIRECT) in fuse_file_aio_write() to take the
> direct_write() code path. Instead of blocking write completion till all
> other clients invalidate their cached pages, blocking a second
> open-for-write till all other clients toggle their inode flag for direct_io
> seems like a simpler approach to reason with. This is the approach I have
> in mind for gluster (handle everything in open(), just not worth having a
> complex per-IO invalidation protocol).
> 
> Avati
> ------------------------------------------------------------------------------
> Precog is a next-generation analytics platform capable of advanced
> analytics on semi-structured data. The platform includes APIs for building
> apps and a phenomenal toolset for data science. Developers can use
> our toolset for easy data analysis & visualization. Get a free account!
> http://www2.precog.com/precogplatform/slashdotnewsletter
> _______________________________________________
> fuse-devel mailing list
> fuse-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/fuse-devel
> 
> 
