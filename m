From: Padmanabh Ratnakar <padmanabh.ratnakar@snapdeal.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogUGlwZSAiZGVhZGxvY2siIGluIEhhbW1lciwgMC45NC41?=
Date: Thu, 19 Jan 2017 04:47:58 +0530
Message-ID: <CAC+4SSin66OQerYzGTzKV0J66GDwEYAi1Ek8EB+iTDSVyphbJQ@mail.gmail.com>
References: <23B01353C2E80240BBE34865782DFE0131A292BD@EX02.corp.qihoo.net>
 <alpine.DEB.2.11.1701101309140.5745@piezo.novalocal> <23B01353C2E80240BBE34865782DFE0131A2AAE0@EX02.corp.qihoo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f174.google.com ([209.85.213.174]:36767 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdARX1b (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2017 18:27:31 -0500
Received: by mail-yb0-f174.google.com with SMTP id 123so9140694ybe.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2017 15:27:04 -0800 (PST)
In-Reply-To: <23B01353C2E80240BBE34865782DFE0131A2AAE0@EX02.corp.qihoo.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6K646Zuq5a+S?= <xuxuehan@360.cn>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
       Fix 63e44e32974c9bae17bb1bfd4261dcb024ad845c is not pulled in v10.2.=
5.
Any reasons for this. Is it recommended to pull this fix in our deployments=
.

Thanks,
Padmanabh

On Wed, Jan 11, 2017 at 3:59 PM, =E8=AE=B8=E9=9B=AA=E5=AF=92 <xuxuehan@360.=
cn> wrote:
> In our test, when one machine is under heavy packet loss, OSDs on other m=
achines can be brought down and sometimes more than one OSD go down, becaus=
e they may try to read a message that comes from that machine. So we are re=
ally concerned, please help us. Thanks
>
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: =E8=AE=B8=E9=9B=AA=E5=AF=92
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2017=E5=B9=B41=E6=9C=8811=E6=97=A5 =
15:13
> =E6=94=B6=E4=BB=B6=E4=BA=BA: 'Sage Weil'
> =E6=8A=84=E9=80=81: ceph-devel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: =E7=AD=94=E5=A4=8D: Pipe "deadlock" in Hammer, 0.94.5
>
> Thanks for your reply, sir:-)
>
> Actually, this case is not very rare in our test. When iptables drop ip p=
ackets with the probability around 98%~99%, this case occurs about every th=
ree times our test runs.
> I checked #14120 as you recommended, however, it doesn't seem to be our p=
roblem. Because, as http://tracker.ceph.com/issues/18184 says, #14120 is ca=
used by a commit that changed Pipe::tcp_read_wait() to return -errno instea=
d of "-1" and this commit is not applied in our tested hammer verion(0.94.5=
).
> And I truly agree with you in that the invocation of "recv" function pass=
es MSG_DONTWAIT flag, so it shouldn't block, however, every time we encount=
er this problem it's always the Pipe::reader_thread who's calling recv that=
 hold the lock when suicide happens, this is really confusing.
>
> Please help us, thank you:-)
>
>
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Sage Weil [mailto:sage@newdream.net]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2017=E5=B9=B41=E6=9C=8810=E6=97=A5 =
21:12
> =E6=94=B6=E4=BB=B6=E4=BA=BA: =E8=AE=B8=E9=9B=AA=E5=AF=92
> =E6=8A=84=E9=80=81: ceph-devel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: Pipe "deadlock" in Hammer, 0.94.5
>
> On Tue, 10 Jan 2017, =E8=AE=B8=E9=9B=AA=E5=AF=92 wrote:
>> Hi, everyone.
>>
>> Recently, we did some experiment to test the stability of the ceph clust=
er. We used Hammer version which is the mostly used version of online clust=
er. One of the scenarios that we simulated is poor network connectivity, in=
 which we used iptables to drop TCP/IP packet under some probability. And s=
ometimes, we can see that some OSD suicide themselves.
>>
>> We used gdb to debug the core dumped by linux. We found that the thread =
that hit the suicide time threshold is a peering thread who is trying to se=
nd a pg_notify message, the ceph-osd log file and gdb output is as follows:
>>
>> Log file:
>>     -3> 2017-01-10 17:02:13.469949 7fd446ff7700  1 heartbeat_map
>> is_healthy 'OSD::osd_tp thread 0x7fd440bed700' had timed out after 15
>>     -2> 2017-01-10 17:02:13.469952 7fd446ff7700  1 heartbeat_map
>> is_healthy 'OSD::osd_tp thread 0x7fd440bed700' had suicide timed out
>> after 150
>>     -1> 2017-01-10 17:02:13.469954 7fd4451f4700  1 --
>> 10.160.132.157:6818/10014122 <=3D=3D osd.20 10.160.132.156:0/24908 163
>> =3D=3D=3D=3D osd_ping(ping e4030 stamp 2017-01-10 17:02:13.450374) v2 =
=3D=3D=3D=3D
>> 47+0+0 (3247646131 0 0) 0x7fd418ca8600 con 0x7fd413c89700
>>      0> 2017-01-10 17:02:13.496895 7fd446ff7700 -1 error_msg
>> common/HeartbeatMap.cc: In function 'bool
>> ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
>> time_t)' thread 7fd446ff7700 time 2017-01-10 17:02:13.469969
>> common/HeartbeatMap.cc: 79: FAILED assert(0 =3D=3D "hit suicide timeout"=
)
>>
>> GDB OUTPUT:
>> (gdb) thread 8
>> [Switching to thread 8 (Thread 0x7fd440bed700 (LWP 15302))]#0
>> 0x0000003c5d80e334 in __lll_lock_wait () from /lib64/libpthread.so.0
>> (gdb) bt
>> #0  0x0000003c5d80e334 in __lll_lock_wait () from
>> /lib64/libpthread.so.0
>> #1  0x0000003c5d8095d8 in _L_lock_854 () from /lib64/libpthread.so.0
>> #2  0x0000003c5d8094a7 in pthread_mutex_lock () from
>> /lib64/libpthread.so.0
>> #3  0x0000000001a54ae4 in Mutex::Lock (this=3D0x7fd426453598,
>> no_lockdep=3Dfalse) at common/Mutex.cc:96
>> #4  0x0000000001409285 in Mutex::Locker::Locker (this=3D0x7fd440beb6c0,
>> m=3D...) at common/Mutex.h:115
>> #5  0x0000000001c46446 in PipeConnection::try_get_pipe
>> (this=3D0x7fd426453580, p=3D0x7fd440beb908) at
>> msg/simple/PipeConnection.cc:38
>> #6  0x0000000001c05809 in SimpleMessenger::submit_message
>> (this=3D0x7fd482029400, m=3D0x7fd425538d00, con=3D0x7fd426453580,
>> dest_addr=3D..., dest_type=3D4, already_locked=3Dfalse) at
>> msg/simple/SimpleMessenger.cc:443
>> #7  0x0000000001c033fa in SimpleMessenger::_send_message
>> (this=3D0x7fd482029400, m=3D0x7fd425538d00, con=3D0x7fd426453580) at
>> msg/simple/SimpleMessenger.cc:136
>> #8  0x0000000001c467c7 in SimpleMessenger::send_message
>> (this=3D0x7fd482029400, m=3D0x7fd425538d00, con=3D0x7fd426453580) at
>> msg/simple/SimpleMessenger.h:139
>> #9  0x0000000001c466a1 in PipeConnection::send_message
>> (this=3D0x7fd426453580, m=3D0x7fd425538d00) at
>> msg/simple/PipeConnection.cc:78
>> #10 0x00000000013b3ff2 in OSDService::send_map (this=3D0x7fd4821e76c8,
>> m=3D0x7fd425538d00, con=3D0x7fd426453580) at osd/OSD.cc:1054
>> #11 0x00000000013b45e7 in OSDService::send_incremental_map
>> (this=3D0x7fd4821e76c8, since=3D4028, con=3D0x7fd426453580,
>> osdmap=3Dstd::tr1::shared_ptr (count 49) 0x7fd426c0f480) at
>> osd/OSD.cc:1087
>> #12 0x00000000013b215f in OSDService::share_map_peer
>> (this=3D0x7fd4821e76c8, peer=3D9, con=3D0x7fd426453580,
>> map=3Dstd::tr1::shared_ptr (count 49) 0x7fd426c0f480) at osd/OSD.cc:887
>> #13 0x00000000013f43cc in OSD::do_notifies (this=3D0x7fd4821e6000,
>> notify_list=3Dstd::map with 7 elements =3D {...},
>> curmap=3Dstd::tr1::shared_ptr (count 49) 0x7fd426c0f480) at
>> osd/OSD.cc:7246
>> #14 0x00000000013f3c99 in OSD::dispatch_context (this=3D0x7fd4821e6000,
>> ctx=3D..., pg=3D0x0, curmap=3Dstd::tr1::shared_ptr (count 49)
>> 0x7fd426c0f480, handle=3D0x7fd440becb40) at osd/OSD.cc:7198
>> #15 0x000000000140043e in OSD::process_peering_events
>> (this=3D0x7fd4821e6000, pgs=3Dstd::list =3D {...}, handle=3D...) at
>> osd/OSD.cc:8539
>> #16 0x000000000141e094 in OSD::PeeringWQ::_process
>> (this=3D0x7fd4821e7070, pgs=3Dstd::list =3D {...}, handle=3D...) at
>> osd/OSD.h:1601
>> #17 0x00000000014b94bf in
>> ThreadPool::BatchWorkQueue<PG>::_void_process (this=3D0x7fd4821e7070,
>> p=3D0x7fd425419040, handle=3D...) at common/WorkQueue.h:107
>> #18 0x0000000001b2d2e8 in ThreadPool::worker (this=3D0x7fd4821e64b0,
>> wt=3D0x7fd4761db430) at common/WorkQueue.cc:128
>> #19 0x0000000001b313f7 in ThreadPool::WorkThread::entry
>> (this=3D0x7fd4761db430) at common/WorkQueue.h:318
>> #20 0x0000000001b33d40 in Thread::entry_wrapper (this=3D0x7fd4761db430)
>> at common/Thread.cc:61
>> #21 0x0000000001b33cb2 in Thread::_entry_func (arg=3D0x7fd4761db430) at
>> common/Thread.cc:45
>> #22 0x0000003c5d807aa1 in start_thread () from /lib64/libpthread.so.0
>> #23 0x0000003c5d4e8aad in clone () from /lib64/libc.so.6
>>
>> And the thread that is holding the mutex lock which this thread is tryin=
g to get is a pipe reader_thread who is trying to read a full message that =
sent from another OSD:
>>
>> (gdb) frame 2
>> #2  0x0000003c5d8094a7 in pthread_mutex_lock () from
>> /lib64/libpthread.so.0
>> (gdb) info reg
>> rax            0xfffffffffffffe00            -512 rbx
>> 0x7fd425538d00             140549136026880 rcx 0xffffffffffffffff
>> -1 rdx            0x10    16 rsi
>> 0x80      128 rdi            0x7fd4264535a8
>> 140549151864232 rbp            0x7fd440beb680
>> 0x7fd440beb680 rsp            0x7fd440beb648            0x7fd440beb648
>> r8             0x7fd4264535a8               140549151864232
>> r9             0x3bc6 15302
>> r10            0x1       1
>> r11            0x246  582
>> r12            0x4       4
>> r13            0x7fd440bed9c0             140549596043712
>> r14            0x0       0
>> r15            0x3       3
>> rip            0x3c5d8094a7   0x3c5d8094a7 <pthread_mutex_lock+55>
>> eflags         0x246               [ PF ZF IF ] cs             0x33
>> 51 ss             0x2b     43 ds             0x0       0 es
>> 0x0       0 fs             0x0        0 gs             0x0        0
>> (gdb) p *(pthread_mutex_t*)0x7fd4264535a8
>> $4 =3D {__data =3D {__lock =3D 2, __count =3D 0, __owner =3D 5008, __nus=
ers =3D 1,
>> __kind =3D 2, __spins =3D 0, __list =3D {__prev =3D 0x0, __next =3D 0x0}=
},
>> __size =3D
>> "\002\000\000\000\000\000\000\000\220\023\000\000\001\000\000\000\002"
>> , '\000' <repeats 22 times>, __align =3D 2}
>> (gdb) thread 50
>> [Switching to thread 50 (Thread 0x7fd4001f1700 (LWP 5008))]#0
>> 0x0000003c5d80ec2c in recv () from /lib64/libpthread.so.0
>> (gdb) bt
>> #0  0x0000003c5d80ec2c in recv () from /lib64/libpthread.so.0
>> #1  0x0000000001c3a6f8 in Pipe::do_recv (this=3D0x7fd426561000,
>> buf=3D0x7fd42649c000 "\a\220\006", len=3D4096, flags=3D64) at
>> msg/simple/Pipe.cc:2428
>> #2  0x0000000001c3aa4d in Pipe::buffered_recv (this=3D0x7fd426561000,
>> buf=3D0x7fd4224c01d3 "", len=3D4096, flags=3D64) at msg/simple/Pipe.cc:2=
474
>> #3  0x0000000001c3ab0d in Pipe::tcp_read_nonblocking
>> (this=3D0x7fd426561000, buf=3D0x7fd4224c0000 "\t\to\030", len=3D4096) at
>> msg/simple/Pipe.cc:2492
>
> It's supposed to be a non-blocking read, so in principle this shouldn't b=
lock and hold the lock.
>
> I suspect what you're seeing is a variation of #14120, fixed by 63e44e329=
74c9bae17bb1bfd4261dcb024ad845c.
>
> How reproducible is this?  We can push a build that includes the fix, but=
 it would be nice to have some confirmation that it is the right one since =
so far this has been a very rare case.
>
> Thanks!
> sage
>
>
>> #4  0x0000000001c37a25 in Pipe::read_message (this=3D0x7fd426561000,
>> pm=3D0x7fd4001f0b80, auth_handler=3D0x7fd422481080) at
>> msg/simple/Pipe.cc:2032
>> #5  0x0000000001c33146 in Pipe::reader (this=3D0x7fd426561000) at
>> msg/simple/Pipe.cc:1581
>> #6  0x0000000001c3b0c8 in Pipe::Reader::entry (this=3D0x7fd426561018) at
>> msg/simple/Pipe.h:50
>> #7  0x0000000001b33d40 in Thread::entry_wrapper (this=3D0x7fd426561018)
>> at common/Thread.cc:61
>> #8  0x0000000001b33cb2 in Thread::_entry_func (arg=3D0x7fd426561018) at
>> common/Thread.cc:45
>> #9  0x0000003c5d807aa1 in start_thread () from /lib64/libpthread.so.0
>> #10 0x0000003c5d4e8aad in clone () from /lib64/libc.so.6
>>
>> Because we are dropping a large amount of ip packets, so we think the =
=E2=80=9Crecv=E2=80=9D call is blocked for a long time, which led to the su=
icide timeout.
>>
>> We read the source code, and found that the lock that directly made the =
thread hit suicide timeout is Connection::lock. Why is this lock used in bo=
th the submit_message and read_message?  Is it supposed to be this way?
>>
>> Please help me, thank you=E2=98=BA
>>
>>
>> N?????r??y??????X??=C7=A7v???)=DE=BA{.n?????z?]z????ay? =CA=87=DA=99??j =
??f???h????? ?w???
> ???j:+v???w???????? ????zZ+???????j"????i
