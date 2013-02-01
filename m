From: Sage Weil <sage@inktank.com>
Subject: RE: Slow request in XFS
Date: Fri, 1 Feb 2013 04:19:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302010415540.11209@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC5EA81F@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1301310441590.11107@cobra.newdream.net> <510A8AA0.6000508@sandia.gov> <alpine.DEB.2.00.1301311159460.807@cobra.newdream.net>
 <6F3FA899187F0043BA1827A69DA2F7CC5EB394@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47494 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3BAMUA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 07:20:00 -0500
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5EB394@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Jim Schutt <jaschut@sandia.gov>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 1 Feb 2013, Chen, Xiaoxi wrote:

> Is it right to have such a lot pg scrubing?I didn't tune anything

For a new cluster, you'll see a bunch of these as the initial scrub 
happens.  Then it's once per configurable period.. 24h for the regular 
scrub (metadata) and a week for the deep scrub (reread all data).  Do

 ceph --show-config | grep scrub

to see the options and their defaults.

sage

> 
> 2013-02-01 16:37:53.943933 osd.12 [INF] 1.4a8 deep-scrub ok
> 2013-02-01 16:37:54.379463 osd.14 [INF] 1.93 deep-scrub ok
> 2013-02-01 16:37:55.076349 osd.210 [INF] 2.4a2 deep-scrub ok
> 2013-02-01 16:37:56.379866 osd.14 [INF] 1.96 deep-scrub ok
> 2013-02-01 16:37:56.664761 osd.15 [INF] 1.a0c deep-scrub ok
> 2013-02-01 16:37:56.908169 osd.120 [INF] 2.39 deep-scrub ok
> 2013-02-01 16:37:56.944525 osd.12 [INF] 1.4ad deep-scrub ok
> 2013-02-01 16:37:57.789605 osd.119 [INF] 1.25 deep-scrub ok
> 2013-02-01 16:37:58.076872 osd.210 [INF] 2.4f5 deep-scrub ok
> 2013-02-01 16:37:58.380193 osd.14 [INF] 1.ea deep-scrub ok
> 2013-02-01 16:37:58.789817 osd.119 [INF] 1.65 deep-scrub ok
> 2013-02-01 16:37:59.174758 osd.13 [INF] 1.4ec deep-scrub ok
> 2013-02-01 16:37:59.945553 osd.12 [INF] 1.4b5 deep-scrub ok
> 2013-02-01 16:38:00.757881 osd.28 [INF] 1.5d6 deep-scrub ok
> 2013-02-01 16:38:00.790282 osd.119 [INF] 1.6b deep-scrub ok
> 2013-02-01 16:38:00.945527 osd.12 [INF] 1.4c4 deep-scrub ok
> 2013-02-01 16:38:01.665956 osd.15 [INF] 1.a1e deep-scrub ok
> 2013-02-01 16:38:02.666142 osd.15 [INF] 2.2d deep-scrub ok
> 2013-02-01 16:38:02.790525 osd.119 [INF] 1.b7 deep-scrub ok
> 2013-02-01 16:38:02.880595 osd.28 [INF] 1.609 deep-scrub ok
> 2013-02-01 16:38:03.077917 osd.210 [INF] 2.50f deep-scrub ok
> 2013-02-01 16:38:03.622409 mon.0 [INF] pgmap v524: 7872 pgs: 81 active, 7710 active+clean, 81 peering; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:38:03.666447 osd.15 [INF] 2.31 deep-scrub ok
> 2013-02-01 16:38:04.731588 mon.0 [INF] pgmap v525: 7872 pgs: 75 active, 7716 active+clean, 81 peering; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:37:55.688988 osd.29 [INF] 1.82f deep-scrub ok
> 2013-02-01 16:37:56.142424 osd.216 [INF] 2.4fc deep-scrub ok
> 2013-02-01 16:37:58.689627 osd.29 [INF] 1.831 deep-scrub ok
> 2013-02-01 16:37:59.689851 osd.29 [INF] 1.845 deep-scrub ok
> 2013-02-01 16:38:01.143157 osd.216 [INF] 2.50d deep-scrub ok
> 2013-02-01 16:38:01.690207 osd.29 [INF] 1.882 deep-scrub ok
> 2013-02-01 16:38:02.143704 osd.216 [INF] 2.551 deep-scrub ok
> 2013-02-01 16:38:02.690510 osd.29 [INF] 1.8be deep-scrub ok
> 2013-02-01 16:38:03.143961 osd.216 [INF] 2.561 deep-scrub ok
> 2013-02-01 16:38:04.144356 osd.216 [INF] 2.61c deep-scrub ok
> 2013-02-01 16:38:05.890791 mon.0 [INF] pgmap v526: 7872 pgs: 75 active, 7716 active+clean, 81 peering; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:38:06.974976 mon.0 [INF] pgmap v527: 7872 pgs: 77 active, 7716 active+clean, 78 peering, 1 active+clean+scrubbing+deep; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:38:08.092490 mon.0 [INF] pgmap v528: 7872 pgs: 77 active, 7716 active+clean, 78 peering, 1 active+clean+scrubbing+deep; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:38:02.318896 osd.220 [INF] 2.3b9 deep-scrub ok
> 2013-02-01 16:38:02.618443 osd.22 [INF] 2.3b0 deep-scrub ok
> 2013-02-01 16:38:04.319381 osd.220 [INF] 2.3cf deep-scrub ok
> 2013-02-01 16:38:04.618932 osd.22 [INF] 2.3b6 deep-scrub ok
> 2013-02-01 16:38:09.160545 mon.0 [INF] pgmap v529: 7872 pgs: 77 active, 7716 active+clean, 78 peering, 1 active+clean+scrubbing+deep; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:38:10.244711 mon.0 [INF] pgmap v530: 7872 pgs: 77 active, 7716 active+clean, 78 peering, 1 active+clean+scrubbing+deep; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:38:00.789838 osd.24 [INF] 1.734 deep-scrub ok
> 2013-02-01 16:38:01.543266 osd.25 [INF] 1.827 deep-scrub ok
> 2013-02-01 16:38:02.543662 osd.25 [INF] 1.834 deep-scrub ok
> 2013-02-01 16:38:03.085778 osd.211 [INF] 2.a24 deep-scrub ok
> 2013-02-01 16:38:03.790503 osd.24 [INF] 1.737 deep-scrub ok
> 2013-02-01 16:38:06.791036 osd.24 [INF] 1.74f deep-scrub ok
> 2013-02-01 16:38:08.544790 osd.25 [INF] 1.83a deep-scrub ok
> 2013-02-01 16:38:10.545088 osd.25 [INF] 1.83f deep-scrub ok
> 2013-02-01 16:38:11.453853 mon.0 [INF] pgmap v531: 7872 pgs: 77 active, 7716 active+clean, 78 peering, 1 active+clean+scrubbing+deep; 0 bytes data, 1738 MB used, 27930 GB / 27931 GB avail
> 2013-02-01 16:38:02.064245 osd.111 [INF] 1.522 deep-scrub ok
> 2013-02-01 16:38:02.169805 osd.110 [INF] 1.608 deep-scrub ok
> 2013-02-01 16:38:05.064739 osd.111 [INF] 1.526 deep-scrub ok
> 2013-02-01 16:38:05.098158 osd.17 [INF] 1.282 deep-scrub ok
> 2013-02-01 16:38:06.065128 osd.111 [INF] 1.53d deep-scrub ok
> 2013-02-01 16:38:07.098443 osd.17 [INF] 1.2dc deep-scrub ok
> 2013-02-01 16:38:09.098901 osd.17 [INF] 1.2e5 deep-scrub ok
> 2013-02-01 16:38:09.236673 osd.16 [INF] 0.1ea deep-scrub ok
> 2013-02-01 16:38:03.124982 osd.27 [INF] 1.545 deep-scrub ok
> 2013-02-01 16:38:04.078118 osd.210 [INF] 2.52d deep-scrub ok
> 2013-02-01 16:38:04.125158 osd.213 [INF] 2.813 deep-scrub ok
> 2013-02-01 16:38:04.381415 osd.14 [INF] 1.103 deep-scrub ok
> 2013-02-01 16:38:04.666744 osd.15 [INF] 2.a8 deep-scrub ok
> 2013-02-01 16:38:05.078598 osd.210 [INF] 2.534 deep-scrub ok
> 2013-02-01 16:38:05.125319 osd.213 [INF] 2.83d deep-scrub ok
> 2013-02-01 16:38:05.300474 osd.117 [INF] 1.3a0 deep-scrub ok
> 2013-02-01 16:38:05.381625 osd.14 [INF] 1.108 deep-scrub ok
> 2013-02-01 16:38:05.881223 osd.28 [INF] 1.634 deep-scrub ok
> 2013-02-01 16:38:06.078723 osd.210 [INF] 2.552 deep-scrub ok
> 2013-02-01 16:38:06.093018 osd.113 [INF] 1.349 deep-scrub ok
> 2013-02-01 16:38:06.125485 osd.27 [INF] 1.546 deep-scrub ok
> 2013-02-01 16:38:06.300759 osd.117 [INF] 1.3fc deep-scrub ok
> 2013-02-01 16:38:06.881229 osd.28 [INF] 1.647 deep-scrub ok
> 2013-02-01 16:38:06.946823 osd.12 [INF] 1.514 deep-scrub ok
> 2013-02-01 16:38:08.093758 osd.113 [INF] 1.3af deep-scrub ok
> 2013-02-01 16:38:08.791689 osd.119 [INF] 1.10a deep-scrub ok
> 2013-02-01 16:38:09.079355 osd.210 [INF] 2.55c deep-scrub ok
> 2013-02-01 16:38:09.125886 osd.27 [INF] 1.54a deep-scrub ok
> 2013-02-01 16:38:09.747373 osd.118 [INF] 0.992 deep-scrub ok
> 2013-02-01 16:38:09.792101 osd.119 [INF] 1.11a deep-scrub ok
> 2013-02-01 16:38:10.079707 osd.210 [INF] 2.5a0 deep-scrub ok
> 2013-02-01 16:38:10.747615 osd.118 [INF] 0.9a6 deep-scrub ok
> 2013-02-01 16:38:11.126305 osd.213 [INF] 2.85e deep-scrub ok
> 2013-02-01 16:38:11.390611 osd.214 [INF] 2.266 deep-scrub ok
> 2013-02-01 16:38:11.692015 osd.29 [INF] 1.8c6 deep-scrub ok
> 2013-02-01 16:38:11.947688 osd.12 [INF] 1.523 deep-scrub ok
> 2013-02-01 16:38:12.301511 osd.117 [INF] 1.442 deep-scrub ok
> 2013-02-01 16:38:12.390220 osd.214 [INF] 2.26c deep-scrub ok
> 
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com] 
> Sent: 2013?2?1? 4:01
> To: Jim Schutt
> Cc: Chen, Xiaoxi; ceph-devel@vger.kernel.org
> Subject: Re: Slow request in XFS
> 
> On Thu, 31 Jan 2013, Jim Schutt wrote:
> > On 01/31/2013 05:43 AM, Sage Weil wrote:
> > > Hi-
> > > 
> > > Can you reproduce this with logs?  It looks like there are a few ops 
> > > that are hanging for a very long time, but there isn't enough 
> > > information here except to point to osds 610, 612, 615, and 68...
> > 
> > FWIW, I have a small pile of disks with bad sections in them - these 
> > sections aren't bad enough that writes fail, but they are bad enough 
> > that throughput drops by a factor of ~20.
> > 
> > Do OSDs already collect statistics on, say, op commit elapsed time 
> > (assuming that's the statistic most directly related to slow writes on 
> > only some sections of a disk), in a way that could be used to diagnose 
> > such disks?
> > 
> > If not, is there enough structure already in place that it would be 
> > easy to add?
> 
> They're tracking it internally, but it gets averaged into the totals before a user gets to see any per-request latencies.  The per-daemon totals are available via the admin socket 'perf dump' command.  Have you looked at that information yet?
> 
> sage
> N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
