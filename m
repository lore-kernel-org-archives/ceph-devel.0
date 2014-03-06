From: Sage Weil <sage@inktank.com>
Subject: contraining crush placement possibilities
Date: Thu, 6 Mar 2014 12:30:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59118 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbaCFUak (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 15:30:40 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5C0348048A
	for <ceph-devel@vger.kernel.org>; Thu,  6 Mar 2014 12:30:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2EBD88048A
	for <ceph-devel@vger.kernel.org>; Thu,  6 Mar 2014 12:30:40 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

During the CRUSH CDS session yesterday I talked a bit about the desire to 
constrain the number of possible disk combinations so that we reduce the 
probability of a concurrent failure from causing data loss.  Sheldon just 
pointed out a talk from ATC that discusses the basic problem:

	https://www.usenix.org/conference/atc13/technical-sessions/presentation/cidon

The situation with CRUSH is slightly better, I think, because the number 
of peers for a given OSD in a large cluster is bounded (pg_num / 
num_osds), but I think we may still be able improve things.

Last night it occurred to me that this is almost just having pgp_num < 
pg_num, but I think that's not quite right either.

If anyone has some clear intuition here, would love to hear it.  If there 
is anything we can do to improve things we definitely want to do it!

sage

