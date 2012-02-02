From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/6] Understanding delays due to
 throttling under very heavy write load
Date: Thu, 2 Feb 2012 12:33:49 -0700
Message-ID: <4F2AE51D.6060709@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov>
 <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F2ADEAE.8010403@sandia.gov>
 <Pine.LNX.4.64.1202021110180.14452@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:36200 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138Ab2BBTeW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 14:34:22 -0500
In-Reply-To: <Pine.LNX.4.64.1202021110180.14452@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

On 02/02/2012 12:15 PM, Sage Weil wrote:
> On Thu, 2 Feb 2012, Jim Schutt wrote:
>> On 02/02/2012 10:52 AM, Gregory Farnum wrote:
>>> On Thu, Feb 2, 2012 at 7:29 AM, Jim Schutt<jaschut@sandia.gov>   wrote:
>>>> I'm currently running 24 OSDs/server, one 1TB 7200 RPM SAS drive
>>>> per OSD.  During a test I watch both OSD servers with both
>>>> vmstat and iostat.
>>>>
>>>> During a "good" period, vmstat says the server is sustaining>   2 GB/s
>>>> for multiple tens of seconds.  Since I use replication factor 2, that
>>>> means that server is sustaining>   500 MB/s aggregate client throughput,
>>>> right?  During such a period vmstat also reports ~10% CPU idle.
>>>>
>>>> During a "bad" period, vmstat says the server is doing ~200 MB/s,
>>>> with lots of idle cycles.  It is during these periods that
>>>> messages stuck in the policy throttler build up such long
>>>> wait times.  Sometimes I see really bad periods with aggregate
>>>> throughput per server<   100 MB/s.
>>>>
>>>> The typical pattern I see is that a run starts with tens of seconds
>>>> of aggregate throughput>   2 GB/s.  Then it drops and bounces around
>>>> 500 - 1000 MB/s, with occasional excursions under 100 MB/s.  Then
>>>> it ramps back up near 2 GB/s again.
>>>
>>> Hmm. 100MB/s is awfully low for this theory, but have you tried to
>>> correlate the drops in throughput with the OSD journals running out of
>>> space?
>>
>> A spot check of logs from my last run doesn't seem to have any
>> "journal throttle: waited for" messages during a slowdown.
>> Is that what you mean?
>>
>> During the fast part of I run I see lots of journal messages
>> with this pattern:
>>
>> 2012-02-02 09:16:18.376996 7fe602e67700 journal put_throttle finished 12 ops
>> and 50346596 bytes, now 22 ops and 90041106 bytes
>> 2012-02-02 09:16:18.417507 7fe5eb436700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.417656 7fe5e742e700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.417756 7fe5f2444700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.422157 7fe5ea434700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.422186 7fe5e9c33700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.424195 7fe5e642c700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.427106 7fe5fb456700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.427139 7fe5f7c4f700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.427159 7fe5e5c2b700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.427176 7fe5ee43c700 journal throttle: waited for bytes
>> 2012-02-02 09:16:18.428299 7fe5f744e700 journal throttle: waited for bytes
>> 2012-02-02 09:16:19.297369 7fe602e67700 journal put_throttle finished 12 ops
>> and 50346596 bytes, now 21 ops and 85845571 bytes
>
> It occurs to me that part of the problem may be the current sync
> io behavior in the journal.  It ends up doing really big writes, which
> makes things bursty, and will get stuff blocked up behind the throttler.
> You might try making 'journal max write bytes' smaller?  Hmm, although
> it's currently 10MB, which isn't too bad.  So unless you've changed it
> from the default, that's probably not it.

I have changed it recently, but I was seeing this type of
behaviour before making that change.

FWIW, here's my current non-standard tunings.  I'm using
these because the standard ones work even worse for me
on this test case:

	osd op threads = 48
	filestore queue max ops = 16
	osd client message size cap = 50000000
	client oc max dirty =         50000000
	journal max write bytes =     50000000
	ms dispatch throttle bytes =  66666666
	client oc size =              100000000
	journal queue max bytes =     125000000
	filestore queue max bytes =   125000000
	objector inflight op bytes =  200000000


FWIW, turning down "filestore queue max ops" and turning up "osd op threads"
made the biggest positive impact on my performance levels on this test.

With default values for those I was seeing much worse stalling behaviour.

>
>> which I think means my journal is doing 50 MB/s, right?
>>
>>> I assume from your setup that they're sharing the disk with the
>>> store (although it works either way),
>>
>> I've got a 4 GB journal partition on the outer tracks of the disk.
>
> This is on the same disk as the osd data?  As an experiement, you could
> try putting the journal on a separate disk (half disks for journals, half
> for data).  That's obviously not what you want in the real world, but it
> would be interesting to see if contention for the spindle is responsible
> for this.
>
>> So far I'm looking at two behaviours I've noticed that seem anomalous to me.
>>
>> One is that I instrumented ms_dispatch(), and I see it take
>> a half-second or more several hundred times, out of several
>> thousand messages.  Is that expected?
>
> I don't think so, but it could happen if the cpu/memory contention, or in
> the case of osdmap updates where we block on io in that thread.

Hmmm.  Would those go into the filestore op queue?

I didn't think to check ms_dispatch() ET until after I had tuned
down "filestore queue max ops".  Is it worth checking this?

>
>> Another is that once a message receive starts, I see ~50 messages
>> that take tens of seconds to receive, when the nominal receive time is
>> a half-second or less.  I'm in the process of tooling up to collect
>> tcpdump data on all my clients to try to catch what is going on with that.
>>
>> Any other ideas on what to look for would be greatly appreciated.
>
> I'd rule out the journal+data on same disk as the source of pain first.
> If that's what's going on, we can take a closer look at speficically how
> to make it behave better!

OK, I'll try that next.

Thanks -- Jim

>
> sage
>
>


