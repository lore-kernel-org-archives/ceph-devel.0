From: Sage Weil <sage@newdream.net>
Subject: pg time stamps
Date: Fri, 13 Jan 2012 09:24:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201130919540.7683@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38820 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab2AMRYV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2012 12:24:21 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 383B3BC795
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 09:24:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 147C6BC795
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 09:24:21 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

wip-osd-pg-stats adds a time stamp and epoch number to the pg_stat_t 
struct.  The epoch is updated when the mapping changes, and the time stamp 
is updated when the pg state changes.

The state timestamp is the interesting one, since it'll make it easier to 
identify PGs that are stuck in, say, down or peering states for long 
periods of time. 

What it doesn't help with is when the pg state is toggling between two 
undesireable states (the stamp will still get updated).  In practice, what 
we probably care about is active vs not active, and degraded vs not 
degraded.  We could add additional time stamps for those, but that may be 
overkill.

Previously we had planned on doing this sort of monitoring using an 
external agent, but that's kind of a pain, duplicates storage, etc.  This 
is simple to add into the pg_stat_t update logic.

I expect this will be rebased on top of the new encoding strategy stuff so 
that the object versioning is backward and forwards compatible, so don't 
worry about that part here.

https://github.com/NewDreamNetwork/ceph/commit/f43282796af50d760a620970ad691e0a20bcf178

Thoughts?
sage
