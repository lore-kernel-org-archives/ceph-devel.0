From: Sage Weil <sage@inktank.com>
Subject: teuthology consumability
Date: Thu, 7 Nov 2013 07:21:36 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311070711080.17943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42833 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab3KGPVg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 10:21:36 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AF6FC80466
	for <ceph-devel@vger.kernel.org>; Thu,  7 Nov 2013 07:21:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id AB61A80466
	for <ceph-devel@vger.kernel.org>; Thu,  7 Nov 2013 07:21:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey all,

I've had a couple different conversations with week with organizations 
that want to ramp up their ceph development efforts, as a big piece of 
that, spin up their own teuthology environments.  There has been a lot 
going on here, and I haven't been on the weekly calls, but I suspect 
things that will help them move forward include:

- documenting a teuthology install-from-scratch.  this would include 
setting up the databases, lock server, workers, etc., and will initially 
be long and ugly but will hopefully shrink over time.

- adding support for euca2ools or some other cloud client that does 
openstack and ec2 for creating/destroying test machines.  hopefully most 
of the integration points are mapped out from the downburst integration 
work.

- ongoing work to collapse the locking and queuing and reporting into a 
unified and/or cohesive service.

I'm probably missing things and/or vastly oversimplifying, but hopefully 
others can chime in an improve this list.  I think the better roadmap we 
have here, the easier it will be for new people to come online and focus 
their efforts where they will make the most difference.

Of course the upcomign CDS is a good place to discuss this, but something 
should be written down first to guide/frame that discussion.

sage
