From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling
 under very heavy write load
Date: Fri, 3 Feb 2012 16:33:58 -0700
Message-ID: <4F2C6EE6.4050008@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov>
 <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F2ADEAE.8010403@sandia.gov>
 <CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
 <4F2AF085.6000405@sandia.gov>
 <CAF3hT9AcxxNtscFczP8fShSsaBm_4zhLQZ2F5c7h1YswVaXHkA@mail.gmail.com>
 <4F2C08A7.2050507@sandia.gov> <3032884323297001561@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:60803 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab2BCXea (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 18:34:30 -0500
In-Reply-To: <3032884323297001561@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/03/2012 10:06 AM, Gregory Farnum wrote:
> On Feb 3, 2012, at 8:18 AM, Jim Schutt<jaschut@sandia.gov>  wrote:
>
>> On 02/02/2012 05:28 PM, Gregory Farnum wrote:
>>> On Thu, Feb 2, 2012 at 12:22 PM, Jim Schutt<jaschut@sandia.gov>   wrote:
>>>> I found 0 instances of "waiting for commit" in all my OSD logs for my last
>>>> run.
>>>>
>>>> So I never waited on the journal?
>>>
>>> Looks like it. Interesting.
>>>
>>>
>>>>>> So far I'm looking at two behaviours I've noticed that seem anomalous to
>>>>>> me.
>>>>>>
>>>>>> One is that I instrumented ms_dispatch(), and I see it take
>>>>>> a half-second or more several hundred times, out of several
>>>>>> thousand messages.  Is that expected?
>>>>>
>>>>>
>>>>> How did you instrument it? If you wrapped the whole function it's
>>>>> possible that those longer runs are actually chewing through several
>>>>> messages that had to get waitlisted for some reason previously.
>>>>> (That's the call to do_waiters().)
>>>>
>>>>
>>>> Yep, I wrapped the whole function, and also instrumented taking osd_lock
>>>> while I was there.  About half the time that ms_dispatch() takes more than
>>>> 0.5 seconds, taking osd_lock is responsible for the delay.  There's two
>>>> dispatch threads, one for ops and one for rep_ops, right?  So one's
>>>> waiting on the other?
>>>
>>> There's just one main dispatcher; no split for the ops and rep_ops .
>>> The reason for that "dispatch_running" is that if there are requests
>>> waiting then the tick() function will run through them if the
>>> messenger dispatch thread is currently idle.
>>> But it is possible for the Messenger to try and dispatch, and for that
>>> to be blocked while some amount of (usually trivial) work is being
>>> done by a different thread, yes. I don't think we've ever observed it
>>> being a problem for anything other than updating OSD maps, though...
>>
>> Ah, OK.
>>
>> I guess I was confused by my log output, e.g.:
>
> D'oh. Sorry, you confused me with your reference to repops, which
> aren't special-cased or anything. But there are two messengers on the
> OSD, each with their own dispatch thread. One of those messengers is
> for clients and one is for other OSDs.
>
> And now that you point that out, I wonder if the problem is lack of
> Cond signaling in ms_dispatch. I'm on my phone right now but I believe
> there's a chunk of commented-out code (why commented instead of
> deleted? I don't know) that we want to uncomment for reasons that will
> become clear when you look at it. :)
> Try that and see how many of your problems disappear?
>

So I cherry-picked Sage's commit 7641a0e171f onto the code
I've been running (1fe75ee6419 + some debug stuff), and saw
no obvious difference in behaviour.

I also tested Sage's suggestion of separating journals and
data, by putting two journal partitions on half my disks,
and two data partitions on the other half.  I made the data
partitions relatively small (~200 GiB each on a 1 TiB drive)
to minimize the effect of inner vs. outer tracks.

That didn't seem to help either.

Still looking -- Jim

