From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling
 under very heavy write load
Date: Thu, 28 Feb 2013 12:37:11 -0700
Message-ID: <512FB1E7.8090001@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov>
 <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F47AEE3.5080305@sandia.gov>
 <alpine.DEB.2.00.1302201551580.26205@cobra.newdream.net>
 <512D0A1F.30801@sandia.gov>
 <alpine.DEB.2.00.1302261135190.4819@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:35335 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499Ab3B1Thj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 14:37:39 -0500
In-Reply-To: <alpine.DEB.2.00.1302261135190.4819@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org, sri@basam.org

Hi Sage,

On 02/26/2013 12:36 PM, Sage Weil wrote:
> On Tue, 26 Feb 2013, Jim Schutt wrote:
>>> I think the right solution is to make an option that will setsockopt on 
>>> SO_RECVBUF to some value (say, 256KB).  I pushed a branch that does this, 
>>> wip-tcp.  Do you mind checking to see if this addresses the issue (without 
>>> manually adjusting things in /proc)?
>>
>> I'll be happy to test it out...
> 
> That would be great!  It's branch wip-tcp, and the setting is 'ms tcp 
> rcvbuf'.

I've verified that I can reproduce the slowdown with the
default value of 1 for /proc/sys/net/ipv4/tcp_moderate_rcvbuf,
and 'ms tcp rcvbuf' at 0.

I've also verified that I could not reproduce any slowdown when
I configure 'ms tcp rcvbuf' to 256 KiB on OSDs.

So, that's great news - sorry for the delay in testing.

Also, FWIW, I ended up testing with commits cb15e6e0f4 and
c346282940 cherry-picked on top of next as of a day or
so ago (commit f58601d681), as for some reason wip-tcp
wouldn't work for me - ceph-mon was non-responsive in
some way I didn't dig into.

-- Jim

> 
> Thanks!
> sage
> 
> 


