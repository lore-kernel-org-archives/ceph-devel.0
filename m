From: Sage Weil <sage@inktank.com>
Subject: v0.56.7 bobtail released
Date: Wed, 28 Aug 2013 10:53:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308281044330.32381@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35349 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3H1RxH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Aug 2013 13:53:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

We have another bugfix update for bobtail.  Most of these fixes have been 
sitting in the bobtail branch (and were run by various users) for some 
time now.  The newest patches fix a problem with multi-delete on rgw.
We recommend that production bobtail clusters upgrade, especially if they 
are using the radosgw.

Notable changes:

 * ceph-fuse: create finisher flags after fork()
 * debian: fix prerm/postinst hooks; do not restart daemons on upgrade
 * librados: fix async aio completion wakeup (manifests as rbd hang)
 * librados: fix hang when osd becomes full and then not full
 * librados: fix locking for aio completion refcounting
 * librbd python bindings: fix stripe_unit, stripe_count
 * librbd: make image creation default configurable
 * mon: fix validation of mds ids in mon commands
 * osd: avoid excessive disk updates during peering
 * osd: avoid excessive memory usage on scrub
 * osd: avoid heartbeat failure/suicide when scrubbing
 * osd: misc minor bug fixes
 * osd: use fdatasync instead of sync_file_range (may avoid xfs power-loss 
   corruption)
 * rgw: escape prefix correctly when listing objects
 * rgw: fix copy attrs
 * rgw: fix crash on multi delete
 * rgw: fix locking/crash when using ops log socket
 * rgw: fix usage logging
 * rgw: handle deep uri resources

For more information, see:

 * http://ceph.com/docs/master/release-notes/#v0-56-7-bobtail
 * http://ceph.com/docs/master/_downloads/v0.56.7.txt

You can get v0.56.7 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.56.7.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian

