From: Sage Weil <sage@inktank.com>
Subject: v0.67-rc3 Dumpling release candidate
Date: Thu, 1 Aug 2013 11:11:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308011108420.22584@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36340 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315Ab3HASLz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 14:11:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

We've tagged and pushed out packages for another release candidate for 
Dumpling.  At this point things are looking very good.  There are a few 
odds and ends with the CLI changes but the core ceph functionality is 
looking quite stable.  Please test!

Packages are available in the -testing repos:

	http://ceph.com/debian-testing/
	http://ceph.com/rpm-testing/

Note that at any time you can also run the latest code for the pending 
release from

	http://gitbuilder.ceph.com/ceph-deb-$DISTRO-x86_64-basic/ref/next/

The draft release notes for v0.67 dumpling are at

	http://ceph.com/docs/master/release-notes/

You can see our bug queue at

	http://tracker.ceph.com/projects/ceph/issues?query_id=27

Happy testing!
sage
