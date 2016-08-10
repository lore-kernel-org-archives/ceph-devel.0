From: Willem Jan Withagen <wjw@digiware.nl>
Subject: admin_socket using poll or kqueue on FreeBSD
Date: Wed, 10 Aug 2016 11:05:06 +0200
Message-ID: <5fe132c8-a4d4-a1e0-e3a8-7b3ac0d45350@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:51102 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbcHJSUj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Aug 2016 14:20:39 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id AE0152565D
	for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 11:05:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hoi,

I'm haveing trouble terminating ceph-mon (and sometimes osd).
Only kill -9 will get it to die.

I think it is due to that AdminSocket is still stuck in poll()?
Should AdminSocket use poll() on FreeBSD, or is this a misconfiguration
and should it be using kqueue stuff?

Below backtraces of the relevant threads...

--WjW


Debugging a "stuck" daemons reveals this in the threads:
(gdb) info threads
  Id   Target Id         Frame
  1    LWP 101835 of process 14361 _umtx_op_err () at
/usr/srcs/head/src/lib/libthr/arch/amd64/amd64/_umtx_op_err.S:37
* 2    LWP 100165 of process 14361 "log" _umtx_op_err () at
/usr/srcs/head/src/lib/libthr/arch/amd64/amd64/_umtx_op_err.S:37
  3    LWP 100352 of process 14361 "service" _umtx_op_err () at
/usr/srcs/head/src/lib/libthr/arch/amd64/amd64/_umtx_op_err.S:37
  4    LWP 100736 of process 14361 "admin_socket" 0x000000080602b9aa in
_poll () from /lib/libc.so.7
  5    LWP 100737 of process 14361 "fn_monstore" _umtx_op_err () at
/usr/srcs/head/src/lib/libthr/arch/amd64/amd64/_umtx_op_err.S:37
  6    LWP 100738 of process 14361 "ms_reaper" _umtx_op_err () at
/usr/srcs/head/src/lib/libthr/arch/amd64/amd64/_umtx_op_err.S:37
  7    LWP 101504 of process 14361 "ms_accepter" 0x000000080602b9aa in
_poll () from /lib/libc.so.7
  8    LWP 101505 of process 14361 "signal_handler" 0x000000080602b9aa
in _poll () from /lib/libc.so.7
  9    LWP 100287 of process 14361 _umtx_op_err () at
/usr/srcs/head/src/lib/libthr/arch/amd64/amd64/_umtx_op_err.S:37

Thread 1 has the following backtrace:
#0  _umtx_op_err () at
/usr/srcs/head/src/lib/libthr/arch/amd64/amd64/_umtx_op_err.S:37
#1  0x00000008020bf4bb in _thr_umtx_wait (mtx=0xa960d80, id=101504,
timeout=0x0) at /usr/srcs/head/src/lib/libthr/thread/thr_umtx.c:180
#2  0x00000008020cae2e in join_common (pthread=0xa960d80,
thread_return=0x0, abstime=0x0) at
/usr/srcs/head/src/lib/libthr/thread/thr_join.c:125
#3  0x00000008020cab61 in _pthread_join (pthread=0xa960d80,
thread_return=0x0) at /usr/srcs/head/src/lib/libthr/thread/thr_join.c:57
#4  0x00000000013e977c in Thread::join (this=0xa816698, prval=0x0) at
/usr/srcs/Ceph/work/ceph/src/common/Thread.cc:173
#5  0x0000000001568dc1 in Accepter::stop (this=0xa816698) at
/usr/srcs/Ceph/work/ceph/src/msg/simple/Accepter.cc:303
#6  0x000000000127ac51 in SimpleMessenger::wait (this=0xa816580) at
/usr/srcs/Ceph/work/ceph/src/msg/simple/SimpleMessenger.cc:540

So the whole process is winding down to exit, but its likely is stuck in
pthread_join() before exiting.

But some ot the threads are waiting on poll():
Thread 8 (LWP 101505 of process 14361):
#0  0x000000080602b9aa in _poll () from /lib/libc.so.7
#1  0x00000008020c0783 in __thr_poll (fds=0x7fffdebf3e00, nfds=4,
timeout=-1) at /usr/srcs/head/src/lib/libthr/thread/thr_syscalls.c:306
#2  0x00000000015fe83c in SignalHandler::entry (this=0xa6fc780) at
/usr/srcs/Ceph/work/ceph/src/global/signal_handler.cc:277
#3  0x00000000013e9466 in Thread::entry_wrapper (this=0xa6fc780) at
/usr/srcs/Ceph/work/ceph/src/common/Thread.cc:89
#4  0x00000000013e9385 in Thread::_entry_func (arg=0xa6fc780) at
/usr/srcs/Ceph/work/ceph/src/common/Thread.cc:69
#5  0x00000008020bc7e9 in thread_start (curthread=0xa961200) at
/usr/srcs/head/src/lib/libthr/thread/thr_create.c:288
#6  0x0000000000000000 in ?? ()
Backtrace stopped: Cannot access memory at address 0x7fffdebf4000

Thread 7 (LWP 101504 of process 14361):
#0  0x000000080602b9aa in _poll () from /lib/libc.so.7
#1  0x00000008020c0783 in __thr_poll (fds=0x7fffdedf4bb8, nfds=1,
timeout=-1) at /usr/srcs/head/src/lib/libthr/thread/thr_syscalls.c:306
#2  0x0000000001567731 in Accepter::entry (this=0xa816698) at
/usr/srcs/Ceph/work/ceph/src/msg/simple/Accepter.cc:248
#3  0x00000000013e9466 in Thread::entry_wrapper (this=0xa816698) at
/usr/srcs/Ceph/work/ceph/src/common/Thread.cc:89
#4  0x00000000013e9385 in Thread::_entry_func (arg=0xa816698) at
/usr/srcs/Ceph/work/ceph/src/common/Thread.cc:69
#5  0x00000008020bc7e9 in thread_start (curthread=0xa960d80) at
/usr/srcs/head/src/lib/libthr/thread/thr_create.c:288
#6  0x0000000000000000 in ?? ()
Backtrace stopped: Cannot access memory at address 0x7fffdedf5000

Thread 4 (LWP 100736 of process 14361):
#0  0x000000080602b9aa in _poll () from /lib/libc.so.7
#1  0x00000008020c0783 in __thr_poll (fds=0x7fffdf9fadd0, nfds=2,
timeout=-1) at /usr/srcs/head/src/lib/libthr/thread/thr_syscalls.c:306
#2  0x0000000001063937 in AdminSocket::entry (this=0xa7aa000) at
/usr/srcs/Ceph/work/ceph/src/common/admin_socket.cc:267
#3  0x00000000013e9466 in Thread::entry_wrapper (this=0xa7aa000) at
/usr/srcs/Ceph/work/ceph/src/common/Thread.cc:89
#4  0x00000000013e9385 in Thread::_entry_func (arg=0xa7aa000) at
/usr/srcs/Ceph/work/ceph/src/common/Thread.cc:69
#5  0x00000008020bc7e9 in thread_start (curthread=0xa75b180) at
/usr/srcs/head/src/lib/libthr/thread/thr_create.c:288
#6  0x0000000000000000 in ?? ()
Backtrace stopped: Cannot access memory at address 0x7fffdf9fb000



