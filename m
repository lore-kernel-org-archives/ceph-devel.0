From: Sage Weil <sage@inktank.com>
Subject: v0.67.2 Dumpling released
Date: Fri, 23 Aug 2013 09:43:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308230941510.28981@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39264 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab3HWQnO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 12:43:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

This is an imporant point release for Dumpling. Most notably, it fixes a 
problem when upgrading directly from v0.56.x Bobtail to v0.67.x Dumpling 
(without stopping at v0.61.x Cuttlefish along the way). It also fixes a 
problem with the CLI parsing of the CEPH_ARGS environment variable (which 
causes problems with older releases of OpenStack), high CPU utilization by 
the ceph-osd daemons, and cleans up the radosgw shutdown sequence.

Notable changes:

 * objecter: resend linger requests when cluster goes from full to 
   non-full
 * ceph: parse CEPH_ARGS environment variable
 * librados: fix small memory leak
 * osd: remove old log objects on upgrade (fixes bobtail -> dumpling jump)
 * osd: disable PGLog::check() via config option (fixes CPU burn)
 * rgw: drain requests on shutdown
 * rgw: misc memory leaks on shutdown

For more information please see the release notes and complete changelog:

 * http://ceph.com/docs/master/release-notes/#v0-67-2-dumpling
 * http://ceph.com/docs/master/_downloads/v0.67.2.txt

You can get v0.67.2 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.67.2.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm

