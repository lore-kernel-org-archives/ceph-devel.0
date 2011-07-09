From: Sage Weil <sage@newdream.net>
Subject: v0.31 released
Date: Sat, 9 Jul 2011 15:10:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107091509560.1314@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35589 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704Ab1GIWHT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Jul 2011 18:07:19 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 17D4DBC6C2
	for <ceph-devel@vger.kernel.org>; Sat,  9 Jul 2011 15:10:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D765EBC6C2
	for <ceph-devel@vger.kernel.org>; Sat,  9 Jul 2011 15:10:30 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've released v0.31. Notable changes include:

 * librados, libceph: can now access multiple clusters in same process
 * osd: snapshot rollback fixes
 * osd: scrub race
 * mds: fixed lock starvation issue
 * client: cache ref counting fixes
 * client: snap writeback, umount hang, cache pressure, other fixes
 * radosgw: atomic PUT

There is also the usual mix of bug fixes and code cleanup all over the 
tree. Much of the work has also been focused on teuthology, our Ceph 
test/QA framework.

For the current sprint (v0.32) we are working on:

 * osd: prehashing of PG objects (to facilitate efficient PG splits/merges)
 * instrumentation (simpler query-based interface, collectd plugins)
 * Chef scripts
 * mds: clustering fixes
 * uclient: chasing down a few hard to hit bugs
 * radosgw: coherent caching of bucket acls
 * more qa (teuthology, tests)

v0.31 can be found in the usual places:

 * Direct download at: http://ceph.newdream.net/downloads/ceph-0.31.tar.gz
 * For Debian/Ubuntu packages see: http://ceph.newdream.net/wiki/Debian

