From: Sage Weil <sage@inktank.com>
Subject: v0.48.1 argonaut stable update released
Date: Tue, 14 Aug 2012 11:18:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208141116420.18862@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55892 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab2HNSSw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 14:18:52 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 101FA80446
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 11:18:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E00FD80446
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 11:18:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've built and pushed the first update to the argonaut stable release.  
This branch has a range of small fixes for stability, compatibility, and 
performance, but no major changes in functionality.  The stability fixes 
are particularly important for large clusters with many OSDs, and for 
network environments where intermittent network failures are more common.

The highlights include:

 * mkcephfs: use default `keyring', `osd data', `osd journal' paths when 
   not specified in conf
 * msgr: various fixes to socket error handling
 * osd: reduce scrub overhead
 * osd: misc peering fixes (past_interval sharing, pgs stuck in `peering' 
   states)
 * osd: fail on EIO in read path (do not silently ignore read errors from 
   failing disks)
 * osd: avoid internal heartbeat errors by breaking some large 
   transactions into pieces
 * osd: fix osdmap catch-up during startup (catch up and then add daemon 
   to osdmap)
 * osd: fix spurious `misdirected op' messages
 * osd: report scrub status via `pg # query'
 * rbd: fix race when watch registrations are resent
 * rbd: fix rbd image id assignment scheme (new image data objects have 
   slightly different names)
 * rbd: fix perf stats for cache hit rate
 * rbd tool: fix off-by-one in key name (crash when empty key specified)
 * rbd: more robust udev rules
 * rados tool: copy object, pool commands
 * radosgw: fix in usage stats trimming
 * radosgw: misc compatibility fixes (date strings, ETag quoting, swift 
   headers, etc.)
 * ceph-fuse: fix locking in read/write paths
 * mon: fix rare race corrupting on-disk data
 * config: fix admin socket `config set' command
 * log: fix in-memory log event gathering
 * debian: remove crush headers, include librados-config
 * rpm: add ceph-disk-{activate, prepare}

The fix for the radosgw usage trimming is incompatible with v0.48 (which 
was effectively broken).  You now need to use the v0.48.1 version of 
radosgw-admin to initiate usage stats trimming.

There are a range of smaller bug fixes as well.  For a complete list of 
what went into this release, please see the release notes and changelog.

You can get this stable update from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.48.1.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/master/install/debian

