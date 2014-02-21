From: Sage Weil <sage@inktank.com>
Subject: firefly branches
Date: Fri, 21 Feb 2014 11:46:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402211141100.17322@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57395 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbaBUTqP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 14:46:15 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 8FFF38044E
	for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 11:46:15 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 737F98044E
	for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 11:46:15 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Now that firefly is frozen, we're going to keep things interesting and 
do things slight different that we did for emperor.  It's closer to what 
we normally do, though, so hopefully this will be simpler.

 master == new stuff for post-firefly v0.79.  this shouldn't see much new 
   code since we're focusing on stabilization right now.

 next == <deleted>.  use firefly instead.

 firefly == what will become firefly 0.78.  this is the branch the nightly 
   qa is focusing on.

Periodically we can merge firefly back into master (as we normally do with 
next), but this isn't particularly important since the all QA is running 
against firefly.

There are now firefly branches in teuthology.git and ceph-qa-suites.git to 
match.

In the past we had both next and the stable-release-to-be branch but it 
was awkward to keep them in sync.  This avoid that ambiguity by just 
having one branch and calling it firefly to make it crystal clear to 
everyone what is what.

That's all!
sage
