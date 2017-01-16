From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Assert in Pipe.cc in Hammer 0.94.7
Date: Mon, 16 Jan 2017 15:27:00 -0800
Message-ID: <CAJ4mKGYrJL1JXwRDRQHg_iJPqsQN_ppRzLAVs0rt9PyLSRnnHw@mail.gmail.com>
References: <CAC+4SSg2EM_7sWvOrkUNCzZ9_tf5ew2MKqw30Db1c-LFEbNrLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:33244 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdAPX1v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jan 2017 18:27:51 -0500
Received: by mail-io0-f179.google.com with SMTP id v96so102695887ioi.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jan 2017 15:27:04 -0800 (PST)
In-Reply-To: <CAC+4SSg2EM_7sWvOrkUNCzZ9_tf5ew2MKqw30Db1c-LFEbNrLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Padmanabh Ratnakar <padmanabh.ratnakar@snapdeal.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 16, 2017 at 5:23 AM, Padmanabh Ratnakar
<padmanabh.ratnakar@snapdeal.com> wrote:
> Hi,
>            We are seeing following assert in Pipe.cc when we hit some
> network glitch in our setup.
>
> msg/simple/Pipe.cc: In function 'int Pipe::connect()' thread
> 7f0124800700 time 2016-12-28 20:43:00.057696
> msg/simple/Pipe.cc: 1156: FAILED assert(m)
>  ceph version 0.94.7 (d56bdf93ced6b80b07397d57e3fa68fe68304432)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x8b) [0xbb1fab]
>  2: (Pipe::connect()+0x380a) [0xc8985a]
>  3: (Pipe::writer()+0x4ca) [0xc8acca]
>  4: (Pipe::Writer::entry()+0xd) [0xc95b1d]
>  5: (()+0x8182) [0x7f01e1b8f182]
>  6: (clone()+0x6d) [0x7f01e00fa47d]
>
> (gdb) bt
> #0  0x00007f01e1b9720b in raise (sig=6) at
> ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:37
> #1  0x0000000000ab70dd in reraise_fatal (signum=6) at
> global/signal_handler.cc:59
> #2  handle_fatal_signal (signum=6) at global/signal_handler.cc:109
> #3  <signal handler called>
> #4  0x00007f01e0036cc9 in __GI_raise (sig=sig@entry=6) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:56
> #5  0x00007f01e003a0d8 in __GI_abort () at abort.c:89
> #6  0x00007f01e0941535 in __gnu_cxx::__verbose_terminate_handler() ()
> from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #7  0x00007f01e093f6d6 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #8  0x00007f01e093f703 in std::terminate() () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #9  0x00007f01e093f922 in __cxa_throw () from
> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
> #10 0x0000000000bb2198 in ceph::__ceph_assert_fail
> (assertion=assertion@entry=0xd8bc4f "m", file=file@entry=0xd928b8
> "msg/simple/Pipe.cc",
>     line=line@entry=1156, func=func@entry=0xd94210
> <Pipe::connect()::__PRETTY_FUNCTION__> "int Pipe::connect()") at
> common/assert.cc:77
> #11 0x0000000000c8985a in Pipe::connect (this=this@entry=0x32030000)
> at msg/simple/Pipe.cc:1156
> #12 0x0000000000c8acca in Pipe::writer (this=0x32030000) at
> msg/simple/Pipe.cc:1703
> #13 0x0000000000c95b1d in Pipe::Writer::entry (this=<optimized out>)
> at msg/simple/Pipe.h:62
> #14 0x00007f01e1b8f182 in start_thread (arg=0x7f0124800700) at
> pthread_create.c:312
> #15 0x00007f01e00fa47d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
>
> Is this a known issue? I searched for it and could not find anyone hitting this.

I don't think so.

>
> Looking at the 0.94.7 code, looks like pipe_lock is released in line
> 886 in the beginning of connect() routine.
> It is again taken later. But there is update to state member variable
> without checking current state in code below.

Where exactly?

> If pipe is moved to STATE_CLOSED in the interval when lock was released,
> there is a chance that it can get overwritten when
> CEPH_MSGR_TAG_WAIT(STATE_WAIT) comes as reply or
> directly to STATE_OPEN in line 1172.

I'm not following your referents here. The out_seq can get
overwritten? Something else?

> I feel this may cause assert seen above but only if many other things
> also happen.

We had some vaguely similar issues in the time after CEPH_MSGR_TAG_SEQ
was introduced, but I think it's been a while. You might have spotted
another rare one.
-Greg
