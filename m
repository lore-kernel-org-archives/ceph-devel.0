From: Sage Weil <sage@newdream.net>
Subject: RE: Filestore throttling
Date: Thu, 23 Oct 2014 06:58:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410230653320.10837@cobra.newdream.net>
References: <BLU175-W34FC39734E69C620D262DEDF920@phx.gbl>, <alpine.DEB.2.00.1410222104080.10837@cobra.newdream.net> <BLU175-W176682F001CDC16FC4FA67DF920@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46288 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbaJWN66 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 09:58:58 -0400
In-Reply-To: <BLU175-W176682F001CDC16FC4FA67DF920@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Thu, 23 Oct 2014, GuangYang wrote:
> Thanks Sage for the quick response!
> 
> We are using firefly (v0.80.4 with a couple of back-ports). One 
> observation we have is that during peering stage (especially if the OSD 
> got down/in for several hours with high load), the peering OPs are in 
> contention with normal OPs and thus bring extremely long latency (up to 
> minutes) for client OPs, the contention happened in filestore for 
> throttling budget, it also happened at dispatcher/op threads, I will 
> send another email with more details after more investigation.

It sounds like the problem here is that when the pg logs are long (1000's 
of entries) the MOSDPGLog messages are bit and generate a big 
ObjectStore::Transaction.  This can be mitigated by shortening the logs, 
but that means shortening the duration that an OSD can be down without 
triggering a backfill.  Part of the answer is probably to break the PGLog 
messages into smaller pieces.

> As for this one, I created a pull request #2779 to change the default 
> value of filesotre_queue_max_ops to 500 (which is specified in the 
> document but code is inconsistent), do you think we should make others 
> as default as well?

We reduced it to 50 almost 2 years ago, in this commit:

commit 44dca5c8c5058acf9bc391303dc77893793ce0be
Author: Sage Weil <sage@inktank.com>
Date:   Sat Jan 19 17:33:25 2013 -0800

    filestore: disable extra committing queue allowance
    
    The motivation here is if there is a problem draining the op queue
    during a sync.  For XFS and ext4, this isn't generally a problem: you
    can continue to make writes while a syncfs(2) is in progress.  There
    are currently some possible implementation issues with btrfs, but we
    have not demonstrated them recently.
    
    Meanwhile, this can cause queue length spikes that screw up latency.
    During a commit, we allow too much into the queue (say, recovery
    operations).  After the sync finishes, we have to drain it out before
    we can queue new work (say, a higher priority client request).  Having
    a deep queue below the point where priorities order work limits the
    value of the priority queue.
    
    Signed-off-by: Sage Weil <sage@inktank.com>

I'm not sure it makes sense to increase it in the general case.  It might 
make sense for your workload, or we may want to make peering transactions 
some sort of special case...?

sage


> 
> Thanks,
> Guang
> 
> ----------------------------------------
> > Date: Wed, 22 Oct 2014 21:06:21 -0700
> > From: sage@newdream.net
> > To: yguang11@outlook.com
> > CC: ceph-devel@vger.kernel.org; ceph-users@lists.ceph.com
> > Subject: Re: Filestore throttling
> >
> > On Thu, 23 Oct 2014, GuangYang wrote:
> >> Hello Cephers,
> >> During our testing, I found that the filestore throttling became a limiting factor for performance, the four settings (with default value) are:
> >> filestore queue max ops = 50
> >> filestore queue max bytes = 100 << 20
> >> filestore queue committing max ops = 500
> >> filestore queue committing max bytes = 100 << 20
> >>
> >> My understanding is, if we lift the threshold, the response for op (end to end) could be improved a lot during high load, and that is one reason to have journal. The downside is that if there is a read following a successful write, the read might stuck longer as the object is not flushed.
> >>
> >> Is my understanding correct here?
> >>
> >> If that is the tradeoff and read after write is not a concern in our use case, can I lift the parameters to below values?
> >> filestore queue max ops = 500
> >> filestore queue max bytes = 200 << 20
> >> filestore queue committing max ops = 500
> >> filestore queue committing max bytes = 200 << 20
> >>
> >> It turns out very helpful during PG peering stage (e.g. OSD down and up).
> >
> > That looks reasonable to me.
> >
> > For peering, I think there isn't really any reason to block sooner rather
> > than later. I wonder if we should try to mark those transactions such
> > that they don't run up against the usual limits...
> >
> > Is this firefly or something later? Sometime after firefly Sam made some
> > changes so that the OSD is more careful about waiting for PG metadata to
> > be persisted before sharing state. I wonder if you will still see the
> > same improvement now...
> >
> > sage
>  		 	   		  N????y????b?????v?????{.n??????z??ay????????j???f????????????????:+v??????????zZ+??????"?!?
