From: Sage Weil <sweil@redhat.com>
Subject: explicitly mapping pgs in OSDMap
Date: Wed, 1 Mar 2017 19:44:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751574AbdCAUKp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Mar 2017 15:10:45 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 767DD3A768D
        for <ceph-devel@vger.kernel.org>; Wed,  1 Mar 2017 19:44:53 +0000 (UTC)
Received: from ovpn-112-32.rdu2.redhat.com (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v21JiqWm025397
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <ceph-devel@vger.kernel.org>; Wed, 1 Mar 2017 14:44:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There's been a longstanding desire to improve the balance of PGs and data 
across OSDs to better utilize storage and balance workload.  We had a few 
ideas about this in a meeting last week and I wrote up a summary/proposal 
here:

	http://pad.ceph.com/p/osdmap-explicit-mapping

The basic idea is to have the ability to explicitly map individual PGs 
to certain OSDs so that we can move PGs from overfull to underfull 
devices.  The idea is that the mon or mgr would do this based on some 
heuristics or policy and should result in a better distribution than teh 
current osd weight adjustments we make now with reweight-by-utilization.

The other key property is that one reason why we need as many PGs as we do 
now is to get a good balance; if we can remap some of them explicitly, we 
can get a better balance with fewer.  In essense, CRUSH gives an 
approximate distribution, and then we correct to make it perfect (or close 
to it).

The main challenge is less about figuring out when/how to remap PGs to 
correct balance, but figuring out when to remove those remappings after 
CRUSH map changes.  Some simple greedy strategies are obvious starting 
points (e.g., to move PGs off OSD X, first adjust or remove existing remap 
entries targetting OSD X before adding new ones), but there are a few 
ways we could structure the remap entries themselves so that they 
more gracefully disappear after a change.

For example, a remap entry might move a PG from OSD A to B if it maps to 
A; if the CRUSH topology changes and the PG no longer maps to A, the entry 
would be removed or ignored.  There are a few ways to do this in the pad; 
I'm sure there are other options.

I put this on the agenda for CDM tonight.  If anyone has any other ideas 
about this we'd love to hear them!

sage
