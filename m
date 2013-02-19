From: Sage Weil <sage@inktank.com>
Subject: v0.57 released
Date: Tue, 19 Feb 2013 15:01:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302191500540.7906@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36329 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933341Ab3BSXCA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 18:02:00 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

We've been spending a lot of time working on bobtail-related stabilization 
and bug fixes, but our next development release v0.57 is finally here! 
Notable changes include:

 * osd: default to libaio for the journal (some performance boost)
 * osd: validate snap collections on startup
 * osd: ceph-filestore-dump tool for debugging
 * osd: deep-scrub omap keys/values
 * ceph tool: some CLI interface cleanups
 * mon: easy adjustment of crush tunables via 'ceph osd crush tunables ...'
 * mon: easy creation of crush rules vai 'ceph osd rule ...'
 * mon: approximate recovery, IO workload stats
 * mon: avoid marking entire CRUSH subtrees out (e.g., if an entire rack 
   goes offline)
 * mon: safety check for pool deletion
 * mon: new checks for identifying and reporting clock drift
 * radosgw: misc fixes
 * rbd: wait for udev to settle in strategic places (avoid spurious 
   errors, failures)
 * rbd-fuse: new tool, package
 * mds, ceph-fuse: manage layouts via xattrs
 * mds: misc bug fixes with clustered MDSs and failure recovery
 * mds: misc bug fixes with readdir
 * libcephfs: many fixes, cleanups with the Java bindings
 * auth: ability to require new cephx signatures on messages (still off by 
   default)

The last couple of weeks have also seen steady forward progress on v0.58, 
which will be out in two weeks. Now is probably as good a time as any to 
mention that we've solidified our release timeline for the next couple of 
months. Each development release will be out on a regular two-week 
schedule (feature-frozen and then delayed one sprint, or two weeks, for 
QA), culminating in the freeze for v0.61 "cuttlefish" at the beginning of 
April, to be released at the end of the month.

You can get v0.57 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball athttp://ceph.com/download/ceph-0.57.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
