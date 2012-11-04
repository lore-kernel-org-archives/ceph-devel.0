From: Sage Weil <sage@inktank.com>
Subject: explicitly specifying pgnum on pool creation
Date: Sun, 4 Nov 2012 03:42:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211040338400.30792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41937 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab2KDLml (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 06:42:41 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5ED6F80060
	for <ceph-devel@vger.kernel.org>; Sun,  4 Nov 2012 03:42:41 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2C0A680060
	for <ceph-devel@vger.kernel.org>; Sun,  4 Nov 2012 03:42:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The wip-explicit-pgnum changes the 'ceph osd pool create <name> <pgnum>' 
command to require the pg_num value instead of defaulting to 8.  This 
would make it harder for users to get this wrong.

On the other hand, it probably also breaks some scripts for deploying 
OpenStack that create volume and image pools.  :/

Ideas?

The original idea was that the monitor would automagically notice when a 
small pgnum pool gets lots of objects and trigger a split.  Even if we 
don't do that, pretty soon now you'll be able to explicitly increase 
pg_num.  I still think it might be a good idea to require it up-front, 
though.

An alternative would be to default to a larger number (say, num_osds << 
2).  My concern there is that it makes it easy to create lots of pgs for 
pools that may be small, and it's still not large enough to get good 
performance for the "create pool, run rados bench" crowd.

sage

