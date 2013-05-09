From: Sage Weil <sage@inktank.com>
Subject: summit: erasure coding
Date: Thu, 9 May 2013 08:23:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305090816130.26155@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54102 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab3EIPX7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 11:23:59 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 36DA080068
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 08:23:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 34A1080068
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 08:23:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We have a great session with Loic, Christopher, Sam, and Greg that 
discussed how to move forward with erasure coding support.  The high-level 
consensus on approach:

 - it is possible to do erasure coding above rados across distinct pools, 
but it is harder, and less useful.
 - we should have an ErasureCodedPG that takes advantage of CRUSH's 
placement to place shards
 - we can support a limited subset of rados operations for such pools and 
still be useful (write_full, or write/append on block boundaries)
 - this will be used in conjuction with a replicated pool as a second tier 
of storage, or by applications that are happy with a limited subset of 
commands.

That said, the implementation will be non-trivial.  But, we identified 
several areas where code cleanup will move us down the right path.  By 
factoring our useful components of PG and ReplicatedPG into separate 
classes, we clean up the current interfaces and can also build unit tests 
for them as we do so for immediate benefit.

Initial focus areas:

 - clean up the OSD -> PG interface (PG -> OSD is already reasonably well 
   captured by teh OSDService class)
 - ObjectContext tracking
 - PG log handling
 - PG missing
 - RepOp state
 - Peering state machine

The last one willb e most tricky (and saved for last).  In each case, 
we'll have to think carefully about how well things generalize from 
replication to erasure coding.

Loic has volunteered to own this work, and Sam and I will be supporting.  
He'll also be joining our daily core standup.  Yay!

sage
