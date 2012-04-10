From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: pgs stuck inactive
Date: Tue, 10 Apr 2012 14:49:57 -0700
Message-ID: <CACLRD_2hHbKFVjSDFHG-z=Sy5wgHDHz6=NWx9mEw51PMLVF7Ng@mail.gmail.com>
References: <CAFtEh-dcEKQ2AzcVmu1G5i-zFHgim5SLZvEmNtDsvkHt+JnzLA@mail.gmail.com>
	<CACLRD_2yhpoUGoivHQpp-LyO82MdTz5SpD0MN5b_vEoqSGBzgg@mail.gmail.com>
	<CAFtEh-dsM_G5GCyqnnBVfAc7GmKZLZcLzkQzrCAGjDgyLC3CGg@mail.gmail.com>
	<CACLRD_1NiFHjx_PZxokVBkADG0z+A61Sj57NJFyYF_vM=ZKSbA@mail.gmail.com>
	<CAFtEh-dLfUYpSbUJamReXB2e1JHm0b55HPs-h1wjCXym-cmHyA@mail.gmail.com>
	<CACLRD_3ccxvLiHxEHMBK+Q+2Ag41a+M07NofU9+Z8Fr06vvvfA@mail.gmail.com>
	<CAFtEh-evVi0q8CZmbPJX_WaCD_y2E=RBf6nNu13106E8hopk5A@mail.gmail.com>
	<CACLRD_3hqoOqbZWnyft3B+pEaPG=pmiDt5HeQASUC=OPS-uA7Q@mail.gmail.com>
	<CAFtEh-dnR0zu=ct-gG0L+76BTYHVFimjFKNhHjnDNZWA=Scs1g@mail.gmail.com>
	<CACLRD_1pf3ezZKAvEuub5PN1=cMESvnuTOVh_45NYc4T5hcPhA@mail.gmail.com>
	<CAFtEh-cx2by6yG_xiQbq5e2fbViOWyHoaOLFPBCZgX7x-7gwFA@mail.gmail.com>
	<CACLRD_0UrwKJuELiZqrL7Q_5AjB1EvOd5gqLRzrxw_7AFMcjxg@mail.gmail.com>
	<CAFtEh-fwt9BwZ7NwZaJVnwq3hgzvkrb1XvKT0uF81vePRcu7oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51273 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab2DJVt7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Apr 2012 17:49:59 -0400
Received: by wgbdr13 with SMTP id dr13so237134wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Apr 2012 14:49:58 -0700 (PDT)
In-Reply-To: <CAFtEh-fwt9BwZ7NwZaJVnwq3hgzvkrb1XvKT0uF81vePRcu7oA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: ceph-devel@vger.kernel.org

Nothing apparent from the backtrace.  I need monitor logs from when
the osd is sending pg_temp requests.  Can you restart the osd and post
the osd and all three monitor logs from when you restarted the osd?
You'll have to enable monitor logging on all three.
-Sam

On Tue, Apr 10, 2012 at 4:34 AM, Damien Churchill <damoxc@gmail.com> wr=
ote:
> Okay done that now:
>
> (gdb) thread apply all bt
>
> Thread 61 (Thread 0x7fb5cb00c700 (LWP 12771)):
> #0 =C2=A00x00007fb5cccdf3f1 in sem_timedwait ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x00000000006981f7 in CephContextServiceThread::entry (this=3D=
0x2b52bc0)
> =C2=A0 =C2=A0at common/ceph_context.cc:53
> #2 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #3 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #4 =C2=A00x0000000000000000 in ?? ()
>
> Thread 60 (Thread 0x7fb5ca80b700 (LWP 12774)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000068abf9 in AdminSocket::entry (this=3D0x2b5c000)
> =C2=A0 =C2=A0at common/admin_socket.cc:211
> #2 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #3 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #4 =C2=A00x0000000000000000 in ?? ()
>
> Thread 59 (Thread 0x7fb5c5801700 (LWP 12831)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000067060e in SimpleMessenger::Accepter::entry (this=
=3D0x2b496b8)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:209
> #2 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #3 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #4 =C2=A00x0000000000000000 in ?? ()
>
> Thread 58 (Thread 0x7fb5c6002700 (LWP 12832)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000672aba in Wait (mutex=3D..., this=3D0x2b49aa0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::reaper_entry (this=3D0x2b49680)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:2336
> #3 =C2=A00x000000000052122d in SimpleMessenger::ReaperThread::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:522
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 57 (Thread 0x7fb5c6803700 (LWP 12833)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000672aba in Wait (mutex=3D..., this=3D0x2b491a0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::reaper_entry (this=3D0x2b48d80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:2336
> #3 =C2=A00x000000000052122d in SimpleMessenger::ReaperThread::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:522
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 56 (Thread 0x7fb5c9008700 (LWP 12834)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000067060e in SimpleMessenger::Accepter::entry (this=
=3D0x2b49b38)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:209
> #2 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #3 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #4 =C2=A00x0000000000000000 in ?? ()
>
> Thread 55 (Thread 0x7fb5ca00a700 (LWP 12835)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000672aba in Wait (mutex=3D..., this=3D0x2b49f20)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::reaper_entry (this=3D0x2b49b00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:2336
> #3 =C2=A00x000000000052122d in SimpleMessenger::ReaperThread::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:522
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 54 (Thread 0x7fb5c9809700 (LWP 12836)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000067060e in SimpleMessenger::Accepter::entry (this=
=3D0x2b49238)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:209
> #2 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #3 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #4 =C2=A00x0000000000000000 in ?? ()
>
> Thread 53 (Thread 0x7fb5c8807700 (LWP 12837)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000672aba in Wait (mutex=3D..., this=3D0x2b49620)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::reaper_entry (this=3D0x2b49200)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:2336
> #3 =C2=A00x000000000052122d in SimpleMessenger::ReaperThread::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:522
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 52 (Thread 0x7fb5c8006700 (LWP 12838)):
> #0 =C2=A00x00007fb5cb302613 in select () from /lib/x86_64-linux-gnu/l=
ibc.so.6
> #1 =C2=A00x00000000006fb210 in SignalHandler::entry (this=3D0x2b4e420=
)
> =C2=A0 =C2=A0at global/signal_handler.cc:201
> #2 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #3 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #4 =C2=A00x0000000000000000 in ?? ()
>
> Thread 51 (Thread 0x7fb5c7805700 (LWP 12839)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000685bf7 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b66060) at common/Cond.h:67
> #2 =C2=A0SafeTimer::timer_thread (this=3D0x2b66050) at common/Timer.c=
c:110
> #3 =C2=A00x000000000068666d in SafeTimerThread::entry (this=3D<optimi=
zed out>)
> =C2=A0 =C2=A0at common/Timer.cc:38
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 50 (Thread 0x7fb5c7004700 (LWP 12840)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000685853 in Wait (mutex=3D..., this=3D0x2b67460) a=
t common/Cond.h:48
> #2 =C2=A0SafeTimer::timer_thread (this=3D0x2b67450) at common/Timer.c=
c:108
> #3 =C2=A00x000000000068666d in SafeTimerThread::entry (this=3D<optimi=
zed out>)
> =C2=A0 =C2=A0at common/Timer.cc:38
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 49 (Thread 0x7fb5c5000700 (LWP 12854)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x00000000007992d0 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b63500) at ./common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b63500) at ./common/Cond.h:74
> #3 =C2=A0FileStore::sync_entry (this=3D0x2b63000) at os/FileStore.cc:=
3352
> #4 =C2=A00x00000000007a65ed in FileStore::SyncThread::entry (this=3D<=
optimized out>)
> =C2=A0 =C2=A0at os/FileStore.h:103
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 48 (Thread 0x7fb5c47ff700 (LWP 12859)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x000000000077807c in Wait (mutex=3D..., this=3D0x2b6ab10)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0FileJournal::write_thread_entry (this=3D0x2b6a800) at os/Fil=
eJournal.cc:1052
>
> #3 =C2=A00x00000000005d4c7d in FileJournal::Writer::entry (this=3D<op=
timized out>)
> =C2=A0 =C2=A0at ./os/FileJournal.h:249
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 47 (Thread 0x7fb5c3ffe700 (LWP 12860)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x000000000077222f in Wait (mutex=3D..., this=3D0x2b6a8c0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0FileJournal::write_finish_thread_entry (this=3D0x2b6a800)
> =C2=A0 =C2=A0at os/FileJournal.cc:1245
> #3 =C2=A00x00000000005d4c5d in FileJournal::WriteFinisher::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at ./os/FileJournal.h:259
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 46 (Thread 0x7fb5c37fd700 (LWP 12861)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000761f8e in Wait (mutex=3D..., this=3D0x2b630b8)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0Finisher::finisher_thread_entry (this=3D0x2b63070) at common=
/Finisher.cc:76
> #3 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #4 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #5 =C2=A00x0000000000000000 in ?? ()
>
> Thread 45 (Thread 0x7fb5c2ffc700 (LWP 12862)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000688a05 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b63868) at common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b63868) at common/Cond.h:74
> #3 =C2=A0ThreadPool::worker (this=3D0x2b63810) at common/WorkQueue.cc=
:71
> #4 =C2=A00x00000000005d4cad in ThreadPool::WorkThread::entry (this=3D=
<optimized out>)
> =C2=A0 =C2=A0at ./common/WorkQueue.h:121
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 44 (Thread 0x7fb5c27fb700 (LWP 12863)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000688a05 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b63868) at common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b63868) at common/Cond.h:74
> #3 =C2=A0ThreadPool::worker (this=3D0x2b63810) at common/WorkQueue.cc=
:71
> #4 =C2=A00x00000000005d4cad in ThreadPool::WorkThread::entry (this=3D=
<optimized out>)
> =C2=A0 =C2=A0at ./common/WorkQueue.h:121
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 43 (Thread 0x7fb5c1ffa700 (LWP 12864)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000781ebd in Wait (mutex=3D..., this=3D0x2b63970)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0FileStore::flusher_entry (this=3D0x2b63000) at os/FileStore.=
cc:3312
> #3 =C2=A00x00000000007a49ed in FileStore::FlusherThread::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at os/FileStore.h:242
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 42 (Thread 0x7fb5c17f9700 (LWP 12865)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000761f8e in Wait (mutex=3D..., this=3D0x2b63750)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0Finisher::finisher_thread_entry (this=3D0x2b63708) at common=
/Finisher.cc:76
> #3 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #4 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #5 =C2=A00x0000000000000000 in ?? ()
>
> Thread 41 (Thread 0x7fb5c0ff8700 (LWP 12866)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000761f8e in Wait (mutex=3D..., this=3D0x2b63400)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0Finisher::finisher_thread_entry (this=3D0x2b633b8) at common=
/Finisher.cc:76
> #3 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #4 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #5 =C2=A00x0000000000000000 in ?? ()
>
> Thread 40 (Thread 0x7fb5c07f7700 (LWP 12867)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000685bf7 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b63590) at common/Cond.h:67
> #2 =C2=A0SafeTimer::timer_thread (this=3D0x2b63580) at common/Timer.c=
c:110
> #3 =C2=A00x000000000068666d in SafeTimerThread::entry (this=3D<optimi=
zed out>)
> =C2=A0 =C2=A0at common/Timer.cc:38
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 39 (Thread 0x7fb5bfff6700 (LWP 12868)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x00000000006748da in Wait (mutex=3D..., this=3D0x2b49718)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::dispatch_entry (this=3D0x2b49680)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:374
> #3 =C2=A00x000000000052120d in SimpleMessenger::DispatchThread::entry=
 (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:559
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 38 (Thread 0x7fb5bf7f5700 (LWP 12869)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x00000000006748da in Wait (mutex=3D..., this=3D0x2b49298)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::dispatch_entry (this=3D0x2b49200)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:374
> #3 =C2=A00x000000000052120d in SimpleMessenger::DispatchThread::entry=
 (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:559
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 37 (Thread 0x7fb5beff4700 (LWP 12870)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x00000000006748da in Wait (mutex=3D..., this=3D0x2b48e18)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::dispatch_entry (this=3D0x2b48d80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:374
> #3 =C2=A00x000000000052120d in SimpleMessenger::DispatchThread::entry=
 (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:559
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 36 (Thread 0x7fb5be7f3700 (LWP 12871)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x00000000006748da in Wait (mutex=3D..., this=3D0x2b49b98)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::dispatch_entry (this=3D0x2b49b00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:374
> #3 =C2=A00x000000000052120d in SimpleMessenger::DispatchThread::entry=
 (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:559
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 35 (Thread 0x7fb5bdff2700 (LWP 12872)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000685bf7 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x7fff73395748) at common/Cond.h:67
> #2 =C2=A0SafeTimer::timer_thread (this=3D0x7fff73395738) at common/Ti=
mer.cc:110
> #3 =C2=A00x000000000068666d in SafeTimerThread::entry (this=3D<optimi=
zed out>)
> =C2=A0 =C2=A0at common/Timer.cc:38
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 34 (Thread 0x7fb5bd7f1700 (LWP 12873)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000761f8e in Wait (mutex=3D..., this=3D0x7fff733958=
38)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0Finisher::finisher_thread_entry (this=3D0x7fff733957f0)
> =C2=A0 =C2=A0at common/Finisher.cc:76
> #3 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #4 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #5 =C2=A00x0000000000000000 in ?? ()
>
> Thread 33 (Thread 0x7fb5cd2e3700 (LWP 12874)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4965950)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4965780)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 32 (Thread 0x7fb5bcff0700 (LWP 12877)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D31,
> =C2=A0 =C2=A0buf=3D0x7fb5bcfefd9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4965780)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 31 (Thread 0x7fb5bceef700 (LWP 12878)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000688a05 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b66470) at common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b66470) at common/Cond.h:74
> #3 =C2=A0ThreadPool::worker (this=3D0x2b66418) at common/WorkQueue.cc=
:71
> #4 =C2=A00x00000000005d4cad in ThreadPool::WorkThread::entry (this=3D=
<optimized out>)
> =C2=A0 =C2=A0at ./common/WorkQueue.h:121
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 30 (Thread 0x7fb5bc6ee700 (LWP 12879)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000688a05 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b66470) at common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b66470) at common/Cond.h:74
> #3 =C2=A0ThreadPool::worker (this=3D0x2b66418) at common/WorkQueue.cc=
:71
> #4 =C2=A00x00000000005d4cad in ThreadPool::WorkThread::entry (this=3D=
<optimized out>)
> =C2=A0 =C2=A0at ./common/WorkQueue.h:121
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 29 (Thread 0x7fb5bbeed700 (LWP 12880)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000688a05 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b665a0) at common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b665a0) at common/Cond.h:74
> #3 =C2=A0ThreadPool::worker (this=3D0x2b66548) at common/WorkQueue.cc=
:71
> #4 =C2=A00x00000000005d4cad in ThreadPool::WorkThread::entry (this=3D=
<optimized out>)
> =C2=A0 =C2=A0at ./common/WorkQueue.h:121
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 28 (Thread 0x7fb5bb6ec700 (LWP 12881)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000688a05 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b666d0) at common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b666d0) at common/Cond.h:74
> #3 =C2=A0ThreadPool::worker (this=3D0x2b66678) at common/WorkQueue.cc=
:71
> #4 =C2=A00x00000000005d4cad in ThreadPool::WorkThread::entry (this=3D=
<optimized out>)
> =C2=A0 =C2=A0at ./common/WorkQueue.h:121
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 27 (Thread 0x7fb5baeeb700 (LWP 12882)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000688a05 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b66800) at common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b66800) at common/Cond.h:74
> #3 =C2=A0ThreadPool::worker (this=3D0x2b667a8) at common/WorkQueue.cc=
:71
> #4 =C2=A00x00000000005d4cad in ThreadPool::WorkThread::entry (this=3D=
<optimized out>)
> =C2=A0 =C2=A0at ./common/WorkQueue.h:121
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 26 (Thread 0x7fb5ba6ea700 (LWP 12883)):
> #0 =C2=A00x00007fb5cccdd3cb in pthread_cond_timedwait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x00000000005b43f2 in WaitUntil (when=3D<optimized out>, mut=
ex=3D...,
> =C2=A0 =C2=A0this=3D0x2b66918) at ./common/Cond.h:67
> #2 =C2=A0WaitInterval (interval=3D<optimized out>, mutex=3D..., cct=3D=
<optimized out>,
> =C2=A0 =C2=A0this=3D0x2b66918) at ./common/Cond.h:74
> #3 =C2=A0OSD::heartbeat_entry (this=3D0x2b66000) at osd/OSD.cc:1699
> #4 =C2=A00x00000000005e68ad in OSD::T_Heartbeat::entry (this=3D<optim=
ized out>)
> =C2=A0 =C2=A0at osd/OSD.h:280
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 25 (Thread 0x7fb5b9ee9700 (LWP 12885)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4965e50)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4965c80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 24 (Thread 0x7fb5b9de8700 (LWP 12886)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4995450)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4995280)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 23 (Thread 0x7fb5b9ce7700 (LWP 12887)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x49951d0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4995000)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 22 (Thread 0x7fb5b9be6700 (LWP 12888)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4995bd0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4995a00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 21 (Thread 0x7fb5b9ae5700 (LWP 12889)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4995950)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4995780)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 20 (Thread 0x7fb5b99e4700 (LWP 12890)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x49956d0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4995500)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 19 (Thread 0x7fb5b98e3700 (LWP 12891)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4995e50)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4995c80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 18 (Thread 0x7fb5b97e2700 (LWP 12892)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4d62bd0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4d62a00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 17 (Thread 0x7fb5b96e1700 (LWP 12893)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D33,
> =C2=A0 =C2=A0buf=3D0x7fb5b96e0d9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4995280)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 16 (Thread 0x7fb5b95e0700 (LWP 12894)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D35,
> =C2=A0 =C2=A0buf=3D0x7fb5b95dfd9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4995a00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 15 (Thread 0x7fb5b94df700 (LWP 12895)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D32,
> =C2=A0 =C2=A0buf=3D0x7fb5b94ded9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4965c80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 14 (Thread 0x7fb5b93de700 (LWP 12896)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D38,
> =C2=A0 =C2=A0buf=3D0x7fb5b93ddd9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4995c80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 13 (Thread 0x7fb5b92dd700 (LWP 12897)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D34,
> =C2=A0 =C2=A0buf=3D0x7fb5b92dcd9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4995000)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 12 (Thread 0x7fb5b91dc700 (LWP 12898)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D36,
> =C2=A0 =C2=A0buf=3D0x7fb5b91dbd9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4995780)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 11 (Thread 0x7fb5b90db700 (LWP 12900)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D39,
> =C2=A0 =C2=A0buf=3D0x7fb5b90dad9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4d62a00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 10 (Thread 0x7fb5b8fda700 (LWP 12899)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D37,
> =C2=A0 =C2=A0buf=3D0x7fb5b8fd9d9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4995500)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 9 (Thread 0x7fb5b8ed9700 (LWP 12903)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D40,
> =C2=A0 =C2=A0buf=3D0x7fb5b8ed8d9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x4d62c80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 8 (Thread 0x7fb5b8dd8700 (LWP 12904)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x4d62e50)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x4d62c80)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 7 (Thread 0x7fb5b8cd7700 (LWP 12908)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D42,
> =C2=A0 =C2=A0buf=3D0x7fb5b8cd6d9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x49ed280)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 6 (Thread 0x7fb5b8bd6700 (LWP 12909)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x49ed450)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x49ed280)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 5 (Thread 0x7fb5b8ad5700 (LWP 12910)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D41,
> =C2=A0 =C2=A0buf=3D0x7fb5b8ad4d9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x49ed000)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 4 (Thread 0x7fb5b89d4700 (LWP 12911)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x49ed1d0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x49ed000)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 3 (Thread 0x7fb5b88d3700 (LWP 12912)):
> #0 =C2=A00x00007fb5cb2fd473 in poll () from /lib/x86_64-linux-gnu/lib=
c.so.6
> #1 =C2=A00x000000000066af87 in tcp_read_wait (sd=3D<optimized out>,
> =C2=A0 =C2=A0timeout=3D<optimized out>) at msg/tcp.cc:53
> #2 =C2=A00x000000000066b238 in tcp_read (cct=3D0x2b4e000, sd=3D43,
> =C2=A0 =C2=A0buf=3D0x7fb5b88d2d9f "\377", len=3D1, timeout=3D900000) =
at msg/tcp.cc:26
> #3 =C2=A00x000000000067e2d3 in SimpleMessenger::Pipe::reader (this=3D=
0x49eda00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1606
> #4 =C2=A00x000000000052126d in SimpleMessenger::Pipe::Reader::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:250
> #5 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #6 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #7 =C2=A00x0000000000000000 in ?? ()
>
> Thread 2 (Thread 0x7fb5b87d2700 (LWP 12913)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000679f1a in Wait (mutex=3D..., this=3D0x49edbd0)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::Pipe::writer (this=3D0x49eda00)
> =C2=A0 =C2=A0at msg/SimpleMessenger.cc:1821
> #3 =C2=A00x000000000052124d in SimpleMessenger::Pipe::Writer::entry (
> =C2=A0 =C2=A0this=3D<optimized out>) at msg/SimpleMessenger.h:258
> #4 =C2=A00x00007fb5cccd8efc in start_thread ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #5 =C2=A00x00007fb5cb30959d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
> #6 =C2=A00x0000000000000000 in ?? ()
>
> Thread 1 (Thread 0x7fb5cd3017a0 (LWP 12770)):
> #0 =C2=A00x00007fb5cccdd04c in pthread_cond_wait@@GLIBC_2.3.2 ()
> =C2=A0 from /lib/x86_64-linux-gnu/libpthread.so.0
> #1 =C2=A00x0000000000672c47 in Wait (mutex=3D..., this=3D0x2b49838)
> =C2=A0 =C2=A0at ./common/Cond.h:48
> #2 =C2=A0SimpleMessenger::wait (this=3D0x2b49680) at msg/SimpleMessen=
ger.cc:2654
> #3 =C2=A00x000000000051efc7 in main (argc=3D<optimized out>, argv=3D<=
optimized out>)
> =C2=A0 =C2=A0at ceph_osd.cc:423
>
>
> On 6 April 2012 22:06, Samuel Just <sam.just@dreamhost.com> wrote:
>> Actually, can you restart osd0, wait the same amount of time, attach
>> to the process with gdb, and post a backtrace from all threads?
>> -Sam
>>
>> On Fri, Apr 6, 2012 at 12:32 PM, Damien Churchill <damoxc@gmail.com>=
 wrote:
>>> I've upped the monitor debug logging and re-uploaded the osd log, i=
s that okay?
>>>
>>> http://damoxc.net/ceph/mon.node21.log.gz
>>>
>>> On 6 April 2012 19:20, Samuel Just <sam.just@dreamhost.com> wrote:
>>>> Hmm, can you post the monitor logs as well for that period? =C2=A0=
It looks
>>>> like the osd is requesting a map change and not getting it.
>>>> -Sam
>>>>
>>>> On Fri, Apr 6, 2012 at 10:59 AM, Damien Churchill <damoxc@gmail.co=
m> wrote:
>>>>> Oops, was set to 600, chmod'd to 644, should be good now.
>>>>>
>>>>> On 6 April 2012 18:56, Samuel Just <sam.just@dreamhost.com> wrote=
:
>>>>>> Error 403.
>>>>>> -Sam
>>>>>>
>>>>>> On Fri, Apr 6, 2012 at 10:53 AM, Damien Churchill <damoxc@gmail.=
com> wrote:
>>>>>>> Okay, uploaded it to http://damoxc.net/ceph/osd.0.log.gz. I res=
tarted
>>>>>>> the osd with debug osd =3D 20 and let it run for 5 minutes or s=
o.
>>>>>>>
>>>>>>> On 6 April 2012 18:30, Samuel Just <sam.just@dreamhost.com> wro=
te:
>>>>>>>> Hmm, osd.0 should be enough. =C2=A0I need osd debugging at aro=
und 20 from
>>>>>>>> when the osd started. =C2=A0Restarting the osd with debugging =
at 20 would
>>>>>>>> also work fine.
>>>>>>>> -Sam
>>>>>>>>
>>>>>>>> On Fri, Apr 6, 2012 at 9:55 AM, Damien Churchill <damoxc@gmail=
=2Ecom> wrote:
>>>>>>>>> I've got that directory on 3 of the osds: 0, 3 and 4. Do you =
want the
>>>>>>>>> logs to all 3 of them?
>>>>>>>>>
>>>>>>>>> On 6 April 2012 17:50, Samuel Just <sam.just@dreamhost.com> w=
rote:
>>>>>>>>>> Is there a 0.138_head directory under current/ on any of you=
r osds?
>>>>>>>>>> If so, can you post the log to that osd? =C2=A0I could also =
use the osd.0
>>>>>>>>>> log.
>>>>>>>>>> -Sam
>>>>>>>>>>
>>>>>>>>>> On Wed, Apr 4, 2012 at 2:44 PM, Damien Churchill <damoxc@gma=
il.com> wrote:
>>>>>>>>>>> I've uploaded them to:
>>>>>>>>>>>
>>>>>>>>>>> http://damoxc.net/ceph/osdmap
>>>>>>>>>>> http://damoxc.net/ceph/pg_dump
>>>>>>>>>>>
>>>>>>>>>>> Thanks
>>>>>>>>>>>
>>>>>>>>>>> On 4 April 2012 21:51, Samuel Just <sam.just@dreamhost.com>=
 wrote:
>>>>>>>>>>>> Can you post a copy of your osd map and the output of 'cep=
h pg dump' ?
>>>>>>>>>>>> =C2=A0You can get the osdmap via 'ceph osd getmap -o <file=
name>'.
>>>>>>>>>>>> -Sam
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, Apr 4, 2012 at 1:12 AM, Damien Churchill <damoxc@g=
mail.com> wrote:
>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm having some trouble getting some pgs to stop being in=
active. The
>>>>>>>>>>>>> cluster is running 0.44.1 and the kernel version is 3.2.x=
=2E
>>>>>>>>>>>>>
>>>>>>>>>>>>> ceph -s reports:
>>>>>>>>>>>>> 2012-04-04 09:08:57.816029 =C2=A0 =C2=A0pg v188540: 990 p=
gs: 223 inactive, 767
>>>>>>>>>>>>> active+clean; 205 GB data, 1013 GB used, 8204 GB / 9315 G=
B avail
>>>>>>>>>>>>> 2012-04-04 09:08:57.817970 =C2=A0 mds e2198: 1/1/1 up {0=3D=
node24=3Dup:active},
>>>>>>>>>>>>> 4 up:standby
>>>>>>>>>>>>> 2012-04-04 09:08:57.818024 =C2=A0 osd e5910: 5 osds: 5 up=
, 5 in
>>>>>>>>>>>>> 2012-04-04 09:08:57.818201 =C2=A0 log 2012-04-04 09:04:03=
=2E838358 osd.3
>>>>>>>>>>>>> 172.22.10.24:6801/30000 159 : [INF] 0.13d scrub ok
>>>>>>>>>>>>> 2012-04-04 09:08:57.818280 =C2=A0 mon e7: 3 mons at
>>>>>>>>>>>>> {node21=3D172.22.10.21:6789/0,node22=3D172.22.10.22:6789/=
0,node23=3D172.22.10.23:6789/0}
>>>>>>>>>>>>>
>>>>>>>>>>>>> ceph health says:
>>>>>>>>>>>>> 2012-04-04 09:09:01.651053 mon <- [health]
>>>>>>>>>>>>> 2012-04-04 09:09:01.666585 mon.1 -> 'HEALTH_WARN 223 pgs =
stuck
>>>>>>>>>>>>> inactive; 223 pgs stuck unclean' (0)
>>>>>>>>>>>>>
>>>>>>>>>>>>> I was wondering if anyone has any suggestions about how t=
o resolve
>>>>>>>>>>>>> this, or things to look for. I've tried restarted the cep=
h daemons on
>>>>>>>>>>>>> the various nodes a few times to no-avail. I don't think =
that there is
>>>>>>>>>>>>> anything wrong with any of the nodes either.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks in advance,
>>>>>>>>>>>>> Damien
>>>>>>>>>>>>> --
>>>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe=
 ceph-devel" in
>>>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>>>> More majordomo info at =C2=A0http://vger.kernel.org/major=
domo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
