From: Sage Weil <sage@inktank.com>
Subject: Re: [fuse-devel] fuse_lowlevel_notify_inval_inode deadlock
Date: Wed, 17 Apr 2013 21:45:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304172140060.626@cobra.newdream.net>
References: <Pine.LNX.4.64.1108171208490.11873@cobra.newdream.net> <878vqpg7zq.fsf@tucsk.pomaz.szeredi.hu> <Pine.LNX.4.64.1108241218040.31664@cobra.newdream.net> <alpine.DEB.2.00.1304171730380.23728@cobra.newdream.net>
 <CAFboF2wXUjbcqN19BJy5764ndao3LbOf1Cj44wN+w_zSphriPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1459843185-1366260302=:626"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41451 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab3DREpD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 00:45:03 -0400
In-Reply-To: <CAFboF2wXUjbcqN19BJy5764ndao3LbOf1Cj44wN+w_zSphriPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anand Avati <anand.avati@gmail.com>
Cc: "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>, greg.farnum@inktank.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1459843185-1366260302=:626
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2013, Anand Avati wrote:
> On Wed, Apr 17, 2013 at 5:43 PM, Sage Weil <sage@inktank.com> wrote:
>       We've hit a new deadlock with fuse_lowlevel_notify_inval_inode,
>       this time
>       on the read side:
>=20
>       - ceph-fuse queues an invalidate (in a separate thread)
>       - kernel initiates a read
>       - invalidate blocks in kernel, waiting on a page lock
>       - the read blocks in ceph-fuse
>=20
>       Now, assuming we're reading the stack traces properly, this is
>       more or
>       less what we see with writes, except with reads, and the obvious
>       "don't
>       block the read" would resolve it.
>=20
>       But! =A0If that is the only way to avoid deadlock, I'm afraid it
>       is
>       difficult to implement reliable cache invalidation at all. =A0The
>       reason we
>       are invalidating is because the server told us to: we are no
>       longer
>       allowed to do reads and cached data is invalid. =A0The obvious
>       approach is
>       to
>=20
>       1- stop processing new reads
>       2- let in-progress reads complete
>       3- invalidate the cache
>       4- ack to server
>=20
>       ...but that will deadlock as above, as any new read will lock
>       pages before
>       blcoking. =A0If we don't block, then the read may repopulate page=
s
>       we just
>       invalidated. =A0We could
>=20
>       1- invalidate
>       2- if any reads happened while we were invalidating, goto 1
>       3- ack
>=20
>       but then we risk starvation and livelock.
>=20
>       How do other people solve this problem? =A0It seems like another
>       upcall that
>       would let you block new reads (and/or writes) from starting
>       while the
>       invalidate is in progress would do the trick, but I'm not
>       convinced I'm
>       not missing something much simpler.
>=20
>=20
> Do you really need to call=A0fuse_lowlevel_notify_inval_inode() while s=
till
> holding the mutex in cfuse? It should be sufficient if you -
>=20
> 0 - Receive inval request from server
> 1 - mutex_lock() in cfuse
> 2 - invalidate cfuse cache
> 3 - mutex_unlock() in cfuse
> 4 - fuse_lowlevel_notify_inval_inode()
> 5 - ack to server
>=20
> The only necessary ordering seems to be 0->[2,4]->5. Placing 4 within t=
he
> mutex boundaries looks unnecessary and self-imposed. In-progress reads =
which
> took the page lock before fuse_lowlevel_notify_inval_inode() would eith=
er
> read data cached in cfuse (in case they reached the cache before 1), or=
 get
> sent over to server as though data was never cached. There wouldn't be =
a
> livelock either. Did I miss something?

It's the concurrent reads I'm concerned about:

3.5 - read(2) is called, locks some pages, and sends a message through th=
e=20
fuse connection

3.9 or 4.1 - ceph-fuse gets the reads request.  It can either handle it,=20
repopulating a region of the page cache it possibly just partially=20
invalidated (rendering the invalidate a failure), or block, possibly=20
preventing the invalidate from ever completing.

4.2 - invalidate either completes (having possibly missed some just-read=20
pages), or deadlocks on a locked page (depending on whether we blocked th=
e=20
read above)

sage

--557981400-1459843185-1366260302=:626--
