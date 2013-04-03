From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Trouble getting a new file system to start, for v0.59 and
 newer
Date: Wed, 3 Apr 2013 16:40:45 -0600
Message-ID: <515CAFED.60705@sandia.gov>
References: <515C4EC4.5040602@sandia.gov>
 <alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net>
 <515C6232.4070204@sandia.gov>
 <CAPYLRzgT47iTKuv-YCQWfU_4O=prrkEByp9KAftj2jFMktve5Q@mail.gmail.com>
 <CAPYLRzhzQp3xsf_QzzYYJo9RAj_sBV1THs2PJUhk1QRe9XB42w@mail.gmail.com>
 <515C6DD1.2050702@sandia.gov>
 <alpine.DEB.2.00.1304031123540.15431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:57804 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758730Ab3DCWlQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 18:41:16 -0400
In-Reply-To: <alpine.DEB.2.00.1304031123540.15431@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/03/2013 12:25 PM, Sage Weil wrote:
>>> > > Sorry, guess I forgot some of the history since this piece at least is
>>> > > resolved now. I'm surprised if 30-second timeouts are causing issues
>>> > > without those overloads you were seeing; have you seen this issue
>>> > > without your high debugging levels and without the bad PG commits (due
>>> > > to debugging)?
>> > 
>> > I think so, because that's why I started with higher debugging
>> > levels.
>> > 
>> > But, as it turns out, I'm just in the process of returning to my
>> > testing of next, with all my debugging back to 0.  So, I'll try
>> > the default timeout of 30 seconds first.  If I have trouble starting
>> > up a new file system, I'll turn up the timeout and try again, without
>> > any extra debugging.  Either way, I'll let you know what happens.
> I would be curious to hear roughly what value between 30 and 300 is 
> sufficient, if you can experiment just a bit.  We probably want to adjust 
> the default.
> 
> Perhaps more importantly, we'll need to look at the performance of the pg 
> stat updates on the mon.  There is a refactor due in that code that should 
> improve life, but it's slated for dumpling.

OK, here's some results, with all debugging at 0, using current next...

My testing is for 1 mon + 576 OSDs, 24/host. All my storage cluster hosts
use 10 GbE NICs now.  The mon host uses an SSD for the mon data store.
My test procedure is to start 'ceph -w', start all the OSDs, and once
they're all running start the mon.  I report the time from starting
the mon to all PGs active+clean.

# PGs     osd mon ack    startup    notes
            timeout       time
-------  ------------    --------   -----
 55392      default      >30:00       1
 55392        300         18:36       2
 55392         60        >30:00       3
 55392        150        >30:00       4
 55392        240        >30:00       5
 55392        300        >30:00       2,6

notes:
1) lots of PGs marked stale, OSDs wrongly marked down
     before I gave up on this case
2) OSDs report lots of slow requests for "pg_notify(...) v4
     currently wait for new map"
3) some OSDs wrongly marked down, OSDs report some slow requests
     for "pg_notify(...) v4 currently wait for new map"
     before I gave up on this case
4) appeared to be making progress; then an OSD was marked
     out at ~21 minutes; many more marked out before I
     gave up on this case
5) some OSD reports of slow requests for "pg_notify",
     some OSDs wrongly marked down, appeared to be making
     progress, then stalled; then I gave up on this case
6) retried this case, appeared to be making progress, but
     after ~18 min stalled at 19701 active+clean, 35691 peering
     until I gave up

Hmmm, I didn't really expect the above results.  I ran out of
time before attempting an even longer osd mon ack timeout.

But either we're on the wrong trail, or 300 is not sufficient.
Or, I'm doing something wrong and haven't yet figured out what
it is.

FWIW, on v0.57 or v0.58 I was testing with one pool at 256K PGs,
and my memory is a new filesystem started up in ~5 minutes.  For
that testing I had to increase 'paxos propose interval' to two
or three seconds to keep the monitor writeout rate (as measured
by vmstat) down to a sustained 50-70 MB/s during start-up.

That was with a 1 GbE NIC in the mon; the reason I upgraded
it was a filesystem with 512K PGs was taking too long to start,
and I thought the mon might be network-limited since it had an
SSD for the mon data store.

For the testing above I used the default 'paxos propose interval'.
I don't know if it matters, but vmstat sees only a little data
being written on the mon system.

-- Jim

> 
> sage
> 
>> > 
>> > -- Jim
>> > 
>>> > > -Greg
>>> > > Software Engineer #42 @ http://inktank.com | http://ceph.com


