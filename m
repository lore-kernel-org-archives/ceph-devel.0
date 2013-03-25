From: Sage Weil <sage@inktank.com>
Subject: v0.56.4 released
Date: Mon, 25 Mar 2013 16:17:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303251616110.12444@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54311 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338Ab3CYXRF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Mar 2013 19:17:05 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

There have been several important fixes that we've backported to bobtail 
that users are hitting in the wild. Most notably, there was a problem with 
pool names with - and _ that OpenStack users were hitting, and memory 
usage by ceph-osd and other daemons due to the trimming of in-memory logs. 
This and more is fixed in v0.56.4. We recommend that all bobtail users 
upgrade.

Notable changes include:

 * mon: fix bug in bringup with IPv6
 * reduce default memory utilization by internal logging (all daemons)
 * rgw: fix for bucket removal
 * rgw: reopen logs after log rotation
 * rgw: fix multipat upload listing
 * rgw: don't copy object when copied onto self
 * osd: fix caps parsing for pools with - or _
 * osd: allow pg log trimming when degraded, scrubbing, recoverying 
   (reducing memory consumption)
 * osd: fix potential deadlock when 'journal aio = true'
 * osd: various fixes for collection creation/removal, rename, temp 
   collections
 * osd: various fixes for PG split
 * osd: deep-scrub omap key/value data
 * osd: fix rare bug in journal replay
 * osd: misc fixes for snapshot tracking
 * osd: fix leak in recovery reservations on pool deletion
 * osd: fix bug in connection management
 * osd: fix for op ordering when rebalancing
 * ceph-fuse: report file system size with correct units
 * mds: get and set directory layout policies via virtual xattrs
 * mkcephfs, init-ceph: close potential security issues with predictable 
   filenames

There is one minor change (fix) in the output to the 'ceph osd tree 
--format=json' command. Please see the full release notes.

You can get v0.56.4 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.56.4.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
