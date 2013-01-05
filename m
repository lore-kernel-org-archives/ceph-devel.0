From: Sage Weil <sage@inktank.com>
Subject: librados/librbd compatibility issue with v0.56
Date: Fri, 4 Jan 2013 21:00:43 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301042056030.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40113 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab3AEFAo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 00:00:44 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DE23B80068
	for <ceph-devel@vger.kernel.org>; Fri,  4 Jan 2013 21:00:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B6EFE80068
	for <ceph-devel@vger.kernel.org>; Fri,  4 Jan 2013 21:00:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We identified a problem with the version of librbd/librados in v0.56.  
There will be a v0.56.1 update in a few days that fixes it.  In the 
meantime, be aware that v0.56 ceph-osds may not interact properly with 
non-v0.56 radosgw or librbd clients, and v0.56 radosgw and librbd clients 
will not interact properly with non-v0.56 OSDs.

If you are using v0.56, we recommend moving to the current testing branch, 
which includes fixes queued up for v0.56.1.  You can get debs from e.g.

  http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/testing/

or for other many other distros; see 

  http://ceph.com/docs/master/install/debian/#add-development-testing-packages

The fix is commit d3abd0fe0bb402ff403259d4b1a718a56331fc39 
(921e06decebccc913c0e4f61916d00e62e7e1635 in testing branch).

Thanks!
sage
