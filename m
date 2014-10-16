From: Sage Weil <sage@newdream.net>
Subject: capping pgs per osd
Date: Thu, 16 Oct 2014 12:52:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410160735390.10462@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54180 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbaJPTwF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Oct 2014 15:52:05 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E1088800BB
	for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 12:52:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B4475800BB
	for <ceph-devel@vger.kernel.org>; Thu, 16 Oct 2014 12:52:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are lots of scenarios in a large cluster an admin mistake or 
misconfiguration can cause a bajillion PGs to pile up on one OSD.  This 
causes various probably, most of which are difficult to diagnose and get 
out of because things are so heavily loaded.

We need to have a way to prevent people/clusters from shooting themselves 
in the foot in this particular way.  Here's a rough proposal:

- config option 'osd max pgs = 500' (or something similar)
- if the osd is at or above pg_max (pg_map.size()), it will silently drop 
any pg peering messages or requests for pgs that they don't already have
- if the osd reaches pg_max, it will set a bit or flag in the osd_stat_t 
it reports to the monitor.
- when the osd drops below pg_max, it will clear that bit

...and the tricky part...

- when the mon sees that osd bit clear, it will do something to the 
osdmap and issue a new epoch.  that something will either trigger an 
interval change for the osd or in other way induce any unpeered pgs 
including that osd to restart peering or resend messages to that osd.

I'm not sure we want to simply trigger an interval change as that will 
restart peering on peered PGs at a time when the OSD is under load.  A 
more targetted way to kick peering (and resend of the potentially dropped 
messages) just for unpeered PGs would be ideal.

Eventually I'd like to see us include this in the thrashing tests by 
setting the pg_max at something that is reasonably low (2x or 3x the 
target/average pgs per osd) and make one of the thrashing operations skew 
the crush weights.  Ideally in a way that will make an overloaded OSD need 
to drain previous PGs before it can accept new ones?

Thoughts?
sage
