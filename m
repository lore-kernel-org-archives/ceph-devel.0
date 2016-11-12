From: Wido den Hollander <wido@42on.com>
Subject: Re: auto stop of scrubbing and deep scrubbing while backfilling or
 recovering
Date: Sat, 12 Nov 2016 17:56:29 +0100 (CET)
Message-ID: <848942188.1988.1478969789844@ox.pcextreme.nl>
References: <bcfd3f34-dcd2-9d6d-52ef-1d39e9f54593@profihost.ag>
 <1789831527.1558.1478604945320@ox.pcextreme.nl>
 <alpine.DEB.2.11.1611081415550.32512@piezo.us.to>
 <1661441329.1631.1478628592614@ox.pcextreme.nl>
 <alpine.DEB.2.11.1611082029590.29278@piezo.us.to>
 <934460932.1738.1478704756331@ox.pcextreme.nl>
 <735474017.1981.1478961603922@ox.pcextreme.nl>
 <326EEDF4-BACC-4CA8-BF3E-5B1BB87CA042@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:44912 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966401AbcKLQ4f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Nov 2016 11:56:35 -0500
In-Reply-To: <326EEDF4-BACC-4CA8-BF3E-5B1BB87CA042@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org


> Op 12 november 2016 om 16:13 schreef Stefan Priebe - Profihost AG <s.priebe@profihost.ag>:
> 
> 
> Great, does this apply for scrub AND deep scrub?
> 

Yes. No scrub will be scheduled when recovery is active. The sched_scrub function takes care of both types.

Wido

> Stefan
> 
> Excuse my typo sent from my mobile phone.
> 
> > Am 12.11.2016 um 15:40 schrieb Wido den Hollander <wido@42on.com>:
> > 
> > 
> >> Op 9 november 2016 om 16:19 schreef Wido den Hollander <wido@42on.com>:
> >> 
> >> 
> >> 
> >>> Op 8 november 2016 om 21:30 schreef Sage Weil <sage@newdream.net>:
> >>> 
> >>> 
> >>> On Tue, 8 Nov 2016, Wido den Hollander wrote:
> >>>>> Op 8 november 2016 om 15:19 schreef Sage Weil <sage@newdream.net>:
> >>>>> 
> >>>>> 
> >>>>> On Tue, 8 Nov 2016, Wido den Hollander wrote:
> >>>>>>> Op 8 november 2016 om 9:35 schreef Stefan Priebe - Profihost AG <s.priebe@profihost.ag>:
> >>>>>>> 
> >>>>>>> 
> >>>>>>> Hello,
> >>>>>>> 
> >>>>>>> i'm wondering if anybody has already thought about automatically
> >>>>>>> stopping srub and deep-scrub in case of backfilling or recovering. I've
> >>>>>>> seen several situations where scrubbing massivly raises the latency
> >>>>>>> while doing backfilling or recovering.
> >>>>>>> 
> >>>>>> 
> >>>>>> Seems like a sane change to me, but maybe a dev has a better option. I 
> >>>>>> don't think a stop is easy, but a 'noscrub' flag could be set inside the 
> >>>>>> OSD.
> >>>>>> 
> >>>>>> Maybe a config option: osd_scrub_during_recovery
> >>>>>> 
> >>>>>> Defaults to true, but can be set to false by the admin.
> >>>>>> 
> >>>>>> Before a scrub starts the OSD will check if there is recovery / 
> >>>>>> backfilling active on the OSD and if so it will not initiate the scrub.
> >>>>> 
> >>>>> Yeah, it seems reasonable.  I think there are two basic options:
> >>>>> 
> >>>>> - Disable scrubbing locally on each OSD if it has scrubbing PGs.  Two 
> >>>>> unrelated OSDs would be free to scrub and backfill at the same time.
> >>>>> 
> >>>>> - Disable scrubbing globally if any pgs are backfilling.  The reasoning 
> >>>>> here is that if backfilling is increasing the latency on some PGs, we 
> >>>>> don't want to increase the latency on others (by scrubbing) too.
> >>>>> 
> >>>>> The other consideration is that if backfil is happening it probably 
> >>>>> doesn't mean we want to prevent scrubbing indefinitely.  Instead, I'd 
> >>>>> suggest increasing the scrub intervals by some factor (e.g., 2x).
> >>>>> 
> >>>>> The first option would probably be a change in the scrub scheduling in 
> >>>>> the OSD.
> >>>>> 
> >>>> 
> >>>> I would go for the first one. Imagine a large cluster where one backfill is busy, that would otherwise halt all scrubs while only a few OSDs are involved.
> >>>> 
> >>>> Option one isn't that hard to implement either I think.
> >>> 
> >>> I added a card to trello: https://trello.com/b/ugTc2QFH/ceph-backlog
> >>> 
> >> 
> >> Wouldn't this be enough?
> >> 
> >> https://github.com/ceph/ceph/pull/11874
> > 
> > Merged! See: https://github.com/ceph/ceph/commit/9100d3362a9ffdd26afc7ee1962c013931cc9e58
> > 
> > By setting osd_scrub_during_recovery to false (defaults to true) you can disable scrubs while recovery threads are active.
> > 
> > This means no NEW scrub will be iniated by the OSD while there are recovery ops active. Any running scrubs will keep running.
> > 
> > Wido 
> > 
> >> 
> >> Wido
> >> 
> >>> Thanks!
> >>> sage
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
