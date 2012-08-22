From: Sage Weil <sage@inktank.com>
Subject: wip-crush
Date: Tue, 21 Aug 2012 18:10:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44609 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2HVBKC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Aug 2012 21:10:02 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 61A968047B
	for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 18:10:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 37C258047B
	for <ceph-devel@vger.kernel.org>; Tue, 21 Aug 2012 18:10:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I pushed a branch that changes some of the crush terminology.  Instead of 
having a crush type called "pool" that requires you to say things like 
"pool=default" in the "ceph osd crush set ..." command, it uses "root" 
instead.  That hopefully reinforces that it is a tree/hierarchy.

There is also a patch that changes "bucket" to "node" throughout, since 
bucket is a term also used by radosgw.

Thoughts?  I think the main pain in making this transition is that old 
clusters have maps that have a type 'pool' and new ones won't, and the 
docs will need to walk people through both...

sage
