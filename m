From: Anand Avati <anand.avati-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: fuse_lowlevel_notify_inval_inode deadlock
Date: Wed, 17 Apr 2013 20:33:23 -0700
Message-ID: <CAFboF2wXUjbcqN19BJy5764ndao3LbOf1Cj44wN+w_zSphriPQ@mail.gmail.com>
References: <Pine.LNX.4.64.1108171208490.11873@cobra.newdream.net>
	<878vqpg7zq.fsf@tucsk.pomaz.szeredi.hu>
	<Pine.LNX.4.64.1108241218040.31664@cobra.newdream.net>
	<alpine.DEB.2.00.1304171730380.23728@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1304171730380.23728-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-devel>,
	<mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=fuse-devel>
List-Post: <mailto:fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-devel>,
	<mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, greg.farnum-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Apr 17, 2013 at 5:43 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> We've hit a new deadlock with fuse_lowlevel_notify_inval_inode, this time
> on the read side:
>
> - ceph-fuse queues an invalidate (in a separate thread)
> - kernel initiates a read
> - invalidate blocks in kernel, waiting on a page lock
> - the read blocks in ceph-fuse
>
> Now, assuming we're reading the stack traces properly, this is more or
> less what we see with writes, except with reads, and the obvious "don't
> block the read" would resolve it.
>
> But!  If that is the only way to avoid deadlock, I'm afraid it is
> difficult to implement reliable cache invalidation at all.  The reason we
> are invalidating is because the server told us to: we are no longer
> allowed to do reads and cached data is invalid.  The obvious approach is
> to
>
> 1- stop processing new reads
> 2- let in-progress reads complete
> 3- invalidate the cache
> 4- ack to server
>
> ...but that will deadlock as above, as any new read will lock pages before
> blcoking.  If we don't block, then the read may repopulate pages we just
> invalidated.  We could
>
> 1- invalidate
> 2- if any reads happened while we were invalidating, goto 1
> 3- ack
>
> but then we risk starvation and livelock.
>
> How do other people solve this problem?  It seems like another upcall that
> would let you block new reads (and/or writes) from starting while the
> invalidate is in progress would do the trick, but I'm not convinced I'm
> not missing something much simpler.
>

Do you really need to call fuse_lowlevel_notify_inval_inode() while still
holding the mutex in cfuse? It should be sufficient if you -

0 - Receive inval request from server
1 - mutex_lock() in cfuse
2 - invalidate cfuse cache
3 - mutex_unlock() in cfuse
4 - fuse_lowlevel_notify_inval_inode()
5 - ack to server

The only necessary ordering seems to be 0->[2,4]->5. Placing 4 within the
mutex boundaries looks unnecessary and self-imposed. In-progress reads
which took the page lock before fuse_lowlevel_notify_inval_inode() would
either read data cached in cfuse (in case they reached the cache before 1),
or get sent over to server as though data was never cached. There wouldn't
be a livelock either. Did I miss something?

Avati
------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
