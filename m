From: Sage Weil <sweil@redhat.com>
Subject: Re:Re: About the blueprint OSD: Transactions
Date: Wed, 4 Mar 2015 16:55:59 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503041638040.23553@cobra.newdream.net>
References: <ACIAwADIAN8kzvlukrK0Farh.1.1425481937528.Hmail.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbbCEA4I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 4 Mar 2015 19:56:08 -0500
In-Reply-To: <ACIAwADIAN8kzvlukrK0Farh.1.1425481937528.Hmail.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, pmcgarry@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 4 Mar 2015, Li Wang wrote:
> Hi Sage, Please take a look if the below works,
> [...]

I think this works.  A few notes:

1- I don't think there's a need to persist the txn on the master until the 
slaves reply with PREPARE_ACK.

2- This is basically optimistic concurrency with backoff if 
possible deadlock is detected.  I think we can do the same thing in the 
proposal in the blueprint if a PREPARE sees that a txn (in-memory) is 
pending or if a client txn is recieved and there is a pending PREPARE.  In 
the latter case, it seems like we should block and wait...

3- In either scheme, we can do full deadlock avoidance if we force 
the master to be the lowest-sorting object name, or something like that.  
But I think that will have a performance impact since there is likely a 
best choice for master depending on the transaction itself... like a txn 
that writes 4MB to an object and inserts a pointer in another object; 
clearly the 4MB piece should be the master so that it is only written once 
and doesn't cross the network.

sage



> 1 Client calculate the 
> PG that the master object suggested by programmers belonging to, and 
> retrieve the primary OSD of that PG, called master, and send the full 
> transaction to it 2 master persist the whole transaction in the 
> corresponding PG metadata 3 master parse transaction, to obtain the set 
> of slave OSDs which are the primary OSDs of other PGs the transaction 
> referred to, and send PREPARE as well as the part of transaction needed 
> be done on each individual PG to its corresponding slave OSD 4 For each 
> slave OSD, it check if there exist a PREPARED-BUT-UNCOMMITTED 
> transaction in its PG metadata such that the two transactions share at 
> least one write operation on the same object, if so, the slave OSD give 
> up preparing, and reply PREPARE-AGAIN. Otherwise, it perform all the 
> read-and-comparison operations in its received transaction part, reply 
> PREPARE-FAIL if any of the operation fail. If all succeed, it persist 
> its transaction part in its PG metadata, and reply PREPARE-ACK 5 master 
> collect all PREPARE_ACKs, and reply client PREPARED, in the case a 
> PREPARE_FAIL received, master reply client ERROR, and send slaves 
> ROLL_BACK, and the slaves will discard its prepared transaction part, if 
> any, and reply master ROLL_BACK_ACK. master collect all ROLL_BACK_ACKs, 
> and discard the transaction. In the case of a PREPARE_AGAIN received, 
> the process is similar to PREPARE_FAIL except that master reply client 
> EAGAIN 6 master send slaves COMMIT 7 slaves get COMMIT and commit their 
> individual transaction part, and reply COMMIT_ACK 8 master collect all 
> COMMIT_ACKs and reply client COMMITTED 9 master close out the 
> transaction record It seems to work without dead locking in the normal 
> condition, however, there are still many kinds of errors it needs to 
> take into account, such as PG changing, OSD down etc, does it? Cheers, 
> Li Wang > -----????----- > ???: Sage Weil


