From: Sage Weil <sage@inktank.com>
Subject: v0.61.7 Cuttlefish update released
Date: Thu, 25 Jul 2013 15:13:28 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307251508220.23376@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39519 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab3GYWN2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 18:13:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-useres@inktank.com

This release fixes another regression preventing monitors to start after 
undergoing certain upgrade sequences, as well as some corner cases with 
Paxos and unusual device names in ceph-disk/cephde-loy.

Notable changes:

 * mon: fix regression in latest full osdmap retrieval
 * mon: fix a long-standing bug with a paxos corner case
 * ceph-disk: improved support for unusual device names (e.g., 
   /dev/cciss/c0d0p1)

For more information see the full release notes at

 * http://ceph.com/docs/master/release-notes/#v0-61-7-cuttlefish

You can get v0.61.7 from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.61.7.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
