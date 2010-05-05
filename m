From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Replacing DRBD use with RBD
Date: Wed, 05 May 2010 13:02:44 -0700
Message-ID: <hrsibo$29c$1@dough.gmane.org>
References: <801672.55708.qm@web36106.mail.mud.yahoo.com> <hrr69o$fhb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:46978 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043Ab0EETxn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 5 May 2010 15:53:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1O9kf3-0004U3-AR
	for ceph-devel@vger.kernel.org; Wed, 05 May 2010 21:53:37 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 05 May 2010 21:53:37 +0200
Received: from eternaleye by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 05 May 2010 21:53:37 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Replying to a response that was off-list:

On Wed, May 5, 2010 at 9:02 AM, Martin Fick <mogulguy@yahoo.com> wrote:
>
> --- On Wed, 5/5/10, Alex Elsayed <eternaleye@gmail.com> wrote:
>
> > >...This would open up the use of RBD devices for linux
> > > containers or linux vservers which could run on any
> > > machine in a cluster (similar to the idea of using it
> > > with kvm/qemu).
> >
> > As it currently stands you could likely run a vserver or an
> > OpenVZ/Virtuozzo/LXC container on Ceph (the distributed FS)
> > directly, rather than layering a local FS over RBD. Also,
> > this would probably provide better performance in the end.
>
> Could you please explain why you would think that this
> would provide better performance in the end?  I would think
> that a simpler local filesystem (with remote read writes)
> could outperform ceph in most situations that would matter
> for virtual systems (i.e. low latencies for small
> read/writes), would it not?

I would recommend benchmarking to have empirical results rather
than going with my presumptions, but in Ceph the metadata servers
cache the metadata and the OSDs journal writes, so any writes which
fit in the journal will be quite fast. Also, RBD has no way of
knowing what reads/writes are 'small' in the RBD block device,
because it works by splitting the disk image into 4MB chunks and
deals with those. That means that even small reads and writes
have a minimum size of 4MB.

>
> > ...This is probably a better solution for container-based
> > virtualization than RBD-based options, due to the advantage
> > one can take of all guests sharing a kernel with the host.
>
> I am not sure I understand why you are saying the guest/host
> sharing thing is an advantage that would benefit using ceph
> over RBD, could you pleas expound?

This is an advantage in the container virtualization case because
you can (say) mount the entire Ceph FS on the host and treat the
containers simply run the containers from a very basic LXC or other 
container config, treating the Ceph filesystem as just another
directory tree from the point of view of the container. This
simplifies your container config, and gives the advantages I named
earlier (online resize, etc).

> > RBD is more likely to be useful for full virtualization
> > like KVM,
>
> Again, why so specifically?

Because for containers, the config is simplest when you can hand
them a directory tree, but for full virtualization, the config is
simplest when you can hand them a block device. Simplicity reduces
the number of potential points where errors can be introduced.

> I agree that ceph would also have it's advantages, but
> RBD based solutions would likely have some advantages
> that ceph will never have.  RBD allows one to use any
> local filesystem with any semantics/features that one
> wishes. RBD is simpler.  RBD is likely currently more
> mature than ceph?

Ceph has POSIX (or as close as possible) semantics, matching local
filesystems, and provides more features than any local FS except
BtrFS, which is similarly under heavy development.

RBD is actually a rather recent addition - the first mailing
list message about it was on March 7th, 2010, whereas Ceph has
been in development since 2007.

I am posting this to the mailing list as well, as others may find it 
interesting.

