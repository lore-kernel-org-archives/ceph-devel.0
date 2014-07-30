From: Sage Weil <sweil@redhat.com>
Subject: Re: giant and hammer dates
Date: Wed, 30 Jul 2014 09:15:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407300905400.5022@cobra.newdream.net>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net> <CAPYLRzgv8m-7LzQBgcGafwOw3SWjn_wVBh7L_+vMnwtRFUYz7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58596 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbaG3QPT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 12:15:19 -0400
In-Reply-To: <CAPYLRzgv8m-7LzQBgcGafwOw3SWjn_wVBh7L_+vMnwtRFUYz7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 30 Jul 2014, Gregory Farnum wrote:
> On Tue, Jul 29, 2014 at 7:11 PM, Sage Weil <sweil@redhat.com> wrote:
> > We've talked a bit about moving to a ~4 month (instead of 3 month)
> > cadence.  I'm still inclined in this direction because it means fewer
> > stable releases that we will be maintaining and a longer and (hopefully)
> > more productive interval to do real work in between.
> >
> > The other key point is that we don't want a repeat of the firefly delay.
> > I think we should stay as close to a train model as we can.  If something
> > isn't ready by freeze, let it wait for the next cycle.  We shouldn't be
> > cramming things in at the end, especially big things.  As a general rule,
> > big things should be merged early in the cycle so that we have lots of
> > time to shake out the issues that only come out of lots of testing and
> > aren't obvious from code review.
> 
> These two points are sort of opposing. In particular, extending the
> release cycle just makes the release seem more important, and
> increases the pressure to merge features in one cycle instead of
> waiting for the next one. (*Especially* if we continue to maintain
> every other named release.)

That's a really good point.  However, I think it's not the frequency of 
stabilization periods but the frequency of stable releases that's in 
conflict with the pressure to merge.  If we maintain every other release, 
then every other release will have that pressure--even greater, because 
it'll be 6 months before the next one.  And if we aren't maintaining the 
odd releases for any significant period, I'm not sure its worth naming 
them and confusing users about which release they should be running.

Basically, I think the trade-off is merge pressure vs backporting and 
upgrade testing work...

> I continue to prefer a 3-month cycle where we maintain enough merging
> discipline that the follow-on one-month shakeout period is something
> that the development team largely doesn't have to worry about, because
> the code is already working *before* we start it and we're just
> uncovering rare and longer-term bugs during that period.

I like the idea of doing more frequent stabilization sprints to keep 
things in good order instead of deferring that until the end of the 
release cycle.

sage
