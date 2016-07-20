From: Ira Cooper <ira@wakeful.net>
Subject: Re: CephFS Samba VFS RHEL packages
Date: Wed, 20 Jul 2016 07:21:25 -0400
Message-ID: <20160720112058.GA13150@ira-t460p.lan>
References: <CA+z5Dsx7phEMT1oxENzCwXxQrB0NtCLwxWGPKF+NeMZNr+KkSw@mail.gmail.com>
 <CALe9h7c=zegmKFYkz7-oKSG9uQ0-TUE+DkXSCNdkwJgvpqsRXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33132 "EHLO
	mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbcGTLVd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2016 07:21:33 -0400
Received: by mail-qt0-f169.google.com with SMTP id w38so24372598qtb.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jul 2016 04:21:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALe9h7c=zegmKFYkz7-oKSG9uQ0-TUE+DkXSCNdkwJgvpqsRXA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Blair Bethwaite <blair.bethwaite@gmail.com>, Ira Cooper <ira@wakeful.net>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jul 20, 2016 at 10:59:36AM +0100, John Spray wrote:
> On Wed, Jul 20, 2016 at 6:45 AM, Blair Bethwaite
> <blair.bethwaite@gmail.com> wrote:
> > Hi all,
> >
> > We've started a CephFS Samba PoC on RHEL but just noticed the Samba
> > Ceph VFS doesn't seem to be included with Samba on RHEL, or we're not
> > looking in the right place. Trying to avoid needing to build Samba
> > from source if possible. Any pointers appreciated.
> 
> RHEL packagers tend to be conservative about building in feature flags
> that aren't official parts of their product.
> 
> Unfortunately we do our upstream Samba testing on Ubuntu, so don't
> have any RPMs from the gitbuilders either; you're probably going to
> have to build your own.
> 
> CCing Ira who was recently evaluating the state of Samba+CephFS and
> might have some tips on setting this up on RHEL.

RHEL: I don't expect that the packages will ever be part of the
RHEL Samba build.  The ones for Gluster aren't, as precident.  But
I don't speak for Red Hat.   :)

I also don't work on RHEL.  I work on Fedora.  So all of this is
written from the point of view of Fedora 23.  I'm working on
straightening out my Fedora 24 development setup.

As far as state of the world?

CTDB: It can be made to work, but I don't recommend it at this
time.  The settings needed aren't friendly to CephFS, and I
would not recommend this in production today.

ACLs: Aren't implemented in vfs_ceph, because I still have to
submit the refactored vfs_ceph code to the Samba team list,
but I ran into testing issues on the CephFS side, regarding
ACL setting, if the Gluster side works, I may just see if we
can push these anyways.  The refactoring unifies the ACL
handling between vfs_ceph and vfs_gluster.

Working absent those two issues: Seems ok, for modern Ceph
bits.  most recent Jewel should be "ok", as I understand
it.  I did my work on pre-release Jewel bits.

I recommend looking at my presentation that I gave at SambaXP.
http://sambaxp.org/ day 3.  It may be out of date in a few
spots, but it should be close.

Cheers,

-Ira / ira@(samba.org|wakeful.net)
