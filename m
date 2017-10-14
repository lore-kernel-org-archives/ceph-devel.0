From: Sage Weil <sweil@redhat.com>
Subject: Re: removed_snaps
Date: Sat, 14 Oct 2017 15:56:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710141549170.26702@piezo.us.to>
References: <alpine.DEB.2.11.1710111556410.26702@piezo.us.to> <CAJ4mKGaw-6Yu5pK97r0GK5q2_Kt=O2d6SG9um+Xvr8JdAKX88A@mail.gmail.com> <alpine.DEB.2.11.1710111841060.26702@piezo.us.to> <CAJ4mKGZbPjKNchv+cqcx_uRhb3GtX5D7ZNj-0UHTapbaHascrQ@mail.gmail.com>
 <alpine.DEB.2.11.1710121354490.26702@piezo.us.to> <CAJ4mKGYxQO7QErAkwaaOjrV48M5k-0RVHscn2gjKYs0T3qMyLA@mail.gmail.com> <alpine.DEB.2.11.1710132052540.26702@piezo.us.to> <CAJ4mKGaauoPR9KnHBhp2C50qBypy4q=Sa7pA-WF-BXeNfBAOXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753759AbdJNP45 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 14 Oct 2017 11:56:57 -0400
In-Reply-To: <CAJ4mKGaauoPR9KnHBhp2C50qBypy4q=Sa7pA-WF-BXeNfBAOXQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Mclean, Patrick" <Patrick.Mclean@sony.com>

On Fri, 13 Oct 2017, Gregory Farnum wrote:
> On Fri, Oct 13, 2017 at 2:32 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Fri, 13 Oct 2017, Gregory Farnum wrote:
> >> Moving on to the stuff actually written down:
> >> How comfortable are we with the size of the currently-deleting
> >> snapshots maps, for computation purposes? I don't have a good way of
> >> quantifying that cost but I'm definitely tempted to split the sets
> >> into
> >> newly_deleted_snaps (for *this epoch*)
> >> deleting_snaps (which are kept around until removed_snaps_lb_epoch)
> >> newly_purged_snaps (also for this epoch, which I think is how you have
> >> it written?)
> >
> > The code I have now has 2 sets: removed_snaps and purged_snaps.
> > purged_snapd was already there before; removed_snaps is the superset that
> > includes stuff not yet purged.  (I made it a superset thinking that
> > the filter_snapc() thing on every op will be faster if it only has to
> > filter against a single set instead of 2 of them, and that matters more
> > than the memory.)
> 
> No, what I mean is:
> * we know that computing the overlap of interval sets can be expensive
> * so we want to only compute overlaps of small sets
> * this is especially true if we're doing it on all outstanding
> operations in librados, within a single thread
> 
> So we definitely don't want to repeat comparisons if we don't have to.
> And I suspect there will be occasional periods of intense snapshot
> deletion from admins where they remove a number large enough to cause
> trouble, and we don't want that to result in noticeably slower IO
> submission on the client-side!
> 
> So we should have a separate set of snaps which were just added to the
> removed_snaps during this epoch, that librados and the OSD map
> processing can use in their normal-course-of-business scanning.

I definitely get that we want to avoid any set intersections (and I think 
the current code actually has only 1 of them, during peering activate).  
But I'm not quite following which lookup you're thinking of.  FTR 
filter_snapc iterates over the vector<snapid_t> in SnapContext and does an 
interval_set lookup on each one to make sure it isn't deleted.

I think there are basically two cases:

1- The request comes in with the same epoch as our epoch, and the mimic 
feature, so we could skip the filter_snapc entirely (client will have done 
it).  Yay!  Hopefully this will be true for most requests in steady state.

2- The request comes in with an older osdmap epoch, so we have to 
filter_snapc against the recent_removed_snaps interval_set<>.  This is 
what we do today, except instead of recent_removed_snaps we have 
removed_snaps_over_all_time, so we are going from a huge set to a 
relatively small one.

We could do something like

3- Maintain a small interval_set with a smaller range of epochs (e.g., 
only the last 20 epochs instead of the last 500) and filter against that 
if the request's epoch is recent enough.

or,

4- Remember the new_removed_snaps for the last N epochs and filter against 
them individually.  This turns into m log(n) lookups instead of one 
log(n*500) lookup (where m << 500)... probably a small win?

sage
