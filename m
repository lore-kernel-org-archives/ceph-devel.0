From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Trouble getting a new file system to start, for v0.59 and
 newer
Date: Thu, 4 Apr 2013 13:14:20 -0600
Message-ID: <515DD10C.2030602@sandia.gov>
References: <515C4EC4.5040602@sandia.gov>
 <alpine.DEB.2.00.1304030857480.12367@cobra.newdream.net>
 <515C6232.4070204@sandia.gov>
 <CAPYLRzgT47iTKuv-YCQWfU_4O=prrkEByp9KAftj2jFMktve5Q@mail.gmail.com>
 <CAPYLRzhzQp3xsf_QzzYYJo9RAj_sBV1THs2PJUhk1QRe9XB42w@mail.gmail.com>
 <515C6DD1.2050702@sandia.gov>
 <alpine.DEB.2.00.1304031123540.15431@cobra.newdream.net>
 <515CAFED.60705@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:54964 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764514Ab3DDTOn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Apr 2013 15:14:43 -0400
In-Reply-To: <515CAFED.60705@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/03/2013 04:40 PM, Jim Schutt wrote:
> On 04/03/2013 12:25 PM, Sage Weil wrote:
>>>>>> >>> > > Sorry, guess I forgot some of the history since this piece at least is
>>>>>> >>> > > resolved now. I'm surprised if 30-second timeouts are causing issues
>>>>>> >>> > > without those overloads you were seeing; have you seen this issue
>>>>>> >>> > > without your high debugging levels and without the bad PG commits (due
>>>>>> >>> > > to debugging)?
>>>> >> > 
>>>> >> > I think so, because that's why I started with higher debugging
>>>> >> > levels.
>>>> >> > 
>>>> >> > But, as it turns out, I'm just in the process of returning to my
>>>> >> > testing of next, with all my debugging back to 0.  So, I'll try
>>>> >> > the default timeout of 30 seconds first.  If I have trouble starting
>>>> >> > up a new file system, I'll turn up the timeout and try again, without
>>>> >> > any extra debugging.  Either way, I'll let you know what happens.
>> > I would be curious to hear roughly what value between 30 and 300 is 
>> > sufficient, if you can experiment just a bit.  We probably want to adjust 
>> > the default.
>> > 
>> > Perhaps more importantly, we'll need to look at the performance of the pg 
>> > stat updates on the mon.  There is a refactor due in that code that should 
>> > improve life, but it's slated for dumpling.
> OK, here's some results, with all debugging at 0, using current next...
> 
> My testing is for 1 mon + 576 OSDs, 24/host. All my storage cluster hosts
> use 10 GbE NICs now.  The mon host uses an SSD for the mon data store.
> My test procedure is to start 'ceph -w', start all the OSDs, and once
> they're all running start the mon.  I report the time from starting
> the mon to all PGs active+clean.

As a sanity check, to be sure I wasn't doing something differently
now than I remember doing before, I re-ran this test for v0.57,
v0.58, and v0.59, using default 'osd mon ack timeout', default
'paxos propose interval', and no debugging:

        55,392 PGs   221,568 PGs
v0.57    1m 07s        9m 42s
v0.58    1m 04s       11m 44s
v0.59     >30m      not attempted

The v0.57/v0.58 runs showed no signs of stress, e.g. no
slow op reports, etc.

The v0.59 run behaved as I previously reported, i.e.,
lots of stale peers, OSDs wrongly marked down, etc.,
before I gave up on it.

-- Jim


