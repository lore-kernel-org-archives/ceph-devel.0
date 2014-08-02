From: Sage Weil <sweil@redhat.com>
Subject: Re: firefly backports
Date: Sat, 2 Aug 2014 16:25:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408021625350.18917@cobra.newdream.net>
References: <alpine.DEB.2.00.1408011756300.1270@cobra.newdream.net> <CA+4uBUbFCn=DMQov3Wt0iJOsgF-hHoX-rsA7kNKsrso=Ahxeew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48041 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaHBXZy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Aug 2014 19:25:54 -0400
In-Reply-To: <CA+4uBUbFCn=DMQov3Wt0iJOsgF-hHoX-rsA7kNKsrso=Ahxeew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 2 Aug 2014, Samuel Just wrote:
> 8733 appears to already be in firefly-next.  I added 7999 and 8438.
> 8701 is the lfn collection_move_rename bug.  Do we want to backport
> that one yet?

Yeah, let's get it all in there so we maximize the amount of time it's 
tested.  So far things look good on master.


> -Sam
> 
> On Fri, Aug 1, 2014 at 6:00 PM, Sage Weil <sage@inktank.com> wrote:
> > Sam, Yehuda,
> >
> > I backported a ton of pending stuff to firefly-next.  A bunch of it was
> > the cephtool tests and unwinding it from the mds cli changes.  Also did
> > ceph df writeable space (with fix).
> >
> > I didn't do some of the core OSD stuff, though, namely
> >
> >  8438 ec objeccts are not cleaned up
> >  8701 scrub found obsolete rollback object
> >  7999 pgs share info that isn't persisted
> >  8733 crash in ECBackend::handle_sub_read
> >
> > Those are the 'pending backport' bugs at least; I suspect there are other
> > OSD fixes that should be included.
> >
> > I also didn't do any of the rgw patches, or the s3-tests.
> >
> > Can you take a look at some point and put them in firefly-next?  I'd like
> > to get this point going through the firefly suite soon so that it bakes
> > there for as long as possible before the next point release.
> >
> > Thanks!
> > sage
> 
> 
