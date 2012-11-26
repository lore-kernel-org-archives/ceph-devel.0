From: Sage Weil <sage@inktank.com>
Subject: stable ceph kernels
Date: Mon, 26 Nov 2012 14:55:39 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211261446020.3409@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53343 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932222Ab2KZWzk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 17:55:40 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B384480060
	for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 14:55:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8CA4080060
	for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 14:55:39 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Quick update:

The latest set of fixes for known bugs in the ceph fs and rbd kernel 
clients are now present in the stable 3.6.7 and 3.4.20 stable kernels 
(available via kernel.org).

The 3.5.y series is being maintained by Canonical for another year or so 
(it's used for 12.10 quantal), and bugfixes have been queued there as 
well, but have not yet been released.

Moving forward, we intend to send all future fixes to 3.4 and later stable 
kernels.  Suse has done some backporting work for kernel RBD to older 
kernels, but we don't have a formal maintenance plan there yet.

Note that aside from the issue Nick reported last week (rbd map hang), 
there aren't any known stability problems with the kernel rbd driver.  Or 
cephfs, for that matter; known bugs there are related to clustered mds and 
corner cases we haven't yet prioritized.  If you are seeing problems with 
the kernel ceph client with these version, it is news to us; please let us 
know!

Thanks-
sage
