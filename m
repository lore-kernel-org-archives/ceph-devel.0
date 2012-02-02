From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling
 under very heavy write load
Date: Thu, 2 Feb 2012 13:31:18 -0700
Message-ID: <4F2AF296.4070808@sandia.gov>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
 <CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
 <4F29CDAA.408@sandia.gov>
 <CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
 <4F2AABF5.6050803@sandia.gov>
 <CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
 <4F2ADEAE.8010403@sandia.gov>
 <CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
 <4F2AF085.6000405@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:46809 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab2BBUcJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 15:32:09 -0500
In-Reply-To: <4F2AF085.6000405@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 02/02/2012 01:22 PM, Jim Schutt wrote:
> On 02/02/2012 12:32 PM, Gregory Farnum wrote:
>> On Thu, Feb 2, 2012 at 11:06 AM, Jim Schutt<jaschut@sandia.gov> wrot=
e:
>>> On 02/02/2012 10:52 AM, Gregory Farnum wrote:
>>>>
>>>> On Thu, Feb 2, 2012 at 7:29 AM, Jim Schutt<jaschut@sandia.gov> wro=
te:
>>>>> The typical pattern I see is that a run starts with tens of secon=
ds
>>>>> of aggregate throughput> 2 GB/s. Then it drops and bounces around
>>>>> 500 - 1000 MB/s, with occasional excursions under 100 MB/s. Then
>>>>> it ramps back up near 2 GB/s again.
>>>>
>>>>
>>>> Hmm. 100MB/s is awfully low for this theory, but have you tried to
>>>> correlate the drops in throughput with the OSD journals running ou=
t of
>>>> space?
>>>
>>>
>>> A spot check of logs from my last run doesn't seem to have any
>>> "journal throttle: waited for" messages during a slowdown.
>>> Is that what you mean?
>>
>> I'd expect to see those, yes, but I actually meant the on-disk journ=
al
>> itself getting full. I believe that should result in output like:
>> write_thread_entry full, going to sleep (waiting for commit)
>> ...although I now notice that's a much higher log level (20) than th=
e
>> other messages (1/5).
>
> So I've been running OSDs with
> debug osd =3D 20
> debug journal =3D 20 ; local journaling
> debug filestore =3D 20 ; local object storage
> debug objector =3D 20
> debug ms =3D 20
> debug =3D 1
>
> I found 0 instances of "waiting for commit" in all my OSD logs for my=
 last run.
>
> So I never waited on the journal?
>
>>
>>> During the fast part of I run I see lots of journal messages
>>> with this pattern:
>>>
>>> 2012-02-02 09:16:18.376996 7fe602e67700 journal put_throttle finish=
ed 12 ops
>>> and 50346596 bytes, now 22 ops and 90041106 bytes
>>> 2012-02-02 09:16:18.417507 7fe5eb436700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.417656 7fe5e742e700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.417756 7fe5f2444700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.422157 7fe5ea434700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.422186 7fe5e9c33700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.424195 7fe5e642c700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.427106 7fe5fb456700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.427139 7fe5f7c4f700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.427159 7fe5e5c2b700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.427176 7fe5ee43c700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:18.428299 7fe5f744e700 journal throttle: waited fo=
r bytes
>>> 2012-02-02 09:16:19.297369 7fe602e67700 journal put_throttle finish=
ed 12 ops
>>> and 50346596 bytes, now 21 ops and 85845571 bytes
>>>
>>> which I think means my journal is doing 50 MB/s, right?
>>
>> Generally, yes =E2=80=94 although that'll also pop up if the store m=
anages to
>> commit faster than the journal (unlikely). :)
>>
>>>> and your description makes me
>>>> think that throughput is initially constrained by sequential journ=
al
>>>> writes but then the journal runs out of space and the OSD has to w=
ait
>>>> for the main store to catch up (with random IO), and that sends th=
e IO
>>>> patterns all to hell. (If you can say that random 4MB IOs are
>>>> hellish.)
>>>
>>>
>>> iostat 1 during the fast part of a run shows both journal and data
>>> partitions running at 45-50 MB/s. During the slow part of a run
>>> they both show similar but low data rates.
>>
>> All right. That's actually not that surprising; random 4MB writes ar=
e
>> pretty nice to a modern drive.
>>
>>>> I'm also curious about memory usage as a possible explanation for =
the
>>>> more dramatic drops.
>>>
>>> My OSD servers have 48 GB memory. During a run I rarely see less th=
an
>>> 24 GB used by the page cache, with the rest mostly used by anonymou=
s memory.
>>> I don't run with any swap.
>>>
>>> So far I'm looking at two behaviours I've noticed that seem anomalo=
us to me.
>>>
>>> One is that I instrumented ms_dispatch(), and I see it take
>>> a half-second or more several hundred times, out of several
>>> thousand messages. Is that expected?
>>
>> How did you instrument it? If you wrapped the whole function it's
>> possible that those longer runs are actually chewing through several
>> messages that had to get waitlisted for some reason previously.
>> (That's the call to do_waiters().)
>
> Yep, I wrapped the whole function, and also instrumented taking osd_l=
ock
> while I was there. About half the time that ms_dispatch() takes more =
than
> 0.5 seconds, taking osd_lock is responsible for the delay. There's tw=
o
> dispatch threads, one for ops and one for rep_ops, right? So one's
> waiting on the other?
>
>>
>>> Another is that once a message receive starts, I see ~50 messages
>>> that take tens of seconds to receive, when the nominal receive time=
 is
>>> a half-second or less. I'm in the process of tooling up to collect
>>> tcpdump data on all my clients to try to catch what is going on wit=
h that.
>>
>> Again, how are you instrumenting that?
>
> I post-process the logs, looking at the time difference between
> "reader got .* policy throttler" and "reader got .* osd_op(client".
>
> When I find a candidate message, I grep the log for just that reader =
thread,
> and see, e.g., this:
>
> osd.0.log:1280693:2012-02-02 09:17:57.704508 7fe5c9099700 -- 172.17.1=
31.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader got 2670720 from policy throttler 4880951=
0/50000000 seq 828/828 waiters 157/149 for src client.4301 tid=3D247
> osd.0.log:1280694:2012-02-02 09:17:57.704525 7fe5c9099700 -- 172.17.1=
31.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader wants 2670720 from dispatch throttler 419=
44358/66666666
> osd.0.log:1280701:2012-02-02 09:17:57.704654 7fe5c9099700 -- 172.17.1=
31.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader got front 128
> osd.0.log:1280705:2012-02-02 09:17:57.704752 7fe5c9099700 -- 172.17.1=
31.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader allocating new rx buffer at offset 0
> osd.0.log:1280710:2012-02-02 09:17:57.704873 7fe5c9099700 -- 172.17.1=
31.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11922000 len 2=
670592
> osd.0.log:1559767:2012-02-02 09:19:40.726589 7fe5c9099700 -- 172.17.1=
31.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11a6a5cc len 1=
325620
> osd.0.log:1561092:2012-02-02 09:19:40.927559 7fe5c9099700 -- 172.17.1=
31.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=3D215 =
pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11a6ab74 len 1=
324172
>
> Note the ~2 minute delay (and ~300,000 lines of logging) between the =
first and second reads.
>
> During that time 129 sockets were processed - what makes sd=3D215 spe=
cial?
>
> I've added tracepoints in my client kernel try_write(), and nothing s=
eems
> unusual (that's with running the patch to ceph_write_space() I posted=
 earlier):
>
[snip wrong trace output]

      kworker/0:2-1790  [000]  1569.078614: ceph_try_write_msg_done: pe=
er osd0 tid 207 seq 4 sent 4194304
      kworker/0:2-1790  [000]  1569.078618: ceph_prepare_write_msg: pee=
r osd0 tid 247 seq 5 sent 0
      kworker/0:2-1790  [000]  1569.078621: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 0
      kworker/0:2-1790  [000]  1569.281943: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 102588
      kworker/0:2-1790  [000]  1569.299540: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 230012
      kworker/0:2-1790  [000]  1569.303088: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 357436
      kworker/0:2-1790  [000]  1569.305580: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 453004
      kworker/0:2-1790  [000]  1569.308217: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 580428
      kworker/0:2-1790  [000]  1569.310914: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 707852
      kworker/0:2-1790  [000]  1569.313742: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 835276
      kworker/0:2-1790  [000]  1569.316653: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 962700
      kworker/0:2-1790  [000]  1569.319203: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1090124
      kworker/0:2-1790  [000]  1569.323786: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1217548
      kworker/0:2-1790  [000]  1569.325982: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1344972
      kworker/0:2-1790  [000]  1569.328577: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1472396
      kworker/0:2-1790  [000]  1573.844837: ceph_handle_reply_msg: peer=
 osd0 tid 179 result 0 flags 0x00000025 (req ffff88018aa2c400)
      kworker/0:2-1790  [000]  1573.845487: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1599820
     flush-ceph-1-11910 [000]  1576.891480: ceph_async_writepages_req: =
tid 377 osd0 ops 1 0x2201/0x0000/0x0000 pages 1024
      kworker/0:2-1790  [000]  1602.214574: ceph_handle_reply_msg: peer=
 osd0 tid 207 result 0 flags 0x00000025 (req ffff88018aa7d400)
      kworker/0:2-1790  [000]  1602.215230: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1663532
     flush-ceph-1-11910 [000]  1636.926835: ceph_async_writepages_req: =
tid 410 osd0 ops 1 0x2201/0x0000/0x0000 pages 1024
      kworker/0:2-1790  [000]  1775.409415: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1663532
      kworker/0:2-1790  [000]  1775.411643: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1790956
      kworker/0:2-1790  [000]  1775.414125: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 1918380
      kworker/0:2-1790  [000]  1775.416520: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 2045804
      kworker/0:2-1790  [000]  1775.419163: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 2173228
      kworker/0:2-1790  [000]  1775.421620: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 2300652
      kworker/0:2-1790  [000]  1775.423868: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 2428076
      kworker/0:2-1790  [000]  1775.426260: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 2555500
      kworker/0:2-1790  [000]  1775.426297: ceph_try_write_msg: peer os=
d0 tid 247 seq 5 sent 2670592
      kworker/0:2-1790  [000]  1775.426298: ceph_try_write_msg_done: pe=
er osd0 tid 247 seq 5 sent 2670592

There's a 170 second gap at 1602.215230 - why?

-- Jim

>
> Hence, tcpdump seems like a good idea?
>
> -- Jim
>
>>
>> -Greg
>>
>>
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
