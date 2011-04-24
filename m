From: Sage Weil <sage@newdream.net>
Subject: v0.27 released
Date: Sat, 23 Apr 2011 21:51:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104232136330.9549@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57678 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1DXEvZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 24 Apr 2011 00:51:25 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 20C4FBC69F
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2011 21:51:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DC0A7BC69F
	for <ceph-devel@vger.kernel.org>; Sat, 23 Apr 2011 21:51:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v0.27 is done!  This mostly bugfixes, cleanups, and incremental 
improvements.  Notably:

 * lots of cleanups in config file loading, handling, to make library 
behavior sane, warn on config file errors, etc.
 * osd: fix out of order ack bug
 * mount.ceph: uses kernel keys interface (when available) to pass secrets
 * osd, mon: use new syncfs() syscall where available
 * librados: compound object operation support
 * librbd: snapshot images no longer writeable
 * librbd: rollback to snapshot and other misc fixes
 * mds: journal replay cleanups, performance, bug fixes
 * mds: many clustered mds fixes (mostly with rename and recovery)
 * mds: standby-replay mode fixes
 * mds: robust lookuphash for better nfs reexport support
 * mon: bugfixes with mds takeover
 * obsync: synchronize object buckets between s3, directory, swift, rados
 * osd: misc recovery fixes
 * radosgw: dup bucket creation fixes
 * radosgw: many small protocol fixes

As part of the radosgw work we've created s3-tests.git, which includes a 
bunch of simple tests to verify implementations of the s3 protocol.  See

 * git://ceph.newdream.net/git/s3-tests.git
 * http://ceph.newdream.net/git/?p=s3-tests.git;a=summary

For v0.28 we're focusing on the OSD cluster, radosgw, and continuing with 
the MDS clustering fixes.  Sam and Josh are working on a refactor in the 
OSD peering code that will make peering more understandable, verifiable, 
and (we hope) less buggy. 

Relevant URLs:
 * Direct download at: http://ceph.newdream.net/download/ceph-0.27.tar.gz
 * For Debian and Ubuntu packages, see http://ceph.newdream.net/wiki/Debian
