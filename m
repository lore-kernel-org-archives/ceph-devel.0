From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Thu, 9 Feb 2012 16:34:53 -0800
Message-ID: <CAORUGqAYnNbBCE8inET++tUzGShRwDQcGn3uTXArrQrbM_rybA@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov> <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov> <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F2ADEAE.8010403@sandia.gov> <CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
 <4F2AF085.6000405@sandia.gov> <CAF3hT9AcxxNtscFczP8fShSsaBm_4zhLQZ2F5c7h1YswVaXHkA@mail.gmail.com>
 <4F2C08A7.2050507@sandia.gov> <3032884323297001561@unknownmsgid>
 <4F2C6EE6.4050008@sandia.gov> <CAC-hyiHSNv_VgLcyVCrJ66HxTGFNBONrmmBddJk5326dLTKgkw@mail.gmail.com>
 <4F2FFDD3.1010100@sandia.gov> <CAC-hyiEdAd++dQFBjPDutqipQcMXZqh4RdEEyA=v12vs6ueDxA@mail.gmail.com>
 <4F3019E9.80607@sandia.gov> <CAF3hT9CW7_CF4iT0cY858kgkke7Wu=TK7ULzPhFj-AW9jycyZA@mail.gmail.com>
 <4F343239.2010907@sandia.gov> <CAGnVnB=beb2XMB55FfG7TgBeqa4gmb=O1S54=s+V6rANeoq3ug@mail.gmail.com>
 <4F3453A7.9000408@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:49608 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729Ab2BJAfO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2012 19:35:14 -0500
Received: by wics10 with SMTP id s10so1648981wic.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Feb 2012 16:35:13 -0800 (PST)
In-Reply-To: <4F3453A7.9000408@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: sridhar basam <sri@basam.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Feb 9, 2012 at 15:15, Jim Schutt <jaschut@sandia.gov> wrote:
> I suspect a bug in the stack, as at an application level I get
> the same sort of stalls whether I use IP over ethernet or IPoIB.
> I need to get traces for both cases to prove that it is the same
> stall...

Hi. I just wanted to confirm that what your tcpdump shows is a packet
loss between the client and the osd. If this wasn't packet loss, you'd
expect the TCP window size to drop to 0 -- not remain at 64k as it is
in your dump -- and you'd expect to see ACKs that don't advance the
sequence number. Something like this:

16:25:16.914407 IP 127.0.0.1.60336 > 127.0.0.1.9999: Flags [P.], seq
90150:93094, ack 1, win 257, options [nop,nop,TS val 3732293 ecr
3732270], length 2944
16:25:16.914416 IP 127.0.0.1.9999 > 127.0.0.1.60336: Flags [.], ack
93094, win 0, options [nop,nop,TS val 3732293 ecr 3732293], length 0
16:25:17.144409 IP 127.0.0.1.60336 > 127.0.0.1.9999: Flags [.], ack 1,
win 257, options [nop,nop,TS val 3732316 ecr 3732293], length 0
16:25:17.144421 IP 127.0.0.1.9999 > 127.0.0.1.60336: Flags [.], ack
93094, win 0, options [nop,nop,TS val 3732316 ecr 3732293], length 0
16:25:17.604409 IP 127.0.0.1.60336 > 127.0.0.1.9999: Flags [.], ack 1,
win 257, options [nop,nop,TS val 3732362 ecr 3732316], length 0
16:25:17.604419 IP 127.0.0.1.9999 > 127.0.0.1.60336: Flags [.], ack
93094, win 0, options [nop,nop,TS val 3732362 ecr 3732293], length 0

As pointed out by Sridhar, various TCP offload mechanisms (and
firewalling!) may make your tcpdump not see the underlying reality.

You might also be just actually losing packets, and the osd settings
might, perhaps, influence the performance of the machine enough to
make it lose packets -- though that sounds a bit far fetched.

You might also be suffering from a Path MTU Discovery black hole, and
need the osd size cap to get full-frame packets out. I see your
tcpdump indicated jumbo frames (at least until the TSO engine!), that
might be its own source of pain.
