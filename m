From: Samuel Just <sjust@redhat.com>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Mon, 9 Nov 2015 14:35:26 -0800
Message-ID: <CAN=+7FU78Pq0nVdTn1uNR6p0b+_HQeMj3UrnvBRqg4OCdQKL3w@mail.gmail.com>
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
	<CAANLjFpVtK7wNFJPQtkewLtjP5d0M6iab42PF09ii6E3ddT3Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:32977 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbbKIWf1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 17:35:27 -0500
Received: by igvi2 with SMTP id i2so85783749igv.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2015 14:35:27 -0800 (PST)
In-Reply-To: <CAANLjFpVtK7wNFJPQtkewLtjP5d0M6iab42PF09ii6E3ddT3Mg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 9, 2015 at 1:30 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> On Mon, Nov 9, 2015 at 1:49 PM, Samuel Just  wrote:
>> We basically don't want a single thread to see all of the operations -- it
>> would cause a tremendous bottleneck and complicate the design
>> immensely.  It's shouldn't be necessary anyway since PGs are a form
>> of course grained locking, so it's probably fine to schedule work for
>> different groups of PGs independently if we assume that all kinds of
>> work are well distributed over those groups.
>
> The only issue that I can see, based on the discussion last week, is
> when the client I/O is small. There will be some points where each
> thread will think it is OK so send a bolder along with the pebbles
> (recovery I/O vs. client I/O), If all/most of the threads send a
> bolder at the same time would it cause issues for slow disks
> (spindles)? A single queue would be much more intelligent about
> situations like this and spread the bolders out better. It also seems
> more scalable as you add threads (I don't think really practical on
> spindles). I assume the bottleneck in your concern is the thread
> communication between threads? I'm trying to understand and in no way
> trying to attack you (I've been know to come across differently than I
> intend to).
>

This is one of the advantages of the dmclock/mclock based designs,
we'd be able to portion out the available IO (expresed as cost/time)
among the threads and let each queue schedule against its own
quota.  A significant challenge there of course is estimating available
io capacity. Another piece is that there needs to be a bound on how
large boulders get.  Recovery will break up recovery of large objects
into lots of messages to avoid having too large a boulder.  Similarly,
there are limits at least on the bulk size of a client IO operation.

I don't understand how a single queue would be more scalable as we
add threads.  Pre-giant, that's how the queue worked, and it was
indeed a significant bottleneck.

As I see it, each operation is ordered in two ways (each requiring
a lock/thread of control/something):
1) The message stream from the client is ordered (represented by
the reader thread in the SimpleMessenger).  The ordering here
is actually part of the librados interface contract for the most part
(certain reads could theoretically be reordered here without
breaking the rules).
2) Operations on the PG are ordered necessarily by the PG lock
(client writes by necessity, most everything else by convenience).

So at a minimum, something ordered by 1 needs to pass off to
something ordered by 2.  We currently do this by allowing the
reader thread to fast-dispatch directly into the op queue responsible
for the PG which owns the op.  A thread local to the right PG then
takes it from there.  This means that two different ops each of which
is on a different client/pg combo may not interact at all and could be
handled entirely in parallel (that's the ideal, anyway).  Depending on
what you mean by "queue", putting all ops in a single queue
necessarily serializes all IO on that structure (even if only for a small
portion of the execution time).  This limits both parallelism and
the amount of computation you can actually do to make the
scheduling decision even more so than the current design does.

Ideally, we'd like to have our cake and eat it too: we'd like good
scheduling (which PrioritizedQueue does not particularly well)
while minimizing overhead of the queue itself (an even bigger
problem with PrioritizedQueue) and keeping scaling as linear
as we can get it on many-core machines (which usually means
that independent ops should have a low probability of touching
the same structures).

>>> But the recovery is still happening the recovery thread and not the
>>> client thread, right? The recovery thread has a lower priority than
>>> the op thread? That's how I understand it.
>>>
>>
>> No, in hammer we removed the snap trim and scrub workqueues.  With
>> wip-recovery-wq, I remove the recovery wqs as well.  Ideally, the only
>> meaningful set of threads remaining will be the op_tp and associated
>> queues.
>
> OK, that is good news, I didn't do a scrub so I haven't seen the OPs
> for that. Do you know the priorities of snap trim, scrub and recovery
> so that I can do some math/logic on applying costs in an efficient way
> as we talked about last week?
>

There are config options in common/config_opt.h iirc.
-Sam

> Thanks,
>
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWQRB6CRDmVDuy+mK58QAAAsMP/RoBeyhqwNDURHagKJ9i
> knjYW4jy0FFw1XmnFRhJN7FuFlYlHZ+bwvQGGYvmOkLlxgY9Y+J1GglwwV14
> Vvtd/1LBOUw06Ch/WjhcgVFNIQdgdNBPHPaRurSTGxnofYKAwqB266gnzwAo
> oX3EpgRskzrlwrOIg+b46Z3FhbdxYfJVqsWIEazIu9uFJDxf/pFimWSig0n1
> bQsB0lZNeTbGKYww5GZqPtY3dVNqbfM6Xj5r5kxf5mhDZ2vKWJfvlc8nu86z
> /VIDy5ZHPFZzv79wNlzNtZ9ofdmMT4n0Bhk8q4SFQSivs2z68DQxthcGXVaB
> Bp5gy19QyE2mC6SeG3kwCYlEiGwJBGN5PVj9wDWrqDRiG/3eRS9yUs7N3RPW
> hViKOYCt5lHBEhkkXaE824FweWZhupzXjiAjCMXYGtWek4LbLH9XFiMrigbR
> b07EohO3cnXvrHL3+SmdEsHs0PIS0o9anyB7wn7Ze9oHQNYHXmzw48nzhth6
> juGxCVeg80iNnlwpH/jQRfyEFB8rKfpJd7BLYdJgc/q4L25o/q588MeUqjUw
> gc0cVkoKnegbz1fZ85CjI3YGXgXwRtVXFFl4Z+KdEJlEa1q9nRBGsho8LkT6
> aanb77/QUJixLi7QQi8blXMvY0wjxzEkbtkoij0rL1OaxmKpoy/Nb8v6kyDL
> rnL6
> =IlY9
> -----END PGP SIGNATURE-----
