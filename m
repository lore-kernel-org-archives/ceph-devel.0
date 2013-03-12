From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: CephFS Space Accounting and Quotas
Date: Tue, 12 Mar 2013 16:34:01 -0600
Message-ID: <513FAD59.4040205@sandia.gov>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
 <1F15E079964848B9BE079E974A1946B4@inktank.com>
 <alpine.DEB.2.00.1303051027180.26446@cobra.newdream.net>
 <51363B30.7080006@42on.com>
 <alpine.DEB.2.00.1303051131010.29462@cobra.newdream.net>
 <513793FD.7010001@sandia.gov>
 <340852C7DC4E472A9D6EA3E0AEDE6EB0@inktank.com>
 <51379FCD.9000502@sandia.gov>
 <D19243567199482692F961618A335817@inktank.com>
 <5137B4E9.1030505@sandia.gov>
 <1856965A675D4D5D971D5DC9AB01C657@inktank.com>
 <5137CDE2.70105@sandia.gov>
 <8B6963669A2E49C286B9241DCD62F557@inktank.com>
 <5138AEFB.5070200@sandia.gov> <513A69F8.6050709@sandia.gov>
 <391D23EA41AE4F05BCE2E6367BA0FC3C@inktank.com>
 <513DEE83.8030909@sandia.gov>
 <114836C3F596429AAB29E98225A25E1B@inktank.com>
 <513E0AF7.7050108@sandia.gov>
 <90B756938EF64998B9230F4E48620CDE@inktank.com>
 <513E4124.9040309@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53156 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933715Ab3CLWe1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Mar 2013 18:34:27 -0400
In-Reply-To: <513E4124.9040309@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On 03/11/2013 02:40 PM, Jim Schutt wrote:
>>> >> If you want I can attempt to duplicate my memory of the first
>>> >> test I reported, writing the files today and doing the strace
>>> >> tomorrow (with timestamps, this time).
>>> >>
>>> >> Also, would it be helpful to write the files with minimal logging, in
>>> >> hopes of inducing minimal timing changes, then upping the logging
>>> >> for the stat phase?
>> > 
>> > Well that would give us better odds of not introducing failures of
>> > any kind during the write phase, and then getting accurate
>> > information on what's happening during the stats, so it probably
>> > would. Basically I'd like as much logging as possible without
>> > changing the states they system goes through. ;)
> Hmmm, this is getting more interesting...
> 
> I just did two complete trials where I built a file system,
> did two sets of writes with minimal MDS logging, then 
> turned MDS logging up to 20 with MDS ms logging at 1 for
> the stat phase.
> 
> In each trial my strace'd find finished in < 10 seconds,
> and there were no slow stat calls (they were taking ~19 ms
> each).
> 
> I'm going to do a third trial where I let things rest
> overnight, after I write the files.  That delay is the
> only thing I haven't reproduced from my first trial....

As you suspected, that didn't make any difference either...
That trial didn't reproduce the slow stat behavior.

It turns out that the only way I can reliably reproduce
the slow stat behavior right now is to turn MDS debugging
up to 20.

I've got another set of logs with MDS debug ms = 1,
which I'll send via an off-list email.

I still haven't figured out what made that first test
exhibit this behavior, when I was using debug mds = 5.

-- Jim

> 
> -- Jim
> 
> 


