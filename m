From: Sage Weil <sage@inktank.com>
Subject: v0.56 released
Date: Mon, 31 Dec 2012 22:02:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212311721310.1906@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39024 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3AAGCD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jan 2013 01:02:03 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 11275803BC
	for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 22:02:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E0733803BC
	for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 22:02:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We're bringing in the new year with a new release, v0.56, which will form 
the basis of the next stable series "bobtail." There is little in the way 
of new functionality since v0.55, as we've been focusing primarily on 
stability, performance, and upgradability from the previous argonaut 
stable series (v0.48.x). If you are a current argonaut user, you can 
either upgrade now, or watch the Inktank blog for the bobtail announcement 
after some additional testing has been completed. If you are a v0.55 or 
v0.55.1 user, we recommend upgrading now.

Notable changes since v0.55 include:

 * librbd: fixes for read-only pools for image cloning
 * osd: fix for mixing argonaut and post-v0.54 OSDs
 * osd: some recovery tuning
 * osd: fix for several scrub, recovery, and watch/notify races/bugs
 * osd: fix pool_stat_t backwawrd compatibility with pre-v0.41 clients
 * osd: experimental split support
 * mkcephfs: misc fixes for fs initialization, mounting
 * radosgw: usage and op logs off by default
 * radosgw: keystone authentication off by default
 * upstart: only enabled with 'upstart' file exists in daemon data 
   directory
 * mount.fuse.ceph: allow mounting of ceph-fuse via /etc/fstab
 * config: always complain about config parsing errors
 * mon: fixed memory leaks, misc bugs
 * mds: many misc fixes

Notable changes since v0.48.2 ("argonaut"):

 * auth: authentication is now on by default; see release notes!
 * osd: improved threading, small io performance
 * osd: deep scrubbing (verify object data)
 * osd: chunky scrubs (more efficient)
 * osd: improved performance during recovery
 * librbd: cloning support
 * librbd: fine-grained striping support
 * librbd: better caching
 * radosgw: improved Swift and S3 API coverage (POST, multi-object delete, 
   striping)
 * radosgw: OpenStack Keystone integration
 * radosgw: efficient usage stats aggregation (for billing)
 * crush: improvements in distribution (still off by default; see CRUSH 
   tunables)
 * ceph-fuse, mds: general stability improvements
 * release RPMs for OpenSUSE, SLES, Fedora, RHEL, CentOS
 * tons and bug fixes and small improvements across the board

If you are upgrading from v0.55, there are no special upgrade 
instructions. If you are upgrading from an older version, please read the 
release notes. Authentication is now enabled by default, and if you do not 
adjust your ceph.conf accordingly before upgrading the system will not 
come up by itself.

You can get this release from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.56.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm

