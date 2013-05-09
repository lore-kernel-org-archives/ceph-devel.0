From: Sage Weil <sage@inktank.com>
Subject: summit: teuthology, build, testing/release
Date: Thu, 9 May 2013 08:10:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305090803430.26155@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53999 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3EIPKI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 11:10:08 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0BBFA80454
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 08:10:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 09B9980454
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 08:10:08 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We did a session during the summit on build and testing tools, which 
mostly focused around what we need to do to teuthology to expand our 
testing coverage for dumpling.  For anyone who is working with the ceph 
code, I suggset taking a quick look at the etherpad to see what was 
discussed.

In particular, we're interested in doing what we can to make the 
teuthology testing tool more easily consumable and useful to developers, 
both to expand the overall testing effort and to make contribution in the 
area of tests and test coverage easier.

A few things we discussed:

 - How useful would it be to make teuthology allocate testing machines via 
a standard API like EC2 or openstack?

 - How can we expand teuthology to gather information about performance 
and resource utilization to more easily track those sorts of regressions 
and improvements?

 - What areas ar emost in need of documentation to let users get up and 
running with teuthology?

If anyone is interested in these topics (or teuthology or our test efforts 
in general), let us know!  If you'd like to get involved, there is lots to 
be done.  There is a daily standup (google hangouts) that you are welcome 
to join, and a healthy backlog of work to be done; see

	http://tracker.ceph.com/projects/teuthology/issues?query_id=36


