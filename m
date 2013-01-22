From: Sage Weil <sage@inktank.com>
Subject: handling fs errors
Date: Mon, 21 Jan 2013 22:05:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57784 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab3AVGFn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 01:05:43 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 57F9980060
	for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 22:05:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3644580060
	for <ceph-devel@vger.kernel.org>; Mon, 21 Jan 2013 22:05:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We observed an interesting situation over the weekend.  The XFS volume 
ceph-osd locked up (hung in xfs_ilock) for somewhere between 2 and 4 
minutes.  After 3 minutes (180s), ceph-osd gave up waiting and committed 
suicide.  XFS seemed to unwedge itself a bit after that, as the daemon was 
able to restart and continue.

The problem is that during that 180s the OSD was claiming to be alive but 
not able to do any IO.  That heartbeat check is meant as a sanity check 
against a wedged kernel, but waiting so long meant that the ceph-osd 
wasn't failed by the cluster quickly enough and client IO stalled.

We could simply change that timeout to something close to the heartbeat 
interval (currently default is 20s).  That will make ceph-osd much more 
sensitive to fs stalls that may be transient (high load, whatever).

Another option would be to make the osd heartbeat replies conditional on 
whether the internal heartbeat is healthy.  Then the heartbeat warnings 
could start at 10-20s, ping replies would pause, but the suicide could 
still be 180s out.  If the stall is short-lived, pings will continue, the 
osd will mark itself back up (if it was marked down) and continue.

Having written that out, the last option sounds like the obvious choice.  
Any other thoughts?

sage
