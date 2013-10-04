From: Sage Weil <sage@inktank.com>
Subject: v0.67.4 released
Date: Fri, 4 Oct 2013 16:55:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310041650540.30223@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58960 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab3JDXzX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Oct 2013 19:55:23 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

This point release fixes an important performance issue with radosgw, 
keystone authentication token caching, and CORS.  All users (especially 
those of rgw) are encouraged to upgrade.

Notable changes:

 * crush: fix invalidation of cached names
 * crushtool: do not crash on non-unique bucket ids
 * mds: be more careful when decoding LogEvents
 * mds: fix heap check debugging commands
 * mon: avoid rebuilding old full osdmaps
 * mon: fix 'ceph crush move ...'
 * mon: fix 'ceph osd crush reweight ...'
 * mon: fix writeout of full osdmaps during trim
 * mon: limit size of transactions
 * mon: prevent both unmanaged and pool snaps
 * osd: disable xattr size limit (prevents upload of large rgw objects)
 * osd: fix recovery op throttling
 * osd: fix throttling of log messages for very slow requests
 * rgw: drain pending requests before completing write
 * rgw: fix CORS
 * rgw: fix inefficient list::size() usage
 * rgw: fix keystone token expiration
 * rgw: fix minor memory leaks
 * rgw: fix null termination of buffer

For more detail:

 * http://ceph.com/docs/master/release-notes/#v0-67-4-dumpling
 * http://ceph.com/docs/master/_downloads/v0.67.4.txt

You can get v0.67.4 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.67.4.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
