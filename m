From: Sage Weil <sage@newdream.net>
Subject: Re: throttling reweight-by-utilization
Date: Wed, 2 Mar 2016 14:15:36 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603021408350.1904@cpach.fuggernut.com>
References: <CABZ+qqmnOCvGa_=XRowxHy=Q-wRihxiTs2=bX1AsDuymvOUd3g@mail.gmail.com> <alpine.DEB.2.11.1601180859180.26381@cpach.fuggernut.com> <CABZ+qqkCZEZcj99sXQw_hZzaBbLAJyaO48MLbbrA6JVhNYEFOQ@mail.gmail.com>
 <CABZ+qq=Cdeq83=Fihp+3NvjGmvtUeZm=YygvJEO2XBd8PHrYhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57076 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbcCBTQD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2016 14:16:03 -0500
In-Reply-To: <CABZ+qq=Cdeq83=Fihp+3NvjGmvtUeZm=YygvJEO2XBd8PHrYhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Latest branch:

	https://github.com/liewegas/ceph/commits/wip-reweight

I made several changes:

- new command, 'osd utilization'

avg 51
stddev 0.707107 (expected baseline 6.68019)
min osd.3 with 52 pgs (1.01961 * mean)
max osd.3 with 50 pgs (0.980392 * mean)

(json version too)

- new commands: osd test-reweight-by-{pg,utilization}

same as osd reweight-by-*, but it doesn't actually to it--just shows the 
before and after stats:

no change
moved 2 / 408 (0.490196%)
avg 51
stddev 5.26783 -> 4.74342 (expected baseline 6.68019)
min osd.3 with 59 -> 57 pgs (1.15686 -> 1.11765 * mean)
max osd.3 with 41 -> 42 pgs (0.803922 -> 0.823529 * mean)

oload 105
max_change 0.05
average 51.000000
overload 53.550000
osd.3 weight 1.000000 -> 0.950012
osd.2 weight 1.000000 -> 0.950012


I'm mostly happy with it, but there are a couple annoying problems:

1) Adding the --no-increasing option (which prevents us from 
weighting things up) effectively breaks the cli parsing for the optional 
pool arguments for reweight-by-pg.  I'm not sure which is more useful; I 
don't think I'd use either one.

2) The stats are all based on pg counts.  It might be possible to estimate 
new stats using the pgmap and estimating storage overhead and a bunch 
of other ugly hackery so that the rewieght-by-utilization case would show 
stats in terms of bytes, but it'd be a lot of work, and I don't think it's 
worth it.  That means that even though the reweight-by-utilization 
adjsutments are done based on actual osd utilizations, the 
before/after stats it shows are in terms of pgs.

Thoughts?
sage



On Tue, 1 Mar 2016, Dan van der Ster wrote:

> Hi Sage,
> I have a wip here: https://github.com/cernceph/ceph/commits/wip-reweight
> I still need to spin up a small test cluster to test it.
> -- Dan
> 
> On Mon, Jan 18, 2016 at 4:25 PM, Dan van der Ster <dan@vanderster.com> wrote:
> > On Mon, Jan 18, 2016 at 3:06 PM, Sage Weil <sage@newdream.net> wrote:
> >> On Mon, 18 Jan 2016, Dan van der Ster wrote:
> >>> Hi,
> >>>
> >>> I'd like to propose a few changes to reweight-by-utilization which
> >>> will make it significantly less scary:
> >>>
> >>> 1. Change reweight-by-utilization to run in "dry run" -- display only
> >>> -- mode unless an admin runs with  --yes-i-really-really-mean-it. This
> >>> way admins can see what will be reweighted before committing to any
> >>> changes.
> >>
> >> I think this piece is key, and there is a lot we might do here to make
> >> this more informative.  In particular, we have the (approx) sizes of each
> >> PG(*) and can calculate their mapping after the proposed change, which
> >> means we could show the min/max utilization, standard deviation, and/or
> >> number of nearfull or full OSDs before and after.
> >>
> >
> > I hadn't thought of that, but it would be cool.
> > My main use of the dry-run functionality is to ensure that it's not
> > going to change too many OSDs at once (IOW letting me try different
> > oload and pool values). Maybe some users want to make a large change
> > all in one go -- in that case this would be useful.
> >
> >
> >> * Almost... we don't really know how many bytes of key/value omap data are
> >> consumed.  So we could either go by the user data accounting, which is a
> >> lower bound, or average the OSD utilization by the PGs it stores
> >> (averaging pools together), or try do the same for just the difference
> >> (which would presumably be omap data + overall overhead).
> >>
> >> I'm not sure how much it is worth trying to be accurate here...
> >>
> >>> 2. Add a configurable to limit the number of OSDs changed per execution:
> >>>   mon_reweight_max_osds_changed (default 4)
> >>>
> >>> 3. Add a configurable to limit the weight changed per OSD:
> >>>   mon_reweight_max_weight_change (default 0.05)
> >>>
> >>> Along with (2) and (3), the main loop in reweight_by_utilization:
> >>>   https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L568
> >>> needs to sort the OSDs by utilization.
> >>>
> >>> 4. Make adjusting weights up optional with a new CLI option
> >>> --adjust-up. This is useful because if you have nearly full OSDs you
> >>> want to prioritize making space on those OSDs.
> >>
> >> These sound reasonable to me.  Although, in general, if we ultimately want
> >> people do to this regularly via cron or something, we'll need --adjust-up.
> >> I wonder if there is some other way it should be biased so that we weight
> >> the overfull stuff down before weighting the underfull stuff up.  Maybe
> >> the max_osds_changed already mostly does that by doing the fullest osds
> >> first?
> >
> > One other reason we need to be able to disable --adjust-up is for
> > non-flat crush trees, where some OSDs get more PGs because of a non
> > trivial ruleset. reweight-by-pg helps in this case, but its still not
> > perfect for all crush layouts. For example, we have a ruleset which
> > puts two replicas in one root and a third replica in another root...
> > this is difficult for the reweight-by-* function to get right. One
> > solution to this which I haven't yet tried is to add a --bucket option
> > to reweight-by-* which only looks at OSDs under a given point in the
> > tree.
> >
> > -- Dan
> >
> >
> >
> >> Thanks, Dan!
> >> sage
> >>
> >>
> >>
> >>> I have already been running with these options in a python prototype:
> >>>   https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py
> >>>
> >>> If you agree I'll port these changes to OSDMonitor.cc and send a PR.
> >>>
> >>> Best Regards,
> >>> Dan
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
