From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Fri, 24 Feb 2012 10:31:43 -0800
Message-ID: <CAORUGqDsOiU+FuoLOxJQV0nAPjtGPgmpyszRzs3O6myJkwO7fg@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov> <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov> <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F47AEE3.5080305@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61234 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab2BXScE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2012 13:32:04 -0500
Received: by wgbdt10 with SMTP id dt10so2340351wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2012 10:32:03 -0800 (PST)
In-Reply-To: <4F47AEE3.5080305@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org, sri@basam.org

On Fri, Feb 24, 2012 at 07:38, Jim Schutt <jaschut@sandia.gov> wrote:
> I've finally figured out what is going on with this behaviour.
> Memory usage was on the right track.
>
> It turns out to be an unfortunate interaction between the
> number of OSDs/server, number of clients, TCP socket buffer
> autotuning, the policy throttler, and limits on the total
> memory used by the TCP stack (net/ipv4/tcp_mem sysctl).
>
> What happens is that for throttled reader threads, the
> TCP stack will continue to receive data as long as there
> is available socket buffer, and the sender has data to send.

Ohh! Yes, if the userspace stops reading a socket, kernel will buffer
data as per SO_RCVBUF etc. And TCP has global limits, and that is
going to push it uncomfortably close to the global limit.

Ceph *could* manipulate SO_RCVBUF size at the time it decides to
throttle a client, that would limit the TCP buffer space consumed by
throttled clients (except for a race where the data got received
before Ceph called setsockopt). I recall seeing a trick like that
pulled off somewhere, but I can't find an example right now.

Or perhaps we just say "sorry your server is swamped with too much
work for the resources it's given; you need more of them". That's not
nice though, when throttling can slow down the non-throttled
connections.
