From: Sage Weil <sage@newdream.net>
Subject: git branch changes!
Date: Thu, 27 Jan 2011 22:35:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101272232200.17860@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59421 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab1A1Gem (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jan 2011 01:34:42 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8B0B0BC715
	for <ceph-devel@vger.kernel.org>; Thu, 27 Jan 2011 22:35:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 6171ABC715
	for <ceph-devel@vger.kernel.org>; Thu, 27 Jan 2011 22:35:14 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've switched around the git branch names to be a bit less strange.  
They've all changed names, so you shouldn't get any surprises in the old 
branches.

 master - current unstable work.  this is the default when you clone.
 stable - last release, plus any bug fixes.
 next   - next release (once it's forked off of master); may not always 
          exist.

If you're after a release, look at the git tags.

There's likely a fair bit of stale documentation now in the wiki and 
elsewhere; if you see it, please fix or mention it so someone else can.

Thanks!
sage
