From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 0/6] Understanding delays due to
 throttling under very heavy write load
Date: Thu, 2 Feb 2012 16:28:36 -0800
Message-ID: <CAF3hT9AcxxNtscFczP8fShSsaBm_4zhLQZ2F5c7h1YswVaXHkA@mail.gmail.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33000 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab2BCA2h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 19:28:37 -0500
Received: by iacb35 with SMTP id b35so3873526iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 16:28:36 -0800 (PST)
In-Reply-To: <4F2AF085.6000405@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 2, 2012 at 12:22 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> I found 0 instances of "waiting for commit" in all my OSD logs for my=
 last
> run.
>
> So I never waited on the journal?

Looks like it. Interesting.


>>> So far I'm looking at two behaviours I've noticed that seem anomalo=
us to
>>> me.
>>>
>>> One is that I instrumented ms_dispatch(), and I see it take
>>> a half-second or more several hundred times, out of several
>>> thousand messages. =A0Is that expected?
>>
>>
>> How did you instrument it? If you wrapped the whole function it's
>> possible that those longer runs are actually chewing through several
>> messages that had to get waitlisted for some reason previously.
>> (That's the call to do_waiters().)
>
>
> Yep, I wrapped the whole function, and also instrumented taking osd_l=
ock
> while I was there. =A0About half the time that ms_dispatch() takes mo=
re than
> 0.5 seconds, taking osd_lock is responsible for the delay. =A0There's=
 two
> dispatch threads, one for ops and one for rep_ops, right? =A0So one's
> waiting on the other?

There's just one main dispatcher; no split for the ops and rep_ops .
The reason for that "dispatch_running" is that if there are requests
waiting then the tick() function will run through them if the
messenger dispatch thread is currently idle.
But it is possible for the Messenger to try and dispatch, and for that
to be blocked while some amount of (usually trivial) work is being
done by a different thread, yes. I don't think we've ever observed it
being a problem for anything other than updating OSD maps, though...


>>> Another is that once a message receive starts, I see ~50 messages
>>> that take tens of seconds to receive, when the nominal receive time=
 is
>>> a half-second or less. =A0I'm in the process of tooling up to colle=
ct
>>> tcpdump data on all my clients to try to catch what is going on wit=
h
>>> that.
>>
>>
>> Again, how are you instrumenting that?
>
>
> I post-process the logs, looking at the time difference between
> "reader got .* policy throttler" and "reader got .* osd_op(client".

I guess the logging output must have changed a bit at some pointer (or
was that one of your patches?). master has "reader wants" not "reader
got" for the policy throttler. (Just got a little confused when
checking the code.)

> When I find a candidate message, I grep the log for just that reader =
thread,
> and see, e.g., this:
>
> osd.0.log:1280693:2012-02-02 09:17:57.704508 7fe5c9099700 --
> 172.17.131.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680=
 sd=3D215
> pgs=3D49 cs=3D1 l=3D1).reader got 2670720 from policy throttler 48809=
510/50000000
> seq 828/828 waiters 157/149 for src client.4301 tid=3D247
> osd.0.log:1280694:2012-02-02 09:17:57.704525 7fe5c9099700 --
> 172.17.131.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680=
 sd=3D215
> pgs=3D49 cs=3D1 l=3D1).reader wants 2670720 from dispatch throttler
> 41944358/66666666
> osd.0.log:1280701:2012-02-02 09:17:57.704654 7fe5c9099700 --
> 172.17.131.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680=
 sd=3D215
> pgs=3D49 cs=3D1 l=3D1).reader got front 128
> osd.0.log:1280705:2012-02-02 09:17:57.704752 7fe5c9099700 --
> 172.17.131.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680=
 sd=3D215
> pgs=3D49 cs=3D1 l=3D1).reader allocating new rx buffer at offset 0
> osd.0.log:1280710:2012-02-02 09:17:57.704873 7fe5c9099700 --
> 172.17.131.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680=
 sd=3D215
> pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11922000 len=
 2670592
> osd.0.log:1559767:2012-02-02 09:19:40.726589 7fe5c9099700 --
> 172.17.131.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680=
 sd=3D215
> pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11a6a5cc len=
 1325620
> osd.0.log:1561092:2012-02-02 09:19:40.927559 7fe5c9099700 --
> 172.17.131.32:6800/14974 >> 172.17.135.85:0/1283168808 pipe(0xbdc9680=
 sd=3D215
> pgs=3D49 cs=3D1 l=3D1).reader reading nonblocking into 0x11a6ab74 len=
 1324172
>
> Note the ~2 minute delay (and ~300,000 lines of logging) between the =
first
> and second reads.
>
> During that time 129 sockets were processed - what makes sd=3D215 spe=
cial?

Hrm. Well, you can try turning up the messenger debugging to 30 and
taking advantage of the "reader reading" "reader read" pair right
around tcp_read_nonblocking.

> I've added tracepoints in my client kernel try_write(), and nothing s=
eems
> unusual (that's with running the patch to ceph_write_space() I posted
> earlier):
>
> =A0 =A0 kworker/0:2-1790 =A0[000] =A01543.200887: ceph_try_write_msg_=
done: peer osd0
> tid 179 seq 3 sent 4194304
> =A0 =A0 kworker/0:2-1790 =A0[000] =A01543.200901: ceph_prepare_write_=
msg: peer osd0
> tid 207 seq 4 sent 0
*snip*
> =A0 =A0 kworker/0:2-1790 =A0[000] =A01569.078614: ceph_try_write_msg_=
done: peer osd0
> tid 207 seq 4 sent 4194304
>
> There's a 25 second gap at 1543.236256, but nothing like the
> 100 second gap in the reader.
>
> Hence, tcpdump seems like a good idea?

You do bring us interesting problems! Let us know what info you come up=
 with.

Oh, and I keep forgetting to ask: what does the write workload look
like? At first I assumed this was a CephFS workload, but given that
you're changing max message sizes and have half-second writes you're
probably doing something else?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
