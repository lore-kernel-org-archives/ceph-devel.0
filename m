From: Sage Weil <sweil@redhat.com>
Subject: cephfs security for multitenancy
Date: Mon, 4 May 2015 11:59:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505041134380.24943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbbEDS7d (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 May 2015 14:59:33 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jashank42@gmail.com, nishtha3rai@gmail.com
Cc: gfarnum@redhat.com, ceph-devel@vger.kernel.org

GSoC and Outreachy have made their assignments and I'm very excited that 
we will have two interns this summer to work on our efforts around 
improved security for CephFS in multitenant environments!  Both Nishtha 
and Jashan will be joining us starting in a few weeks (mid-May?).  
Welcome!

The other CephFS developers you'll likely be interacting with (besides me) 
are Greg Farnum (also in California), Zheng Yan (China), and John Spray 
(Scotland).  We have a daily video call (usually 5-15 minutes) at 14:30 
UTC (8pm IST, I believe).  You are welcome and encouraged to join when you 
can.  We also use the ceph-devel email list, the #ceph-devel IRC channel 
on irc.oftc.net to communicate, and the github comment stream for code 
review.

We currently have a few things planned:

- A "root_squash" mode that works similarly to the NFS option.  Nishtha 
got started on this a few weeks back with some initial patches, posted 
here:

	https://github.com/ceph/ceph/pull/4112

We were hoping we could define some pretty simple semantics that capture 
both the root_squash behavior (that provides some minimal security when 
lots of hosts are mounting a shared fs) and also the case where a client 
is only allowed to behave as one user, as Greg points out that may be too 
ambitious.

- The ability to restrict a client to act as a single user.  This is 
important if, for example, we want to allow unprivileged ceph-fuse or 
libcephfs users to be properly restricted.

- The ability to restrict a client to a path or subdirectory.  We have the 
parsing in place for MDSAuthCap, but that's about it.  This will require a 
range of checks in the MDS to ensure that the client is not doing anything 
outside of their permitted subtree.

My gut says that working out the root_squash semantics and figuring out if 
there is overlap with the restrict-to-uid behavior is the first order of 
business.  Greg and I talked about it several weeks back but all I can 
remember now was that it wasn't as simple as I'd hoped...

sage
