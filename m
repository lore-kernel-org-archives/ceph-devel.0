From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Wierd deadlock in OSD
Date: Tue, 27 Sep 2016 10:00:27 +0800
Message-ID: <CABAwU-YRrGxmOzEA8XJLOHyt3jy3nMaV9kzMGfyz8uD5pMr2KQ@mail.gmail.com>
References: <CAFZHTObOfkHnsu11em+X6ivZ2fWEsOPbgaSnqn8kkgOTu6Q99A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36219 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932504AbcI0CA3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Sep 2016 22:00:29 -0400
Received: by mail-qk0-f179.google.com with SMTP id z190so189015004qkc.3
        for <ceph-devel@vger.kernel.org>; Mon, 26 Sep 2016 19:00:29 -0700 (PDT)
In-Reply-To: <CAFZHTObOfkHnsu11em+X6ivZ2fWEsOPbgaSnqn8kkgOTu6Q99A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeegn Chen <jeegnchen@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

hi, you can create an issue on website:
http://tracker.ceph.com/projects/ceph/issues
we have notice some osd_tp timeout suicide situation, maybe have the
same reason with your post.

2016-09-27 9:47 GMT+08:00 Jeegn Chen <jeegnchen@gmail.com>:
> Hi all,
>
> I noticed a deadlock phenomenon in Hammer OSD (Strictly speaking,
> starvation related to locks may be more precise since there is no lock
> circle).
> Although I found the threads locking each other, I have not figured
> out why they came to the state. Any hint will be appreciate.
>
> As you see in the following inspection through gdb
> * thread 11 has taken osd_lock but is waiting for heartbeat_lock
> * thread 37 has taken heartbeat_lock but is waiting for a PipeConnection'=
s lock
> * thread 286 has taken the PipeConnection's lock needed by thread 37,
> but it never returns from Pipe::tcp_read_nonblocking() to
> Pipe::read_message(); As a result, the PipeConnection's lock is never
> released by Pipe::read_message()
> * Since osd_lock and heartbeat_lock are reserved, most of the OSD's
> lock cannot move ahead and looks deadlock
>
> More detailed check on thread 286 shows that,EAGAIN error is always
> received when recv() is invoked in Pipe::do_recv(). Thus,
> Pipe::do_recv() logic retries forever, which is why
> Pipe::tcp_read_nonblocking() cannot finish.
>
> I examined the Pipe object with gdb  and know it is a connection from
> 192.168.30.41:63805 to 192.168.30.105:6805. So I used "lsof" and
> "netstat" to check both servers (See the result following the gdb
> content). It seems that 192.168.30.41:63805->192.168.30.105:6805 is
> still ESTABILISHED on 192.168.30.41 but the TCP connection does not
> exist in 192.168.30.105's perspective.
> My understanding is that even if a connection is half-closed on one
> side, recv() on the other side should return 0 and give no error. But
> why does recv() give EAGAIN constantly?
>
> Any idea on how this happen or any explanation? Some bug in kernel TCP
> stack (2.6.32)?
>
>
> (gdb) thread 11
> [Switching to thread 11 (Thread 0x7fcebcd2f700 (LWP 29061))]#0
> 0x00000032a260e334 in __lll_lock_wait () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x00000032a260e334 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00000032a26095d8 in _L_lock_854 () from /lib64/libpthread.so.0
> #2  0x00000032a26094a7 in pthread_mutex_lock () from /lib64/libpthread.so=
.0
> #3  0x0000000000c0ba3b in Mutex::Lock (this=3D0x5bb0ce8,
> no_lockdep=3DUnhandled dwarf expression opcode 0xf3) at
> common/Mutex.cc:91
> #4  0x0000000000795c29 in Locker (this=3D0x5bb0000) at common/Mutex.h:115
> #5  OSD::maybe_update_heartbeat_peers (this=3D0x5bb0000) at osd/OSD.cc:34=
32
> #6  0x00000000007bad13 in OSD::tick (this=3D0x5bb0000) at osd/OSD.cc:3863
> #7  0x00000000007cb299 in Context::complete (this=3D0x5988a60,
> r=3DUnhandled dwarf expression opcode 0xf3) at include/Context.h:65
> #8  0x0000000000c21bbf in SafeTimer::timer_thread (this=3D0x5bb0070) at
> common/Timer.cc:105
> #9  0x0000000000c2317d in SafeTimerThread::entry (this=3DUnhandled dwarf
> expression opcode 0xf3) at common/Timer.cc:38
> #10 0x00000032a2607aa1 in start_thread () from /lib64/libpthread.so.0
> #11 0x00000032a22e893d in clone () from /lib64/libc.so.6
> (gdb) frame 8
> #8  0x0000000000c21bbf in SafeTimer::timer_thread (this=3D0x5bb0070) at
> common/Timer.cc:105
> 105           callback->complete(0);
> (gdb) p &lock
> $1 =3D (Mutex *) 0x5bb0018
> (gdb) frame 5
> #5  OSD::maybe_update_heartbeat_peers (this=3D0x5bb0000) at osd/OSD.cc:34=
32
> 3432      Mutex::Locker l(heartbeat_lock);
> (gdb) p &heartbeat_lock
> $2 =3D (Mutex *) 0x5bb0ce8
>
> (gdb) thread 37
> [Switching to thread 37 (Thread 0x7fceaa4e4700 (LWP 29763))]#0
> 0x00000032a260e334 in __lll_lock_wait () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x00000032a260e334 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00000032a26095d8 in _L_lock_854 () from /lib64/libpthread.so.0
> #2  0x00000032a26094a7 in pthread_mutex_lock () from /lib64/libpthread.so=
.0
> #3  0x0000000000c0ba3b in Mutex::Lock (this=3D0x49c38b18,
> no_lockdep=3DUnhandled dwarf expression opcode 0xf3
> ) at common/Mutex.cc:91
> #4  0x0000000000ddeecb in Locker (this=3D0x49c38b00, p=3D0x7fceaa4e2c60)
> at common/Mutex.h:115
> #5  PipeConnection::try_get_pipe (this=3D0x49c38b00, p=3D0x7fceaa4e2c60)
> at msg/simple/PipeConnection.cc:38
> #6  0x0000000000db52dc in SimpleMessenger::submit_message
> (this=3D0x5aa8e00, m=3D0x2c6d0b40, con=3D0x49c38b00, dest_addr=3D...,
> dest_type=3D4, already_locked=3Dfalse)
>     at msg/simple/SimpleMessenger.cc:443
> #7  0x0000000000db5da7 in SimpleMessenger::_send_message
> (this=3D0x5aa8e00, m=3D0x2c6d0b40, con=3D0x49c38b00) at
> msg/simple/SimpleMessenger.cc:136
> #8  0x00000000007a27e0 in OSDService::send_incremental_map
> (this=3D0x5bb16c8, since=3D58626, con=3D0x49c38b00, osdmap=3DUnhandled dw=
arf
> expression opcode 0xf3
> ) at osd/OSD.cc:1087
> #9  0x00000000007a2a89 in OSDService::share_map_peer (this=3D0x5bb16c8,
> peer=3D28, con=3D0x49c38b00, map=3Dstd::tr1::shared_ptr (count 562)
> 0x5b367500) at osd/OSD.cc:887
> #10 0x00000000007a8324 in OSD::handle_osd_ping (this=3D0x5bb0000,
> m=3D0x6861f600) at osd/OSD.cc:3599
> #11 0x00000000007a8b2b in OSD::heartbeat_dispatch (this=3D0x5bb0000,
> m=3D0x6861f600) at osd/OSD.cc:5254
> #12 0x0000000000de07ab in ms_deliver_dispatch (this=3D0x5aa9dc8) at
> msg/Messenger.h:567
> #13 DispatchQueue::entry (this=3D0x5aa9dc8) at msg/simple/DispatchQueue.c=
c:185
> #14 0x0000000000db86dd in DispatchQueue::DispatchThread::entry
> (this=3DUnhandled dwarf expression opcode 0xf3
> ) at msg/simple/DispatchQueue.h:103
> #15 0x00000032a2607aa1 in start_thread () from /lib64/libpthread.so.0
> #16 0x00000032a22e893d in clone () from /lib64/libc.so.6
> (gdb) frame 10
> #10 0x00000000007a8324 in OSD::handle_osd_ping (this=3D0x5bb0000,
> m=3D0x6861f600) at osd/OSD.cc:3599
> 3599                service.share_map_peer(from, con.get());
> (gdb) p &heartbeat_lock
> $6 =3D (Mutex *) 0x5bb0ce8
> (gdb) frame 5
> #5  PipeConnection::try_get_pipe (this=3D0x49c38b00, p=3D0x7fceaa4e2c60)
> at msg/simple/PipeConnection.cc:38
> 38        Mutex::Locker l(lock);
> (gdb) p &lock
> $8 =3D (Mutex *) 0x49c38b18
> (gdb)
> (gdb) thread 286
> [Switching to thread 286 (Thread 0x7fce7a9d9700 (LWP 15873))]#0
> 0x00000032a260ec2c in recv () from /lib64/libpthread.so.0
> (gdb) bt
> #0  0x00000032a260ec2c in recv () from /lib64/libpthread.so.0
> #1  0x0000000000dc8724 in recv (this=3D0x52fec800,
>     buf=3D0xe27c000
> "\235\302=C3=B3H[\002\220R1\035\251\334,-(\353L\rJ\247\232i\210._j\001\37=
5\357\351U\211=E2=A4=B8}\322}8\250\\\374\325W\020f\237\037\314\300Ty\251-\3=
07%\277\ni\205\213\031\245\024\314=D2=82j\223\025\207\212Z`4\340E5!\016\006=
\227\064\320h\334*\224\204\061\037r\017=CA=8D\325\f/\202G\257\065&j%\"\222\=
027\064\204\322n\244\315K\220\354.i\255\206\004z\320M&j\\\200\256x=E2=90=9A=
|\343\r\237_\347Q\023I\261\216\315Y\202M\361\217Q\301\252\224\370$\330\370\=
354\334T\261\226\263E%!\245pC\262)\r%\031\244\061\262(u*{\325B\n\222\017QW*=
+\230\262\067\216\335~\224"...,
> len=3D4096, flags=3D64) at /usr/include/bits/socket2.h:45
> #2  Pipe::do_recv (this=3D0x52fec800,
>     buf=3D0xe27c000
> "\235\302=C3=B3H[\002\220R1\035\251\334,-(\353L\rJ\247\232i\210._j\001\37=
5\357\351U\211=E2=A4=B8}\322}8\250\\\374\325W\020f\237\037\314\300Ty\251-\3=
07%\277\ni\205\213\031\245\024\314=D2=82j\223\025\207\212Z`4\340E5!\016\006=
\227\064\320h\334*\224\204\061\037r\017=CA=8D\325\f/\202G\257\065&j%\"\222\=
027\064\204\322n\244\315K\220\354.i\255\206\004z\320M&j\\\200\256x=E2=90=9A=
|\343\r\237_\347Q\023I\261\216\315Y\202M\361\217Q\301\252\224\370$\330\370\=
354\334T\261\226\263E%!\245pC\262)\r%\031\244\061\262(u*{\325B\n\222\017QW*=
+\230\262\067\216\335~\224"...,
> len=3D4096, flags=3D64) at msg/simple/Pipe.cc:2430
> #3  0x0000000000dc8990 in Pipe::buffered_recv (this=3D0x52fec800,
> buf=3D0x4d29e3e1 "", len=3D3823, flags=3DUnhandled dwarf expression opcod=
e
> 0xf3
> ) at msg/simple/Pipe.cc:2476
> #4  0x0000000000dc8a90 in Pipe::tcp_read_nonblocking (this=3D0x52fec800,
> buf=3DUnhandled dwarf expression opcode 0xf3
> ) at msg/simple/Pipe.cc:2494
> #5  0x0000000000dc9b36 in Pipe::read_message (this=3D0x52fec800,
> pm=3D0x7fce7a9d8b98, auth_handler=3D0x5d22ef60) at msg/simple/Pipe.cc:203=
4
> #6  0x0000000000ddbcc7 in Pipe::reader (this=3D0x52fec800) at
> msg/simple/Pipe.cc:1581
> #7  0x0000000000dded6d in Pipe::Reader::entry (this=3DUnhandled dwarf
> expression opcode 0xf3
> ) at msg/simple/Pipe.h:50
> #8  0x00000032a2607aa1 in start_thread () from /lib64/libpthread.so.0
> #9  0x00000032a22e893d in clone () from /lib64/libc.so.6
> (gdb) frame 5
> #5  0x0000000000dc9b36 in Pipe::read_message (this=3D0x52fec800,
> pm=3D0x7fce7a9d8b98, auth_handler=3D0x5d22ef60) at msg/simple/Pipe.cc:203=
4
> 2034          int got =3D tcp_read_nonblocking(bp.c_str(), read);
> (gdb) p connection_state
> $3 =3D {px =3D 0x49c38b00}
> (gdb) p &((PipeConnection*)0x49c38b00)->lock
> $5 =3D (Mutex *) 0x49c38b18
> (gdb) p this->port
> $11 =3D 63805
> (gdb) p this->peer_type
> $12 =3D 4
> (gdb) printf "%d.%d.%d.%d\n",
> this->peer_addr.addr4.sin_addr.s_addr&0xFF,
> this->peer_addr.addr4.sin_addr.s_addr>>8&0xFF ,
> this->peer_addr.addr4.sin_addr.s_addr>>16&0xFF,
> this->peer_addr.addr4.sin_addr.s_addr>>24&0xFF
> 192.168.30.105
> (gdb) printf "%d\n", (this->peer_addr.addr4.sin_port<<8&0xFF00) |
> (this->peer_addr.addr4.sin_port>>8&0x00FF)
> 6805
>
>
> [root@192.168.30.41 ~]# lsof -i :63805
> COMMAND    PID USER   FD   TYPE    DEVICE SIZE/OFF NODE NAME
> ceph-osd 29007 root  647u  IPv4 150861496      0t0  TCP
> 192.168.30.41:63805->192.168.30.105:6805 (ESTABLISHED)
>
> [root@192.168.30.105 ~]# netstat -nap | grep 63805
> [root@192.168.30.105 ~]#
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Thank you!
HuangJun
