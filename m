From: Sage Weil <sage@inktank.com>
Subject: summit: rados namespaces, crush language extension
Date: Thu, 9 May 2013 09:05:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305090824240.26155@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54514 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab3EIQFv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 May 2013 12:05:51 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 130D780068
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 09:05:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 10CE580068
	for <ceph-devel@vger.kernel.org>; Thu,  9 May 2013 09:05:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We had a session in the afternoon with a few miscellaneous rados items.  
The first was rados namespaces.  This is a relatively simple extension to 
the rados API that lets you separate a pool into separate logical 
namespaces, and extends the capability/security semantics to let you 
restrict access by namespace.  This is useful for multitenancy in cases 
where the number of tenants makes a pool-per-tenant impractical.  The work 
items involved were captured on teh etherpad at

	http://wiki.ceph.com/01Planning/Developer_Summit/Etherpad_Snapshots/2G%3A_RADOS_namespaces%2C_CRUSH_language_extension%2C_CRUSH_library

The second item was extending the CRUSH rule language to allow more 
sophisticated placement strategies.  We identifed several use cases that 
are not currently handled, and brainstormed possible solutions.  Several 
ideas, but no concrete solutions yet.  If anyone is interested in this 
work, let me know!

The last topic was supposed to be turning CRUSH into an easily consumable 
shared library (libcrush.so), but we ran out of time.  Again, if there are 
interested parties, let me know!

sage
