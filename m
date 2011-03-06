From: Sage Weil <sage@newdream.net>
Subject: v0.25 released
Date: Sat, 5 Mar 2011 21:00:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103041524260.20043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58243 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab1CFE6g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Mar 2011 23:58:36 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 037FDBC692
	for <ceph-devel@vger.kernel.org>; Sat,  5 Mar 2011 21:00:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D59DDBC692
	for <ceph-devel@vger.kernel.org>; Sat,  5 Mar 2011 21:00:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've just tagged the v0.25 release.  Most of the work here is in the OSD 
cluster, a new librbd library (refactoring existing RBD infrastructure), 
and a librados API refresh.

The librados changes are an attempt to clean up the API warts sooner 
rather than later.  If there are any issues with the new interface, we'd 
like to hear about them!

The new librbd library sits on top of librados and captures the RBD 
striping, snapshotting, and other functionality, presenting a simple 
block device-like interface.  The qemu/KVM driver is being rewritten in 
terms of librbd, which will vastly simplify the upstream qemu code and 
allow us to fix bugs and add functionality without being tied to a 
specific version of qemu/KVM.

Other changes since v0.24 include:

 * osd: fix map churn while peering
 * osd: "watch/notify" framework for RBD synchronization
 * osd: ability to read from closest replica
 * osd: many bug fixes
 * osd: improved recovery behavior (tolerate missing objects)
 * mds: misc clustering fixes
 * mds: fix respawn
 * mds: misc bug fixes
 * mds: "hot standby" behavior
 * /etc/ceph/keyring instead of keyring.bin
 * ability to log to syslog

The focus for v0.26 will remain on stability, primary with the OSD 
cluster, RBD, and radosgw.  Internally, we're focusing on building out our 
QA and performance testing infrastructure.

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.25.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian

sage
