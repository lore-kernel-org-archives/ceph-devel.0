From: Sage Weil <sweil@redhat.com>
Subject: The first infernalis dev release will be v9.0.0
Date: Mon, 4 May 2015 09:09:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504301528410.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53837 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbbEDQJr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 May 2015 12:09:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

The first Ceph release back in Jan of 2008 was 0.1.  That made sense at 
the time.  We haven't revised the versioning scheme since then, however, 
and are now at 0.94.1 (first Hammer point release).  To avoid reaching 
0.99 (and 0.100 or 1.00?) we have a new strategy.  This was discussed a 
bit on ceph-devel and in #ceph-devel and there doesn't appear to be any 
scheme that everyone likes.

So, we're going to go with something that only a few people dislike:

 x.0.z - development releases (for early testers and the brave at heart)
 x.1.z - release candidates (for test clusters, brave users)
 x.2.z - stable/bugfix releases (for users)

x will start at 9 for Infernalis ("I" is the 9th letter), making our first 
development release of the 9th release cycle 9.0.0.  Subsequent 
development releases will be 9.0.1, 9.0.2, etc.

In a couple months we'll have a 9.1.0 (and maybe 9.1.1) release candidate.

A few weeks after that we'll have the Infernalis release 9.2.0, followed 
by stable bug fix updates 9.2.1, 9.2.2, etc., and then begin work on the 
Jewel (10.y.z) release.

We'll see how this works out.  We can adjust this in the future to any 
other 9.y.z scheme (e.g., 9.1, 9.2 etc dev releases and 9.8.z stable 
releases); the main commitment here is to the 9 part, indicating 
Infernalis is the 9th major release cycle.

Onward!
sage
