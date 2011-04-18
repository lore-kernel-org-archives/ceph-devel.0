From: Gregory Farnum <gfarnum@gmail.com>
Subject: Re: Suicide
Date: Mon, 18 Apr 2011 16:02:58 -0700
Message-ID: <FF1D1635C657408E9A7F6275AB23DD61@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38687 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab1DRXDE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 19:03:04 -0400
Received: by pzk9 with SMTP id 9so2318048pzk.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 16:03:03 -0700 (PDT)
In-Reply-To: <4DACBD77.9020600@provocation.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Monday, April 18, 2011 at 3:38 PM, Zenon Panoussis wrote:

> On 04/18/2011 11:21 PM, Gregory Farnum wrote:
> 
> > I looked through your logs a bit and noticed that the OSD on node01 is 
> > crashing due to high latencies on disk access (I think the defaults for
> > this case are it asserts out if there's no progress after 10 minutes or
> > something). 
> 
> First of all, thank you for plowing through those huge logs. It's a feat
> all and by itself.
> 
> Could you please post an example where you found the OSD crashing, so that
> I and others know what log entries to look for?

In this case what I was actually searching for was client requests coming in and then getting lost on some wait list somewhere. I didn't see any of those, but I did see an OSD backtrace:
2011-04-16 20:11:30.304029 7fce00c24700 FileStore: sync_entry timed out after 600 seconds.
ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
2011-04-16 20:11:30.304483 1: (SafeTimer::timer_thread()+0x36b) [0x5f365b]
2011-04-16 20:11:30.304517 2: (SafeTimerThread::entry()+0xd) [0x5f5dfd]
2011-04-16 20:11:30.304545 3: /lib64/libpthread.so.0() [0x3ea6e077e1]
2011-04-16 20:11:30.304573 4: (clone()+0x6d) [0x3ea6ae18ed]
2011-04-16 20:11:30.304599 os/FileStore.cc: In function 'virtual void SyncEntryTimeout::finish(int)', in thread '0x7fce00c24700'
os/FileStore.cc: 2573: FAILED assert(0)
ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
1: (SyncEntryTimeout::finish(int)+0xf4) [0x5953d4]
2: (SafeTimer::timer_thread()+0x36b) [0x5f365b]
3: (SafeTimerThread::entry()+0xd) [0x5f5dfd]
4: /lib64/libpthread.so.0() [0x3ea6e077e1]
5: (clone()+0x6d) [0x3ea6ae18ed]
ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)
1: (SyncEntryTimeout::finish(int)+0xf4) [0x5953d4]
2: (SafeTimer::timer_thread()+0x36b) [0x5f365b]
3: (SafeTimerThread::entry()+0xd) [0x5f5dfd]
4: /lib64/libpthread.so.0() [0x3ea6e077e1]
5: (clone()+0x6d) [0x3ea6ae18ed]




> > Based on that, I pretty much have to guess that there's just too much 
> > stress on your disk and it's going to cause problems. You can try loosening
> > the various configurable timeouts to let it run longer but it seems like
> > really you just need beefier disks for the amount of stuff you're doing to
> > them. 
> 
> My hardware is indeed very primitive, but in order to prevent this from
> happening I would have to make sure that the disks always have more capacity
> than the network. In a real-world setup, with gigabit or muti-gigabit
> networking and multiple applications doing disk I/O simultaneously, this
> is unfeasible. Also, I suspect that it would go against the hierarchy of
> O/S subsystem layering.
It's a bit more complicated than that. While we could probably do a better job of controlling bandwidths, there are a lot of pieces devoted to handling changes in disk performance and preventing the OSD from accepting more data than it can handle -- much of this is tunable (it's not well-documented but off the top of my head the ones to look at are osd_client_message_size_cap, for how much client data to hold in-memory waiting on disk [defaults to 200MB], and filestore_op_threads, which defaults to 2 but might be better at 1 or 0 for a very slow disk) . The specific crash that I saw here meant that the OSD called sync on its underlying filesystem and 6 minutes later the sync hadn't completed! The system can handle slow disks but it became basically unresponsive, at which point the proper r
 esponse in a replicated scenario is to kill itself (the data should all exist elsewhere). I think the problem you ran into is just that because the box was so overloaded your monitor fell behind and
 the timeouts that should have handled transferring everything got bogged down (or, possibly, something broke and the timeouts didn't trigger properly everywhere but I didn't see anything obvious in your logs).

> What I mean is this: if an application tries to write data to the file
> system and fails, the application should either hang or time out and
> bail out; the file system itself should still not crash. The application
> is always agnostic about the file system, so therefore the file system
> should never acknowledge more data than it can promise to actually
> process.
> 
> In the case of ceph things get complicated by the fact that ceph appears
> as a file system to the applications using it, but depends itself on an
> underlying file system for its disk access. As a result, ceph is responsible
> for the data it accepts from applications, but has no way to meet this
> responsibility if the underlying file system lets it down.
> 
> I don't know how this problem can be truly solved, but some trickery with
> I/O buffers might go a long way towards mitigating it. Or perhaps some
> available capacity calls between the monitor and the client. Every other
> networked file system has a similar problem, so looking at how NFS or samba
> deal with it could provide ideas or even ready code.

This is something we've put some thought into. Basically the reason that you're having problems is because
1) you've got a very small system using configuration defaults that don't match up with the capabilities of the hardware you're using, and
2) Ceph's still young so it turns all failures into node crashes (this is by far the simplest failure model and it's generally the appropriate one when dealing with an inherently-distributed system).

I'd recommend tuning down the configuration and seeing if that helps you at all.
-Greg



