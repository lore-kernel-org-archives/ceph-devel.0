From: Sage Weil <sage@newdream.net>
Subject: Re: throttling reweight-by-utilization
Date: Mon, 18 Jan 2016 09:06:19 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601180859180.26381@cpach.fuggernut.com>
References: <CABZ+qqmnOCvGa_=XRowxHy=Q-wRihxiTs2=bX1AsDuymvOUd3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41878 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbcAROGN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jan 2016 09:06:13 -0500
In-Reply-To: <CABZ+qqmnOCvGa_=XRowxHy=Q-wRihxiTs2=bX1AsDuymvOUd3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 18 Jan 2016, Dan van der Ster wrote:
> Hi,
> 
> I'd like to propose a few changes to reweight-by-utilization which
> will make it significantly less scary:
> 
> 1. Change reweight-by-utilization to run in "dry run" -- display only
> -- mode unless an admin runs with  --yes-i-really-really-mean-it. This
> way admins can see what will be reweighted before committing to any
> changes.

I think this piece is key, and there is a lot we might do here to make 
this more informative.  In particular, we have the (approx) sizes of each 
PG(*) and can calculate their mapping after the proposed change, which 
means we could show the min/max utilization, standard deviation, and/or 
number of nearfull or full OSDs before and after.

* Almost... we don't really know how many bytes of key/value omap data are 
consumed.  So we could either go by the user data accounting, which is a 
lower bound, or average the OSD utilization by the PGs it stores 
(averaging pools together), or try do the same for just the difference 
(which would presumably be omap data + overall overhead).

I'm not sure how much it is worth trying to be accurate here...

> 2. Add a configurable to limit the number of OSDs changed per execution:
>   mon_reweight_max_osds_changed (default 4)
> 
> 3. Add a configurable to limit the weight changed per OSD:
>   mon_reweight_max_weight_change (default 0.05)
> 
> Along with (2) and (3), the main loop in reweight_by_utilization:
>   https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L568
> needs to sort the OSDs by utilization.
> 
> 4. Make adjusting weights up optional with a new CLI option
> --adjust-up. This is useful because if you have nearly full OSDs you
> want to prioritize making space on those OSDs.

These sound reasonable to me.  Although, in general, if we ultimately want 
people do to this regularly via cron or something, we'll need --adjust-up.  
I wonder if there is some other way it should be biased so that we weight 
the overfull stuff down before weighting the underfull stuff up.  Maybe 
the max_osds_changed already mostly does that by doing the fullest osds 
first?

Thanks, Dan!
sage



> I have already been running with these options in a python prototype:
>   https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py
> 
> If you agree I'll port these changes to OSDMonitor.cc and send a PR.
> 
> Best Regards,
> Dan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
