From: Sage Weil <sage@inktank.com>
Subject: all rbd users: set 'filestore fiemap = false'
Date: Sun, 17 Jun 2012 21:02:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206172053320.16985@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45958 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab2FRECS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 00:02:18 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AFB72BC60D
	for <ceph-devel@vger.kernel.org>; Sun, 17 Jun 2012 21:02:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7D09FBC60D
	for <ceph-devel@vger.kernel.org>; Sun, 17 Jun 2012 21:02:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If you are using RBD, and want to avoid potential image corruption, add

	filestore fiemap = false

to the [osd] section of your ceph.conf and restart your OSDs.

We've tracked down the source of some corruption to racy/buggy FIEMAP 
ioctl behavior.  The RBD client (when caching is diabled--the default) 
uses a 'sparse read' operation that the OSD implements by doing an fsync 
on the object file, mapping which extents are allocated, and sending only 
that data over the wire.  We have observed incorrect/changing FIEMAP on 
both btrfs:

	fsync
	fiemap returns mapping
	<time passes, no modifications to file>
	fiemap returns different mapping

Josh is still tracking down which kernels and file system are affected; 
fortunately it is relatively easy to reproduce with the test_librbd_fsx 
tool.  In the meantime, the (mis)feature can be safely disabled. It will 
default to off in 0.48. It is unclear whether it's really much of a 
performance win anyway.

Thanks!
sage
