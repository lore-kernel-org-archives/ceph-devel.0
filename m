From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: monitor crashing
Date: Tue, 13 Oct 2015 06:41:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510130637450.6589@cobra.newdream.net>
References: <CACx0BdM2qsO0n492Y7R=+FBfJzJT+4HxbBYaU1rkG0mZV=caJw@mail.gmail.com> <CACx0BdNRPk64Etwvs7_tEce=xwFw7E4Ube=8raav_-EFhhP2Fw@mail.gmail.com> <CACx0BdMi79jokSX4aPy9XJrUorE-2Fa-_oBDjYwW3bBuee5A7g@mail.gmail.com> <alpine.DEB.2.00.1510130624270.6589@cobra.newdream.net>
 <CACx0BdOOY0k02kJSacm_rHgBz0wLKv0YtganjuGy9Vtj63QVPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42649 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbbJMNlM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 09:41:12 -0400
In-Reply-To: <CACx0BdOOY0k02kJSacm_rHgBz0wLKv0YtganjuGy9Vtj63QVPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Periquito <periquito@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 13 Oct 2015, Luis Periquito wrote:
> the store.db dir is 3.4GB big :(
> 
> can I do it on my side?

Nevermind, I was able to reproduce it from the bugzilla.  I've pushed a 
branch wip-ecpool-hammer.  Not sure which distro you're on, but packages 
will appear at gitbuilder.ceph.com in 30-45 minutes.  This fixes the mon 
crash, which will let you delete the pool.  I suggest stopping the OSDs 
before starting the mon with this or else they might get pg create 
messages and crash too.  Once the pool is removed you can start them 
again.  They shouldn't need to be upgraded.

Note that the latest hammer doesn't let you create the pool at all because 
it fails the crush safety check (I had to disable the check to reproduce 
this), so that's good at least!

sage

> 
> On Tue, Oct 13, 2015 at 2:25 PM, Sage Weil <sage@newdream.net> wrote:
> > On Tue, 13 Oct 2015, Luis Periquito wrote:
> >> Any ideas? I'm growing desperate :(
> >>
> >> I've tried compiling from source, and including
> >> https://github.com/ceph/ceph/pull/5276, but it still crashes on boot
> >> of the ceph-mon
> >
> > If you can email a (link to a) tarball of your mon data directory I'd love
> > to extract the osdmap and see why crush is crashing.. it's obviously not
> > supposed to do that (even with a bad rule).  You can also use
> > the ceph-post-file utility.
> >
> > Thanks!
> > sage
> >
> >
> >>
> >> ---------- Forwarded message ----------
> >> From: Luis Periquito <periquito@gmail.com>
> >> Date: Tue, Oct 13, 2015 at 12:26 PM
> >> Subject: Re: monitor crashing
> >> To: Ceph Users <ceph-users@lists.ceph.com>
> >>
> >>
> >> I'm currently running Hammer (0.94.3), created an invalid LRC profile
> >> (typo in the l=, should have been l=4 but was l=3, and now I don't
> >> have enough different ruleset-locality) and created a pool. Is there
> >> any way to delete this pool? remember I can't start the ceph-mon...
> >>
> >> On Tue, Oct 13, 2015 at 11:56 AM, Luis Periquito <periquito@gmail.com> wrote:
> >> > It seems I've hit this bug:
> >> > https://bugzilla.redhat.com/show_bug.cgi?id=1231630
> >> >
> >> > is there any way I can recover this cluster? It worked in our test
> >> > cluster, but crashed the production one...
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
