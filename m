From: Brian Chrisman <brchrisman@gmail.com>
Subject: cfuse crash stack trace
Date: Fri, 18 Mar 2011 16:11:06 -0700
Message-ID: <AANLkTimzePYGQfTRHONB7LdSncjXn_EPcuCUjwAFniQm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41529 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754690Ab1CRXLI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2011 19:11:08 -0400
Received: by vws1 with SMTP id 1so4089288vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2011 16:11:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm doing some testing via cfuse (technically via samba-over-cfuse).
I caught the core dump and pulled a stack trace.  This is the thread
that seems to be initiating the core dump.
I can provide the rest if it'll help identify what's going on.


My cfuse crashing thread:

Thread 1 (Thread 1696):
#0  0x00007f14ede7d38b in raise () from /lib64/libpthread.so.0
No symbol table info available.
#1  0x0000000000553fe9 in handle_fatal_signal(int) ()
No symbol table info available.
#2  <signal handler called>
No symbol table info available.
#3  0x00007f14eccb29b5 in raise () from /lib64/libc.so.6
No symbol table info available.
#4  0x00007f14eccb4195 in abort () from /lib64/libc.so.6
No symbol table info available.
#5  0x00007f14ed557aad in __gnu_cxx::__verbose_terminate_handler() ()
from /usr/lib64/libstdc++.so.6
No symbol table info available.
#6  0x00007f14ed555c36 in ?? () from /usr/lib64/libstdc++.so.6
---Type <return> to continue, or q <return> to quit---
No symbol table info available.
#7  0x00007f14ed555c63 in std::terminate() () from /usr/lib64/libstdc++.so.6
No symbol table info available.
#8  0x00007f14ed555d5e in __cxa_throw () from /usr/lib64/libstdc++.so.6
No symbol table info available.
#9  0x00000000005400c3 in ceph::__ceph_assert_fail(char const*, char
const*, int, char const*) ()
No symbol table info available.
#10 0x00000000004ef5a0 in ObjectCacher::bh_write_ack(int, sobject_t,
long, unsigned long, unsigned long) ()
No symbol table info available.
#11 0x00000000004fe30a in ObjectCacher::C_WriteAck::finish(int) ()
No symbol table info available.
#12 0x00000000004d0d6c in Objecter::handle_osd_op_reply(MOSDOpReply*) ()
No symbol table info available.
#13 0x00000000004a4e43 in Client::ms_dispatch(Message*) ()
No symbol table info available.
#14 0x0000000000454b32 in SimpleMessenger::dispatch_entry() ()
No symbol table info available.
#15 0x000000000044d0ac in SimpleMessenger::DispatchThread::entry() ()
No symbol table info available.
#16 0x00007f14ede757e1 in start_thread () from /lib64/libpthread.so.0
No symbol table info available.
#17 0x00007f14ecd6151d in clone () from /lib64/libc.so.6
No symbol table info available.
