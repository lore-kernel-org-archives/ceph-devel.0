From: Jim Schutt <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 31 Mar 2011 11:10:11 -0600
Message-ID: <4D94B573.7070505@sandia.gov>
References: <4D939FF7.1070104@sandia.gov> <Pine.LNX.4.64.1103301449400.18670@cobra.newdream.net> <4D948CAC.6040709@sandia.gov> <Pine.LNX.4.64.1103310920460.13796@cobra.newdream.net> <4D94B333.4060700@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:52337 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab1CaR2R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 13:28:17 -0400
In-Reply-To: <4D94B333.4060700@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Jim Schutt wrote:
> Sage Weil wrote:
>> On Thu, 31 Mar 2011, Jim Schutt wrote:
>>>> I was actually suggesting we try to make it core dump inside the 
>>>> "delete
>>>> this" and watching for a stall in progress and then sending SIGABRT 
>>>> to dump
>>>> core in the act.  That way we verify it really is in the allocator (and
>>>> maybe even see where).  That's a bit harder to set up, though!  
>>> Right, I couldn't think of how to automate that stall detection
>>> during the stall, rather than after.  At least, I couldn't
>>> think of how to do it without incurring possibly excessive
>>> overhead, say by starting a timer on every "delete this".
>>
>> Yeah.  I wonder if dumping core on a cosd right when it gets marked 
>> down would do the trick?  That should catch it ~20 seconds or whatever 
>> in the stall.  By watching for the "osdfoo marked down" messages from 
>> ceph -w?
> 
> What about making Cond::Wait() use pthread_cond_timedwait()
> with a suitable timeout value, say 10 seconds, and asserting
> on timeout?  Do you think there would be many legitimate 10
> second delays in OSD processing?
> 

Or, I could make a Cond::WaitIntervalOrAbort(), and
use it just on the pipe lock, since that's the source
of the trouble.  Sound useful?

-- Jim
