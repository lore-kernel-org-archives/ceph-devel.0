From: Sage Weil <sage@inktank.com>
Subject: v0.53 released
Date: Tue, 16 Oct 2012 16:48:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210161647550.5342@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33300 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab2JPXs5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Oct 2012 19:48:57 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5CD548044E
	for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 16:48:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 38D368044E
	for <ceph-devel@vger.kernel.org>; Tue, 16 Oct 2012 16:48:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Another development release of Ceph is ready, v0.53. We are getting pretty 
close to what will be frozen for the next stable release (bobtail), so if 
you would like a preview, give this one a go. Notable changes include:

 * librbd: image locking
 * rbd: fix list command when more than 1024 (format 2) images
 * osd: backfill reservation framework (to avoid flooding new osds with 
   backfill data)
 * osd, mon: honor new 'nobackfill' and 'norecover' osdmap flags
 * osd: new 'deep scrub' will compare object content across replicas (once 
   per week by default)
 * osd: crush performance improvements
 * osd: some performance improvements related to request queuing
 * osd: capability syntax improvements, bug fixes
 * osd: misc recovery fixes
 * osd: fix memory leak on certain error paths
 * osd: default journal size to 1 GB
 * crush: default root of tree type is now 'root' instead of 'pool' (to 
   avoid confusiong wrt rados pools)
 * ceph-fuse: fix handling for .. in root directory
 * librados: some locking fixes
 * mon: some election bug fixes
 * mon: some additional on-disk metadata to facilitate future mon changes 
   (post-bobtail)
 * mon: throttle osd flapping based on osd history (limits osdmap 
   "thrashing" on overloaded or unhappy clusters)
 * mon: new 'osd crush create-or-move ...' command
 * radosgw: fix copy-object vs attributes
 * radosgw: fix bug in bucket stat updates
 * mds: fix ino release on abort session close, relative getattr path, mds 
   shutdown, other misc items
 * upstart: stop jobs on shutdown
 * common: thread pool sizes can now be adjusted at runtime
 * build fixes for Fedora 18, CentOS/RHEL 6

The big items are locking support in RBD, and OSD improvements like deep 
scrub (which verify object data across replicas) and backfill reservations 
(which limit load on expanding clusters). And a huge swath of bugfixes and 
cleanups, many due to feeding the code through scan.coverity.com (they 
offer free static code analysis for open source projects).

v0.54 is now frozen, and will include many deployment-related fixes 
(including a new ceph-deploy tool to replace mkcephfs), more bugfixes for 
libcephfs, ceph-fuse, and the MDS, and the fruits of some performance work 
on the OSD.

You can get v0.53 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.53.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
