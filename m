From: Sage Weil <sage@inktank.com>
Subject: v0.59 released
Date: Thu, 21 Mar 2013 07:48:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303202216400.6202@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33783 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab3CUOsH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 10:48:07 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Another sprint and another release!  This one is delayed a day or two due 
to power issues in our data center.  The most exciting bit here is a big 
refactor in the monitor that has finally landed (thanks go to Joao Luis), 
but there is lots of other good stuff to go around:

 * mon: rearchitected to utilize single instance of paxos and a key/value 
   store (Joao Luis)
 * mon: new 'ceph df [detail]' command
 * osd: support for improved hashing of PGs across OSDs via HASHPSPOOL 
   pool flag and feature
 * osd: refactored watch/notify infrastructure (fixes protocol, removes 
   many bugs) (Sam Just) 
 * osd, librados: ability to list watchers (David Zafman)
 * osd, librados: new listsnaps command (David Zafman)
 * osd: trim log more aggressively, avoid appearance of leak memory
 * osd: misc split fixes
 * osd: a few journaling bug fixes
 * osd: connection handling bug fixes
 * rbd: avoid FIEMAP when importing from file (it can be buggy)
 * librados: fix linger bugs (Josh Durgin)
 * librbd: fixed flatten deadlock (Josh Durgin)
 * rgw: fixed >4MB range requests (Jan Harkes)
 * rgw: fix log rotation
 * mds: allow xattrs on root
 * ceph-fuse: fix statfs(2) reporting
 * msgr: optionally tune TCP buffer size to avoid throughput collapse (Jim 
   Schutt)
 * consume less memory for logging by default
 * always use system leveldb (Gary Lowell)

WARNING: We noticed the librados headers are broken as the build was going 
out, and the fix just missed the build.  We'll do a point release if 
anyone needs it.

When upgrading, try to avoid leaving mixed monitor versions for long 
periods of time; see the release notes for more details:

	http://ceph.com/docs/master/release-notes/#v0-59

In other news, the ceph-cookbooks for Chef just got a long-overdue update.  
If you are a Chef user, please take a look at the updated repo on github 
and let us know what you think (or better yet start sending your pull 
requests our way):

	http://github.com/ceph/ceph-cookbooks

I should also mention that, although you don't see much action here, Caleb 
and Yehuda are hard at work on the multi-site, disaster recovery, and API 
features for radosgw.

You can get v0.59 from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.59.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm

