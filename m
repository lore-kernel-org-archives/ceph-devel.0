From: Sage Weil <sage@newdream.net>
Subject: Re: auto stop of scrubbing and deep scrubbing while backfilling or
 recovering
Date: Tue, 8 Nov 2016 20:30:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611082029590.29278@piezo.us.to>
References: <bcfd3f34-dcd2-9d6d-52ef-1d39e9f54593@profihost.ag> <1789831527.1558.1478604945320@ox.pcextreme.nl> <alpine.DEB.2.11.1611081415550.32512@piezo.us.to> <1661441329.1631.1478628592614@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57958 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933110AbcKHUaQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 15:30:16 -0500
In-Reply-To: <1661441329.1631.1478628592614@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel@vger.kernel.org

On Tue, 8 Nov 2016, Wido den Hollander wrote:
> > Op 8 november 2016 om 15:19 schreef Sage Weil <sage@newdream.net>:
> > 
> > 
> > On Tue, 8 Nov 2016, Wido den Hollander wrote:
> > > > Op 8 november 2016 om 9:35 schreef Stefan Priebe - Profihost AG <s.priebe@profihost.ag>:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > i'm wondering if anybody has already thought about automatically
> > > > stopping srub and deep-scrub in case of backfilling or recovering. I've
> > > > seen several situations where scrubbing massivly raises the latency
> > > > while doing backfilling or recovering.
> > > > 
> > > 
> > > Seems like a sane change to me, but maybe a dev has a better option. I 
> > > don't think a stop is easy, but a 'noscrub' flag could be set inside the 
> > > OSD.
> > > 
> > > Maybe a config option: osd_scrub_during_recovery
> > > 
> > > Defaults to true, but can be set to false by the admin.
> > > 
> > > Before a scrub starts the OSD will check if there is recovery / 
> > > backfilling active on the OSD and if so it will not initiate the scrub.
> > 
> > Yeah, it seems reasonable.  I think there are two basic options:
> > 
> > - Disable scrubbing locally on each OSD if it has scrubbing PGs.  Two 
> > unrelated OSDs would be free to scrub and backfill at the same time.
> > 
> > - Disable scrubbing globally if any pgs are backfilling.  The reasoning 
> > here is that if backfilling is increasing the latency on some PGs, we 
> > don't want to increase the latency on others (by scrubbing) too.
> > 
> > The other consideration is that if backfil is happening it probably 
> > doesn't mean we want to prevent scrubbing indefinitely.  Instead, I'd 
> > suggest increasing the scrub intervals by some factor (e.g., 2x).
> > 
> > The first option would probably be a change in the scrub scheduling in 
> > the OSD.
> > 
> 
> I would go for the first one. Imagine a large cluster where one backfill is busy, that would otherwise halt all scrubs while only a few OSDs are involved.
> 
> Option one isn't that hard to implement either I think.

I added a card to trello: https://trello.com/b/ugTc2QFH/ceph-backlog

Thanks!
sage
