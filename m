From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Degraded objects on brand new file system?
Date: Tue, 23 Nov 2010 16:07:40 -0700
Message-ID: <1290553660.15814.59.camel@sale659.sandia.gov>
References: <1290199290.4782.20.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1011222310560.17131@cobra.newdream.net>
 <1290531519.15814.32.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1011231405060.4650@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:57088 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab0KWXHx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 18:07:53 -0500
In-Reply-To: <Pine.LNX.4.64.1011231405060.4650@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Tue, 2010-11-23 at 15:05 -0700, Sage Weil wrote:
> On Tue, 23 Nov 2010, Jim Schutt wrote:
> > Hi Sage,
> > 
> > On Tue, 2010-11-23 at 00:11 -0700, Sage Weil wrote:
> > > Hi Jim,
> > > 
> > > On Fri, 19 Nov 2010, Jim Schutt wrote:
> > > > I've just created a brand-new filesystem using current unstable
> > > > branch.
> > > > 
> > > > ceph -w shows me this after I start it up and it settles down,:
> > > > 
> > > > 2010-11-19 13:07:39.279045    pg v247: 3432 pgs: 3432 active; 54 KB data, 98200 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
> > > > 2010-11-19 13:07:39.532174    pg v248: 3432 pgs: 3432 active; 54 KB data, 98232 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
> > > > 2010-11-19 13:07:41.123789    pg v249: 3432 pgs: 3432 active; 54 KB data, 98416 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
> > > 
> > > There were some issues in unstable that were preventing the recovery from 
> > > completing.  They should be sorted out in the current git. 
> > 
> > Thanks for taking a look.
> > 
> > FWIW, as of c327c6a2064f I can still reproduce this.
> > My recipe is: build a filesystem with 7 monitor instances,
> > 7 mds instances; 13 osd instances.  Start all the mon
> > instances with a pdsh; start all the mds instances with a pdsh;
> > start the osd instances one-by-one, with a few seconds between
> > starting instances.
> 
> Okay, I just fixed a number of issues and have this working on 24 nodes.  
> Just pushed it all to the unstable branch.  Let us know if you see any 
> remaining osd recovery problems.

Cool, thanks for the quick turnaround:

2010-11-23 16:04:55.047920    pg v198: 3432 pgs: 79 active, 3353 active+clean; 138 KB data, 257 MB used, 3032 GB / 3032 GB avail; 108/234 degraded (46.154%)
2010-11-23 16:04:55.369455    pg v199: 3432 pgs: 79 active, 3353 active+clean; 138 KB data, 260 MB used, 3032 GB / 3032 GB avail; 108/234 degraded (46.154%)
2010-11-23 16:04:55.659880    pg v200: 3432 pgs: 79 active, 3353 active+clean; 138 KB data, 262 MB used, 3032 GB / 3032 GB avail; 108/234 degraded (46.154%)
2010-11-23 16:04:58.058551    pg v201: 3432 pgs: 79 active, 3353 active+clean; 138 KB data, 265 MB used, 3032 GB / 3032 GB avail; 108/234 degraded (46.154%)
2010-11-23 16:04:58.330541    pg v202: 3432 pgs: 79 active, 3353 active+clean; 138 KB data, 236 MB used, 3032 GB / 3032 GB avail; 108/234 degraded (46.154%)
2010-11-23 16:04:58.904685    pg v203: 3432 pgs: 79 active, 3353 active+clean; 138 KB data, 212 MB used, 3032 GB / 3032 GB avail; 98/234 degraded (41.880%)
2010-11-23 16:04:59.306771    pg v204: 3432 pgs: 68 active, 3364 active+clean; 138 KB data, 185 MB used, 3032 GB / 3032 GB avail; 82/234 degraded (35.043%)
2010-11-23 16:04:59.620307    pg v205: 3432 pgs: 63 active, 3369 active+clean; 138 KB data, 186 MB used, 3032 GB / 3032 GB avail; 80/234 degraded (34.188%)
2010-11-23 16:04:59.902632    pg v206: 3432 pgs: 62 active, 3370 active+clean; 138 KB data, 187 MB used, 3032 GB / 3032 GB avail; 79/234 degraded (33.761%)
2010-11-23 16:05:00.288754    pg v207: 3432 pgs: 52 active, 3380 active+clean; 138 KB data, 187 MB used, 3032 GB / 3032 GB avail; 64/234 degraded (27.350%)
2010-11-23 16:05:02.798427    pg v208: 3432 pgs: 50 active, 3382 active+clean; 138 KB data, 185 MB used, 3032 GB / 3032 GB avail; 62/234 degraded (26.496%)
2010-11-23 16:05:03.096632    pg v209: 3432 pgs: 43 active, 3389 active+clean; 138 KB data, 157 MB used, 3032 GB / 3032 GB avail; 52/234 degraded (22.222%)
2010-11-23 16:05:03.378364    pg v210: 3432 pgs: 39 active, 3393 active+clean; 138 KB data, 133 MB used, 3032 GB / 3032 GB avail; 47/234 degraded (20.085%)
2010-11-23 16:05:03.676672    pg v211: 3432 pgs: 32 active, 3400 active+clean; 138 KB data, 135 MB used, 3032 GB / 3032 GB avail; 39/234 degraded (16.667%)
2010-11-23 16:05:04.030404    pg v212: 3432 pgs: 12 active, 3420 active+clean; 138 KB data, 136 MB used, 3032 GB / 3032 GB avail; 19/234 degraded (8.120%)
2010-11-23 16:05:09.459450    pg v213: 3432 pgs: 3432 active+clean; 138 KB data, 125 MB used, 3032 GB / 3032 GB avail

:)

-- Jim

> 
> Thanks!
> sage
> 
> > 
> > Let me know if there's anything else I can do.
> > 
> > -- Jim
> > 
> > > 
> > > Thanks!
> > > sage
> > > 
> > > 
> > > > 
> > > > That output seems to come from PGMap::print_summary().
> > > > If so, it seems to be telling me I have 108 objects, 
> > > > of which 95 are degraded.
> > > > 
> > > > If so, why would I have any degraded objects on
> > > > a brand-new file system?  All my osds are up/in;
> > > > shouldn't any degraded objects have been recovered?
> > > > 
> > > > Note that I haven't even mounted it anywhere yet.
> > > > 
> > > > Also, the above result is after starting
> > > > each of my 13 osds one at a time, waiting for
> > > > the PGs for each osd to go active before
> > > > starting up the next osd.
> > > > 
> > > > If I start up all the cosds a newly created file system 
> > > > roughly simultaneously, using pdsh, I get 7/108 objects
> > > > degraded.
> > > > 
> > > > What am I missing?
> > > > 
> > > > How can I learn what objects are degraded?
> > > > 
> > > > Thanks -- Jim
> > > > 
> > > > 
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 


