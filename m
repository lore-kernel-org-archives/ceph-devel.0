From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Degraded objects on brand new file system?
Date: Tue, 23 Nov 2010 09:58:39 -0700
Message-ID: <1290531519.15814.32.camel@sale659.sandia.gov>
References: <1290199290.4782.20.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1011222310560.17131@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:60289 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab0KWQ6w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 11:58:52 -0500
In-Reply-To: <Pine.LNX.4.64.1011222310560.17131@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

On Tue, 2010-11-23 at 00:11 -0700, Sage Weil wrote:
> Hi Jim,
> 
> On Fri, 19 Nov 2010, Jim Schutt wrote:
> > I've just created a brand-new filesystem using current unstable
> > branch.
> > 
> > ceph -w shows me this after I start it up and it settles down,:
> > 
> > 2010-11-19 13:07:39.279045    pg v247: 3432 pgs: 3432 active; 54 KB data, 98200 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
> > 2010-11-19 13:07:39.532174    pg v248: 3432 pgs: 3432 active; 54 KB data, 98232 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
> > 2010-11-19 13:07:41.123789    pg v249: 3432 pgs: 3432 active; 54 KB data, 98416 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
> 
> There were some issues in unstable that were preventing the recovery from 
> completing.  They should be sorted out in the current git. 

Thanks for taking a look.

FWIW, as of c327c6a2064f I can still reproduce this.
My recipe is: build a filesystem with 7 monitor instances,
7 mds instances; 13 osd instances.  Start all the mon
instances with a pdsh; start all the mds instances with a pdsh;
start the osd instances one-by-one, with a few seconds between
starting instances.

Let me know if there's anything else I can do.

-- Jim

> 
> Thanks!
> sage
> 
> 
> > 
> > That output seems to come from PGMap::print_summary().
> > If so, it seems to be telling me I have 108 objects, 
> > of which 95 are degraded.
> > 
> > If so, why would I have any degraded objects on
> > a brand-new file system?  All my osds are up/in;
> > shouldn't any degraded objects have been recovered?
> > 
> > Note that I haven't even mounted it anywhere yet.
> > 
> > Also, the above result is after starting
> > each of my 13 osds one at a time, waiting for
> > the PGs for each osd to go active before
> > starting up the next osd.
> > 
> > If I start up all the cosds a newly created file system 
> > roughly simultaneously, using pdsh, I get 7/108 objects
> > degraded.
> > 
> > What am I missing?
> > 
> > How can I learn what objects are degraded?
> > 
> > Thanks -- Jim
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


