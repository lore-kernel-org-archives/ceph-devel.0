From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: common/Mutex.h:102: FAILED assert(nlock > 0)
Date: Fri, 22 Oct 2010 14:25:06 -0600
Message-ID: <1287779106.6806.78.camel@sale659.sandia.gov>
References: <1287773810.6806.74.camel@sale659.sandia.gov>
 <AANLkTikL=9eXGTGyMzs2b71kQfaEieayp-KFNUrLy2k2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:59355 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757203Ab0JVUZO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Oct 2010 16:25:14 -0400
In-Reply-To: <AANLkTikL=9eXGTGyMzs2b71kQfaEieayp-KFNUrLy2k2@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,

On Fri, 2010-10-22 at 13:40 -0600, Gregory Farnum wrote:
> If you pull the newest unstable you'll find this fixed, it was a
> short-lived error in the tree. :)

What's the tip of the unstable branch for you?

My latest pull as of 14:23:00 MDT has 242b5992f307 as 
the tip, and it's still showing this problem?

Thanks -- Jim

> -Greg
> 
> On Fri, Oct 22, 2010 at 11:56 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > Hi,
> >
> > The unstable branch is giving me lots of these asserts when
> > I try to start up a file system with 10 servers, 16 cosd/server:
> >
> > # tail -30 /var/log/ceph/osd.113.log
> > 2010-10-22 12:46:41.372489 4733b940 -- 172.17.40.28:6803/10781 <== osd128 172.17.40.29:6801/6905 1 ==== osd_ping(e0 as_of 4 ACK) v1 ==== 61+0+0 (2649909510 0 0) 0x226bc30
> > 2010-10-22 12:46:41.372507 4733b940 osd113 4  peer osd128 172.17.40.29:6801/6905 requesting heartbeats
> > common/Mutex.h: In function 'void Mutex::Unlock()':
> > common/Mutex.h:102: FAILED assert(nlock > 0)
> >  ceph version 0.23~rc (commit:55fcbc649c42f029ca63a1f36acc5244beacf705)
> >  1: (SimpleMessenger::Pipe::accept()+0x130e) [0x474a2e]
> >  2: (SimpleMessenger::Pipe::reader()+0x1f5) [0x476b15]
> >  3: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x46562d]
> >  4: (Thread::_entry_func(void*)+0x7) [0x480607]
> >  5: /lib64/libpthread.so.0 [0x7fda5bce973d]
> >  6: (clone()+0x6d) [0x7fda5af7dd1d]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> > *** Caught signal (ABRT) ***
> >  ceph version 0.23~rc (commit:55fcbc649c42f029ca63a1f36acc5244beacf705)
> >  1: (sigabrt_handler(int)+0x4a) [0x614cfa]
> >  2: /lib64/libc.so.6 [0x7fda5aeda2d0]
> >  3: (gsignal()+0x35) [0x7fda5aeda265]
> >  4: (abort()+0x110) [0x7fda5aedbd10]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x114) [0x7fda5b750cb4]
> >  6: /usr/lib64/libstdc++.so.6 [0x7fda5b74edb6]
> >  7: /usr/lib64/libstdc++.so.6 [0x7fda5b74ede3]
> >  8: /usr/lib64/libstdc++.so.6 [0x7fda5b74eeca]
> >  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x214) [0x601a34]
> >  10: (Mutex::Unlock()+0x5b) [0x4655fb]
> >  11: (SimpleMessenger::Pipe::accept()+0x130e) [0x474a2e]
> >  12: (SimpleMessenger::Pipe::reader()+0x1f5) [0x476b15]
> >  13: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x46562d]
> >  14: (Thread::_entry_func(void*)+0x7) [0x480607]
> >  15: /lib64/libpthread.so.0 [0x7fda5bce973d]
> >  16: (clone()+0x6d) [0x7fda5af7dd1d]
> >
> >
> > # gdb /usr/bin/cosd
> > Reading symbols from /usr/bin/cosd...done.
> > (gdb) l *0x474a2e
> > 0x474a2e is in SimpleMessenger::Pipe::accept() (msg/SimpleMessenger.cc:897).
> > 892       return 0;   // success.
> > 893
> > 894      fail_unlocked:
> > 895       if (existing)
> > 896         existing->pipe_lock.Unlock();
> > 897       pipe_lock.Lock();
> > 898       bool queued = is_queued();
> > 899       if (queued)
> > 900         state = STATE_CONNECTING;
> > 901       else
> > (gdb) q
> >
> >
> > FWIW, it looks to me like a double unlock via a failed reply.
> >
> > -- Jim
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 


