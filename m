From: Sage Weil <sage@inktank.com>
Subject: v0.67.9 Dumpling released
Date: Wed, 21 May 2014 13:02:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405211300500.25785@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41421 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187AbaEUUC2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 May 2014 16:02:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

This Dumpling point release fixes several minor bugs. The most prevalent 
in the field is one that occasionally prevents OSDs from starting on 
recently created clusters.

We recommand that all v0.67.x Dumpling users upgrade at their convenience.

Notable Changes
---------------

* ceph-fuse, libcephfs: client admin socket command to kick and inspect 
  MDS sessions (#8021, Zheng Yan)
* monclient: fix failure detection during mon handshake (#8278, Sage Weil)
* mon: set tid on no-op PGStatsAck messages (#8280, Sage Weil)
* msgr: fix a rare bug with connection negotiation between OSDs (Guang 
  Yang)
* osd: allow snap trim throttling with simple delay (#6278, Sage Weil)
* osd: check for splitting when processing recover/backfill reservations 
  (#6565, Samuel Just)
* osd: fix backfill position tracking (#8162, Samuel Just)
* osd: fix bug in backfill stats (Samuel Just)
* osd: fix bug preventing OSD startup for infant clusters (#8162, Greg 
  Farnum)
* osd: fix rare PG resurrection race causing an incomplete PG (#7740, 
  Samuel Just)
* osd: only complete replicas count toward min_size (#7805, Samuel Just)
* rgw: allow setting ACLs with empty owner (#6892, Yehuda Sadeh)
* rgw: send user manifest header field (#8170, Yehuda Sadeh)

For more detailed information, see the complete changelog at

  http://ceph.com/docs/master/_downloads/v0.67.9.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.67.9.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy

