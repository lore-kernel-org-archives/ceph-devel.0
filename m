From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS Space Accounting and Quotas
Date: Mon, 11 Mar 2013 09:57:53 -0700
Message-ID: <90B756938EF64998B9230F4E48620CDE@inktank.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38267 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab3CKQ6B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 12:58:01 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so3987397pbc.36
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 09:58:01 -0700 (PDT)
In-Reply-To: <513E0AF7.7050108@sandia.gov>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>

On Monday, March 11, 2013 at 9:48 AM, Jim Schutt wrote:
> On 03/11/2013 09:48 AM, Greg Farnum wrote:
> > On Monday, March 11, 2013 at 7:47 AM, Jim Schutt wrote:
> > > 
> > > For this run, the MDS logging slowed it down enough to cause the
> > > client caps to occasionally go stale. I don't think it's the cause
> > > of the issue, because I was having it before I turned MDS debugging
> > > up. My client caps never go stale at, e.g., debug mds 5.
> > 
> > 
> > 
> > Oh, so this might be behaviorally different than you were seeing before? Drat.
> > 
> > You had said before that each newfstatat was taking tens of seconds,
> > whereas in the strace log you sent along most of the individual calls
> > were taking a bit less than 20 milliseconds. Do you have an strace of
> > them individually taking much more than that, or were you just
> > noticing that they took a long time in aggregate?
> 
> 
> 
> When I did the first strace, I didn't turn on timestamps, and I was
> watching it scroll by. I saw several stats in a row take ~30 secs,
> at which point I got bored, and took a look at the strace man page to
> figure out how to get timestamps ;)
> 
> Also, another difference is for that test, I was looking at files
> I had written the day before, whereas for the strace log I sent,
> there was only several minutes between writing and the strace of find.
> 
> I thought I had eliminated the page cache issue by using fdatasync
> when writing the files. Perhaps the real issue is affected by that
> delay?

I'm not sure. I can't think of any mechanism by which waiting longer would increase the time lags, though, so I doubt it.

> > I suppose if you were going to run it again then just the message
> > logging could also be helpful. That way we could at least check and
> > see the message delays and if the MDS is doing other work in the
> > course of answering a request.
> 
> 
> 
> I can do as many trials as needed to isolate the issue.
> 
> What message debugging level is sufficient on the MDS; 1?
Yep, that will capture all incoming and outgoing messages. :) 
> 
> If you want I can attempt to duplicate my memory of the first
> test I reported, writing the files today and doing the strace
> tomorrow (with timestamps, this time).
> 
> Also, would it be helpful to write the files with minimal logging, in
> hopes of inducing minimal timing changes, then upping the logging
> for the stat phase?

Well that would give us better odds of not introducing failures of any kind during the write phase, and then getting accurate information on what's happening during the stats, so it probably would. Basically I'd like as much logging as possible without changing the states they system goes through. ;)
-Greg

