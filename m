From: Sage Weil <sage@newdream.net>
Subject: Re: cfuse crash stack trace
Date: Fri, 18 Mar 2011 16:53:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103181651180.16804@cobra.newdream.net>
References: <AANLkTimzePYGQfTRHONB7LdSncjXn_EPcuCUjwAFniQm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37305 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757599Ab1CRXvS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2011 19:51:18 -0400
In-Reply-To: <AANLkTimzePYGQfTRHONB7LdSncjXn_EPcuCUjwAFniQm@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 18 Mar 2011, Brian Chrisman wrote:
> I'm doing some testing via cfuse (technically via samba-over-cfuse).
> I caught the core dump and pulled a stack trace.  This is the thread
> that seems to be initiating the core dump.
> I can provide the rest if it'll help identify what's going on.

If this is reproducible, can you pass --log-file /some/path to cfuse to 
get the crash dump (assert error, line number, etc.)?  Also, you should 
probably build with -g to get the debug symbols (I suspect that's why 
you're getting the no symbol table errors).  Better yet, if you can 
reproduce this with cfuse --log-file foo --debug-client 20 --debug-ms 1 
--debug-objectcacher 20 it'll be easy to squash.

Also which version?

Thanks!
sage


> > 
> My cfuse crashing thread:
> 
> Thread 1 (Thread 1696):
> #0  0x00007f14ede7d38b in raise () from /lib64/libpthread.so.0
> No symbol table info available.
> #1  0x0000000000553fe9 in handle_fatal_signal(int) ()
> No symbol table info available.
> #2  <signal handler called>
> No symbol table info available.
> #3  0x00007f14eccb29b5 in raise () from /lib64/libc.so.6
> No symbol table info available.
> #4  0x00007f14eccb4195 in abort () from /lib64/libc.so.6
> No symbol table info available.
> #5  0x00007f14ed557aad in __gnu_cxx::__verbose_terminate_handler() ()
> from /usr/lib64/libstdc++.so.6
> No symbol table info available.
> #6  0x00007f14ed555c36 in ?? () from /usr/lib64/libstdc++.so.6
> ---Type <return> to continue, or q <return> to quit---
> No symbol table info available.
> #7  0x00007f14ed555c63 in std::terminate() () from /usr/lib64/libstdc++.so.6
> No symbol table info available.
> #8  0x00007f14ed555d5e in __cxa_throw () from /usr/lib64/libstdc++.so.6
> No symbol table info available.
> #9  0x00000000005400c3 in ceph::__ceph_assert_fail(char const*, char
> const*, int, char const*) ()
> No symbol table info available.
> #10 0x00000000004ef5a0 in ObjectCacher::bh_write_ack(int, sobject_t,
> long, unsigned long, unsigned long) ()
> No symbol table info available.
> #11 0x00000000004fe30a in ObjectCacher::C_WriteAck::finish(int) ()
> No symbol table info available.
> #12 0x00000000004d0d6c in Objecter::handle_osd_op_reply(MOSDOpReply*) ()
> No symbol table info available.
> #13 0x00000000004a4e43 in Client::ms_dispatch(Message*) ()
> No symbol table info available.
> #14 0x0000000000454b32 in SimpleMessenger::dispatch_entry() ()
> No symbol table info available.
> #15 0x000000000044d0ac in SimpleMessenger::DispatchThread::entry() ()
> No symbol table info available.
> #16 0x00007f14ede757e1 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #17 0x00007f14ecd6151d in clone () from /lib64/libc.so.6
> No symbol table info available.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
