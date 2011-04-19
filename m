From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Suicide
Date: Mon, 18 Apr 2011 17:17:11 -0700
Message-ID: <BANLkTi=VS8V4xWKFHg9et1QGS_SDGJw+Bw@mail.gmail.com>
References: <4DA85AA6.8050707@provocation.net>
	<3704E18884CB47E081E09984151ACC7B@gmail.com>
	<4DA8C8FB.5050106@provocation.net>
	<161F0A2E50F1465996C6A9075A508C85@gmail.com>
	<4DA8D4EF.8090006@provocation.net>
	<25103BE141804650A169B6444F0D6D21@gmail.com>
	<4DAA2B38.1090706@provocation.net>
	<BANLkTi=rdcyUu_7PwFc0nRbYs-V=tr+V8Q@mail.gmail.com>
	<CB9E56C259C44656B7B9DD670A548B8A@gmail.com>
	<4DACBD77.9020600@provocation.net>
	<FF1D1635C657408E9A7F6275AB23DD61@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39689 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab1DSARN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 20:17:13 -0400
Received: by fxm17 with SMTP id 17so2975527fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 17:17:11 -0700 (PDT)
In-Reply-To: <FF1D1635C657408E9A7F6275AB23DD61@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@gmail.com>
Cc: Zenon Panoussis <oracle@provocation.net>, ceph-devel@vger.kernel.org

On Mon, Apr 18, 2011 at 4:02 PM, Gregory Farnum <gfarnum@gmail.com> wrote:
> On Monday, April 18, 2011 at 3:38 PM, Zenon Panoussis wrote:
>
>> On 04/18/2011 11:21 PM, Gregory Farnum wrote:
>>
>> > I looked through your logs a bit and noticed that the OSD on node01 is
>> > crashing due to high latencies on disk access (I think the defaults for
>> > this case are it asserts out if there's no progress after 10 minutes or
>> > something).
>>
>> First of all, thank you for plowing through those huge logs. It's a feat
>> all and by itself.
>>
>> Could you please post an example where you found the OSD crashing, so that
>> I and others know what log entries to look for?
>
> In this case what I was actually searching for was client requests coming in and then getting lost on some wait list somewhere. I didn't see any of those, but I did see an OSD backtrace:
> 2011-04-16 20:11:30.304029 7fce00c24700 FileStore: sync_entry timed out after 600 seconds.
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
> 2011-04-16 20:11:30.304483 1: (SafeTimer::timer_thread()+0x36b) [0x5f365b]
> 2011-04-16 20:11:30.304517 2: (SafeTimerThread::entry()+0xd) [0x5f5dfd]
> 2011-04-16 20:11:30.304545 3: /lib64/libpthread.so.0() [0x3ea6e077e1]
> 2011-04-16 20:11:30.304573 4: (clone()+0x6d) [0x3ea6ae18ed]
> 2011-04-16 20:11:30.304599 os/FileStore.cc: In function 'virtual void SyncEntryTimeout::finish(int)', in thread '0x7fce00c24700'
> os/FileStore.cc: 2573: FAILED assert(0)
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
> 1: (SyncEntryTimeout::finish(int)+0xf4) [0x5953d4]
> 2: (SafeTimer::timer_thread()+0x36b) [0x5f365b]
> 3: (SafeTimerThread::entry()+0xd) [0x5f5dfd]
> 4: /lib64/libpthread.so.0() [0x3ea6e077e1]
> 5: (clone()+0x6d) [0x3ea6ae18ed]
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
> 1: (SyncEntryTimeout::finish(int)+0xf4) [0x5953d4]
> 2: (SafeTimer::timer_thread()+0x36b) [0x5f365b]
> 3: (SafeTimerThread::entry()+0xd) [0x5f5dfd]
> 4: /lib64/libpthread.so.0() [0x3ea6e077e1]
> 5: (clone()+0x6d) [0x3ea6ae18ed]

This particular timeout was added in response to a specific bug where
someone did a drive pull, and it was never reported to userspace.
Instead, the btrfs filesystem just blocked forever.

http://tracker.newdream.net/issues/735

We decided just to add a timeout that would trigger if a commit took
too long. This is basically a dirty hack. It would be better just to
have the drive pull event properly communicated to userspace. However,
we thought that it wouldn't really cause problems in practice since
the timeout was so long.

There are other timeouts in the code, like the OSD heartbeat timeout.
In general, as Greg pointed out, Ceph is supposed to assure data
security through redundant copies on multiple OSDs. If we let
unresponsive OSDs linger forever, we could get in a situation where
the upper layer (the Ceph filesystem) continues to wait forever for an
unresponsive OSD, even though there are lots of other OSDs that could
easily take up the slack. This is like starving to death at the
all-you-can-eat buffet, just because they're out of jell-o.

There is some logic in FileStore::queue_transactions  that is supposed
to throttle the requests we're making to the FileStore. I haven't ever
really examined that code. I guess it's possible that it is not doing
a very good job of preventing work from piling up faster than we can
take care of it.

In general, there is a lot of performance tuning and optimization work
left to do. We're working towards having better metrics so that it
will be easier to measure our progress in this area. Hopefully we can
get something like a nightly autotest that will email out performance
numbers for the master branch.

cheers,
Colin
