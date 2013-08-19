From: Sage Weil <sage@inktank.com>
Subject: v0.61.8 Cuttlefish released
Date: Mon, 19 Aug 2013 12:56:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308191251390.11136@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50378 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab3HST4I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Aug 2013 15:56:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

We've made another point release for Cuttlefish. This release contains a 
number of fixes that are generally not individually critical, but do trip 
up users from time to time, are non-intrusive, and have held up under 
testing.

Notable changes include:

 * librados: fix async aio completion wakeup
 * librados: fix aio completion locking
 * librados: fix rare deadlock during shutdown
 * osd: fix race when queueing recovery operations
 * osd: fix possible race during recovery
 * osd: optionally preload rados classes on startup (disabled by default)
 * osd: fix journal replay corner condition
 * osd: limit size of peering work queue batch (to speed up peering)
 * mon: fix paxos recovery corner case
 * mon: fix rare hang when monmap updates during an election
 * mon: make osd pool mksnap ... avoid exposing uncommitted state
 * mon: make osd pool rmsnap ... not racy, avoid exposing uncommitted state
 * mon: fix bug during mon cluster expansion
 * rgw: fix crash during multi delete operation
 * msgr: fix race conditions during osd network reinitialization
 * ceph-disk: apply mount options when remounting

For more detailed information, please see the detailed release notes and 
complete changelog:

 * http://ceph.com/docs/master/release-notes/#v0-61-8-cuttlefish
 * http://ceph.com/docs/master/_downloads/v0.61.8.txt

You can get v0.61.8 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.61.8.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm

