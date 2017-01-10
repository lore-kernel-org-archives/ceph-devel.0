From: Sage Weil <sage@newdream.net>
Subject: Re: Pipe "deadlock" in Hammer, 0.94.5
Date: Tue, 10 Jan 2017 13:11:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701101309140.5745@piezo.novalocal>
References: <23B01353C2E80240BBE34865782DFE0131A292BD@EX02.corp.qihoo.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1993995432-1484053897=:5745"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37441 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759474AbdAJNLi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jan 2017 08:11:38 -0500
In-Reply-To: <23B01353C2E80240BBE34865782DFE0131A292BD@EX02.corp.qihoo.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?0O3Rqbqu?= <xuxuehan@360.cn>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1993995432-1484053897=:5745
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 10 Jan 2017, 许雪寒 wrote:
> Hi, everyone.
> 
> Recently, we did some experiment to test the stability of the ceph cluster. We used Hammer version which is the mostly used version of online cluster. One of the scenarios that we simulated is poor network connectivity, in which we used iptables to drop TCP/IP packet under some probability. And sometimes, we can see that some OSD suicide themselves. 
> 
> We used gdb to debug the core dumped by linux. We found that the thread that hit the suicide time threshold is a peering thread who is trying to send a pg_notify message, the ceph-osd log file and gdb output is as follows:
> 
> Log file:
>     -3> 2017-01-10 17:02:13.469949 7fd446ff7700  1 heartbeat_map is_healthy 'OSD::osd_tp thread 0x7fd440bed700' had timed out after 15
>     -2> 2017-01-10 17:02:13.469952 7fd446ff7700  1 heartbeat_map is_healthy 'OSD::osd_tp thread 0x7fd440bed700' had suicide timed out after 150
>     -1> 2017-01-10 17:02:13.469954 7fd4451f4700  1 -- 10.160.132.157:6818/10014122 <== osd.20 10.160.132.156:0/24908 163 ==== osd_ping(ping e4030 stamp 2017-01-10 17:02:13.450374) v2 ==== 47+0+0 (3247646131 0 0) 0x7fd418ca8600 con 0x7fd413c89700
>      0> 2017-01-10 17:02:13.496895 7fd446ff7700 -1 error_msg common/HeartbeatMap.cc: In function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*, time_t)' thread 7fd446ff7700 time 2017-01-10 17:02:13.469969
> common/HeartbeatMap.cc: 79: FAILED assert(0 == "hit suicide timeout")
> 
> GDB OUTPUT:
> (gdb) thread 8
> [Switching to thread 8 (Thread 0x7fd440bed700 (LWP 15302))]#0  0x0000003c5d80e334 in __lll_lock_wait () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x0000003c5d80e334 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x0000003c5d8095d8 in _L_lock_854 () from /lib64/libpthread.so.0
> #2  0x0000003c5d8094a7 in pthread_mutex_lock () from /lib64/libpthread.so.0
> #3  0x0000000001a54ae4 in Mutex::Lock (this=0x7fd426453598, no_lockdep=false) at common/Mutex.cc:96
> #4  0x0000000001409285 in Mutex::Locker::Locker (this=0x7fd440beb6c0, m=...) at common/Mutex.h:115
> #5  0x0000000001c46446 in PipeConnection::try_get_pipe (this=0x7fd426453580, p=0x7fd440beb908) at msg/simple/PipeConnection.cc:38
> #6  0x0000000001c05809 in SimpleMessenger::submit_message (this=0x7fd482029400, m=0x7fd425538d00, con=0x7fd426453580, dest_addr=..., dest_type=4, already_locked=false) at msg/simple/SimpleMessenger.cc:443
> #7  0x0000000001c033fa in SimpleMessenger::_send_message (this=0x7fd482029400, m=0x7fd425538d00, con=0x7fd426453580) at msg/simple/SimpleMessenger.cc:136
> #8  0x0000000001c467c7 in SimpleMessenger::send_message (this=0x7fd482029400, m=0x7fd425538d00, con=0x7fd426453580) at msg/simple/SimpleMessenger.h:139
> #9  0x0000000001c466a1 in PipeConnection::send_message (this=0x7fd426453580, m=0x7fd425538d00) at msg/simple/PipeConnection.cc:78
> #10 0x00000000013b3ff2 in OSDService::send_map (this=0x7fd4821e76c8, m=0x7fd425538d00, con=0x7fd426453580) at osd/OSD.cc:1054
> #11 0x00000000013b45e7 in OSDService::send_incremental_map (this=0x7fd4821e76c8, since=4028, con=0x7fd426453580, osdmap=std::tr1::shared_ptr (count 49) 0x7fd426c0f480) at osd/OSD.cc:1087
> #12 0x00000000013b215f in OSDService::share_map_peer (this=0x7fd4821e76c8, peer=9, con=0x7fd426453580, map=std::tr1::shared_ptr (count 49) 0x7fd426c0f480) at osd/OSD.cc:887
> #13 0x00000000013f43cc in OSD::do_notifies (this=0x7fd4821e6000, notify_list=std::map with 7 elements = {...}, curmap=std::tr1::shared_ptr (count 49) 0x7fd426c0f480) at osd/OSD.cc:7246
> #14 0x00000000013f3c99 in OSD::dispatch_context (this=0x7fd4821e6000, ctx=..., pg=0x0, curmap=std::tr1::shared_ptr (count 49) 0x7fd426c0f480, handle=0x7fd440becb40) at osd/OSD.cc:7198
> #15 0x000000000140043e in OSD::process_peering_events (this=0x7fd4821e6000, pgs=std::list = {...}, handle=...) at osd/OSD.cc:8539
> #16 0x000000000141e094 in OSD::PeeringWQ::_process (this=0x7fd4821e7070, pgs=std::list = {...}, handle=...) at osd/OSD.h:1601
> #17 0x00000000014b94bf in ThreadPool::BatchWorkQueue<PG>::_void_process (this=0x7fd4821e7070, p=0x7fd425419040, handle=...) at common/WorkQueue.h:107
> #18 0x0000000001b2d2e8 in ThreadPool::worker (this=0x7fd4821e64b0, wt=0x7fd4761db430) at common/WorkQueue.cc:128
> #19 0x0000000001b313f7 in ThreadPool::WorkThread::entry (this=0x7fd4761db430) at common/WorkQueue.h:318
> #20 0x0000000001b33d40 in Thread::entry_wrapper (this=0x7fd4761db430) at common/Thread.cc:61
> #21 0x0000000001b33cb2 in Thread::_entry_func (arg=0x7fd4761db430) at common/Thread.cc:45
> #22 0x0000003c5d807aa1 in start_thread () from /lib64/libpthread.so.0
> #23 0x0000003c5d4e8aad in clone () from /lib64/libc.so.6
> 
> And the thread that is holding the mutex lock which this thread is trying to get is a pipe reader_thread who is trying to read a full message that sent from another OSD:
> 
> (gdb) frame 2
> #2  0x0000003c5d8094a7 in pthread_mutex_lock () from /lib64/libpthread.so.0
> (gdb) info reg
> rax            0xfffffffffffffe00            -512
> rbx            0x7fd425538d00             140549136026880
> rcx            0xffffffffffffffff               -1
> rdx            0x10    16
> rsi            0x80      128
> rdi            0x7fd4264535a8              140549151864232
> rbp            0x7fd440beb680            0x7fd440beb680
> rsp            0x7fd440beb648            0x7fd440beb648
> r8             0x7fd4264535a8               140549151864232
> r9             0x3bc6 15302
> r10            0x1       1
> r11            0x246  582
> r12            0x4       4
> r13            0x7fd440bed9c0             140549596043712
> r14            0x0       0
> r15            0x3       3
> rip            0x3c5d8094a7   0x3c5d8094a7 <pthread_mutex_lock+55>
> eflags         0x246               [ PF ZF IF ]
> cs             0x33      51
> ss             0x2b     43
> ds             0x0       0
> es             0x0       0
> fs             0x0        0
> gs             0x0        0
> (gdb) p *(pthread_mutex_t*)0x7fd4264535a8
> $4 = {__data = {__lock = 2, __count = 0, __owner = 5008, __nusers = 1, __kind = 2, __spins = 0, __list = {__prev = 0x0, __next = 0x0}}, __size = "\002\000\000\000\000\000\000\000\220\023\000\000\001\000\000\000\002", '\000' <repeats 22 times>, __align = 2}
> (gdb) thread 50
> [Switching to thread 50 (Thread 0x7fd4001f1700 (LWP 5008))]#0  0x0000003c5d80ec2c in recv () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x0000003c5d80ec2c in recv () from /lib64/libpthread.so.0
> #1  0x0000000001c3a6f8 in Pipe::do_recv (this=0x7fd426561000, buf=0x7fd42649c000 "\a\220\006", len=4096, flags=64) at msg/simple/Pipe.cc:2428
> #2  0x0000000001c3aa4d in Pipe::buffered_recv (this=0x7fd426561000, buf=0x7fd4224c01d3 "", len=4096, flags=64) at msg/simple/Pipe.cc:2474
> #3  0x0000000001c3ab0d in Pipe::tcp_read_nonblocking (this=0x7fd426561000, buf=0x7fd4224c0000 "\t\to\030", len=4096) at msg/simple/Pipe.cc:2492

It's supposed to be a non-blocking read, so in principle this shouldn't 
block and hold the lock.

I suspect what you're seeing is a variation of #14120, fixed by 
63e44e32974c9bae17bb1bfd4261dcb024ad845c.

How reproducible is this?  We can push a build that includes the fix, but 
it would be nice to have some confirmation that it is the right one since 
so far this has been a very rare case.

Thanks!
sage


> #4  0x0000000001c37a25 in Pipe::read_message (this=0x7fd426561000, pm=0x7fd4001f0b80, auth_handler=0x7fd422481080) at msg/simple/Pipe.cc:2032
> #5  0x0000000001c33146 in Pipe::reader (this=0x7fd426561000) at msg/simple/Pipe.cc:1581
> #6  0x0000000001c3b0c8 in Pipe::Reader::entry (this=0x7fd426561018) at msg/simple/Pipe.h:50
> #7  0x0000000001b33d40 in Thread::entry_wrapper (this=0x7fd426561018) at common/Thread.cc:61
> #8  0x0000000001b33cb2 in Thread::_entry_func (arg=0x7fd426561018) at common/Thread.cc:45
> #9  0x0000003c5d807aa1 in start_thread () from /lib64/libpthread.so.0
> #10 0x0000003c5d4e8aad in clone () from /lib64/libc.so.6
> 
> Because we are dropping a large amount of ip packets, so we think the “recv” call is blocked for a long time, which led to the suicide timeout.
> 
> We read the source code, and found that the lock that directly made the thread hit suicide timeout is Connection::lock. Why is this lock used in both the submit_message and read_message?  Is it supposed to be this way?
> 
> Please help me, thank you☺
> 
> 
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-1993995432-1484053897=:5745--
