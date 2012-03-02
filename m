From: Sage Weil <sage@newdream.net>
Subject: v0.43 released
Date: Fri, 2 Mar 2012 14:05:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021404180.1674@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47257 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754720Ab2CBWFK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 17:05:10 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B1A32BC802
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 14:05:09 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 89B7DBC802
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 14:05:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

V0.43 is ready, and includes:

 * improved signal handlers (cleaner shutdown)
 * osd: refactored/improved push/pull code (recovery)
 * osd: ability query osd pg state
 * osd: ability to query missing/unfound objects
 * osd: dump in-progress operations via admin socket
 * osd: clearer pg states; added 'remapped' and 'recovering'
 * mon: track time since pg states have changed; issue health warning when 
  "stuck" in peering, recovery
 * mon: validate new crush map before accepting it
 * mon: paxos recovery bug fixes
 * crushtool: improved testing
 * crush: fix weight adjustment for tree, list buckets; unit tests

This is of course in addition to the usual helping of bug fixes, mostly in 
the OSD code.  Nothing too drastic this time around.

For v0.44 we plan to complete:

 * osd: key/value objects with leveldb
 * radosgw: faster/simpler GET and PUT (especially for non-btrfs users)
 * radosgw: basic swift/s3 acl interoperability
 * librados: caching
 * librbd: caching

In the meantime, you can get v0.43 from the following locations (note that 
our github url has changed):

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.43.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#installing-the-packages

