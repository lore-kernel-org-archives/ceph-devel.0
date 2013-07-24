From: Sage Weil <sage@inktank.com>
Subject: v0.61.6 Cuttlefish update released
Date: Tue, 23 Jul 2013 21:47:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307232146370.334@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46645 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab3GXErw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jul 2013 00:47:52 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

There was a problem with the monitor daemons in v0.61.5 that would prevent 
them from restarting after some period of time.  This release fixes the 
bug and works around the issue to allow affected monitors to restart.  
All v0.61.5 users are strongly recommended to upgrade.

Thanks everyone who helped track the problem down!

Notable changes:

 * mon: record latest full osdmap
 * mon: work around previous bug in which latest full osdmap was not 
   recorded
 * mon: avoid scrub while paxos is updating

For more information please see the complete release notes:

 * http://ceph.com/docs/master/release-notes/#v0-61-6-cuttlefish

You can get v0.61.6 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.61.6.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
 
