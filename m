From: Sage Weil <sage@inktank.com>
Subject: v0.49 released
Date: Mon, 23 Jul 2012 20:57:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207232056290.27559@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34980 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753538Ab2GXD5X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jul 2012 23:57:23 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B48EF81352
	for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 20:57:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 846C981352
	for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 20:57:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This release is a bit less exciting than most because it is the first 
development release since argonaut, and much of our time has been spent 
working on stability. Most of those fixes have been backported and slated 
for the next argonaut point release (v0.48.1).  I'll include both below; 
see the 0.48.1 release notes (when it's available later this week) to see 
what changes with argonaut.

 * mon: 'ceph osd crush move' command lets you rearrange your CRUSH 
   hierarchy
 * osd: scrub efficiency improvement
 * osd: capability grammar improvements
 * osd: many bug fixes
 * msgr: various messenger bug fixes
 * librados: several bug fixes (rare races, locking errors)
 * mon: several bug fixes (rare races causing crashes)
 * log: fix in-memory buffering behavior (to only write log messages on 
   crash)
 * ceph-disk-prepare: creates and labels GPT partitions
 * rados: ability to copy, rename pools

There is also lots of work going on with RBD to get the layering working. 
This didn't quite make the 0.50 cutoff, but will be testable in the 0.51 
release (or sooner, for those interested in testing the release 
candidate). The devops deployment work with Chef and upstart is also 
progressing nicely, although it is still not quite ready for wide use. 
We've also been working on some OSD threading and peering improvements 
that will appear in v0.50.

For those of you using our Debian/Ubuntu packages, please note that the 
URL is now slightly different for the development release.  The stable 
(e.g., argonaut) release will remain at the old URL 
(http://ceph.com/debian) while the development releases will live at 
http://ceph.com/testing.

You can get this latest development release at:

 * Git at git://github.com/ceph/ceph.git
 * Tarball athttp://ceph.com/download/ceph-0.49.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/master/install/debian

