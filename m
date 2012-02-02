From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/6] Understanding delays due to
 throttling under very heavy write load
Date: Thu, 2 Feb 2012 13:22:29 -0700
Message-ID: <4F2AF085.6000405@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov>
 <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F2ADEAE.8010403@sandia.gov>
 <CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:56249 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab2BBUXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 15:23:01 -0500
In-Reply-To: <CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 02/02/2012 12:32 PM, Gregory Farnum wrote:
> On Thu, Feb 2, 2012 at 11:06 AM, Jim Schutt<jaschut@sandia.gov>  wrot=
e:
>> On 02/02/2012 10:52 AM, Gregory Farnum wrote:
>>>
>>> On Thu, Feb 2, 2012 at 7:29 AM, Jim Schutt<jaschut@sandia.gov>    w=
rote:
>>>> The typical pattern I see is that a run starts with tens of second=
s
>>>> of aggregate throughput>    2 GB/s.  Then it drops and bounces aro=
und
>>>> 500 - 1000 MB/s, with occasional excursions under 100 MB/s.  Then
>>>> it ramps back up near 2 GB/s again.
>>>
>>>
>>> Hmm. 100MB/s is awfully low for this theory, but have you tried to
>>> correlate the drops in throughput with the OSD journals running out=
 of
>>> space?
>>
>>
>> A spot check of logs from my last run doesn't seem to have any
>> "journal throttle: waited for" messages during a slowdown.
>> Is that what you mean?
>
> I'd expect to see those, yes, but I actually meant the on-disk journa=
l
> itself getting full. I believe that should result in output like:
>      write_thread_entry full, going to sleep (waiting for commit)
> ...although I now notice that's a much higher log level (20) than the
> other messages (1/5).

So I've been running OSDs with
	debug osd =3D 20
	debug journal =3D 20   ; local journaling
	debug filestore =3D 20 ; local object storage
	debug objector =3D 20
	debug ms =3D 20
	debug =3D 1

I found 0 instances of "waiting for commit" in all my OSD logs for my l=
ast run.

So I never waited on the journal?

>
>> During the fast part of I run I see lots of journal messages
>> with this pattern:
>>
>> 2012-02-02 09:16:18.376996 7fe602e67700 journal put_throttle finishe=
d 12 ops
>> and 50346596 bytes, now 22 ops and 90041106 bytes
>> 2012-02-02 09:16:18.417507 7fe5eb436700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.417656 7fe5e742e700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.417756 7fe5f2444700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.422157 7fe5ea434700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.422186 7fe5e9c33700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.424195 7fe5e642c700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.427106 7fe5fb456700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.427139 7fe5f7c4f700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.427159 7fe5e5c2b700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.427176 7fe5ee43c700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:18.428299 7fe5f744e700 journal throttle: waited for=
 bytes
>> 2012-02-02 09:16:19.297369 7fe602e67700 journal put_throttle finishe=
d 12 ops
>> and 50346596 bytes, now 21 ops and 85845571 bytes
>>
>> which I think means my journal is doing 50 MB/s, right?
>
> Generally, yes =E2=80=94 although that'll also pop up if the store ma=
nages to
> commit faster than the journal (unlikely). :)
>
>>> and your description makes me
>>> think that throughput is initially constrained by sequential journa=
l
>>> writes but then the journal runs out of space and the OSD has to wa=
it
>>> for the main store to catch up (with random IO), and that sends the=
 IO
>>> patterns all to hell. (If you can say that random 4MB IOs are
>>> hellish.)
>>
>>
>> iostat 1 during the fast part of a run shows both journal and data
>> partitions running at 45-50 MB/s.  During the slow part of a run
>> they both show similar but low data rates.
>
> All right. That's actually not that surprising; random 4MB writes are
> pretty nice to a modern drive.
>
>>> I'm also curious about memory usage as a possible explanation for t=
he
>>> more dramatic drops.
>>
>> My OSD servers have 48 GB memory.  During a run I rarely see less th=
an
>> 24 GB used by the page cache, with the rest mostly used by anonymous=
 memory.
>> I don't run with any swap.
>>
>> So far I'm looking at two behaviours I've noticed that seem anomalou=
s to me.
>>
>> One is that I instrumented ms_dispatch(), and I see it take
>> a half-second or more several hundred times, out of several
>> thousand messages.  Is that expected?
>
> How did you instrument it? If you wrapped the whole function it's
> possible that those longer runs are actually chewing through several
> messages that had to get waitlisted for some reason previously.
> (That's the call to do_waiters().)

Yep, I wrapped the whole function, and also instrumented taking osd_loc=
k
while I was there.  About half the time that ms_dispatch() takes more t=
han
0.5 seconds, taking osd_lock is responsible for the delay.  There's two
dispatch threads, one for ops and one for rep_ops, right?  So one's
waiting on the other?

>
>> Another is that once a message receive starts, I see ~50 messages
>> that take tens of seconds to receive, when the nominal receive time =
is
>> a half-second or less.  I'm in the process of tooling up to collect
>> tcpdump data on all my clients to try to catch what is going on with=
 that.
>
> Again, how are you instrumenting that?

I post-process the logs, looking at the time difference between
"reader got .* policy throttler" and "reader got .* osd_op(client".

When I find a candidate message, I grep the log for just that reader th=
read,
and see, e.g., this:

osd.0.log:1280693:2012-02-02 09:17:57.704508 7fe5c9099700 -- 172.17.131=
=2E32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader got 2670720 from policy throttler 4880951=
0/50000000 seq 828/828 waiters 157/149 for src client.4301 tid=3D247
osd.0.log:1280694:2012-02-02 09:17:57.704525 7fe5c9099700 -- 172.17.131=
=2E32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader wants 2670720 from dispatch throttler 419=
44358/66666666
osd.0.log:1280701:2012-02-02 09:17:57.704654 7fe5c9099700 -- 172.17.131=
=2E32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader got front 128
osd.0.log:1280705:2012-02-02 09:17:57.704752 7fe5c9099700 -- 172.17.131=
=2E32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader allocating new rx buffer at offset 0
osd.0.log:1280710:2012-02-02 09:17:57.704873 7fe5c9099700 -- 172.17.131=
=2E32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11922000 len 2=
670592
osd.0.log:1559767:2012-02-02 09:19:40.726589 7fe5c9099700 -- 172.17.131=
=2E32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11a6a5cc len 1=
325620
osd.0.log:1561092:2012-02-02 09:19:40.927559 7fe5c9099700 -- 172.17.131=
=2E32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11a6ab74 len 1=
324172

Note the ~2 minute delay (and ~300,000 lines of logging) between the fi=
rst and second reads.

During that time 129 sockets were processed - what makes sd=3D215 speci=
al?

I've added tracepoints in my client kernel try_write(), and nothing see=
ms
unusual (that's with running the patch to ceph_write_space() I posted e=
arlier):

      kworker/0:2-1790  [000]  1543.200887: ceph_try_write_msg_done: pe=
er osd0 tid 179 seq 3 sent 4194304
      kworker/0:2-1790  [000]  1543.200901: ceph_prepare_write_msg: pee=
r osd0 tid 207 seq 4 sent 0
      kworker/0:2-1790  [000]  1543.200904: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 0
      kworker/0:2-1790  [000]  1543.203475: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 123951
      kworker/0:2-1790  [000]  1543.206069: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 251375
      kworker/0:2-1790  [000]  1543.208505: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 378799
      kworker/0:2-1790  [000]  1543.210898: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 506223
      kworker/0:2-1790  [000]  1543.213354: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 633647
      kworker/0:2-1790  [000]  1543.215095: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 761071
      kworker/0:2-1790  [000]  1543.217636: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 856639
      kworker/0:2-1790  [000]  1543.221925: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 984063
      kworker/0:2-1790  [000]  1543.225468: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 1111487
      kworker/0:2-1790  [000]  1543.228113: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 1238911
      kworker/0:2-1790  [000]  1543.231166: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 1366335
      kworker/0:2-1790  [000]  1543.236256: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 1493759
      kworker/0:2-1790  [000]  1569.020329: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 1621183
      kworker/0:2-1790  [000]  1569.022522: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 1748607
      kworker/0:2-1790  [000]  1569.024716: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 1876031
      kworker/0:2-1790  [000]  1569.027872: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2003455
      kworker/0:2-1790  [000]  1569.030603: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2130879
      kworker/0:2-1790  [000]  1569.034906: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2258303
      kworker/0:2-1790  [000]  1569.037398: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2385727
      kworker/0:2-1790  [000]  1569.040094: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2513151
      kworker/0:2-1790  [000]  1569.042541: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2640575
      kworker/0:2-1790  [000]  1569.045323: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2767999
      kworker/0:2-1790  [000]  1569.048565: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 2895423
      kworker/0:2-1790  [000]  1569.051410: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3022847
      kworker/0:2-1790  [000]  1569.053606: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3150271
      kworker/0:2-1790  [000]  1569.055802: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3277695
      kworker/0:2-1790  [000]  1569.058857: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3405119
      kworker/0:2-1790  [000]  1569.061298: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3532543
      kworker/0:2-1790  [000]  1569.063692: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3659967
      kworker/0:2-1790  [000]  1569.069931: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3787391
      kworker/0:2-1790  [000]  1569.072926: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 3914815
      kworker/0:2-1790  [000]  1569.075909: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 4042239
      kworker/0:2-1790  [000]  1569.078603: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 4169663
      kworker/0:2-1790  [000]  1569.078613: ceph_try_write_msg: peer os=
d0 tid 207 seq 4 sent 4194304
      kworker/0:2-1790  [000]  1569.078614: ceph_try_write_msg_done: pe=
er osd0 tid 207 seq 4 sent 4194304

There's a 25 second gap at 1543.236256, but nothing like the
100 second gap in the reader.

Hence, tcpdump seems like a good idea?

-- Jim

>
> -Greg
>
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
