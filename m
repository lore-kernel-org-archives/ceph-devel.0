From: Jeegn Chen <jeegnchen@gmail.com>
Subject: Definition of nlock in common/Mutex.h seems resulting in core dump
Date: Mon, 4 Jul 2016 16:18:05 +0800
Message-ID: <CAFZHTOaR-U5OT1YZe8S3VARpNuU5SZ6bLLQ4CkKuVq1gaoKJnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33130 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbcGDISI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2016 04:18:08 -0400
Received: by mail-lf0-f42.google.com with SMTP id f6so112265219lfg.0
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2016 01:18:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I see such call stack in a Ceph 0.94.1 OSD core dump.
Mutex::_pre_unlock() asserted failure when it noticed an inconsistent
in nlock. I checked the code and did not find logic error yet. But I
notice the type of nlock is int instead of atomic_t and nlock is
modified without locking. Thus in multi-threaded environment, the
value of nlock may be updated inconsistently when threads are
scheduled in different ways. So my guess is that the root cause of the
core dump is the incorrect type of nlock. The related logic in Ceph
10.2.0 seems the same.

What do you think?

(gdb) bt
#0  0x000000374360f6ab in raise () from /lib64/libpthread.so.0
#1  0x0000000000bf1525 in reraise_fatal (signum=6) at
global/signal_handler.cc:59
#2  handle_fatal_signal (signum=6) at global/signal_handler.cc:109
#3  <signal handler called>
#4  0x0000003743232625 in raise () from /lib64/libc.so.6
#5  0x0000003743233e05 in abort () from /lib64/libc.so.6
#6  0x000000374322b74e in __assert_fail_base () from /lib64/libc.so.6
#7  0x000000374322b810 in __assert_fail () from /lib64/libc.so.6
#8  0x0000000000c0ba85 in _pre_unlock (this=0x5892240) at common/Mutex.h:96
#9  Mutex::Unlock (this=0x5892240) at common/Mutex.cc:104
#10 0x0000000000c1a9eb in ~Locker (this=0x5892220) at common/Mutex.h:118
#11 CephContextServiceThread::entry (this=0x5892220) at
common/ceph_context.cc:73
#12 0x0000003743607aa1 in start_thread () from /lib64/libpthread.so.0
#13 0x00000037432e893d in clone () from /lib64/libc.so.6
(gdb) frame 8
#8  0x0000000000c0ba85 in _pre_unlock (this=0x5892240) at common/Mutex.h:96
96          assert(nlock > 0);
