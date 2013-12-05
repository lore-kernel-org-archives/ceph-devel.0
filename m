From: Sage Weil <sage@inktank.com>
Subject: core standup
Date: Thu, 5 Dec 2013 09:26:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312050919450.32370@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49545 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976Ab3LER0Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Dec 2013 12:26:16 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 694768004F
	for <ceph-devel@vger.kernel.org>; Thu,  5 Dec 2013 09:26:16 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 66CDB8004F
	for <ceph-devel@vger.kernel.org>; Thu,  5 Dec 2013 09:26:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Missing core standup today (all day meeting).

Y:
- more wip-tier work
- almost done with memstore (a simple in-memory ObjectStore backend to 
  serve as a reference implementation and possibly as a benchmarking tool)
- more review of Zheng's mds branch

T:
- meeting
- finish memstore
- more wip-tier wrangling (verify the trimming is working properly; add a 
test for it)

B:
- wip-crush-tunables needs review
- wip-crush needs review
- wip-pool-set-* needs some consensus on approach.  the kludgey fix is in 
the pull requests; an alternative general approach is described by
	https://github.com/ceph/ceph/pull/895#issuecomment-29846799

