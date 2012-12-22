From: Sage Weil <sage@inktank.com>
Subject: Re: mon not marking dead osds down and slow streaming write
 performance
Date: Sat, 22 Dec 2012 07:56:10 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212220752450.32156@cobra.newdream.net>
References: <CABf87Xk54Q-SP2258MsXDVKAo2TgjOw8xds2f9W=XxmgdSRFTA@mail.gmail.com> <alpine.DEB.2.00.1212201046050.16508@cobra.newdream.net> <CABf87XmB9qgusXdSgfPD9qnDtMuCyFtWk_tyX8h8=fSZGs6=Ag@mail.gmail.com> <alpine.DEB.2.00.1212201633590.16508@cobra.newdream.net>
 <CABf87X=qV1uVRi8=N1tjh7gbXpb=Uk07hqwyXOR2SAFHtE-jfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46571 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2LVP4L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Dec 2012 10:56:11 -0500
In-Reply-To: <CABf87X=qV1uVRi8=N1tjh7gbXpb=Uk07hqwyXOR2SAFHtE-jfA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Chapman <michael.chapman@anu.edu.au>
Cc: ceph-devel@vger.kernel.org

On Sat, 22 Dec 2012, Michael Chapman wrote:
> On Fri, Dec 21, 2012 at 11:37 AM, Sage Weil <sage@inktank.com> wrote:
> > On Fri, 21 Dec 2012, Michael Chapman wrote:
> >> I'll remove them properly. Thanks for your help. Do you have any
> >> suggestions on the second (mon IO) issue I'm seeing?
> >
> > Whoops, missed it:
> >
> >> >> A second issue I have been having is that my reads+writes are very
> >> >> bursty, going from 8MB/s to 200MB/s when doing a dd from a physical
> >> >> client over 10GbE. It seems to be waiting on the mon most of the time,
> >> >> and iostat shows long io wait times for the disk the mon is using. I
> >> >> can also see it writing ~40MB/s constantly to disk in iotop, though I
> >> >> don't know if this is random or sequential. I see a lot of waiting for
> >> >> sub ops which I thought might be a result of the io wait.
> >> >>
> >> >> Is that a normal amount of activity for a mon process? Should I be
> >> >> running the mon processes off more than just a single sata disk to
> >> >> keep up with ~30 OSD processes?
> >
> > Is the ceph-mon daemon running on its own disk (or /), separate from the
> > osds?  My first guess is that this is could be a sync(2) issue.
> 
> It's on /
> Is that going to be bad? My first thought was that maybe too much
> logging was bringing it down but there's very little iops in the log
> directory during use.

/ should be fine, as long as the ceph-osd's are on their own disk.  My 
next guess is that there might be a lot of logging going on, but I guess 
that's not it either.

Long iowait on / isn't necessarily bad.  The mon is doing an fsync on 
every write, which is not going to be very fast.  There aren't too many 
writes, though.

The bursty write behavior may be unrelated to the mons.  Just to be sure, 
you could mark the osds on the ceph-mon nodes 'out' (ceph osd out 1 2 3 
...) so that they are not being used and see if the burstiness is still 
there...

sage
