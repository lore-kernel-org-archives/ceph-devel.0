From: Sage Weil <sage@inktank.com>
Subject: v0.67.5 dumpling released
Date: Sat, 21 Dec 2013 21:23:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312212121250.6194@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40376 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3LVFX0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Dec 2013 00:23:26 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

This release includes a few critical bug fixes for the radosgw, including 
a fix for hanging operations on large objects. There are also several bug 
fixes for radosgw multi-site replications, and a few backported features. 
Also, notably, the osd perf command (which dumps recent performance 
information about active OSDs) has been backported.

We recommend that all 0.67.x Dumpling users upgrade.

Notable changes:

 * ceph-fuse: fix crash in caching code
 * mds: fix looping in populate_mydir()
 * mds: fix standby-replay race
 * mon: accept osd pool set ... as string
 * mon: backport: osd perf command to dump recent OSD performance stats
 * osd: add feature compat check for upcoming object sharding
 * rbd.py: increase parent name size limit
 * rgw: backport: allow wildcard in supported keystone roles
 * rgw: backport: improve swift COPY behavior
 * rgw: backport: log and open admin socket by default
 * rgw: backport: validate S3 tokens against keystone
 * rgw: fix bucket removal
 * rgw: fix client error code for chunked PUT failure
 * rgw: fix hang on large object GET
 * rgw: fix rare use-after-free
 * rgw: various DR bug fixes
 * sysvinit, upstart: prevent starting daemons using both init systems

For the complete changelog, see

 * http://ceph.com/docs/master/_downloads/v0.67.5.txt

You can get v0.67.5 from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.67.5.tar.gz
 * For packages, see http://ceph.com/docs/master/install/get-packages/
 * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy/
