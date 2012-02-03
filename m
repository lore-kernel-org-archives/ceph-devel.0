From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling
 under very heavy write load
Date: Fri, 3 Feb 2012 09:17:43 -0700
Message-ID: <4F2C08A7.2050507@sandia.gov>
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
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:42370 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab2BCQST (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 11:18:19 -0500
In-Reply-To: <CAF3hT9AcxxNtscFczP8fShSsaBm_4zhLQZ2F5c7h1YswVaXHkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 02/02/2012 05:28 PM, Gregory Farnum wrote:
> On Thu, Feb 2, 2012 at 12:22 PM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> I found 0 instances of "waiting for commit" in all my OSD logs for my last
>> run.
>>
>> So I never waited on the journal?
>
> Looks like it. Interesting.
>
>
>>>> So far I'm looking at two behaviours I've noticed that seem anomalous to
>>>> me.
>>>>
>>>> One is that I instrumented ms_dispatch(), and I see it take
>>>> a half-second or more several hundred times, out of several
>>>> thousand messages.  Is that expected?
>>>
>>>
>>> How did you instrument it? If you wrapped the whole function it's
>>> possible that those longer runs are actually chewing through several
>>> messages that had to get waitlisted for some reason previously.
>>> (That's the call to do_waiters().)
>>
>>
>> Yep, I wrapped the whole function, and also instrumented taking osd_lock
>> while I was there.  About half the time that ms_dispatch() takes more than
>> 0.5 seconds, taking osd_lock is responsible for the delay.  There's two
>> dispatch threads, one for ops and one for rep_ops, right?  So one's
>> waiting on the other?
>
> There's just one main dispatcher; no split for the ops and rep_ops .
> The reason for that "dispatch_running" is that if there are requests
> waiting then the tick() function will run through them if the
> messenger dispatch thread is currently idle.
> But it is possible for the Messenger to try and dispatch, and for that
> to be blocked while some amount of (usually trivial) work is being
> done by a different thread, yes. I don't think we've ever observed it
> being a problem for anything other than updating OSD maps, though...

Ah, OK.

I guess I was confused by my log output, e.g.:

osd.0.log:2277569:2012-02-02 09:23:41.666420 7fe5fe65e700 osd.0 31 ms_dispatch ET 0.990204 osd_lock ET 0.001438 msg 0xbe19400
osd.0.log:2277697:2012-02-02 09:23:41.669949 7fe5fee5f700 osd.0 31 ms_dispatch ET 0.993136 osd_lock ET 0.992708 msg 0x13afd680

I thought 7fe5fe65e700 and 7fe5fee5f700 identified the threads.

I need to go study that code some more....

>
>
>>>> Another is that once a message receive starts, I see ~50 messages
>>>> that take tens of seconds to receive, when the nominal receive time is
>>>> a half-second or less.  I'm in the process of tooling up to collect
>>>> tcpdump data on all my clients to try to catch what is going on with
>>>> that.
>>>
>>>
>>> Again, how are you instrumenting that?
>>
>>
>> I post-process the logs, looking at the time difference between
>> "reader got .* policy throttler" and "reader got .* osd_op(client".
>
> I guess the logging output must have changed a bit at some pointer (or
> was that one of your patches?). master has "reader wants" not "reader
> got" for the policy throttler. (Just got a little confused when
> checking the code.)

Yep, I added an extra message to make post-processing logs easier, sorry.

>
>> When I find a candidate message, I grep the log for just that reader thread,
>> and see, e.g., this:
>>
>> osd.0.log:1280693:2012-02-02 09:17:57.704508 7fe5c9099700 --
>> 172.17.131.32:6800/14974>>  172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=215
>> pgs=49 cs=1 l=1).reader got 2670720 from policy throttler 48809510/50000000
>> seq 828/828 waiters 157/149 for src client.4301 tid=247
>> osd.0.log:1280694:2012-02-02 09:17:57.704525 7fe5c9099700 --
>> 172.17.131.32:6800/14974>>  172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=215
>> pgs=49 cs=1 l=1).reader wants 2670720 from dispatch throttler
>> 41944358/66666666
>> osd.0.log:1280701:2012-02-02 09:17:57.704654 7fe5c9099700 --
>> 172.17.131.32:6800/14974>>  172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=215
>> pgs=49 cs=1 l=1).reader got front 128
>> osd.0.log:1280705:2012-02-02 09:17:57.704752 7fe5c9099700 --
>> 172.17.131.32:6800/14974>>  172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=215
>> pgs=49 cs=1 l=1).reader allocating new rx buffer at offset 0
>> osd.0.log:1280710:2012-02-02 09:17:57.704873 7fe5c9099700 --
>> 172.17.131.32:6800/14974>>  172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=215
>> pgs=49 cs=1 l=1).reader reading nonblocking into 0x11922000 len 2670592
>> osd.0.log:1559767:2012-02-02 09:19:40.726589 7fe5c9099700 --
>> 172.17.131.32:6800/14974>>  172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=215
>> pgs=49 cs=1 l=1).reader reading nonblocking into 0x11a6a5cc len 1325620
>> osd.0.log:1561092:2012-02-02 09:19:40.927559 7fe5c9099700 --
>> 172.17.131.32:6800/14974>>  172.17.135.85:0/1283168808 pipe(0xbdc9680 sd=215
>> pgs=49 cs=1 l=1).reader reading nonblocking into 0x11a6ab74 len 1324172
>>
>> Note the ~2 minute delay (and ~300,000 lines of logging) between the first
>> and second reads.
>>
>> During that time 129 sockets were processed - what makes sd=215 special?
>
> Hrm. Well, you can try turning up the messenger debugging to 30 and
> taking advantage of the "reader reading" "reader read" pair right
> around tcp_read_nonblocking.

OK, I'll give that a try as well, thanks.
>
>> I've added tracepoints in my client kernel try_write(), and nothing seems
>> unusual (that's with running the patch to ceph_write_space() I posted
>> earlier):
>>
>>      kworker/0:2-1790  [000]  1543.200887: ceph_try_write_msg_done: peer osd0
>> tid 179 seq 3 sent 4194304
>>      kworker/0:2-1790  [000]  1543.200901: ceph_prepare_write_msg: peer osd0
>> tid 207 seq 4 sent 0
> *snip*
>>      kworker/0:2-1790  [000]  1569.078614: ceph_try_write_msg_done: peer osd0
>> tid 207 seq 4 sent 4194304
>>
>> There's a 25 second gap at 1543.236256, but nothing like the
>> 100 second gap in the reader.
>>
>> Hence, tcpdump seems like a good idea?
>
> You do bring us interesting problems! Let us know what info you come up with.
>
> Oh, and I keep forgetting to ask: what does the write workload look
> like? At first I assumed this was a CephFS workload, but given that
> you're changing max message sizes and have half-second writes you're
> probably doing something else?

I'm just using "pdsh -f <number of clients> -w <client list>"
to start up a "dd conv=fdatasync" on each client, roughly
simultaneously.

I think the short messages are coming from writeback control.
I've got the writeback tracepoints enabled, and most of the time
I see things like this:

tc85.trace.log:166469:    flush-ceph-1-11910 [000]  1787.028175: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296424688 age=30 index=513024 to_write=1024 wrote=1024
tc85.trace.log:166474:    flush-ceph-1-11910 [000]  1787.028889: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296424688 age=30 index=514048 to_write=1024 wrote=1024

But occasionally I see this sort of thing:

tc85.trace.log:22410:    flush-ceph-1-11910 [001]  1546.957999: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=0 index=295936 to_write=11264 wrote=11264
tc85.trace.log:29383:    flush-ceph-1-11910 [001]  1547.327652: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=0 index=307200 to_write=11264 wrote=11264
tc85.trace.log:37048:    flush-ceph-1-11910 [001]  1548.861577: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=2 index=316416 to_write=9216 wrote=9216
tc85.trace.log:42864:    flush-ceph-1-11910 [000]  1550.023496: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=3 index=323584 to_write=7168 wrote=7168
tc85.trace.log:47626:    flush-ceph-1-11910 [000]  1550.976374: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=4 index=329728 to_write=6144 wrote=6144
tc85.trace.log:51607:    flush-ceph-1-11910 [001]  1551.781108: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=5 index=334848 to_write=5120 wrote=5120
tc85.trace.log:51998:    flush-ceph-1-11910 [001]  1551.860104: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=5 index=339968 to_write=5120 wrote=5120
tc85.trace.log:52018:    flush-ceph-1-11910 [001]  1551.863599: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=5 index=345088 to_write=5120 wrote=5120
tc85.trace.log:52034:    flush-ceph-1-11910 [001]  1551.866372: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=5 index=350208 to_write=5120 wrote=5120
tc85.trace.log:52044:    flush-ceph-1-11910 [001]  1551.866767: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=5 index=0 to_write=5120 wrote=648
tc85.trace.log:69705:    flush-ceph-1-11910 [000]  1576.878034: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296214116 age=30 index=352256 to_write=1024 wrote=1400
tc85.trace.log:69830:    flush-ceph-1-11910 [000]  1576.892907: writeback_single_inode: bdi ceph-1: ino=1099511712863 state= dirtied_when=4296214116 age=30 index=0 to_write=1024 wrote=576
tc85.trace.log:81609:    flush-ceph-1-11910 [001]  1606.907407: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296244466 age=30 index=378880 to_write=1024 wrote=1472
tc85.trace.log:81678:    flush-ceph-1-11910 [001]  1606.916107: writeback_single_inode: bdi ceph-1: ino=1099511712863 state= dirtied_when=4296244466 age=30 index=0 to_write=1024 wrote=831
tc85.trace.log:96729:    flush-ceph-1-11910 [000]  1636.918264: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296274503 age=30 index=393216 to_write=1024 wrote=1217
tc85.trace.log:96839:    flush-ceph-1-11910 [000]  1636.931363: writeback_single_inode: bdi ceph-1: ino=1099511712863 state= dirtied_when=4296274503 age=30 index=0 to_write=1024 wrote=933
tc85.trace.log:111179:    flush-ceph-1-11910 [001]  1666.932329: writeback_single_inode: bdi ceph-1: ino=1099511712863 state=I_DIRTY_PAGES dirtied_when=4296304541 age=30 index=415744 to_write=1024 wrote=1115
tc85.trace.log:111298:    flush-ceph-1-11910 [001]  1666.945162: writeback_single_inode: bdi ceph-1: ino=1099511712863 state= dirtied_when=4296304541 age=30 index=0 to_write=1024 wrote=941

I eventually want to understand what is happening here.....

BTW, should I post my ceph client tracepoint patches?  I ask because
it's not clear to me they would be useful to anyone but me.

-- Jim

> -Greg
>
>


