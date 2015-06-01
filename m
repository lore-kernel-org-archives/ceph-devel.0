From: Sage Weil <sweil@redhat.com>
Subject: Re: A bug in rolling back to a degraded object
Date: Mon, 1 Jun 2015 16:41:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1506011629530.20600@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C53489EBE1F@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902AbbFAXld (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Jun 2015 19:41:33 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C53489EBE1F@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Zhiqiang,

On Mon, 1 Jun 2015, Wang, Zhiqiang wrote:
> Hi Sage and all,
> 
> Another bug discovered during the proxy write teuthology testing is when 
> rolling back to a degraded object. This doesn't seem specific to proxy 
> write. I see a scenario like below from the log file:
> 
>  - A rollback op comes in, and is enqueued.
>  - Several other ops on the same object come in, and are enqueued.
>  - The rollback op dispatches, and finds the object which it rollbacks 
> to is degraded, then this op is pushbacked into a list to wait for the 
> degraded object to recover.
>  - The later ops are handled and responded back to client.
>  - The degraded object recovers. The rollback op is enqueued again and 
> finally responded to client.

Yep!
 
> This breaks the op order. A fix for this is to maintain a map to track 
> the <source, destination> pair. And when an op on the source dispatches, 
> if such a pair exists, queue the op in the destination's degraded 
> waiting list. A drawback of this approach is that some entries in the ' 
> waiting_for_degraded_object' list of the destination object may not be 
> actually accessing the destination, but the source. Does this make 
> sense?

Yeah, and I think it's fine for the op to appear in the other object's 
list.  In fact there is already a mechanism in place that does something 
similar: obc->blocked_by.  It was added for the clone operation, which 
nfortunately I don't think it's not exercised in any of our test.. but 
I think it does exactly what you need.  If you set the head's blocked_by 
to the clone (and the clone's blocks set to include the head) then anybody 
trying to write to the head will queue up on the clone's degraded 
list (see the check for this in ReplicatedPG::do_op()).

I think this mostl amounts to making the _rollback_to() method get the 
clone's obc, set up the blocked_by/blocks relationship, start recovery of 
that object immediately, and queue itself on the waiting list.

Does that make sense?
sage
