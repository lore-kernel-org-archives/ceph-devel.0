From: Sage Weil <sweil@redhat.com>
Subject: Re: snap_trimming + backfilling is inefficient with many
 purged_snaps
Date: Thu, 18 Sep 2014 15:27:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com> <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch> <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com> <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com> <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com> <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net>
 <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38126 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbaIRW1H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 18:27:07 -0400
In-Reply-To: <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, ceph-devel@vger.kernel.org

On Fri, 19 Sep 2014, Florian Haas wrote:
> Hi Sage,
> 
> was the off-list reply intentional?

Whoops!  Nope :)

> On Thu, Sep 18, 2014 at 11:47 PM, Sage Weil <sweil@redhat.com> wrote:
> >> So, disaster is a pretty good description. Would anyone from the core
> >> team like to suggest another course of action or workaround, or are
> >> Dan and I generally on the right track to make the best out of a
> >> pretty bad situation?
> >
> > The short term fix would probably be to just prevent backfill for the time
> > being until the bug is fixed.
> 
> As in, osd max backfills = 0?

Yeah :)

Just managed to reproduce the problem...

sage

> > The root of the problem seems to be that it is trying to trim snaps that
> > aren't there.  I'm trying to reproduce the issue now!  Hopefully the fix
> > is simple...
> >
> >         http://tracker.ceph.com/issues/9487
> >
> > Thanks!
> > sage
> 
> Thanks. :)
> 
> Cheers,
> Florian
> 
> 
