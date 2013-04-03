From: Gregory Farnum <greg@inktank.com>
Subject: Re: Trouble getting a new file system to start, for v0.59 and newer
Date: Wed, 3 Apr 2013 15:51:13 -0700
Message-ID: <CAPYLRzgyxiFQ_VVde9dB6WZhg5eFr-qbRxS6WQC7ewC4FXXWpQ@mail.gmail.com>
References: <515C4EC4.5040602@sandia.gov>
	<alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net>
	<515C6232.4070204@sandia.gov>
	<CAPYLRzgT47iTKuv-YCQWfU_4O=prrkEByp9KAftj2jFMktve5Q@mail.gmail.com>
	<CAPYLRzhzQp3xsf_QzzYYJo9RAj_sBV1THs2PJUhk1QRe9XB42w@mail.gmail.com>
	<515C6DD1.2050702@sandia.gov>
	<alpine.DEB.2.00.1304031123540.15431@cobra.newdream.net>
	<515CAFED.60705@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:42421 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489Ab3DCWvP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Apr 2013 18:51:15 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so506667qcs.20
        for <ceph-devel@vger.kernel.org>; Wed, 03 Apr 2013 15:51:14 -0700 (PDT)
In-Reply-To: <515CAFED.60705@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Sage Weil <sage@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Apr 3, 2013 at 3:40 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 04/03/2013 12:25 PM, Sage Weil wrote:
>>>> > > Sorry, guess I forgot some of the history since this piece at =
least is
>>>> > > resolved now. I'm surprised if 30-second timeouts are causing =
issues
>>>> > > without those overloads you were seeing; have you seen this is=
sue
>>>> > > without your high debugging levels and without the bad PG comm=
its (due
>>>> > > to debugging)?
>>> >
>>> > I think so, because that's why I started with higher debugging
>>> > levels.
>>> >
>>> > But, as it turns out, I'm just in the process of returning to my
>>> > testing of next, with all my debugging back to 0.  So, I'll try
>>> > the default timeout of 30 seconds first.  If I have trouble start=
ing
>>> > up a new file system, I'll turn up the timeout and try again, wit=
hout
>>> > any extra debugging.  Either way, I'll let you know what happens.
>> I would be curious to hear roughly what value between 30 and 300 is
>> sufficient, if you can experiment just a bit.  We probably want to a=
djust
>> the default.
>>
>> Perhaps more importantly, we'll need to look at the performance of t=
he pg
>> stat updates on the mon.  There is a refactor due in that code that =
should
>> improve life, but it's slated for dumpling.
>
> OK, here's some results, with all debugging at 0, using current next.=
=2E.
>
> My testing is for 1 mon + 576 OSDs, 24/host. All my storage cluster h=
osts
> use 10 GbE NICs now.  The mon host uses an SSD for the mon data store=
=2E
> My test procedure is to start 'ceph -w', start all the OSDs, and once
> they're all running start the mon.  I report the time from starting
> the mon to all PGs active+clean.
>
> # PGs     osd mon ack    startup    notes
>             timeout       time
> -------  ------------    --------   -----
>  55392      default      >30:00       1
>  55392        300         18:36       2
>  55392         60        >30:00       3
>  55392        150        >30:00       4
>  55392        240        >30:00       5
>  55392        300        >30:00       2,6
>
> notes:
> 1) lots of PGs marked stale, OSDs wrongly marked down
>      before I gave up on this case
> 2) OSDs report lots of slow requests for "pg_notify(...) v4
>      currently wait for new map"
> 3) some OSDs wrongly marked down, OSDs report some slow requests
>      for "pg_notify(...) v4 currently wait for new map"
>      before I gave up on this case
> 4) appeared to be making progress; then an OSD was marked
>      out at ~21 minutes; many more marked out before I
>      gave up on this case
> 5) some OSD reports of slow requests for "pg_notify",
>      some OSDs wrongly marked down, appeared to be making
>      progress, then stalled; then I gave up on this case
> 6) retried this case, appeared to be making progress, but
>      after ~18 min stalled at 19701 active+clean, 35691 peering
>      until I gave up
>
> Hmmm, I didn't really expect the above results.  I ran out of
> time before attempting an even longer osd mon ack timeout.
>
> But either we're on the wrong trail, or 300 is not sufficient.
> Or, I'm doing something wrong and haven't yet figured out what
> it is.
>
> FWIW, on v0.57 or v0.58 I was testing with one pool at 256K PGs,
> and my memory is a new filesystem started up in ~5 minutes.  For
> that testing I had to increase 'paxos propose interval' to two
> or three seconds to keep the monitor writeout rate (as measured
> by vmstat) down to a sustained 50-70 MB/s during start-up.
>
> That was with a 1 GbE NIC in the mon; the reason I upgraded
> it was a filesystem with 512K PGs was taking too long to start,
> and I thought the mon might be network-limited since it had an
> SSD for the mon data store.
>
> For the testing above I used the default 'paxos propose interval'.
> I don't know if it matters, but vmstat sees only a little data
> being written on the mon system.

That's odd; I'd actually expect to see more going to disk with v0.59
than previously. Is vmstat actually looking at disk IO, or might it be
missing DirectIO or something? (Not that I remember if LevelDB is
using those.)
However, I think you might want to increase your paxos propose
interval to where it was before =97 your OSDs are having trouble keepin=
g
up with the number of maps that are being generated, based on the fact
that you have a lot of pg notifies stuck waiting for newer maps.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
