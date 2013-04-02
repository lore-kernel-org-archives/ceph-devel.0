From: Sage Weil <sage@inktank.com>
Subject: v0.60 released
Date: Mon, 1 Apr 2013 19:16:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1304011817500.28170@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38055 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758828Ab3DBCQt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Apr 2013 22:16:49 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

Another sprint and another release!  This is the last development release 
before v0.61 Cuttlefish, which is due out in 4 weeks (around May 1).  The 
next few weeks will be focused on making sure everything we've built over 
the last few months is rock solid and ready for you.  We will have an -rc 
release ready for you in a couple of weeks.  In the meantime, v0.60 has a 
few goodies:

* osd: make tracking of object snapshot metadata more efficient (Sam Just)
* osd: misc fixes to PG split (Sam Just)
* osd: improve journal corruption detection (Sam Just)
* osd: improve handling when disk fills up (David Zafman)
* osd: add 'noscrub', 'nodeepscrub' osdmap flags (David Zafman)
* osd: fix hang in 'journal aio = true' mode (Sage Weil)
* ceph-disk-prepare: fix mkfs args on old distros (Alexandre Marangone)
* ceph-disk-activate: improve multicluster support, error handling (Sage 
  Weil)
* librbd: optionally wait for flush before enabling writeback (Josh 
  Durgin)
* crush: update weights for all instances of an item, not just the first 
  (Sage Weil)
* mon: shut down safely if disk approaches full (Joao Luis)
* rgw: fix Content-Length on 32-bit machines (Jan Harkes)
* mds: store and update backpointers/traces on directory, file objects 
  (Sam Lang)
* mds: improve session cleanup (Sage Weil)
* mds, ceph-fuse: fix bugs with replayed requests after MDS restart (Sage 
  Weil)
* ceph-fuse: enable kernel cache invalidation (Sam Lang)
* libcephfs: new topo API requests for Hadoop (Noah Watkins)
* ceph-fuse: session handling cleanup, bug fixes (Sage Weil)
* much code cleanup and optimization (Danny Al-Gaaf)
* use less memory for logging by default
* upstart: automatically set osd weight based on df (Guilhem Lettron)
* init-ceph, mkcephfs: close a few security holes with -a  (Sage Weil)
* rpm/deb: do not remove /var/lib/ceph on purge (v0.59 was the only 
  release to do so)

You can get v0.60 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.60.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
