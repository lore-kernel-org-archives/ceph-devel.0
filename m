From: Sage Weil <sage@inktank.com>
Subject: bobtail release candidates
Date: Sun, 25 Nov 2012 09:57:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211250953400.23552@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41272 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab2KYR5d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 12:57:33 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7C9A8800BB
	for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 09:57:33 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 599C8800BB
	for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 09:57:33 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

There are automatic builds of the prerelease bobtail code available under 
the 'next' branch.

For debs,
	http://ceph.com/docs/master/install/debian/#add-development-testing-packages

For example, for Ubuntu 12.04 precise,
	http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/next/

And RPMs for el6,
	http://gitbuilder.ceph.com/ceph-rpm-centos6-x86_64-basic/ref/next/RPMS/x86_64/

Any testing and early feedback is greatly appreciated.

Thanks!
sage
