From: Sage Weil <sweil@redhat.com>
Subject: full cluster/pool handling
Date: Thu, 24 Sep 2015 05:30:34 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40734 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304AbbIXMag (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Sep 2015 08:30:36 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 6A214C0B2B5C
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 12:30:36 +0000 (UTC)
Received: from redhat.com ([10.3.112.16])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t8OCUYuq007038
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 08:30:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Xuan Liu recently pointed out that there is a problem with our handling 
for full clusters/pools: we don't allow any writes when full, 
including delete operations.

While fixing a separate full issue I ended up making several fixes and 
cleanups in the full handling code in 

	https://github.com/ceph/ceph/pull/6052

The interesting part of that is that we will allow a write as long as it 
doesn't increase the overall utilizate of bytes or objects (according to 
the pg stats we're maintaining).  That will include remove ops, of cours, 
but will also allow overwrites while full, which seems fair.

However, that's not quite the full story: the client side currently 
does not send any requests while the full flag is set--it waits until the 
full flags are cleared before resending things.

We can modify things on the client so that it allows ops it knows will 
succeed (e.g., a simple remove op).  However, if there is another op also 
queued on that object *before* it, we should either block the remove op 
(to preserve ordering) or discard it when the remove succeeds (on the 
assumption that any effect it had is now moot).

Is the latter option safe?

Or, should we do something more clever?  Ideally it would be good if other 
allowed operations are let through, but unfortunately the client doesn't 
really know enough to tell whether it will/can succeed.  e.g., a class 
"refcount.put" call might result in a deletion (and in fact there is a 
class that does just that).  We could also send all such requests and, if 
we get ENOSPC, keep them queued and retry when the full flag is cleared.  
That would require a bit more complexity on the OSD side to preserve 
ordering, but it's doable...

sage
