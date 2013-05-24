From: Sage Weil <sage@inktank.com>
Subject: libcephfs/Client api changes
Date: Thu, 23 May 2013 19:42:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305231934560.11264@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47993 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759688Ab3EXCmx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 22:42:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, matt@linuxbox.com
Cc: david.zafman@inktank.com

Hi Matt!

I took a closer look at the libcephfs branch you guys have.  A copy is in 
wip-libcephfs in the main ceph.git, and I opened a pull request on github 
just to capture review comments.  Please take a look at 

	https://github.com/ceph/ceph/pull/318

Lots of small questions and issues, but overall the appraoch looks great.  
I also rebased/squashed teh changes into a separate set of patches that 
try to capture the logical changes (instead of the patchset evolution).. 
these are in wip-libcephfs-rebased.

Can you take a look?

I think the ideal path forward (at least from my perspective :) would be:

- diff the rebased branch with yours to make sure the things i dropped 
  aren't important.
- make sure teh 'reject' patches are unimportant, and drop them from the 
  series.  the objecter change would fall into this category..
- address the review comments, modifying the rebased patches as 
  appropriate
- fix up the patch changelogs to have proper authorship and (where 
  appropriate) any background/justification for the change.  (in several 
  cases I was guessing what the change was about)
- rebase onto current master branch
- submit a new github pull request
- profit!

One way or another, I'd love to get this stuff upstream.

Thanks-
sage

