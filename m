From: Sage Weil <sage@newdream.net>
Subject: wip-pg-stale
Date: Fri, 27 Jan 2012 13:32:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201271330420.8285@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41733 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab2A0Vcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jan 2012 16:32:39 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7A114BCAF5
	for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2012 13:32:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4943ABCAF5
	for <ceph-devel@vger.kernel.org>; Fri, 27 Jan 2012 13:32:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Please review.  

If the monitor sees an osdmap go by where nodes go down (or up) it will 
scan its pg_map and mark any pg whose primary is down as 'stale'.  If/when 
the pg recovers, that will get refreshed.  If not, the admin will know 
something is up.

We'll soon be adding the last_active, last_clean, and now last_unstale (?) 
fields so that bigger alarms can go off when the pg stays stale for more 
than a few seconds...

sage
