From: Sage Weil <sage@inktank.com>
Subject: today
Date: Wed, 10 Jul 2013 09:42:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307100927360.22858@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59806 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab3GJQmY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 12:42:24 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2718C80063
	for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 09:42:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CCD3F80063
	for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 09:42:23 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

will probably miss the rados standup this morning.

yesterday: 
- got almost all of the mon stuff all merged in 
- one new mon issue discovered: paxos race with scrub, see wip-scrub-paxos 
for one possible fix.  alternatively, we could avoid touching paxos and 
make scrub work around it.  
- backported the full osdmap fix to cuttlefish last night

today:
- airplane with wifi from 1:30 on
- get 5518 reviewed/tested (unbounded inc osdmap sharing can cause osd 
dominos)
- 5581 big suite failures: looks like pgs are stuck stale, stats not 
getting published to the mon.
- look at the msgr osd drop on #5517, once sam has the logs on slider
- pile of other things in pending backport queue
