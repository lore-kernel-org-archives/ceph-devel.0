From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Could be due to a race condition... Re: Help with understanding
 throttle.finish()
Date: Fri, 6 May 2016 23:04:01 +0200
Message-ID: <828fd24d-f73d-42e6-69e0-d9f6c5811edd@digiware.nl>
References: <57225355.3040401@digiware.nl>
 <8402c73a-d6c4-6ad7-453e-c100e7376e72@digiware.nl>
 <CAJ4mKGZDvFPAZmhF1c=b07=myW7-y+SgEONL1zyB+piV-r50Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:57496 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758495AbcEFVEi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 17:04:38 -0400
In-Reply-To: <CAJ4mKGZDvFPAZmhF1c=b07=myW7-y+SgEONL1zyB+piV-r50Hg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 6-5-2016 20:41, Gregory Farnum wrote:
> On Fri, May 6, 2016 at 8:29 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 28-4-2016 20:15, Willem Jan Withagen wrote:
>>>
>>> Hi,
>>>
>>> I'm running a rather simple setup on my FreeBSD port.
>>>
>>> function TEST_simple() {
>>>     # run the most simple config, and run a bechmark on it.
>>>     local dir=$1
>>>
>>>     run_mon $dir a || return 1
>>>     run_osd $dir 0 || return 1
>>>
>>>     #
>>>     # default values should work
>>>     #
>>>     ceph tell osd.0 bench || return 1
>>>
>>> }
>>>
>>> This in the end crashes with:
>>>     8059eec00 -1 FileStore: sync_entry timed out after 600 seconds.
>>> exactly 10 minutes after startup.
>>> This trhread does just about exactly nothing, it initialises the time,
>>> and then traps after 10 minutes.
>>> # grep 8059eec00  testdir/osd-bench/osd.0.log
>>> 2016-04-28 19:51:44.444689 8059eec00 -1 FileStore: sync_entry timed out
>>> after 600 seconds.
>>> 2016-04-28 19:51:44.487104 8059eec00 -1 os/filestore/FileStore.cc: In
>>> function 'virtual void SyncEntryTimeout::finish(int)' thread 8059eec00
>>> time
>>
>>
>> Haven't made much progress with this problem.
>> Rebases, but that does not bring any "fixes" in.
>>
>> An extra measure point in time.
>> I've ran the OSD thru truss (aka strace in linux speak) and that does
>> complete.
>>
>> Now what truss/strace does it augments kernel entry and exit with monitoring
>> code
>> and as such it can (and will change) the micro-timing. Als a consequence of
>> that
>> it could also order the way threads interact.
>> It could very well be a difference between semantics in Locks/Mutexes
>> between
>> Linux and FreeBSD, but I have not really found any suggestions to that
>> regard.
>>
>> The fact that with truss/strace the osd does not generate a crash,
>> (not even with: --filestore-commit-timeout=10)
>> is in indication that I could very likely be either a deadlock or other lock
>> related issue that is hiding somewhere under the lid of the OSD.
>>
>> What are people using to analyze timing/locking/deadlocking issues in the
>> Cephcode?
> 
> Our Mutex implementations have a custom lockdep built in. That should
> be checking for anything using those...
> 
> But I'd be inclined to just check exactly what the thread is doing. I
> think it's a lot more likely to be getting an unexpected syscall value
> and just sitting still or something.

Oke, so the lockdep should at least report any created deadlocks?
Or does it even try to reverse lock-order if it sees possibilities it
would be oke to do so?

So it is very likely the second alternative I gave: Mismatching semantics.

Already had that issue with ENODATA and ENOATTR, which got also troubled
by the fact that Boost it also defines. And of course with a number that
is again different:
    boost/cerrno.hpp:#define ENODATA 9919

I've also switched on --debug-timer=20 in my tests, and I'm now
comparing the input of a "regular"run that blocks, and a trussed-run
that run to completion, so see where we do not reload the timer.
Next is then to see why.

But then my wife came home, and we sat out on the veranda with a nice
glass of Prosecco in the evening sun.... Beats thumbing trhu
Ceph-traces. 8=D
Not much time durring the weekend, so likely to be continued after the
weekend.

--WjW

