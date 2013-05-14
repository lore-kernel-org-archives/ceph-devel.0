From: Sage Weil <sage@inktank.com>
Subject: v0.62 released
Date: Tue, 14 May 2013 16:00:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305141557310.19562@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37743 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758431Ab3ENXAd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 19:00:33 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 75B69800BA
	for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 16:00:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5C447800BA
	for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 16:00:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is the first release after cuttlefish.  Since most of this window was 
spent on stabilization, there isn't a lot of new stuff here aside from 
cleanups and fixes (most of which are backported to v0.61). v0.63 is due 
out in 2 weeks and will have more goodness.

 * mon: fix validation of mds ids from CLI commands
 * osd: fix for an op ordering bug
 * osd, mon: optionally dump leveldb transactions to a log
 * osd: fix handling for split after upgrade from bobtail
 * debian, specfile: packaging cleanups
 * radosgw-admin: create keys for new users by default
 * librados python binding cleanups
 * misc code cleanups

You can get v0.62 from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.62.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
