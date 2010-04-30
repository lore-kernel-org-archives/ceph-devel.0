From: Sage Weil <sage@newdream.net>
Subject: v0.20 released
Date: Fri, 30 Apr 2010 16:36:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004301529210.5318@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41046 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980Ab0D3Xda (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Apr 2010 19:33:30 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D0053BC788
	for <ceph-devel@vger.kernel.org>; Fri, 30 Apr 2010 16:36:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A53D8BC788
	for <ceph-devel@vger.kernel.org>; Fri, 30 Apr 2010 16:36:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After a long few weeks of debugging, we're releasing v0.20.  The goal here 
is to get something out prior to the v2.6.34 kernel release (which will 
include the Ceph client) with most of the pending improvements.  Changes 
since v0.19 include:

    * osd: new filestore, journaling infrastructure.  (lower latency 
      writes, btrfs no longer strictly required)
    * msgr: wire protocol improvements
    * mds: reduced memory utilization (still more to do!)
    * auth: many auth_x cleanups and improvements
    * librados: some cleanup; C++ API now usable
    * many bug fixes throughout

There are a handful of bugs that we've seen but haven't been able to 
reproduce reliably.  As those are fixed there will be a v0.20.1 point 
release.  In the meantime, work continues on v0.21.  Upcoming changes 
include:

    * performance improvements
    * rbd: rados block device (kvm and native linux drivers)
    * flock/fnctl lock support
    * lazy io
    * allow client reconnect even after mds has restarted (useful for 
      clients temporarily disconnected during mds restarts)
    * cluster mds fixes

To get it:

    * Direct download at http://ceph.newdream.net/download/ceph-v0.20.tar.gz
    * For Debian packages see http://ceph.newdream.net/wiki/Debian

RPMs will be included in the soon to be released Fedora 13.  There is also 
a ceph.spec file in git to build your own.

sage
