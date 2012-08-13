From: Sage Weil <sage@inktank.com>
Subject: v0.50 released
Date: Mon, 13 Aug 2012 14:45:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208131445160.28931@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49955 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2HMVpp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Aug 2012 17:45:45 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 63CE08004B
	for <ceph-devel@vger.kernel.org>; Mon, 13 Aug 2012 14:45:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2BA3D8004B
	for <ceph-devel@vger.kernel.org>; Mon, 13 Aug 2012 14:45:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The next development release v0.50 is ready, and includes:

 * osd: major refactor of PG peering and threading
 * osd: more/better dump info about in-progress operations
 * osd: better tracking of recent slow operations
 * osd: misc fixes
 * librados: watch/notify fixes, misc memory leaks
 * mon: misc fixes
 * mon: less-destructive ceph-mon --mkfs behavior
 * rados: copy rados pools
 * radosgw: various compatibility fixes

Right now the main development going on is with the RBD layering, which 
will hit master shortly, and OSD performance, various bits of which are 
being integrated. There was also a large pile of messenger cleanups and 
races fixes that will be on v0.52.

You can get v0.50 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball athttp://ceph.com/download/ceph-0.50.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/master/install/debian

One note: there was a build issue with the latest gcc that affected the 
Debian squeeze and wheezy builds; those packages were not built for this 
release.
