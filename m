From: Sage Weil <sage@newdream.net>
Subject: Re: Definition of nlock in common/Mutex.h seems resulting in core
 dump
Date: Mon, 4 Jul 2016 13:08:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1607041307370.31395@piezo.us.to>
References: <CAFZHTOaR-U5OT1YZe8S3VARpNuU5SZ6bLLQ4CkKuVq1gaoKJnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42570 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbcGDNIz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2016 09:08:55 -0400
In-Reply-To: <CAFZHTOaR-U5OT1YZe8S3VARpNuU5SZ6bLLQ4CkKuVq1gaoKJnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeegn Chen <jeegnchen@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 4 Jul 2016, Jeegn Chen wrote:
> Hi all,
> 
> I see such call stack in a Ceph 0.94.1 OSD core dump.
> Mutex::_pre_unlock() asserted failure when it noticed an inconsistent
> in nlock. I checked the code and did not find logic error yet. But I
> notice the type of nlock is int instead of atomic_t and nlock is
> modified without locking. Thus in multi-threaded environment, the
> value of nlock may be updated inconsistently when threads are
> scheduled in different ways. So my guess is that the root cause of the
> core dump is the incorrect type of nlock. The related logic in Ceph
> 10.2.0 seems the same.

The nlock value is always modified while holding the mutex (after lock, 
before unlock).  Usually this sort of error indicates a use-after-free of 
some sort.  In this case, the CephContext is probably getting destroyed 
before the thread is shut down... probably a put() where there shouldn't 
be one?  Are you able to reproduce this crash?

sage


 > 
> What do you think?
> 
> (gdb) bt
> #0  0x000000374360f6ab in raise () from /lib64/libpthread.so.0
> #1  0x0000000000bf1525 in reraise_fatal (signum=6) at
> global/signal_handler.cc:59
> #2  handle_fatal_signal (signum=6) at global/signal_handler.cc:109
> #3  <signal handler called>
> #4  0x0000003743232625 in raise () from /lib64/libc.so.6
> #5  0x0000003743233e05 in abort () from /lib64/libc.so.6
> #6  0x000000374322b74e in __assert_fail_base () from /lib64/libc.so.6
> #7  0x000000374322b810 in __assert_fail () from /lib64/libc.so.6
> #8  0x0000000000c0ba85 in _pre_unlock (this=0x5892240) at common/Mutex.h:96
> #9  Mutex::Unlock (this=0x5892240) at common/Mutex.cc:104
> #10 0x0000000000c1a9eb in ~Locker (this=0x5892220) at common/Mutex.h:118
> #11 CephContextServiceThread::entry (this=0x5892220) at
> common/ceph_context.cc:73
> #12 0x0000003743607aa1 in start_thread () from /lib64/libpthread.so.0
> #13 0x00000037432e893d in clone () from /lib64/libc.so.6
> (gdb) frame 8
> #8  0x0000000000c0ba85 in _pre_unlock (this=0x5892240) at common/Mutex.h:96
> 96          assert(nlock > 0);
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
