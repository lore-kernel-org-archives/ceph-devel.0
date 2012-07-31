From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: avoiding false detection of down OSDs
Date: Tue, 31 Jul 2012 13:58:58 -0600
Message-ID: <50183902.40906@sandia.gov>
References: <CAPYLRzjoaWkMkz4U+=rZQ+YMS76vkLf_KVZfbWmdLnPuCYadSw@mail.gmail.com>
 <50170EF0.5040004@sandia.gov>
 <CAPYLRzhH-MNPHhXbg36jkMGGdh3mtn+jqR5FQDzGta0y67UkPw@mail.gmail.com>
 <5017F4CC.9070308@sandia.gov>
 <CAPYLRzg6=xc0ib=Wdv96TzuCYWdw6zbUSVWvvYPPNp0_ExpW9g@mail.gmail.com>
 <alpine.DEB.2.00.1207311136130.3171@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:43878 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab2GaT7c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 15:59:32 -0400
In-Reply-To: <alpine.DEB.2.00.1207311136130.3171@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org

On 07/31/2012 12:40 PM, Sage Weil wrote:
> On Tue, 31 Jul 2012, Gregory Farnum wrote:
>> On Tue, Jul 31, 2012 at 8:07 AM, Jim Schutt<jaschut@sandia.gov>  wrote:

>>> Also, FWIW I've been running my Ceph servers with no swap,
>>> and I've recently doubled the size of my storage cluster.
>>> Is it possible to have map processing do a little memory
>>> accounting and log it, or to provide some way to learn
>>> that map processing is chewing up significant amounts of
>>> memory?  Or maybe there's already a way to learn this that
>>> I need to learn about?  I sometimes run into something that
>>> shares some characteristics with what you describe, but is
>>> primarily triggered by high client write load.  I'd like
>>> to be able to confirm or deny it's the same basic issue
>>> you've described.
>>
>> I think that we've done all our diagnosis using profiling tools, but
>> there's now a map cache and it probably wouldn't be too difficult to
>> have it dump data via perfcounters if you poked around...anything like
>> this exist yet, Sage?
>
> Much of the bad behavior was triggered by #2860, fixes for which just went
> into the stable and master branches yesterday.  It's difficult to fully
> observe the bad behavior, though (lots of time spend in
> generate_past_intervals, reading old maps off disk).  With the fix, we
> pretty much only process maps during handle_osd_map.
>
> Adding perfcounters in the methods that grab a map out of the cache or
> (more importantly) read it off disk will give you better visibility into
> that.  It should be pretty easy to instrument that (and I'll gladly
> take patches that implement that... :).  Without knowing more about what
> you're seeing, it's hard to say if its related, though.  This was
> triggered by long periods of unclean pgs and lots of data migration, not
> high load.

An issue I've been seeing is unusually high OSD memory use.
It seems to be triggered by linux clients timing out requests
and resetting OSDs during a heavy write load, but I was hoping
to rule out any memory-use issues caused by map processing.
However, this morning I started testing your server wip-msgr
branch together with the kernel-side patches queued up for 3.6,
and so far with that combination I've been unable to trigger the
behavior I was seeing.  So, that's great news, and I think
confirms that issue was unrelated to any map issues.

I've also sometimes had issues with my cluster becoming unstable
when failing an OSD while the cluster is under a heavy write load,
but hadn't been successful at characterizing under what conditions
it couldn't recover.  I expect that situation is now improved as
well, and will retest.

Thanks -- Jim

>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


