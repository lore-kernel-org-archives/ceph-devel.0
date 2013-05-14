From: Sage Weil <sage@inktank.com>
Subject: pg balancing
Date: Mon, 13 May 2013 17:35:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305131730380.10961@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48819 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab3ENAfM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 May 2013 20:35:12 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jaschut@sandia.gov
Cc: ceph-devel@vger.kernel.org

Hi Jim-

You mentioned the other day your concerns about the uniformity of the PG 
and data distribution.  There are several ways to attack it (including 
increasing the number of PGs), but one that we haven't tested much yet is 
the 'reweight-by-utilization' function in the monitor.

The idea is that there will always be some statistical variance in the 
distribution and a non-zero probability of having outlier OSDs with too 
many PG.  We adjust for this by taking nodes that are substantially above 
the mean down by some adjustment factor in an automated way.

 ceph osd reweight-by-utilization MIN

where MIN is the minimum relative utilization at which we will start 
adjusting down.  It is always > 100 (100% of the mean), and defaults to 
120.  After it adjusts the reweights, you should see the result in 'ceph 
osd tree' output

Have you played with this at all on your cluster?  I'd be very interested 
in how well this does/does not improve things for you.

Thanks!
sage

