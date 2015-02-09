From: Sage Weil <sweil@redhat.com>
Subject: RE: scrub scheduling
Date: Mon, 9 Feb 2015 02:24:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502090222120.5710@cobra.newdream.net>
References: <alpine.DEB.2.00.1502081318090.5713@cobra.newdream.net> <BLU175-W7A98B2231FED626F80689DF270@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57364 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760050AbbBIKYi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Feb 2015 05:24:38 -0500
In-Reply-To: <BLU175-W7A98B2231FED626F80689DF270@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "simon.leinen@gmail.com" <simon.leinen@gmail.com>

On Mon, 9 Feb 2015, GuangYang wrote:
> Hi Sage,
> Another potential problem with scrub scheduling, as observed in our 
> deployment (2PB cluster, 70% full), was that some PGs hadn't been 
> scrubbed for 1.5 months, even we have the configuration to do deep 
> scrubbing weekly.
> 
> With our deployment and percentage of full of the cluster, as well as 
> the conservative setting for scrubbing (osd_max_scrubs = 1), one round 
> of scrubbing would not finish in 1 one week, so that we properly should 
> schedule that monthly (with weekly shallow scrubbing).

This is simply a function of the amount of data and speed of the backend, 
right?  Nothing we can fix in Ceph?

> Another problem, is that currently the scheduling of scrub is optimized 
> locally at each OSD, that is, for each PG this OSD acts as the primary, 
> it selects the one which hasn't been scheduled to scrubbing longest, put 
> it as the candidate and request scrub reserver from all replicas. Since 
> each OSD can only have 1 active scrubbing, that active slot could 
> potentially always occupied by a replica, as a result, the PG whose 
> primary is this OSD, fail to schedule and left behind.
>
> Is this issue worth an enhancement?

Good point.  Yeah, I think it's definitely worth fixing!

sage

> 
> Thanks,
> Guang
> 
> 
> ----------------------------------------
> > Date: Sun, 8 Feb 2015 13:38:28 -0800
> > From: sweil@redhat.com
> > To: ceph-devel@vger.kernel.org
> > CC: simon.leinen@gmail.com
> > Subject: scrub scheduling
> >
> > Simon Leinen at Switch did a greaet post recently about the impact of
> > scrub on their cluster(s):
> >
> > http://blog.simon.leinen.ch/2015/02/ceph-deep-scrubbing-impact.html
> >
> > Basically the 2 week deep scrub interval kicks in on exactly a 2 week
> > cycle and the cluster goes crazy for a few hours and then does nothing
> > (but client IO) for the next two weeks.
> >
> > The options governing this are:
> >
> > OPTION(osd_scrub_min_interval, OPT_FLOAT, 60*60*24) // if load is low
> > OPTION(osd_scrub_max_interval, OPT_FLOAT, 7*60*60*24) // regardless of load
> > OPTION(osd_deep_scrub_interval, OPT_FLOAT, 60*60*24*7) // once a week
> > OPTION(osd_scrub_load_threshold, OPT_FLOAT, 0.5)
> >
> > That is, if the load is < .5 (probably almost never on a real cluster) it
> > will scrub every day, otherwise (regardless of load) it will scrub each PG
> > at least once a week.
> >
> > Several things we can do here:
> >
> > 1- Maybe the shallow scrub interval should be less than the deep scrub
> > interval?
> >
> > 2- There is a new feature for hammer that limits scrub to certain times of
> > day, contributed by Xinze Chi:
> >
> > OPTION(osd_scrub_begin_hour, OPT_INT, 0)
> > OPTION(osd_scrub_end_hour, OPT_INT, 24)
> >
> > That is, by default, scrubs can happen at any time. You can use this to
> > limit to certain hour sof the night, or whatever is appropriate for your
> > cluster. That only sort of helps, though; Simon's scrub frenzy will still
> > happen one day a week, all at once (or maybe spread over 2 nights).
> >
> > 3- We can spread them out during the allowed window. But how to do that?
> > We could make the scrub interval randomly +/- a value of up to 50% of the
> > total interval. Or we could somehow look at the current rate of scrubbing
> > (average time to completeion for the current pool, maybe).. any look at
> > the total number of items in the scrub queue?
> >
> > 4- Ric pointed out to me that even if we spread these out, scrubbing at
> > full speed has an impact. Even if we do all the prioritization magic we
> > can there will still be a buch of large IOs in the queue. What if we have
> > a hard throttle on the scrub rate, objects per second and/or bytes per
> > second? In the end the same number of IOs traverse the queue and
> > potentially interfere with client IO, but they would be spread out over a
> > longer period of time and be less noticeable (i.e., slow down client IOs
> > from different workloads and not all the same workload). I'm not totally
> > convinced this is an improvement over a strategy where we have only 1
> > scrub IO in flight at all times, but that isn't quite how scrub schedules
> > itself so it's hard to compare it that way, and in the end the user
> > experience and perceived impact should be lower...
> >
> > 5- Auto-adjust the above scrub rate based on the total amount of data,
> > scrub interval, and scrub hours so that we are scrubbing at the slowest
> > rate possible that meets the schedule. We'd have to be slightly clever to
> > have the right feedback in place here...
> >
> > Thoughts?
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
>  		 	   		  N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
