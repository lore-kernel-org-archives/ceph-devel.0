From: Sage Weil <sage@newdream.net>
Subject: v0.40 released
Date: Fri, 13 Jan 2012 21:30:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201132129210.13210@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33018 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab2ANFaV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jan 2012 00:30:21 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A987FBC91E
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 21:30:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 885F4BC91E
	for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2012 21:30:20 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's been several weeks, but v0.40 is ready.  This has mostly been a 
stabilization release, so there isn't too much new here.  Some notable 
additions include:

 * new and improved specfile, for RH and SuSE based distributions.
 * mon: expose cluster stats via admin socket (accessible via collectd 
   plugin)
 * simpler/generalized admin socket interface (ceph --admin-socket 
   /path/to/sock command)
 * rados: ability to specify object locators on command line
 * osd: improved pool 'ls' protocol (includes locators)

There's a much longer list of bugs fixed, but I'm not sure it's worth 
listing here.  Lots of stuff in the OSD, for the most part.  Notably, 
there is only one high priority OSD bug in the tracker right now, and it 
is just awaiting confirmation from the nightly QA run that the fix is 
correct.

The main thing that didn't make the cut is the "backfill" work, that is 
about to be merged into master for v0.41.  This revamps the way OSDs 
handle recovery when the entire PG has to be replicated to a new location, 
and significantly reduces memory requirements and improves the recovery 
speed.  For v0.41, we're also working on mechanisms to improve visibility 
into the health of the cluster and addressing some performance issues.

To download v0.40:

 * Git at git://github.com/NewDreamNetwork/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.40.tar.gz
 * For Debian/Ubuntu packages, see
   http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#installing-the-packages
 
