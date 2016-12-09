From: Sage Weil <sweil@redhat.com>
Subject: Re: random thoughts on past_intervals
Date: Fri, 9 Dec 2016 23:24:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612092323370.5710@piezo.novalocal>
References: <CAN=+7FUSq49OxTbKNRO7xkay0MQAGyfZyBKnUnn+Nux-ysNVOA@mail.gmail.com> <CAN=+7FUBDFcDUVztaGh0xf2rU833HEM9ja2i1G5garSooEuJrw@mail.gmail.com> <alpine.DEB.2.11.1612092214330.5710@piezo.novalocal>
 <CAN=+7FWJ4J32dkNSmDrpVnUTcvwo6J1m14ON1COhcp5d_UrweQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752380AbcLIXYc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 9 Dec 2016 18:24:32 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C937D31B32C
        for <ceph-devel@vger.kernel.org>; Fri,  9 Dec 2016 23:24:31 +0000 (UTC)
In-Reply-To: <CAN=+7FWJ4J32dkNSmDrpVnUTcvwo6J1m14ON1COhcp5d_UrweQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 9 Dec 2016, Samuel Just wrote:
> Currently, never.  However, I'm thinking that we might want to retain
> the freedom to not send the structure if it's really big.  And
> actually, we won't ever need to extend a received past_intervals
> structure to the current epoch since if the interval changed, we'd
> throw out the whole message.

I'd say throw out the incremental build code, then, and assert 
past_intervals is present at notify time; we can re-add something to 
recalculate the whole past_intervals if it becomes necessary in the 
future.

sage


> -Sam
> 
> On Fri, Dec 9, 2016 at 2:16 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Fri, 9 Dec 2016, Samuel Just wrote:
> >> In particular, we don't need PG::generate_past_intervals duplicating
> >> the logic in build_past_intervals_parallel since constructed PG
> >> objects only ever need to maintain a consistent past_intervals
> >> structure, never build it from scratch.
> >
> > Sounds good to me.
> >
> > My main question is:
> >
> >> On Fri, Dec 9, 2016 at 11:59 AM, Samuel Just <sjust@redhat.com> wrote:
> >> > There's code for dealing with some odd past_intervals configurations
> >> > including doesn't go back far enough and doesn't go forward far
> >> > enough.  I *think* we can simplify this as follows:
> >> > 1) Once the PG object is constructed and in memory, past_intervals
> >> > extends from history.last_epoch_started to the PG's current map
> >> > 2) On disk, either 1) is true or the set is empty (after an import)
> >> >
> >> > On boot, the OSD generates past_intervals in parallel for any PGs
> >> > without them (and perhaps verifies 1) for the rest).  On receipt of a
> >> > Notify creating a PG, the OSD generates the past_intervals structure
> >> > before instantiating the PG using the same process as on boot --
> >> > starting with the included past_intervals if present (may not extend
> >> > to the current map, and so may need to be extended).
> >
> > When does this actually happen?  If PGs are always in state 1, can we
> > instead ensure that PG notify will always include past_intervals and that
> > a received notify will never require us to go off do the (slow) work of
> > loading up old maps to generate old intervals?
> >
> > Then, we can focus our efforts on make the past_intervals representation
> > compact (e.g., by discarding redundant intervals)...
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
