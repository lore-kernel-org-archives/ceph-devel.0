From: Sage Weil <sweil@redhat.com>
Subject: older kernels vs firefly
Date: Fri, 1 Aug 2014 18:29:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408011821320.18917@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44703 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbaHBB3L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Aug 2014 21:29:11 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 12C3C8002D
	for <ceph-devel@vger.kernel.org>; Fri,  1 Aug 2014 18:29:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D14668002D
	for <ceph-devel@vger.kernel.org>; Fri,  1 Aug 2014 18:29:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A couple firefly point releases ago we removed the Ceph requirement that, 
when EC pools are present, all clients must have the EC feature bit.  This 
is because the only users of EC are current not kernel based, so even 
having that feature bit doesn't mean a newer kernel is any better off than 
an older one.  And (we thought) it meant that an older kernel (e.g., 
3.12) can still map an rbd or mount cephfs when the cluster has a new EC 
pool created for unrelated purposes.

...but there is still a problem.  The EC pools need new CRUSH rule steps 
to work effectively, and normally have a rule using those new features 
for the EC pool.  And the code that ensures that clients understand all 
features that the CRUSH map uses works, so those kernels *still* can't
talk to a firefly cluster with EC pools (if the EC pools are configured 
properly and are using a "good" CRUSH rule).

Simply not requiring that feature of any client is problematic because 
clients using those pools do need to understand that feature.  So, I'm not 
sure what the quick fix is...

As for the real fix, I think we need to add a features field to the 
OSDMap pg_pool_t so that, for a given pool, there may be additional client 
requirements.  The CRUSH feature code can then map the per-rule feature 
bits to only the pools that need it.  And eventually clients can be made 
to verify those per-pool features.

I suppose we could then backport all of that to firefly?  :/

sage

