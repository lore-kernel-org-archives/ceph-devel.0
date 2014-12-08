From: Sage Weil <sweil@redhat.com>
Subject: rados read ordering
Date: Mon, 8 Dec 2014 09:03:01 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbaLHRDH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Dec 2014 12:03:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com, jdurgin@redhat.com, yehuda@redhat.com, dillaman@redhat.com
Cc: zhiqiang.wang@intel.com, ceph-devel@vger.kernel.org

The current RADOS behavior is that reads (on any given object) are always 
processed in the order they are submitted by the client.  This causes a 
few headaches for the cache tiering that it would be nice to avoid.  It 
also occurs to me that there are likely cases where we could go a lot 
faster by not strictly ordering things.  For example, a stat can respond 
more quickly than a large read, and some reads may hit cache while others 
go to disk.  This doesn't happen currently because of the (lame) way we do 
reads synchronously, but hope that can change too.

I propose we drop this semantic.  If a client wants reads to have a strict 
ordering, they can set the existing RWORDERED flag (which also orders them 
with respect to writes).  That's not the most general thing ever, but I'm 
not sure we care about callers who want reads ordered with respect to each 
other but not writes.

The real question is whether there are any users that want/need this 
currently.  I can't think of any offhand.  In several places we submit 
multiple *writes* and expect them to be strictly ordered (e.g., we 
set a completion on teh last write only).  I don't think we do this 
anywhere for reads though...

Josh, Yehuda, Jason--can you think of any in RBD or RGW that would depend 
on this?

sage
