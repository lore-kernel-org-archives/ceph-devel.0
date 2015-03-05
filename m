From: Sage Weil <sweil@redhat.com>
Subject: Re: About the blueprint OSD: Transactions
Date: Wed, 4 Mar 2015 23:38:04 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503042331010.25972@cobra.newdream.net>
References: <ACIAwADIAN8kzvlukrK0Farh.1.1425481937528.Hmail.liwang@ubuntukylin.com> <alpine.DEB.2.00.1503041638040.23553@cobra.newdream.net> <54F7D376.6070705@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32980 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149AbbCEHiN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Mar 2015 02:38:13 -0500
In-Reply-To: <54F7D376.6070705@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, pmcgarry@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 5 Mar 2015, Li Wang wrote:
> On 2015/3/5 8:56, Sage Weil wrote:
> > On Wed, 4 Mar 2015, Li Wang wrote:
> > > Hi Sage, Please take a look if the below works,
> > > [...]
> > 
> > I think this works.  A few notes:
> > 
> > 1- I don't think there's a need to persist the txn on the master until the
> > slaves reply with PREPARE_ACK.
> 
> I think the txn must be persisted at the very first at master side,
> since once it send the message to slaves, there must be a mechanism
> that the ROLL_BACK message could be resent to slaves if master down,
> just there may only few, rather than whole information of the
> transaction need be persisted

I think we can still skip it because it's not about durabiliy (master and 
slave are both PGs that are replicated), just about coordination.  if 
master repeers the slaves will ask whether to roll forward or back and the 
(new) master will respond with ROLLBACK or COMMIT.

If you missed the CDS session it should be posted on youtube shortly... we 
discussed both possibilities.  We think the main difference is that in 
your case you have to do a double write (prepare + commit on master) but 
that hides the commit latency sinc eyou can reply when you get the 
PREPARE_ACKs.  In my proposal, you only write once on the master, but you 
have to wait for the PREPAREs, and then write the COMMIT, and then reply 
to the clients.. which will have a higher total latency.

> > 2- This is basically optimistic concurrency with backoff if
> > possible deadlock is detected.  I think we can do the same thing in the
> > proposal in the blueprint if a PREPARE sees that a txn (in-memory) is
> > pending or if a client txn is recieved and there is a pending PREPARE.  In
> > the latter case, it seems like we should block and wait...
> > 
> 
> Yes. We can divide the process into two steps, the first step is
> PREPARE, only for deadlock avoidance, this only refers to memory
> operation in all slaves' sides. First, master send PREPARE to slaves,
> the slaves check if there is pending transaction in memory, if so,
> reply master EAGAIN, otherwise reply PREPARE_ACK, which lead to
> an extremely fast deadlock avoidance. master collect all PREPARE_ACK,
> and send COMMIT to slaves, then slaves commit their transaction part
> to PG metadata, reply master COMMIT_ACK

Backing off if any affected object has another in-flight transaction is 
sufficient but also conservative since we'll fail/retry transactions that 
actually could have completed w/o deadlocking.  The altnerative is to 
leave it to the client to only propose transactions that won't conflict.  
The latter is certainly an easier first version to implement :) but it may 
also be that it's all that we want.  Solving the deadlock avoidance in the 
general case sucks.  :(

Maybe a simple backoff like you propose is a decent middle ground... I 
susepect, though, that a large portion of transactions in the real world 
will be A+B, A+C, A+D, etc where they are non-deadlocking but do overlap 
(e.g. on an index or metadata object).

sage
