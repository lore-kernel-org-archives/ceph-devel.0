From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Wed, 4 Nov 2015 19:20:09 -0800
Message-ID: <CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
References: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
	<CAN=+7FWJ2aH1mRg7Z4P2o9f7hB7q2MHE6rBzyeR9Yrnf8qh3jA@mail.gmail.com>
	<CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35561 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031670AbbKEDUL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Nov 2015 22:20:11 -0500
Received: by wmll128 with SMTP id l128so1959845wml.0
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2015 19:20:10 -0800 (PST)
In-Reply-To: <CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 4, 2015 at 7:00 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Thanks for your help on IRC Samuel. I think I found where I made a
> mistake. I'll do some more testing. So far with max_backfills=1 on
> spindles, the impact of setting an OSD out and in on a saturated
> cluster seems to be minimal. On my I/O graphs it is hard to tell where
> the OSD was out and in recovering. If I/O becomes blocked, it seems
> that they don't linger around long. All of the clients report getting
> about the same amount of work done with little variance so no one
> client is getting indefinitely blocked (or blocked for really long
> times) causing the results between clients to be skewed like before.
>
> So far this queue seems to be very positive. I'd hate to put a lot of
> working getting this ready to merge if there is little interest in it
> (a lot of things to do at work and some other things I'd like to track
> down in the Ceph code as well). What are some of the next steps for
> something like this, meaning a pretty significant change to core code?

Well, step one is to convince people it's worthwhile. Your performance
information and anecdotal evidence of client impact is a pretty good
start. For it to get merged:
1) People will need to review it and verify it's not breaking anything
they can identify from code. Things are a bit constricted right now,
but this is pretty small and of high interest so I make no promises
for the core team but submitting a PR will be the way to start.
Getting positive buy-in from other contributors who are interested in
performance will also push it up the queue.
2) There will need to be a lot of testing on something like this.
Everything has to pass a run of the RADOS suite. Unfortunately this is
a bad month for that as the lab is getting physically shipped around
in a few weeks, so if you can afford to make it happen with the
teuthology-openstack stuff that will accelerate the timeline a lot (we
will still need to run it ourselves but once it's passed externally we
can put it in a lot more test runs we expect to pass, instead of in a
bucket with others that will all get blocked on any one failure).
3) For a new queuing system I suspect that rather than a direct merge
to default master, Sam will want to keep both in the code for a while
with a config value and run a lot of the nightlies on this one to
tease out any subtle races and bugs.
4) Eventually we become confident that it's in good shape and it
replaces the old queue.

Obviously those are the optimistic steps. ;)
-Greg

>
> Thank you to all who took time to help point me in the right direction.
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Wed, Nov 4, 2015 at 12:49 PM, Samuel Just  wrote:
>> I didn't look into it closely, but that almost certainly means that
>> your queue is reordering primary->replica replicated write messages.
>> -Sam
>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWOsY1CRDmVDuy+mK58QAA9LIQALIUgbS4BuDS704HPOpA
> XwvGxspelMCaBkLHLgiHU4T/Jc8JaXhgdRMwMiKeLI246Z7hRngSGlIDYc4+
> nP4kWZIkwbJeTa/Z6bM6C3itFtJmQpkPvdjI+GiME5ZdYvFgCZQyDD71rqja
> H14m0+JsEaIHQF0JZz6OyNxbyRWsM+M68nOvpAx8/fOGHBC/0VwPbLrOUP9O
> 3J3NvbhN9xlYJeivXSAyzxmHQDD8mO1c1AUTrHgnTViD2k3fmcH0mOHIJ+jn
> ARZbeLN3hlXG0i9PHpnHzBVNSxsfb5VPxX970R3gvRWIt40QV/QL7q2SajWP
> ofxgEpkaO48ANQSYDlqSNcM+w46TtgcJljtX0vbrHIW3Skyaz4UZQ/dzX4lX
> a5Zzk01oFwXfMd10KgVbJf78qVYHy2r5aq46iFnrFLU43iy+Qve7Kex4XZFi
> vPFFVea89Of838NqTxW21+3oJthrz1g7RKHghZAbXaj3WKchuEU+uVG4XTo1
> 0PU4a5ZYVTH6zYHpwJo2/89OzdkBe9S6s00+4JmfVWWEhb6+QwUjBQp1TJbB
> TnMzSKfzgRyi/wHThv2XcZN12tttZMM2L4Ea3mHG+cxOTTZ1opv8/H2mprm8
> 7UuO4vk5K0c4IwPVmt9m5DTVhyn4hZ/QJmc+NARD3zc1u3qWFLkH2WaRMpBb
> mRWA
> =kgAl
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
