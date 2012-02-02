From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/6] Understanding delays due to
 throttling under very heavy write load
Date: Thu, 2 Feb 2012 12:06:22 -0700
Message-ID: <4F2ADEAE.8010403@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov>
 <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:46055 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932604Ab2BBTGt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 14:06:49 -0500
In-Reply-To: <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 02/02/2012 10:52 AM, Gregory Farnum wrote:
> On Thu, Feb 2, 2012 at 7:29 AM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> I'm currently running 24 OSDs/server, one 1TB 7200 RPM SAS drive
>> per OSD.  During a test I watch both OSD servers with both
>> vmstat and iostat.
>>
>> During a "good" period, vmstat says the server is sustaining>  2 GB/s
>> for multiple tens of seconds.  Since I use replication factor 2, that
>> means that server is sustaining>  500 MB/s aggregate client throughput,
>> right?  During such a period vmstat also reports ~10% CPU idle.
>>
>> During a "bad" period, vmstat says the server is doing ~200 MB/s,
>> with lots of idle cycles.  It is during these periods that
>> messages stuck in the policy throttler build up such long
>> wait times.  Sometimes I see really bad periods with aggregate
>> throughput per server<  100 MB/s.
>>
>> The typical pattern I see is that a run starts with tens of seconds
>> of aggregate throughput>  2 GB/s.  Then it drops and bounces around
>> 500 - 1000 MB/s, with occasional excursions under 100 MB/s.  Then
>> it ramps back up near 2 GB/s again.
>
> Hmm. 100MB/s is awfully low for this theory, but have you tried to
> correlate the drops in throughput with the OSD journals running out of
> space?

A spot check of logs from my last run doesn't seem to have any
"journal throttle: waited for" messages during a slowdown.
Is that what you mean?

During the fast part of I run I see lots of journal messages
with this pattern:

2012-02-02 09:16:18.376996 7fe602e67700 journal put_throttle finished 12 ops and 50346596 bytes, now 22 ops and 90041106 bytes
2012-02-02 09:16:18.417507 7fe5eb436700 journal throttle: waited for bytes
2012-02-02 09:16:18.417656 7fe5e742e700 journal throttle: waited for bytes
2012-02-02 09:16:18.417756 7fe5f2444700 journal throttle: waited for bytes
2012-02-02 09:16:18.422157 7fe5ea434700 journal throttle: waited for bytes
2012-02-02 09:16:18.422186 7fe5e9c33700 journal throttle: waited for bytes
2012-02-02 09:16:18.424195 7fe5e642c700 journal throttle: waited for bytes
2012-02-02 09:16:18.427106 7fe5fb456700 journal throttle: waited for bytes
2012-02-02 09:16:18.427139 7fe5f7c4f700 journal throttle: waited for bytes
2012-02-02 09:16:18.427159 7fe5e5c2b700 journal throttle: waited for bytes
2012-02-02 09:16:18.427176 7fe5ee43c700 journal throttle: waited for bytes
2012-02-02 09:16:18.428299 7fe5f744e700 journal throttle: waited for bytes
2012-02-02 09:16:19.297369 7fe602e67700 journal put_throttle finished 12 ops and 50346596 bytes, now 21 ops and 85845571 bytes

which I think means my journal is doing 50 MB/s, right?

> I assume from your setup that they're sharing the disk with the
> store (although it works either way),

I've got a 4 GB journal partition on the outer tracks of the disk.

> and your description makes me
> think that throughput is initially constrained by sequential journal
> writes but then the journal runs out of space and the OSD has to wait
> for the main store to catch up (with random IO), and that sends the IO
> patterns all to hell. (If you can say that random 4MB IOs are
> hellish.)

iostat 1 during the fast part of a run shows both journal and data
partitions running at 45-50 MB/s.  During the slow part of a run
they both show similar but low data rates.

> I'm also curious about memory usage as a possible explanation for the
> more dramatic drops.

My OSD servers have 48 GB memory.  During a run I rarely see less than
24 GB used by the page cache, with the rest mostly used by anonymous memory.
I don't run with any swap.

So far I'm looking at two behaviours I've noticed that seem anomalous to me.

One is that I instrumented ms_dispatch(), and I see it take
a half-second or more several hundred times, out of several
thousand messages.  Is that expected?

Another is that once a message receive starts, I see ~50 messages
that take tens of seconds to receive, when the nominal receive time is
a half-second or less.  I'm in the process of tooling up to collect
tcpdump data on all my clients to try to catch what is going on with that.

Any other ideas on what to look for would be greatly appreciated.

-- Jim

> -Greg
>
>


