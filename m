From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Thu, 3 Mar 2011 13:47:14 -0700
Message-ID: <1299185234.4750.137.camel@sale659.sandia.gov>
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
 <1299182603.4750.128.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:43913 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758472Ab1CCUrY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2011 15:47:24 -0500
In-Reply-To: <1299182603.4750.128.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 2011-03-03 at 13:03 -0700, Jim Schutt wrote:
> > If none of that works, it's possible that someone is calling exit()
> > somewhere. You can attach a gdb to the process and put a breakpoint on
> > exit() to see if this is going on. There's a lot of "your foo is not
> > bar enough, I hate your config, exit(1)" type code that gets executed
> > while the daemon is starting up. It sounds like you should be past
> > that point, though.
> 
> I've finally gotten a little info, using a variant of
> your gdb idea: I waited until many of the OSD instances
> had died, then I attached gdb to several that were left,
> and waited.
> 
> Two of them died the same way, like this:
> 
> Program received signal SIGPIPE, Broken pipe.
> [Switching to Thread 0x7fd7888c8940 (LWP 28693)]
> 0x00007fd7a9b82f2b in sendmsg () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x00007fd7a9b82f2b in sendmsg () from /lib64/libpthread.so.0
> #1  0x0000000000672e0b in SimpleMessenger::Pipe::do_sendmsg (
>     this=0x7fd799b67c20, sd=13, msg=0x7fd7888c7f20, len=251237, more=false)
>     at msg/SimpleMessenger.cc:1994
> #2  0x00000000006739d3 in SimpleMessenger::Pipe::write_message (
>     this=0x7fd799b67c20, m=0x7fd79b2dcb70) at msg/SimpleMessenger.cc:2217
> #3  0x000000000067e74a in SimpleMessenger::Pipe::writer (this=0x7fd799b67c20)
>     at msg/SimpleMessenger.cc:1734
> #4  0x000000000066fa2b in SimpleMessenger::Pipe::Writer::entry (
>     this=0x7fd799b67e70) at msg/SimpleMessenger.h:204
> #5  0x000000000068282e in Thread::_entry_func (arg=0x7fd799b67e70)
>     at ./common/Thread.h:41
> #6  0x00007fd7a9b7b73d in start_thread (arg=<value optimized out>)
>     at pthread_create.c:301
> #7  0x00007fd7a8a91f6d in clone () from /lib64/libc.so.6
> (gdb) 
> 

Has something maybe changed in signal handling recently?

Maybe SIGPIPE used to be blocked, and sendmsg() would
return -EPIPE, but now it's not blocked and not handled?

This bit in linux-2.6.git/net/core/stream.c is what made
me wonder, but maybe it's a red herring:

int sk_stream_error(struct sock *sk, int flags, int err)
{
	if (err == -EPIPE)
		err = sock_error(sk) ? : -EPIPE;
	if (err == -EPIPE && !(flags & MSG_NOSIGNAL))
		send_sig(SIGPIPE, current, 0);
	return err;
}

-- Jim



