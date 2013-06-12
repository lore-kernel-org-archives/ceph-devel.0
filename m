From: Sage Weil <sage@inktank.com>
Subject: v0.64 released
Date: Wed, 12 Jun 2013 15:30:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306121528460.1439@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48782 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757986Ab3FLWae (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Jun 2013 18:30:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

A new development release of Ceph is out.  Notable changes include:

 * osd: monitor both front and back interfaces
 * osd: verify both front and back network are working before rejoining 
   cluster
 * osd: fix memory/network inefficiency during deep scrub
 * osd: fix incorrect mark-down of osds
 * mon: fix start fork behavior
 * mon: fix election timeout
 * mon: better trim/compaction behavior
 * mon: fix units in 'ceph df' output
 * mon, osd: misc memory leaks
 * librbd: make default options/features for newly created images (e.g., 
   via qemu-img) configurable
 * mds: many fixes for mds clustering
 * mds: fix rare hang after client restart
 * ceph-fuse: add ioctl support
 * ceph-fuse/libcephfs: fix for cap release/hang
 * rgw: handle deep uri resources
 * rgw: fix CORS bugs
 * ceph-disk: add '[un]suppress-active DEV' command
 * debian: rgw: stop daemon on uninstall
 * debian: fix upstart behavior with upgrades

You can get v0.64 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.64.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm

