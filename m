From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Mon, 9 Nov 2015 19:39:31 -0500
Message-ID: <CANP1eJF0d-t=MThTui3y4NXpzpMpSo0s6tv9cEFB3pT3K0wZJg@mail.gmail.com>
References: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
	<CAN=+7FWJ2aH1mRg7Z4P2o9f7hB7q2MHE6rBzyeR9Yrnf8qh3jA@mail.gmail.com>
	<CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
	<CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
	<CAANLjFo8RiTqmQJEbr5O082613pNGsu3-YM0VX-tToY-YPBfuQ@mail.gmail.com>
	<alpine.DEB.2.00.1511060202130.5830@cobra.newdream.net>
	<CAANLjFrka=DHN=1D-=wsY4HgHQ=-tg0+0hfff80kiiaaRK=r0g@mail.gmail.com>
	<CAANLjFqMf9xPMPLx-8BM=P00vJ0OnXNCkC3K3Xe-R27Dt6k4Kw@mail.gmail.com>
	<alpine.DEB.2.00.1511080619140.27153@cobra.newdream.net>
	<CAN=+7FUyzNtzjngg-r=fdRo9uqeZfcMRvqc7eZumn7KaB9KYmg@mail.gmail.com>
	<CAANLjFoFT6ajEBJKfhA9rnjyJ+a8gKpFrQz74uyobKjiyZvxeQ@mail.gmail.com>
	<CAN=+7FWjVG5XuBqzzeZkQiQ=ZVSbScUj2gNms6gy52N738Y5sQ@mail.gmail.com>
	<CAANLjFpveonAff_aQNV-RNKOkhgBHjNAjwLftjWWinz+XNFztw@mail.gmail.com>
	<CAN=+7FWi=wcQsFU7rMLPKdLF+9DZGKUgNmMTM3xDP0+K0bQ56A@mail.gmail.com>
	<CAANLjFrXdK2r25RaC4RB3=irSv_qufvQi__S4QbZBN7VS1WSjw@mail.gmail.com>
	<CAN=+7FW3G1V5DvF=C=TCiBN_L2xLhydhXGbbUc4GYG=-dEqGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:33143 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbKJAje (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 19:39:34 -0500
Received: by lffz63 with SMTP id z63so39384617lff.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2015 16:39:32 -0800 (PST)
In-Reply-To: <CAN=+7FW3G1V5DvF=C=TCiBN_L2xLhydhXGbbUc4GYG=-dEqGEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Robert LeBlanc <robert@leblancnet.us>, Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 9, 2015 at 3:49 PM, Samuel Just <sjust@redhat.com> wrote:
> On Mon, Nov 9, 2015 at 12:31 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> On Mon, Nov 9, 2015 at 12:47 PM, Samuel Just  wrote:
>>> What I really want from PrioritizedQueue (and from the dmclock/mclock
>>> approaches that are also being worked on) is a solution to the problem
>>> of efficiently deciding which op to do next taking into account
>>> fairness across io classes and ops with different costs.
>>
>>> On Mon, Nov 9, 2015 at 11:19 AM, Robert LeBlanc  wrote:
>>>> -----BEGIN PGP SIGNED MESSAGE-----
>>>> Hash: SHA256
>>>>
>>>> Thanks, I think some of the fog is clearing. I was wondering how
>>>> operations between threads were keeping the order of operations in
>>>> PGs, that explains it.
>>>>
>>>> My original thoughts were to have a queue in front and behind the
>>>> Prio/WRR queue. Threads scheduling work would queue to the pre-queue.
>>>> The queue thread would pull ops off that queue and place them into the
>>>> specialized queue, do house keeping, etc and would dequeue ops in that
>>>> queue to a post-queue that worker threads would monitor. The thread
>>>> queue could keep a certain amount of items in the post-queue to
>>>> prevent starvation and worker threads from being blocked.
>>>
>>> I'm not sure what the advantage of this would be -- it adds another thread
>>> to the processing pipeline at best.
>>
>> There are a few reasons I thought about it. 1. It is hard to
>> prioritize/mange the work load if you can't see/manage all the
>> operations. One queue allows the algorithm to make decisions based on
>> all available information. (This point seems to be handled in a
>> different way in the future) 2. Reduce latency in the Op path. When an
>> OP is queued, there is overhead in getting it in the right place. When
>> an OP is dequeued there is more overhead in spreading tokens, etc.
>> Right now that is all serial, if an OP is stuck in the queue waiting
>> to be dispatched some of this overhead can't be performed while in
>> this waiting period. The idea is pushing that overhead to a separate
>> thread and allowing a worker thread to queue/dequeue in the most
>> efficient manner. It also allows for more complex trending,
>> scheduling, etc because it can sit outside of the OP path. As the
>> workload changes, it can dynamically change how it manages the queue
>> like simple fifo for low periods where latency is dominated by compute
>> time, to Token/WRR when latency is dominated by disk access, etc.
>>
>
> We basically don't want a single thread to see all of the operations -- it
> would cause a tremendous bottleneck and complicate the design
> immensely.  It's shouldn't be necessary anyway since PGs are a form
> of course grained locking, so it's probably fine to schedule work for
> different groups of PGs independently if we assume that all kinds of
> work are well distributed over those groups.

There are are some queue implementations that rely on a single thread
essentially playing traffic cop in between queues and it's pretty
fast. FastFlow, the C++ lib, does that. It constructs other kinds of
queues from fast lock-free / wait-free SPSC queues. In the case of
something like MPMC there's a mediator thread there that manages N
SPSC in-queus to MSPC out-queues.

I'm only bringing this up since if you have a problem that might need
a mediator to arrange order, it's possible to do it fast.

>
>>>> It would require the worker thread to be able to handle any kind of
>>>> op, or having separate post-queues for the different kinds of work.
>>>> I'm getting the feeling that this may be a far too simplistic approach
>>>> to the problem (or at least in terms of the organization of Ceph at
>>>> this point). I'm also starting to feel that I'm getting out of my
>>>> league trying to understand all the intricacies of the OSD work flow
>>>> (trying to start with one of the most complicated parts of the system
>>>> doesn't help).
>>>>
>>>> Maybe what I should do is just code up the queue to drop in as a
>>>> replacement for the Prio queue for the moment. Then as your async work
>>>> is completing we can shake out the potential issues with recovery and
>>>> costs that we talked about earlier. One thing that I'd like to look
>>>> into is elevating the priority of recovery ops that have client OPs
>>>> blocked. I don't think the WRR queue gives the recovery thread a lot
>>>> of time to get its work done.
>>>>
>>>
>>> If an op comes in that requires recovery to happen before it can be
>>> processed, we send the recovery messages with client priority rather
>>> than recovery priority.
>>
>> But the recovery is still happening the recovery thread and not the
>> client thread, right? The recovery thread has a lower priority than
>> the op thread? That's how I understand it.
>>
>
> No, in hammer we removed the snap trim and scrub workqueues.  With
> wip-recovery-wq, I remove the recovery wqs as well.  Ideally, the only
> meaningful set of threads remaining will be the op_tp and associated
> queues.
>
>>>> Based on some testing on Friday, the number of recovery ops on an osd
>>>> did not really change if there were 20 backfilling or 1 backfilling.
>>>> The difference came in with how many client I/Os were blocked waiting
>>>> for objects to recover. When 20 backfills were going, there were a lot
>>>> more blocked I/O waiting for objects to show up or recover. With one
>>>> backfill, there were far less blocked I/O, but there were still times
>>>> I/O would block.
>>>
>>> The number of recovery ops is actually a separate configurable
>>> (osd_recovery_max_active -- default to 15).  It's odd that with more
>>> backfilling on a single osd, there is more blocked IO.  Looking into
>>> that would be helpful and would probably give you some insight
>>> into recovery and the op processing pipeline.
>>
>> I'll see what I can find here.
>>
>> - ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v1.2.3
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJWQQJ0CRDmVDuy+mK58QAAeeUP/1uN/9EdqQDJdxW7fgeJ
>> /E0X49LmnnCigMPL5QJ3fpGjf44C0xcc9LN5IGJwwumHd5ozznpocy8Oj30N
>> +rNPJQ4dxcRao+bXUL/+DCQuY0wN/i7CqfMTW5PFmkdH4K9Lgce+bN6Q5Ora
>> q8JZvAxaZLCLZ10N+uiD5ghs+3X68hu4Da8SYQj0vjLs5gV4oATebF3JuYXW
>> GZ9qNfm2ygbeuT5Q0fhOKrvwJ9taKagMNrZLU10Wz5lHpGNitP3f17sVQznF
>> 7ZCkZ+2oS+P4Lerchc3xB2qBJUoPJGSuGAUTSl/uUeyMoZT1+2LvLdNbJaio
>> UonoKJv47p4mpjo75x6FTWbJg0Ix+8/3/6oo3CkxC+6vOeWcv90B3TJGJPRz
>> tAayNB/1YpsVZ3QlHiuyC7+TdKofLRlMR21iAnAJkZ6FdgMz9SFk1Rp4vuyR
>> 1qeZ+B4qA0m9ZWjx/G80j3fkUDY48EHR5gnI1k+WHFAh8KqT3eTRr37n9HH4
>> 7wVakfPv89+HRjqrlA7WK5F89UVp1I+2kEmtPADCiwgh2wf0zn7Y5tA4FMXH
>> DIloZIRfvPwFtwpqgF7GR5vb/1dEOzD9Da0Zb7gBfsEfGaI2pJ+yvD1ad3BB
>> eqHQ05rl7s8meeX0H+6gWn9/f0JA65k2P2Y4N3YHk6OvKqIqnhreS9Tl4grH
>> MrBN
>> =Ju+O
>> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
