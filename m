From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/6] Understanding delays due to
 throttling under very heavy write load
Date: Thu, 2 Feb 2012 11:32:04 -0800
Message-ID: <CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
	<CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
	<4F29CDAA.408@sandia.gov>
	<CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
	<4F2AABF5.6050803@sandia.gov>
	<CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
	<4F2ADEAE.8010403@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54383 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007Ab2BBTcF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 14:32:05 -0500
Received: by iacb35 with SMTP id b35so3539097iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 11:32:04 -0800 (PST)
In-Reply-To: <4F2ADEAE.8010403@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 2, 2012 at 11:06 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> On 02/02/2012 10:52 AM, Gregory Farnum wrote:
>>
>> On Thu, Feb 2, 2012 at 7:29 AM, Jim Schutt<jaschut@sandia.gov> =A0wr=
ote:
>>> The typical pattern I see is that a run starts with tens of seconds
>>> of aggregate throughput> =A02 GB/s. =A0Then it drops and bounces ar=
ound
>>> 500 - 1000 MB/s, with occasional excursions under 100 MB/s. =A0Then
>>> it ramps back up near 2 GB/s again.
>>
>>
>> Hmm. 100MB/s is awfully low for this theory, but have you tried to
>> correlate the drops in throughput with the OSD journals running out =
of
>> space?
>
>
> A spot check of logs from my last run doesn't seem to have any
> "journal throttle: waited for" messages during a slowdown.
> Is that what you mean?

I'd expect to see those, yes, but I actually meant the on-disk journal
itself getting full. I believe that should result in output like:
    write_thread_entry full, going to sleep (waiting for commit)
=2E..although I now notice that's a much higher log level (20) than the
other messages (1/5).

> During the fast part of I run I see lots of journal messages
> with this pattern:
>
> 2012-02-02 09:16:18.376996 7fe602e67700 journal put_throttle finished=
 12 ops
> and 50346596 bytes, now 22 ops and 90041106 bytes
> 2012-02-02 09:16:18.417507 7fe5eb436700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.417656 7fe5e742e700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.417756 7fe5f2444700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.422157 7fe5ea434700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.422186 7fe5e9c33700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.424195 7fe5e642c700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.427106 7fe5fb456700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.427139 7fe5f7c4f700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.427159 7fe5e5c2b700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.427176 7fe5ee43c700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:18.428299 7fe5f744e700 journal throttle: waited for =
bytes
> 2012-02-02 09:16:19.297369 7fe602e67700 journal put_throttle finished=
 12 ops
> and 50346596 bytes, now 21 ops and 85845571 bytes
>
> which I think means my journal is doing 50 MB/s, right?

Generally, yes =97=A0although that'll also pop up if the store manages =
to
commit faster than the journal (unlikely). :)

>> and your description makes me
>> think that throughput is initially constrained by sequential journal
>> writes but then the journal runs out of space and the OSD has to wai=
t
>> for the main store to catch up (with random IO), and that sends the =
IO
>> patterns all to hell. (If you can say that random 4MB IOs are
>> hellish.)
>
>
> iostat 1 during the fast part of a run shows both journal and data
> partitions running at 45-50 MB/s. =A0During the slow part of a run
> they both show similar but low data rates.

All right. That's actually not that surprising; random 4MB writes are
pretty nice to a modern drive.

>> I'm also curious about memory usage as a possible explanation for th=
e
>> more dramatic drops.
>
> My OSD servers have 48 GB memory. =A0During a run I rarely see less t=
han
> 24 GB used by the page cache, with the rest mostly used by anonymous =
memory.
> I don't run with any swap.
>
> So far I'm looking at two behaviours I've noticed that seem anomalous=
 to me.
>
> One is that I instrumented ms_dispatch(), and I see it take
> a half-second or more several hundred times, out of several
> thousand messages. =A0Is that expected?

How did you instrument it? If you wrapped the whole function it's
possible that those longer runs are actually chewing through several
messages that had to get waitlisted for some reason previously.
(That's the call to do_waiters().)

> Another is that once a message receive starts, I see ~50 messages
> that take tens of seconds to receive, when the nominal receive time i=
s
> a half-second or less. =A0I'm in the process of tooling up to collect
> tcpdump data on all my clients to try to catch what is going on with =
that.

Again, how are you instrumenting that?

-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
