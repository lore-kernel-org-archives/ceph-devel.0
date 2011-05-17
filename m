From: Simon Tian <aixt2006@gmail.com>
Subject: operate one file in multi clients with libceph
Date: Tue, 17 May 2011 21:00:27 +0800
Message-ID: <BANLkTi=wd0+u774vRNDJZoXW_EoE9OP67Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47259 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab1EQNA3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 09:00:29 -0400
Received: by wya21 with SMTP id 21so354986wya.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 06:00:27 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

       When I write and read a file in client A, open with
ceph_open(test_path, O_RDWR|O_CREAT,0 ), and read the same file in
client B, with ceph_open(test_path, O_RDONLY, 0).  Client A and B are
running on different host.
       After a while, client A will throw a exception. This exception
appear every time.

       The back trace in ceph is:

(gdb) bt
#0  0x000000367fa30265 in raise () from /lib64/libc.so.6
#1  0x000000367fa31d10 in abort () from /lib64/libc.so.6
#2  0x0000003682ebec44 in __gnu_cxx::__verbose_terminate_handler() ()
from /usr/lib64/libstdc++.so.6
#3  0x0000003682ebcdb6 in ?? () from /usr/lib64/libstdc++.so.6
#4  0x0000003682ebcde3 in std::terminate() () from /usr/lib64/libstdc++.so.6
#5  0x0000003682ebceca in __cxa_throw () from /usr/lib64/libstdc++.so.6
#6  0x00007ffff7c51a78 in ceph::__ceph_assert_fail
(assertion=0x7ffff7ce0a1c "r == 0", file=0x7ffff7ce0a02
"common/Mutex.h", line=118,
    func=0x7ffff7ce0ca0 "void Mutex::Lock(bool)") at common/assert.cc:86
#7  0x00007ffff7b1ee1c in Mutex::Lock (this=0x6293f0,
no_lockdep=false) at common/Mutex.h:118
#8  0x00007ffff7b395f4 in Client::sync_write_commit (this=0x629090,
in=0x7ffff0001b50) at client/Client.cc:4979
#9  0x00007ffff7baf304 in C_Client_SyncCommit::finish
(this=0x7ffff3206300) at client/Client.cc:4973
#10 0x00007ffff7c951d5 in Objecter::handle_osd_op_reply
(this=0x62b420, m=0x632190) at osdc/Objecter.cc:806
#11 0x00007ffff7b56038 in Client::ms_dispatch (this=0x629090,
m=0x632190) at client/Client.cc:1414
#12 0x00007ffff7bcb01d in Messenger::ms_deliver_dispatch
(this=0x628350, m=0x632190) at msg/Messenger.h:98
#13 0x00007ffff7bb262b in SimpleMessenger::dispatch_entry
(this=0x628350) at msg/SimpleMessenger.cc:352
#14 0x00007ffff7b22641 in SimpleMessenger::DispatchThread::entry
(this=0x6287d8) at msg/SimpleMessenger.h:533
#15 0x00007ffff7b5aa28 in Thread::_entry_func (arg=0x6287d8) at
./common/Thread.h:41
#16 0x00000036802064a7 in start_thread () from /lib64/libpthread.so.0
#17 0x000000367fad3c2d in clone () from /lib64/libc.so.6

So is there any way to avoid this?


Thx!
Simon
