From: Sage Weil <sweil@redhat.com>
Subject: Re: snap_trimming + backfilling is inefficient with many
 purged_snaps
Date: Fri, 19 Sep 2014 08:19:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net>
References: <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com> <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch> <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com> <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com> <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com> <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com> <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net>
 <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com> <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net> <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com> <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch>
 <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44118 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbaISPTk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 11:19:40 -0400
In-Reply-To: <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <daniel.vanderster@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Florian Haas <florian@hastexo.com>

On Fri, 19 Sep 2014, Dan van der Ster wrote:
> On Fri, Sep 19, 2014 at 10:41 AM, Dan Van Der Ster
> <daniel.vanderster@cern.ch> wrote:
> >> On 19 Sep 2014, at 08:12, Florian Haas <florian@hastexo.com> wrote:
> >>
> >> On Fri, Sep 19, 2014 at 12:27 AM, Sage Weil <sweil@redhat.com> wrote:
> >>> On Fri, 19 Sep 2014, Florian Haas wrote:
> >>>> Hi Sage,
> >>>>
> >>>> was the off-list reply intentional?
> >>>
> >>> Whoops!  Nope :)
> >>>
> >>>> On Thu, Sep 18, 2014 at 11:47 PM, Sage Weil <sweil@redhat.com> wrote:
> >>>>>> So, disaster is a pretty good description. Would anyone from the core
> >>>>>> team like to suggest another course of action or workaround, or are
> >>>>>> Dan and I generally on the right track to make the best out of a
> >>>>>> pretty bad situation?
> >>>>>
> >>>>> The short term fix would probably be to just prevent backfill for the time
> >>>>> being until the bug is fixed.
> >>>>
> >>>> As in, osd max backfills = 0?
> >>>
> >>> Yeah :)
> >>>
> >>> Just managed to reproduce the problem...
> >>>
> >>> sage
> >>
> >> Saw the wip branch. Color me freakishly impressed on the turnaround. :) Thanks!
> >
> > Indeed :) Thanks Sage!
> > wip-9487-dumpling fixes the problem on my test cluster. Trying in prod now?
> 
> Final update, after 4 hours in prod and after draining 8 OSDs -- zero
> slow requests :)

That's great news!

But, please be careful.  This code hasn't been reiewed yet or been through 
any testing!  I would hold off on further backfills until it's merged.

Thanks!
sage
