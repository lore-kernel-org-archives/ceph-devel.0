From: Sage Weil <sweil@redhat.com>
Subject: Re: About the blueprint OSD: Transactions
Date: Tue, 3 Mar 2015 14:52:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503031443010.25972@cobra.newdream.net>
References: <54F57FBB.6060309@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52476 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756375AbbCCWwu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 Mar 2015 17:52:50 -0500
In-Reply-To: <54F57FBB.6060309@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, pmcgarry@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 3 Mar 2015, Li Wang wrote:
> Hi Sage,
>   We are pretty interested in the multi-object transaction support,
> we think it is potencially very useful. we have read your implementation
> description, and summarize it as below, please check if our
> understanding is correct,
> 
> 1 client select a master, and sends full txn to master
> 2 master holds txn in memory, sends PREPAREs to slaves
> 3 slaves persist PREPARE on the side, send PREPARE_ACK,
>   in the case there is a compare-then-write operation,
>   and compartion fail, slave will send PREPARE_FAIL instead
> 4 master collects all PREPARE_ACKs and applies the txn
>   and marks txn COMMITTING, in the case a PREPARE_FAIL received,
>   master send slaves ROLL_BACK, and the slaves will discard
>   the prepared txn
> 5 once persisted, master send COMMITs to slaves
> 6 master replies to client COMMITED, to enable client to proceed
>   to do other operations except reading the commited data
> 7 slaves get COMMIT and apply, reply with COMMIT_ACK
> 8 master collect COMMIT_ACK and reply to client FINISHED, to enable
>   client read the data
> 9 master closes out txn record

Yep!   Plus the failure path handling...

> We think it manifiests to implement a transaction itself, however,
> it did not take into account the cases that concurrent multiple transactions,
> how to enforce the order and atomicity among the distributed transactions,
> how to do locking and dead locking avoidance, it seems there are
> some further desgining jobs to do.

Yeah.  I think it would be nice if we can define a few simple flags 
indicating whether the masters and/or slaves are readable during the 
prepared-but-uncommitted phase, as there are different requirements for 
different users.

And we need to pick a (simple!) deadlock avoidance approach.  Maybe a 
simple EAGAIN is enough and leave it to the clients to be consistent about 
which object to choose as the master.

> We are wondering if you can move this blueprint discussion into a
> UTC+8 friendly time, so that we can involve in

I think Patrick is moving it!

Thanks-
sage
