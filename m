From: Sage Weil <sweil@redhat.com>
Subject: Re: random thoughts on past_intervals
Date: Sat, 10 Dec 2016 00:42:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612100039370.5710@piezo.novalocal>
References: <CAN=+7FUSq49OxTbKNRO7xkay0MQAGyfZyBKnUnn+Nux-ysNVOA@mail.gmail.com> <CAN=+7FUBDFcDUVztaGh0xf2rU833HEM9ja2i1G5garSooEuJrw@mail.gmail.com> <alpine.DEB.2.11.1612092214330.5710@piezo.novalocal> <CAN=+7FWJ4J32dkNSmDrpVnUTcvwo6J1m14ON1COhcp5d_UrweQ@mail.gmail.com>
 <alpine.DEB.2.11.1612092323370.5710@piezo.novalocal> <CAN=+7FUPxEbMBkqXUgDCq_W0hkcvV2GvFkafLsS4qgX8zfb6zw@mail.gmail.com> <CAN=+7FWWCzVpB8MhAW57PbBkb_1pZUGj-Kj3WkOvL=mKccvw_Q@mail.gmail.com> <CAN=+7FWiTn+4sVNWf8dOGwLnAyB92+-Gfzxyu9H2GpRAD2hArA@mail.gmail.com>
 <alpine.DEB.2.11.1612100002460.5710@piezo.novalocal> <CAN=+7FW-zJLGro5KNmEv=t0m2xyVLfZML1b+U1miKvSR9eo8Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbcLJAmb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Dec 2016 19:42:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9064BC04B925
        for <ceph-devel@vger.kernel.org>; Sat, 10 Dec 2016 00:42:30 +0000 (UTC)
In-Reply-To: <CAN=+7FW-zJLGro5KNmEv=t0m2xyVLfZML1b+U1miKvSR9eo8Wg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 9 Dec 2016, Samuel Just wrote:
> Oh, I haven't gotten to that part yet.  I was referring to
> c7d92d1d3fe469f5e8e7c35185a670570c665029 which duplicates some of the
> logic in the PriorSet constructor to verify after we have the infos
> that every interval has at least one complete peer
> (last_backfill=max).  I think it mattered in early 2012 when backfill
> peers existed in the acting set, but now it is either unnecessary or
> better handled in choose_acting.

Oh I see.

If we don't have this check, then *somewhere else* we have to be verifying 
that we have at least one (that is !incomplete) from the last interval or 
else we can't be sure we aren't missing writes.  ...right?  My memory 
is hazy here.  I can't rmeember if there is a secondary effect wehre we 
can infer that we didn't go active in the later interval because the 
OSDs in the earlier interval haven't advanced last_epoch_started...

s



> ATM, I'm trying to prune down the number of questions asked of
> past_intervals to see how much I can leave out.


> -Sam
> 
> On Fri, Dec 9, 2016 at 4:04 PM, Sage Weil <sweil@redhat.com> wrote:
> > I'm not quite following.  The criterion I used before was that an interval
> > goes into past_intervals iff maybe_went_rw=true.  In this case, it would
> > be true; we wouldn't know what infos we get until partway through peering
> > anyway.
> >
> > (The other thing I did was, after the fact, filter out older intervals
> > that have duplicate up[_primary]/acting[_primary].)
> >
> > sage
> >
> > On Fri, 9 Dec 2016, Samuel Just wrote:
> >
> >> Yeah, I don't think it does.  If by some chance we only got an
> >> incomplete info from such an interval, it doesn't matter whether
> >> choose_acting skips it or not when determining the most recent active
> >> interval since it couldn't have changed last_epoch_started or
> >> history.last_epoch_started.  I think I can just kill that section.
> >> -Sam
> >>
> >> On Fri, Dec 9, 2016 at 3:41 PM, Samuel Just <sjust@redhat.com> wrote:
> >> > Currently trying to figure out whether
> >> > c7d92d1d3fe469f5e8e7c35185a670570c665029 matters (any interval where
> >> > acting contains an incomplete peer is could not have gone active,
> >> > right?)
> >> > -Sam
> >> >
> >> > On Fri, Dec 9, 2016 at 3:40 PM, Samuel Just <sjust@redhat.com> wrote:
> >> >> Yeah, that's pretty much where I'm going.
> >> >> -Sam
> >> >>
> >> >> On Fri, Dec 9, 2016 at 3:24 PM, Sage Weil <sweil@redhat.com> wrote:
> >> >>> On Fri, 9 Dec 2016, Samuel Just wrote:
> >> >>>> Currently, never.  However, I'm thinking that we might want to retain
> >> >>>> the freedom to not send the structure if it's really big.  And
> >> >>>> actually, we won't ever need to extend a received past_intervals
> >> >>>> structure to the current epoch since if the interval changed, we'd
> >> >>>> throw out the whole message.
> >> >>>
> >> >>> I'd say throw out the incremental build code, then, and assert
> >> >>> past_intervals is present at notify time; we can re-add something to
> >> >>> recalculate the whole past_intervals if it becomes necessary in the
> >> >>> future.
> >> >>>
> >> >>> sage
> >> >>>
> >> >>>
> >> >>>> -Sam
> >> >>>>
> >> >>>> On Fri, Dec 9, 2016 at 2:16 PM, Sage Weil <sweil@redhat.com> wrote:
> >> >>>> > On Fri, 9 Dec 2016, Samuel Just wrote:
> >> >>>> >> In particular, we don't need PG::generate_past_intervals duplicating
> >> >>>> >> the logic in build_past_intervals_parallel since constructed PG
> >> >>>> >> objects only ever need to maintain a consistent past_intervals
> >> >>>> >> structure, never build it from scratch.
> >> >>>> >
> >> >>>> > Sounds good to me.
> >> >>>> >
> >> >>>> > My main question is:
> >> >>>> >
> >> >>>> >> On Fri, Dec 9, 2016 at 11:59 AM, Samuel Just <sjust@redhat.com> wrote:
> >> >>>> >> > There's code for dealing with some odd past_intervals configurations
> >> >>>> >> > including doesn't go back far enough and doesn't go forward far
> >> >>>> >> > enough.  I *think* we can simplify this as follows:
> >> >>>> >> > 1) Once the PG object is constructed and in memory, past_intervals
> >> >>>> >> > extends from history.last_epoch_started to the PG's current map
> >> >>>> >> > 2) On disk, either 1) is true or the set is empty (after an import)
> >> >>>> >> >
> >> >>>> >> > On boot, the OSD generates past_intervals in parallel for any PGs
> >> >>>> >> > without them (and perhaps verifies 1) for the rest).  On receipt of a
> >> >>>> >> > Notify creating a PG, the OSD generates the past_intervals structure
> >> >>>> >> > before instantiating the PG using the same process as on boot --
> >> >>>> >> > starting with the included past_intervals if present (may not extend
> >> >>>> >> > to the current map, and so may need to be extended).
> >> >>>> >
> >> >>>> > When does this actually happen?  If PGs are always in state 1, can we
> >> >>>> > instead ensure that PG notify will always include past_intervals and that
> >> >>>> > a received notify will never require us to go off do the (slow) work of
> >> >>>> > loading up old maps to generate old intervals?
> >> >>>> >
> >> >>>> > Then, we can focus our efforts on make the past_intervals representation
> >> >>>> > compact (e.g., by discarding redundant intervals)...
> >> >>>> >
> >> >>>> > sage
> >> >>>> --
> >> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> >>>> the body of a message to majordomo@vger.kernel.org
> >> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >>>>
> >> >>>>
> >>
> >>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
