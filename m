From: Sage Weil <sage@inktank.com>
Subject: v0.56.1 released
Date: Mon, 7 Jan 2013 20:53:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301072052180.20676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45612 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab3AHExv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 23:53:51 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5C8B08044E
	for <ceph-devel@vger.kernel.org>; Mon,  7 Jan 2013 20:53:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 37B1F8044E
	for <ceph-devel@vger.kernel.org>; Mon,  7 Jan 2013 20:53:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We found a few critical problems with v0.56, and fixed a few outstanding 
problems. v0.56.1 is ready, and we're pretty pleased with it!

There are two critical fixes in this update: a fix for possible data loss 
or corruption if power is lost, and a protocol compatibility problem that 
was introduced in v0.56 (between v0.56 and any other version of ceph).

 * osd: fix commit sequence for XFS, ext4 (or any other non-btrfs) to 
   prevent data loss on power cycle or kernel panic
 * osd: fix compatibility for CALL operation
 * osd: process old osdmaps prior to joining cluster (fixes slow startup)
 * osd: fix a couple of recovery-related crashes
 * osd: fix large io requests when journal is in (non-default) aio mode
 * log: fix possible deadlock in logging code

This release will kick off the bobtail backport series, and will get a 
shiny new URL for it's home.

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.56.1.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
