From: Sage Weil <sage@inktank.com>
Subject: v0.54 released
Date: Tue, 13 Nov 2012 17:15:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211131714410.25991@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53550 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077Ab2KNBPl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 20:15:41 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4089C8004F
	for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 17:15:41 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1B27D8004F
	for <ceph-devel@vger.kernel.org>; Tue, 13 Nov 2012 17:15:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The v0.54 development release is ready! This will be the last development 
release before v0.55 "bobtail," our next long-term stable release, is 
ready. Notable changes this time around include:

 * osd: use entire device if journal is a block device
 * osd: new caps structure (see below)
 * osd: backfill target reservations (improve performance during recovery)
 * ceph-fuse: many fixes (including memory leaks, hangs)
 * radosgw: REST API for managing usage stats
 * radosgw: many small fixes, cleanups (coverity)
 * mds: misc fixes for multi-mds clusters
 * rbd: ls -l
 * ceph-disk-prepare: support for external journals, default mount/mkfs 
   options, etc.
 * ceph-debugpack: miscimprovements

There isn't anything especially exciting here; most of the big stuff is 
landing in v0.55, which will become bobtail. Most of our effort over the 
next few weeks will be on make sure that v0.55 bobtail is rock solid and 
performs well.

Note that the syntax for the OSD capabilities have changed slightly. If 
you use non-default capabilities, please refer to the full release notes.

You can get v0.54 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball athttp://ceph.com/download/ceph-0.54.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
