From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: About the blueprint OSD: Transactions
Date: Tue, 10 Mar 2015 10:09:07 +0800
Message-ID: <54FE5243.5080303@ubuntukylin.com>
References: <ACIAwADIAN8kzvlukrK0Farh.1.1425481937528.Hmail.liwang@ubuntukylin.com> <alpine.DEB.2.00.1503041638040.23553@cobra.newdream.net> <54F7D376.6070705@ubuntukylin.com> <alpine.DEB.2.00.1503042331010.25972@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:58632 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbCJCJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Mar 2015 22:09:13 -0400
In-Reply-To: <alpine.DEB.2.00.1503042331010.25972@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, pmcgarry@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sjust@redhat.com>

The atomicity semantics of transaction must not be violated. Suppose
there are two concurrent transactions, T1 (Transaction 1) writes a set
of objects {A, B, C}, and T2 touches {B, C, D}, where each object is in
a different OSD. And A and D are selected as the master, respectively.
For simplicity, suppose T1 do a write to make the value of each object
be 1, while T2 make them 2. Then only two results are legal, either
A=B=C=1, or B=C=D=2, it forbids to happen that B=1, C=2 or vice versa.
Suppose OSD_B receives PREPARE in a sequence of (T1, T2), while OSD_C
receives PREPARE in a sequence of (T2, T1). This could happen since T1
and T2 are managed by different masters. The operation sequence is as
follows,

1. OSD_B receives PREPARE from T1 and do the preparation
2. OSD_C receives PREPARE from T2 and do the preparation
3. OSD_B receives PREPARE from T2, finds a in-flight transaction on B,
wait for T1 to finish
4. OSD_C receives PREPARE from T1, finds a in-flight transaction on C,
wait for T2 to finish

Obviously, it results in a deadlock. So if there is in-flight
transaction to share the write on the same object,
it should not wait. Also it could not accept, otherwise, the atomicity
may be violated. For the above example, in Steps 3 and 4, if the two
OSDs accept the PREPARE, then the final results after the two
transactions finished will be B=2, C=1. Note forcing the master to be
the lowest-sorting object name seems not fix this problem either,
  if the sorting of A and D are slower than B and C. So it seems the
only option is to give up and retry in such case.

  Please check how is the following,
  (1) Client calculate the PG that the master object suggested by
  programmers belonging to, and retrieve the primary
  OSD of that PG, called master, and send the full transaction to it
(2) Master hold the transaction in memory, and send PREPARE to slaves
(3) Slave check if there exists at least one in-flight transaction on
the same object, if so, reply master EAGAIN, otherwise reply PREPARE_ACK
(4) Master collect PREPARE_ACK, and send COMMIT to slaves. In the case
EAGAIN received, master reply client EAGAIN, and send ROLL_BACK to any
prepared slaves, discard the transaction, and expect client resend the
transaction with a newer id.
(5) Slave perform all the read-and-comparison operations, reply EFAIL
if any operation fail. If all succeed, slave commit the transaction
into journal of PG metadata, and reply master COMMIT_ACK
(6) Master collect COMMIT_ACK, reply client COMMITED, and send APPLY to
slaves. In the case EFAIL received from slave, master reply client
EFAIL, send ROLL_BACK to slaves, and discard the transaction
(7) Slave apply the transaction from journal or PG metadata to the
actual objects, and reply master APPLY_ACK
(8) Master collect APPLY_ACK, reply client APPLIED, and close out the
transaction Note it does not describe the persist operation on master
side, because in terms of the process PREPARE, COMMIT and APPLY, master
acts as exactly a slave. For example, in Step 3, the master also will
check if there is a conflict in-flight transaction.

Cheers,
Li Wang


On 2015/3/5 15:49, Sage Weil wrote:
> On Thu, 5 Mar 2015, Li Wang wrote:
>> On 2015/3/5 8:56, Sage Weil wrote:
>>> On Wed, 4 Mar 2015, Li Wang wrote:
>>>> Hi Sage, Please take a look if the below works,
>>>> [...]
>>>
>>> I think this works.  A few notes:
>>>
>>> 1- I don't think there's a need to persist the txn on the master until the
>>> slaves reply with PREPARE_ACK.
>>
>> I think the txn must be persisted at the very first at master side,
>> since once it send the message to slaves, there must be a mechanism
>> that the ROLL_BACK message could be resent to slaves if master down,
>> just there may only few, rather than whole information of the
>> transaction need be persisted
>
> I think we can still skip it because it's not about durabiliy (master and
> slave are both PGs that are replicated), just about coordination.  if
> master repeers the slaves will ask whether to roll forward or back and the
> (new) master will respond with ROLLBACK or COMMIT.
>
> If you missed the CDS session it should be posted on youtube shortly... we
> discussed both possibilities.  We think the main difference is that in
> your case you have to do a double write (prepare + commit on master) but
> that hides the commit latency sinc eyou can reply when you get the
> PREPARE_ACKs.  In my proposal, you only write once on the master, but you
> have to wait for the PREPAREs, and then write the COMMIT, and then reply
> to the clients.. which will have a higher total latency.
>
>>> 2- This is basically optimistic concurrency with backoff if
>>> possible deadlock is detected.  I think we can do the same thing in the
>>> proposal in the blueprint if a PREPARE sees that a txn (in-memory) is
>>> pending or if a client txn is recieved and there is a pending PREPARE.  In
>>> the latter case, it seems like we should block and wait...
>>>
>>
>> Yes. We can divide the process into two steps, the first step is
>> PREPARE, only for deadlock avoidance, this only refers to memory
>> operation in all slaves' sides. First, master send PREPARE to slaves,
>> the slaves check if there is pending transaction in memory, if so,
>> reply master EAGAIN, otherwise reply PREPARE_ACK, which lead to
>> an extremely fast deadlock avoidance. master collect all PREPARE_ACK,
>> and send COMMIT to slaves, then slaves commit their transaction part
>> to PG metadata, reply master COMMIT_ACK
>
> Backing off if any affected object has another in-flight transaction is
> sufficient but also conservative since we'll fail/retry transactions that
> actually could have completed w/o deadlocking.  The altnerative is to
> leave it to the client to only propose transactions that won't conflict.
> The latter is certainly an easier first version to implement :) but it may
> also be that it's all that we want.  Solving the deadlock avoidance in the
> general case sucks.  :(
>
> Maybe a simple backoff like you propose is a decent middle ground... I
> susepect, though, that a large portion of transactions in the real world
> will be A+B, A+C, A+D, etc where they are non-deadlocking but do overlap
> (e.g. on an index or metadata object).
>
> sage
>
