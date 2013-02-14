From: Sage Weil <sage@inktank.com>
Subject: v0.56.3 released
Date: Wed, 13 Feb 2013 17:51:36 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302131750540.20247@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34799 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab3BNBvh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Feb 2013 20:51:37 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1E24D8048B
	for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 17:51:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id EF7FB8048B
	for <ceph-devel@vger.kernel.org>; Wed, 13 Feb 2013 17:51:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've fixed an important bug that a few users were hitting with 
unresponsive OSDs and internal heartbeat timeouts. This, along with a 
range of less critical fixes, was sufficient to justify another point 
release. Any production users should upgrade.

Notable changes include:

 * osd: flush peering work queue prior to start
 * osd: persist osdmap epoch for idle PGs
 * osd: fix and simplify connection handling for heartbeats
 * osd: avoid crash on invalid admin command
 * mon: fix rare races with monitor elections and commands
 * mon: enforce that OSD reweights be between 0 and 1 (NOTE: not CRUSH 
   weights)
 * mon: approximate client, recovery bandwidth logging
 * radosgw: fixed some XML formatting to conform to Swift API inconsistency
 * radosgw: fix usage accounting bug; add repair tool
 * radosgw: make fallback URI configurable (necessary on some web servers)
 * librbd: fix handling for interrupted 'unprotect' operations
 * mds, ceph-fuse: allow file and directory layouts to be modified via 
   virtual xattrs

You can get v0.56.3 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.56.3.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
