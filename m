From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Mon, 9 Nov 2015 14:30:40 -0700
Message-ID: <CAANLjFpVtK7wNFJPQtkewLtjP5d0M6iab42PF09ii6E3ddT3Mg@mail.gmail.com>
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
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35115 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbbKIVao (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Nov 2015 16:30:44 -0500
Received: by vkgy188 with SMTP id y188so1761511vkg.2
        for <ceph-devel@vger.kernel.org>; Mon, 09 Nov 2015 13:30:43 -0800 (PST)
In-Reply-To: <CAN=+7FW3G1V5DvF=C=TCiBN_L2xLhydhXGbbUc4GYG=-dEqGEg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Mon, Nov 9, 2015 at 1:49 PM, Samuel Just  wrote:
> We basically don't want a single thread to see all of the operations -- it
> would cause a tremendous bottleneck and complicate the design
> immensely.  It's shouldn't be necessary anyway since PGs are a form
> of course grained locking, so it's probably fine to schedule work for
> different groups of PGs independently if we assume that all kinds of
> work are well distributed over those groups.

The only issue that I can see, based on the discussion last week, is
when the client I/O is small. There will be some points where each
thread will think it is OK so send a bolder along with the pebbles
(recovery I/O vs. client I/O), If all/most of the threads send a
bolder at the same time would it cause issues for slow disks
(spindles)? A single queue would be much more intelligent about
situations like this and spread the bolders out better. It also seems
more scalable as you add threads (I don't think really practical on
spindles). I assume the bottleneck in your concern is the thread
communication between threads? I'm trying to understand and in no way
trying to attack you (I've been know to come across differently than I
intend to).

>> But the recovery is still happening the recovery thread and not the
>> client thread, right? The recovery thread has a lower priority than
>> the op thread? That's how I understand it.
>>
>
> No, in hammer we removed the snap trim and scrub workqueues.  With
> wip-recovery-wq, I remove the recovery wqs as well.  Ideally, the only
> meaningful set of threads remaining will be the op_tp and associated
> queues.

OK, that is good news, I didn't do a scrub so I haven't seen the OPs
for that. Do you know the priorities of snap trim, scrub and recovery
so that I can do some math/logic on applying costs in an efficient way
as we talked about last week?

Thanks,

- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWQRB6CRDmVDuy+mK58QAAAsMP/RoBeyhqwNDURHagKJ9i
knjYW4jy0FFw1XmnFRhJN7FuFlYlHZ+bwvQGGYvmOkLlxgY9Y+J1GglwwV14
Vvtd/1LBOUw06Ch/WjhcgVFNIQdgdNBPHPaRurSTGxnofYKAwqB266gnzwAo
oX3EpgRskzrlwrOIg+b46Z3FhbdxYfJVqsWIEazIu9uFJDxf/pFimWSig0n1
bQsB0lZNeTbGKYww5GZqPtY3dVNqbfM6Xj5r5kxf5mhDZ2vKWJfvlc8nu86z
/VIDy5ZHPFZzv79wNlzNtZ9ofdmMT4n0Bhk8q4SFQSivs2z68DQxthcGXVaB
Bp5gy19QyE2mC6SeG3kwCYlEiGwJBGN5PVj9wDWrqDRiG/3eRS9yUs7N3RPW
hViKOYCt5lHBEhkkXaE824FweWZhupzXjiAjCMXYGtWek4LbLH9XFiMrigbR
b07EohO3cnXvrHL3+SmdEsHs0PIS0o9anyB7wn7Ze9oHQNYHXmzw48nzhth6
juGxCVeg80iNnlwpH/jQRfyEFB8rKfpJd7BLYdJgc/q4L25o/q588MeUqjUw
gc0cVkoKnegbz1fZ85CjI3YGXgXwRtVXFFl4Z+KdEJlEa1q9nRBGsho8LkT6
aanb77/QUJixLi7QQi8blXMvY0wjxzEkbtkoij0rL1OaxmKpoy/Nb8v6kyDL
rnL6
=IlY9
-----END PGP SIGNATURE-----
