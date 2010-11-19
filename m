From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Degraded objects on brand new file system?
Date: Fri, 19 Nov 2010 13:41:30 -0700
Message-ID: <1290199290.4782.20.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:59734 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0KSUlm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Nov 2010 15:41:42 -0500
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 17D894FF57C
	for <ceph-devel@vger.kernel.org>; Fri, 19 Nov 2010 13:41:37 -0700 (MST)
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id oAJKfLDM006048 for
 <ceph-devel@vger.kernel.org>; Fri, 19 Nov 2010 13:41:21 -0700
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I've just created a brand-new filesystem using current unstable
branch.

ceph -w shows me this after I start it up and it settles down,:

2010-11-19 13:07:39.279045    pg v247: 3432 pgs: 3432 active; 54 KB data, 98200 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
2010-11-19 13:07:39.532174    pg v248: 3432 pgs: 3432 active; 54 KB data, 98232 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)
2010-11-19 13:07:41.123789    pg v249: 3432 pgs: 3432 active; 54 KB data, 98416 KB used, 3032 GB / 3032 GB avail; 95/108 degraded (87.963%)

That output seems to come from PGMap::print_summary().
If so, it seems to be telling me I have 108 objects, 
of which 95 are degraded.

If so, why would I have any degraded objects on
a brand-new file system?  All my osds are up/in;
shouldn't any degraded objects have been recovered?

Note that I haven't even mounted it anywhere yet.

Also, the above result is after starting
each of my 13 osds one at a time, waiting for
the PGs for each osd to go active before
starting up the next osd.

If I start up all the cosds a newly created file system 
roughly simultaneously, using pdsh, I get 7/108 objects
degraded.

What am I missing?

How can I learn what objects are degraded?

Thanks -- Jim



