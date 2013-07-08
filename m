From: Sage Weil <sage@inktank.com>
Subject: mon fixes
Date: Sun, 7 Jul 2013 21:48:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307072130250.22858@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54566 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab3GHEsn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jul 2013 00:48:43 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E06948004B
	for <ceph-devel@vger.kernel.org>; Sun,  7 Jul 2013 21:48:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AF1108004B
	for <ceph-devel@vger.kernel.org>; Sun,  7 Jul 2013 21:48:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I spent a lot of time over the last couple days tracking down monitor sync 
problems which resulted in several different patches and branches that are 
ready for review, merge, and backporting.  This includes a bunch of new 
tests, mon scrubbing, and a few teuthology changes.

This order probably makes the most sense:

scrub: dirt-simple scrubbing of mon stores to verify they are storing the 
right thing (and, e.g, sync works as expected).  not performant enough for 
automatic background scrubbing, but good enough for dev or teuthology to 
use to verify things are working properly.

 review wip-mon-scrub (next)
 https://github.com/ceph/ceph/pull/404
  + backport to cuttlefish (includes feature bit patches)

  There's a version of htis i tested on cuttlefish and reproduced the 
  bug below, but the branch needs to be redone after the master commit is 
  finalized/reviewed/etc.

 review teuthology.git wip-mon-thrash patches (better mon thrashing, triggers scrub)
 https://github.com/ceph/teuthology/pull/17
  + backport to cuttlefish

 ceph-qa-suite wip-mon tests


full map bug (this was turned up by scrub):

 review wip-mon-fix-osdmap-sync
 https://github.com/ceph/ceph/pull/405
  + backport to cuttlefish

  The new tests + scrub reliably reproduce this, and pass with the fix, 
  both on master and cuttlefish.


new mon sync is a simpler implementation of mon sync.  this needs careful 
review, but is passing all of my tests and appears to be less bug-prone.

 https://github.com/ceph/ceph/pull/400


mon sync improvements for cuttlefish.  this is a cleaned-up version of the 
changes we needed for a customer cluster to make a very long-running sync 
complete.  several config values adjusted, and sync behavior made more 
reliable/robust... luckily without changing the protocol compatibility
with cuttlefish.  reviewed by joao, but should get another set of eyes.

 https://github.com/ceph/ceph/pull/399

