From: Sage Weil <sage@inktank.com>
Subject: v0.61.9 Cuttlefish released
Date: Thu, 17 Oct 2013 13:29:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310171323330.16583@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42479 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762335Ab3JQU3g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Oct 2013 16:29:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

This point release resolves several low to medium-impact bugs across the 
code base, and fixes a performance problem (CPU utilization) with radosgw. 
We recommend that all production cuttlefish users upgrade.

Notable changes:

 * ceph, ceph-authtool: fix help (Danny Al-Gaaf)
 * ceph-disk: partprobe after creating journal partition
 * ceph-disk: specific fs type when mounting (Alfredo Deza)
 * ceph-fuse: fix bug when compiled against old versions
 * ceph-fuse: fix use-after-free in caching code (Yan, Zheng)
 * ceph-fuse: misc caching bugs
 * ceph.spec: remove incorrect mod_fcgi dependency (Gary Lowell)
 * crush: fix name caching
 * librbd: fix bug when unpausing cluster (Josh Durgin)
 * mds: fix LAZYIO lock hang
 * mds: fix bug in file size recovery (after client crash)
 * mon: fix paxos recovery corner case
 * osd: fix exponential backoff for slow request warnings (Loic Dachary)
 * osd: fix readdir_r usage
 * osd: fix startup for long-stopped OSDs
 * rgw: avoid std::list::size() to avoid wasting CPU cycles (Yehuda Sadeh)
 * rgw: drain pending requests during write (fixes data safety issue) 
   (Yehuda Sadeh)
 * rgw: fix authenticated users group ACL check (Yehuda Sadeh)
 * rgw: fix bug in POST (Yehuda Sadeh)
 * rgw: fix sysvinit script status command, return value (Danny Al-Gaaf)
 * rgw: reduce default log level (Yehuda Sadeh)

For more detailed information, see

 * http://ceph.com/docs/master/release-notes/#v0-61-9-cuttlefish
 * http://ceph.com/docs/master/_downloads/v0.61.9.txt

You can get v0.61.9 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.61.9.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
