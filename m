From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 13:03:23 -0700
Message-ID: <1299182603.4750.128.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
 <1299103144.4750.49.camel@sale659.sandia.gov>
 <1299106628.4750.62.camel@sale659.sandia.gov>
 <AANLkTikU_F_mRaYC6xE5V9OHaDbyjWJ7fnpVCXkz=tK=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:54211 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab1CCUDf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:03:35 -0500
In-Reply-To: <AANLkTikU_F_mRaYC6xE5V9OHaDbyjWJ7fnpVCXkz=tK=@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-03-02 at 19:26 -0700, Colin McCabe wrote:
> Hi Jim,
> 
> We have seen this problem before. The usual suspects are the oom
> killer (grep for "out of memory" in syslog).
> Unfortunately, SIGKILL is uncatchable and that's what the OOM killer sends.
> 
> Another problem that can prevent core files from being generated is
> bad ulimit -c settings or a bad setting for core_pattern and friends.
> One problem I have a lot too is that the partition I'm writing core
> files to fills up.
> 
> If none of that works, it's possible that someone is calling exit()
> somewhere. You can attach a gdb to the process and put a breakpoint on
> exit() to see if this is going on. There's a lot of "your foo is not
> bar enough, I hate your config, exit(1)" type code that gets executed
> while the daemon is starting up. It sounds like you should be past
> that point, though.

I've finally gotten a little info, using a variant of
your gdb idea: I waited until many of the OSD instances
had died, then I attached gdb to several that were left,
and waited.

Two of them died the same way, like this:

Program received signal SIGPIPE, Broken pipe.
[Switching to Thread 0x7fd7888c8940 (LWP 28693)]
0x00007fd7a9b82f2b in sendmsg () from /lib64/libpthread.so.0
(gdb) bt
#0  0x00007fd7a9b82f2b in sendmsg () from /lib64/libpthread.so.0
#1  0x0000000000672e0b in SimpleMessenger::Pipe::do_sendmsg (
    this=0x7fd799b67c20, sd=13, msg=0x7fd7888c7f20, len=251237, more=false)
    at msg/SimpleMessenger.cc:1994
#2  0x00000000006739d3 in SimpleMessenger::Pipe::write_message (
    this=0x7fd799b67c20, m=0x7fd79b2dcb70) at msg/SimpleMessenger.cc:2217
#3  0x000000000067e74a in SimpleMessenger::Pipe::writer (this=0x7fd799b67c20)
    at msg/SimpleMessenger.cc:1734
#4  0x000000000066fa2b in SimpleMessenger::Pipe::Writer::entry (
    this=0x7fd799b67e70) at msg/SimpleMessenger.h:204
#5  0x000000000068282e in Thread::_entry_func (arg=0x7fd799b67e70)
    at ./common/Thread.h:41
#6  0x00007fd7a9b7b73d in start_thread (arg=<value optimized out>)
    at pthread_create.c:301
#7  0x00007fd7a8a91f6d in clone () from /lib64/libc.so.6
(gdb) 


Program received signal SIGPIPE, Broken pipe.
[Switching to Thread 0x7f1aed7f3940 (LWP 28726)]
0x00007f1b01238f2b in sendmsg () from /lib64/libpthread.so.0
(gdb) bt
#0  0x00007f1b01238f2b in sendmsg () from /lib64/libpthread.so.0
#1  0x0000000000672e0b in SimpleMessenger::Pipe::do_sendmsg (
    this=0x7f1af15c94d0, sd=114, msg=0x7f1aed7f2f20, len=126728, more=false)
    at msg/SimpleMessenger.cc:1994
#2  0x00000000006739d3 in SimpleMessenger::Pipe::write_message (
    this=0x7f1af15c94d0, m=0x23d3010) at msg/SimpleMessenger.cc:2217
#3  0x000000000067e74a in SimpleMessenger::Pipe::writer (this=0x7f1af15c94d0)
    at msg/SimpleMessenger.cc:1734
#4  0x000000000066fa2b in SimpleMessenger::Pipe::Writer::entry (
    this=0x7f1af15c9720) at msg/SimpleMessenger.h:204
#5  0x000000000068282e in Thread::_entry_func (arg=0x7f1af15c9720)
    at ./common/Thread.h:41
#6  0x00007f1b0123173d in start_thread (arg=<value optimized out>)
    at pthread_create.c:301
#7  0x00007f1b00147f6d in clone () from /lib64/libc.so.6

The third also got 

Program received signal SIGPIPE, Broken pipe.
[Switching to Thread 0x7f531fefe940 (LWP 28700)]
0x00007f533ffeaf2b in sendmsg () from /lib64/libpthread.so.0
(gdb) 

but something was a little different and I didn't get a 
backtrace from it.

-- Jim


> 
> Colin
> 


