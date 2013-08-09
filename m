From: Sage Weil <sage@inktank.com>
Subject: cds: rsockets follow-up
Date: Thu, 8 Aug 2013 21:33:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308082130570.1479@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59927 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab3HIEdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 00:33:25 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 9A39A8004F
	for <ceph-devel@vger.kernel.org>; Thu,  8 Aug 2013 21:33:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5FA908004F
	for <ceph-devel@vger.kernel.org>; Thu,  8 Aug 2013 21:33:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've translated the blueprint that came out of the CDS rsockets session 
into tickets in the tracker:

http://tracker.ceph.com/issues/5912
http://tracker.ceph.com/issues/5913
http://tracker.ceph.com/issues/5914
http://tracker.ceph.com/issues/5915
http://tracker.ceph.com/issues/5916

This includes all fo the messenger changes, but not the OSDMap (or other) 
changes that would let us keep track of multiple addrs for osds, mons, 
etc.  I think we can wait on that until we know that the rsockets stuff is 
working well.  Until then, for the purposes of testing, using rsockets 
only should be just fine.

Note that nobody has signed up to do any of this work yet.  If you are 
interested, we think this is a pretty straightforward project to get going 
on!

sage

