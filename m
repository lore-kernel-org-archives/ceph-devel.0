From: Sage Weil <sage@inktank.com>
Subject: promote/copy-from and flush vs scrub
Date: Mon, 20 Jan 2014 15:25:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401201517000.2149@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35145 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbaATXZO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jan 2014 18:25:14 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sam.just@inktank.com
Cc: ceph-devel@vger.kernel.org

I hit an assert in some of my manual fiddling with the tiering agent where 
a promote, copy-from, or flush operation would hit

  -546> 2014-01-20 14:44:55.506594 7f0a467fc700 -1 osd/ReplicatedPG.cc: In 
function 'void ReplicatedPG::finish_ctx(ReplicatedPG::OpContext*, int)' 
thread 7f0a467fc700 time 2014-01-20 14:44:55.466752
osd/ReplicatedPG.cc: 4737: FAILED assert(soid < scrubber.start || soid >= 
scrubber.end)

The problem is that we normally block ops that hit the current scrub chunk 
in do_op at the very top level, but all of these ops are initiating writes 
at lower levels after doing some other slow/blocking work.

They are smart enough to take and block on the rwlock stuff, but I'm 
worried that the waiting_for_active queue is too coarse for this.  My 
thought is to add a std::map of obc's blocked on scrub and wake them up 
when the scrub chunk completes.  Any better ideas?

Incidentally, we need to make the thrashosds task smart enough to pause 
thrashing long enough for scrubs to happen so that these issues are 
covered in the normal test suite...

sage
