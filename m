From: Sage Weil <sage@newdream.net>
Subject: localized pgs
Date: Tue, 17 Apr 2012 09:36:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204170935350.15197@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53317 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753704Ab2DQQgK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Apr 2012 12:36:10 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 0B66BBC7C5
	for <ceph-devel@vger.kernel.org>; Tue, 17 Apr 2012 09:36:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 41FCABC7C5
	for <ceph-devel@vger.kernel.org>; Tue, 17 Apr 2012 09:36:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I think the preferred osd placement groups need to go.  They were 
originally added to get hadoop-style data placement, but it's not clear 
that that is actually desireable, we don't recommend or test them, and 
looking at them now there are some serious problems with how they 
currently work.

- The idea was that there would be a small set of pgs that are bound to 
osds, but we aren't creating them when osds are added and removed.  Nor 
can we, because data is stored in the pg and doesn't move between pgs. If 
we created new localized pgs when osds are added, that would mean 
previously stored data is now in the wrong pg.  I think the only way it 
would work (given the current approach) is if you decided at cluster 
creation time what the max number of osds would be, and they would bind 
themselves to other osds similarly to how the stable_mod() function is 
used for the object to pg mapping.

- It is muddies the current abstractions.  The whole point of Ceph is that 
OSDs can come and go, and as soon as you can say this data is stored on 
that disk the whole thing gets messy.

- The forcefeed bits in CRUSH are hugely ugly.  It would be incredibly 
satisfying to rip them out.

- Using localized PGs can very easily screw up the distribution of data in 
the system.  Users won't have any concept of how much disk space is 
available, etc., which means that Ceph would have to monitor the localized 
data on each node and move other PGs away as appropriate. Even if it did 
that, the localized data could outgrow the node size too. There are a few 
tricks that could be played to delay ENOSPC, but nothing that is 
particularly compelling.

- Nobody uses them.

I guess the question is, is there a compelling use case, and if there is, 
is there a better approach?

sage

