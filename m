From: Sage Weil <sage@inktank.com>
Subject: 2 more weeks until v0.57
Date: Tue, 5 Feb 2013 09:37:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302050922130.25165@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58662 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3BERhD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 12:37:03 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9C7A780068
	for <ceph-devel@vger.kernel.org>; Tue,  5 Feb 2013 09:37:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 66B2A80068
	for <ceph-devel@vger.kernel.org>; Tue,  5 Feb 2013 09:37:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We got a bit sloppy this sprint in that a lot of fixes went into the 
master branch instead of the frozen 'next' branch, which was slated to 
become v0.57.  Many/most of those were backported to v0.56.x.  That means 
what was intended to become v0.57 has many regressions relative to 
v0.56.2, and isn't really useful to anyone.

Instead of releasing it, we're just going to re-freeze the master for 
release in 2 weeks at the end of this sprint.

For those who are committing to ceph.git: please take care to put any 
fixes in 'next' instead of 'master'.

thanks!
sage
