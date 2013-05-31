From: Sage Weil <sage@inktank.com>
Subject: mon load..
Date: Thu, 30 May 2013 19:50:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305301817310.26396@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50522 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab3EaCus (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 22:50:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: joao.luis@inktank.com
Cc: ceph-devel@vger.kernel.org

I'm playing with Mark's cluster, where he is seeing high ceph-mon cpu 
utilization when he creates new big pools.  I'm able to fairly reliably 
reproduce a livelock where it is stuck checking is_readable on queued auth 
requests long enough that it times out on the election and has to start 
all over again.

I see two issues:

- The PaxosService stuff is pulling values directly out of leveldb, and 
that is slow in this case.  Not completely sure why (compaction in teh 
background?  who knows.)  But, it's also unnecessary.. except that there 
is currently not a notification of the PaxosService instances when the 
underlying data changes.  That most easily plugs into a fwe places in teh 
Paxos class and on startup, but the way the layering is structured it's 
not very clean.  Not sure what teh right way to fix this up is.. but I 
think we do want some sort of PaxosService::refresh() that tells us 
whenever things changed; it can be the one to call the child's 
pdate_from_paxos().

- We should be able to discard those auth messages (and others!) if the 
original connection they came from has disconnected.. which is normally 
will after the client disconnects after 3 seconds (by default).

There is also wip-mon-trim that will lower the trim periodicity (and 
compaction) for the paxos states; that ought to help some as well, but I 
haven't tried it yet...

sage

