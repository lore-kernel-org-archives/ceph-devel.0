From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Thu, 5 Nov 2015 08:14:44 -0700
Message-ID: <CAANLjFo8RiTqmQJEbr5O082613pNGsu3-YM0VX-tToY-YPBfuQ@mail.gmail.com>
References: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
	<CAN=+7FWJ2aH1mRg7Z4P2o9f7hB7q2MHE6rBzyeR9Yrnf8qh3jA@mail.gmail.com>
	<CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
	<CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34937 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbbKEPOq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Nov 2015 10:14:46 -0500
Received: by ykek133 with SMTP id k133so135975396yke.2
        for <ceph-devel@vger.kernel.org>; Thu, 05 Nov 2015 07:14:45 -0800 (PST)
In-Reply-To: <CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Thanks Gregory,

People are most likely busy and haven't had time to digest this and I
may be expecting more excitement from it (I'm excited due to the
results and probably also that such a large change still works). I'll
keep working towards a PR, this was mostly proof of concept, now that
there is some data I'll clean up the code.

I was thinking that a config option to choose the scheduler would be a
good idea. In terms of the project what is the better approach: create
a new template and each place the template class is instantiated
select the queue, or perform the queue selection in the same template
class, or something else I haven't thought of.

Are there public teuthology-openstack systems that could be used for
testing? I don't remember, I'll have to search back through the
mailing list archives.

I appreciate all the direction as I've tried to figure this out.

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Nov 4, 2015 at 8:20 PM, Gregory Farnum  wrote:
> On Wed, Nov 4, 2015 at 7:00 PM, Robert LeBlanc  wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> Thanks for your help on IRC Samuel. I think I found where I made a
>> mistake. I'll do some more testing. So far with max_backfills=1 on
>> spindles, the impact of setting an OSD out and in on a saturated
>> cluster seems to be minimal. On my I/O graphs it is hard to tell where
>> the OSD was out and in recovering. If I/O becomes blocked, it seems
>> that they don't linger around long. All of the clients report getting
>> about the same amount of work done with little variance so no one
>> client is getting indefinitely blocked (or blocked for really long
>> times) causing the results between clients to be skewed like before.
>>
>> So far this queue seems to be very positive. I'd hate to put a lot of
>> working getting this ready to merge if there is little interest in it
>> (a lot of things to do at work and some other things I'd like to track
>> down in the Ceph code as well). What are some of the next steps for
>> something like this, meaning a pretty significant change to core code?
>
> Well, step one is to convince people it's worthwhile. Your performance
> information and anecdotal evidence of client impact is a pretty good
> start. For it to get merged:
> 1) People will need to review it and verify it's not breaking anything
> they can identify from code. Things are a bit constricted right now,
> but this is pretty small and of high interest so I make no promises
> for the core team but submitting a PR will be the way to start.
> Getting positive buy-in from other contributors who are interested in
> performance will also push it up the queue.
> 2) There will need to be a lot of testing on something like this.
> Everything has to pass a run of the RADOS suite. Unfortunately this is
> a bad month for that as the lab is getting physically shipped around
> in a few weeks, so if you can afford to make it happen with the
> teuthology-openstack stuff that will accelerate the timeline a lot (we
> will still need to run it ourselves but once it's passed externally we
> can put it in a lot more test runs we expect to pass, instead of in a
> bucket with others that will all get blocked on any one failure).
> 3) For a new queuing system I suspect that rather than a direct merge
> to default master, Sam will want to keep both in the code for a while
> with a config value and run a lot of the nightlies on this one to
> tease out any subtle races and bugs.
> 4) Eventually we become confident that it's in good shape and it
> replaces the old queue.
>
> Obviously those are the optimistic steps. ;)
> -Greg
>
>>
>> Thank you to all who took time to help point me in the right direction.
>> - ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>
>>
>> On Wed, Nov 4, 2015 at 12:49 PM, Samuel Just  wrote:
>>> I didn't look into it closely, but that almost certainly means that
>>> your queue is reordering primary->replica replicated write messages.
>>> -Sam
>>>
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: Mailvelope v1.2.3
>> Comment: https://www.mailvelope.com
>>
>> wsFcBAEBCAAQBQJWOsY1CRDmVDuy+mK58QAA9LIQALIUgbS4BuDS704HPOpA
>> XwvGxspelMCaBkLHLgiHU4T/Jc8JaXhgdRMwMiKeLI246Z7hRngSGlIDYc4+
>> nP4kWZIkwbJeTa/Z6bM6C3itFtJmQpkPvdjI+GiME5ZdYvFgCZQyDD71rqja
>> H14m0+JsEaIHQF0JZz6OyNxbyRWsM+M68nOvpAx8/fOGHBC/0VwPbLrOUP9O
>> 3J3NvbhN9xlYJeivXSAyzxmHQDD8mO1c1AUTrHgnTViD2k3fmcH0mOHIJ+jn
>> ARZbeLN3hlXG0i9PHpnHzBVNSxsfb5VPxX970R3gvRWIt40QV/QL7q2SajWP
>> ofxgEpkaO48ANQSYDlqSNcM+w46TtgcJljtX0vbrHIW3Skyaz4UZQ/dzX4lX
>> a5Zzk01oFwXfMd10KgVbJf78qVYHy2r5aq46iFnrFLU43iy+Qve7Kex4XZFi
>> vPFFVea89Of838NqTxW21+3oJthrz1g7RKHghZAbXaj3WKchuEU+uVG4XTo1
>> 0PU4a5ZYVTH6zYHpwJo2/89OzdkBe9S6s00+4JmfVWWEhb6+QwUjBQp1TJbB
>> TnMzSKfzgRyi/wHThv2XcZN12tttZMM2L4Ea3mHG+cxOTTZ1opv8/H2mprm8
>> 7UuO4vk5K0c4IwPVmt9m5DTVhyn4hZ/QJmc+NARD3zc1u3qWFLkH2WaRMpBb
>> mRWA
>> =kgAl
>> -----END PGP SIGNATURE-----
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWO3JgCRDmVDuy+mK58QAAeCcP/jHnG3r257cdcRYZzg9o
iMOxnuKAXNnwscYzJysCHsoQ2S3dB9SCxt8r+QvDo09IkXzarFaW647nzG6H
zeCtbhx2NFU/jOqPip/8XDUaDYlDrjHuskDJwz+jzoaZfWPjLfPkmETU/8vh
mrGZH+kjYuu1WhmM8cGJZJLrKA7C2OPTAU5PRmx5enClHXhdxyskZ7BUxcXp
uPJJg7pemT/qaJPrO7e7wwhYw43GaeSULp8QGFsqireCwbv9mndB7bbOa40U
ElHmgWgcG1UkkydW/U9DaJHM52ZbrAuG7XkZRsmB1oTmVriEoOFYSiGv5F+R
Mjxe9OlqiL9Fd/AQXunAAMdwIU5T3mlkrxMvhroRkW2+EerrRVW3JbJ8gmQ9
lXPRw9RxcQY5m8S+8+CWikBHvsRBCXEGA8tXUYqLuDJKpRHeCo7PpONS3III
QB+tgWaMteoeJGZ7nGLFcaKxTGa1tNKju4M2845/L8Fawy8jdYYcLqOTUs80
M1gpQ0UHzTXdQEdQnufxgaCFfwblF5vIlr6qd89rR5m0eJipElQLi2Uh0Zd3
0t0i0xtFdprkxDmzX/bzbARAnlS1cz/yoB85r3JxeNPev671mocQc0uyFkt7
P04ogGWzLBN5B4nWNWDznOZS52G+vhkFxryUyl9+LDafAKiTTPmhB/LXPMs+
7ny7
=Xg0t
-----END PGP SIGNATURE-----
