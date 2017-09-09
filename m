From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: very slow backfill on Luminous + Bluestore
Date: Sat, 9 Sep 2017 10:27:42 +0800
Message-ID: <CAEYCsV+=qgUMfmTmyDWEYTFTRFk1Jmn-2iO8eokgbaNpXVT38w@mail.gmail.com>
References: <CAEYCsV+eUcNKAa5s6X9tZKjJ+off2WXR6o_Ayggv0ZW_E6obVw@mail.gmail.com>
 <alpine.DEB.2.11.1709081528560.16664@piezo.novalocal> <CAEYCsVJEiFra_gun33a=ROvQhosmPLZtYr04w+q5TcCU8C+6MQ@mail.gmail.com>
 <f60827b0-fc54-b72e-adec-a2df6a822b04@redhat.com> <CAEYCsVJ+pVs6=GkWq-SNiDoQQURRumWo=K0EVcuvquvs7+X2zw@mail.gmail.com>
 <CAJ4mKGZY86teMTbg-RC-kt9KUYCk1y66wy23-OYypVdGeWO99w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35203 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757247AbdIIC1o (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Sep 2017 22:27:44 -0400
Received: by mail-oi0-f49.google.com with SMTP id z73so20405277oia.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 Sep 2017 19:27:44 -0700 (PDT)
In-Reply-To: <CAJ4mKGZY86teMTbg-RC-kt9KUYCk1y66wy23-OYypVdGeWO99w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Mark Nelson <mnelson@redhat.com>, Sage Weil <sage@newdream.net>, Ceph Development <ceph-devel@vger.kernel.org>

Full bt trace is pasted below, looks to me like all idle.

For some more information, this pool has too much PG than it should be
( 8192 PG -> 26 OSDs), and rocksdb( in old OSD, i.e rocksdb on hdd)
was showing high compaction overhead even cause slow request in
cluster. This was the reason for me to move to another 24 OSD with SSD
as DB block.

Thread 67 (Thread 0x7f958bd09700 (LWP 4029606)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904fc24b in ceph::logging::Log::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f958bd09700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 66 (Thread 0x7f958b2fc700 (LWP 4029613)):
#0  0x00007f958d0a1b13 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95907056d4 in
EpollDriver::event_wait(std::vector<FiredFileEvent,
std::allocator<FiredFileEvent> >&, timeval*) ()
#2  0x00007f9590583077 in EventCenter::process_events(int,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> >*)
()
#3  0x00007f9590585dee in ?? ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f958b2fc700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 65 (Thread 0x7f958aafb700 (LWP 4029614)):
#0  0x00007f958d0a1b13 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95907056d4 in
EpollDriver::event_wait(std::vector<FiredFileEvent,
std::allocator<FiredFileEvent> >&, timeval*) ()
#2  0x00007f9590583077 in EventCenter::process_events(int,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> >*)
()
#3  0x00007f9590585dee in ?? ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f958aafb700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 64 (Thread 0x7f958a2fa700 (LWP 4029615)):
#0  0x00007f958d0a1b13 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95907056d4 in
EpollDriver::event_wait(std::vector<FiredFileEvent,
std::allocator<FiredFileEvent> >&, timeval*) ()
#2  0x00007f9590583077 in EventCenter::process_events(int,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> >*)
()
#3  0x00007f9590585dee in ?? ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f958a2fa700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 63 (Thread 0x7f9589380700 (LWP 4029617)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95905e5446 in CephContextServiceThread::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f9589380700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 62 (Thread 0x7f9588b7f700 (LWP 4029618)):
#0  0x00007f958d09412d in poll () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95904d6c23 in AdminSocket::entry() ()
---Type <return> to continue, or q <return> to quit---
#2  0x00007f958dfb1182 in start_thread (arg=0x7f9588b7f700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 61 (Thread 0x7f9587b49700 (LWP 4029715)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95900047f3 in
ceph::timer_detail::timer<ceph::time_detail::mono_clock>::timer_thread()
()
#2  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9587b49700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 60 (Thread 0x7f9587348700 (LWP 4029717)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9587348700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 59 (Thread 0x7f9586b47700 (LWP 4029718)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9586b47700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 58 (Thread 0x7f9586346700 (LWP 4029719)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9586346700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 57 (Thread 0x7f9585b45700 (LWP 4029720)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9585b45700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 56 (Thread 0x7f9585344700 (LWP 4029721)):
#0  0x00007f958f01958a in ?? () from /lib/x86_64-linux-gnu/libaio.so.1
#1  0x00007f95904aa6a7 in aio_queue_t::get_next_completed(int, aio_t**, int) ()
#2  0x00007f9590495989 in KernelDevice::_aio_thread() ()
#3  0x00007f959049a3bd in KernelDevice::AioCompletionThread::entry() ()
---Type <return> to continue, or q <return> to quit---
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9585344700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 55 (Thread 0x7f9584b43700 (LWP 4029723)):
#0  0x00007f958f01958a in ?? () from /lib/x86_64-linux-gnu/libaio.so.1
#1  0x00007f95904aa6a7 in aio_queue_t::get_next_completed(int, aio_t**, int) ()
#2  0x00007f9590495989 in KernelDevice::_aio_thread() ()
#3  0x00007f959049a3bd in KernelDevice::AioCompletionThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9584b43700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 54 (Thread 0x7f9584342700 (LWP 4029724)):
#0  0x00007f958f01958a in ?? () from /lib/x86_64-linux-gnu/libaio.so.1
#1  0x00007f95904aa6a7 in aio_queue_t::get_next_completed(int, aio_t**, int) ()
#2  0x00007f9590495989 in KernelDevice::_aio_thread() ()
#3  0x00007f959049a3bd in KernelDevice::AioCompletionThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9584342700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 53 (Thread 0x7f957c332700 (LWP 4029959)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f957c332700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 52 (Thread 0x7f957cb33700 (LWP 4029960)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f95903a7b25 in BlueStore::_kv_sync_thread() ()
#3  0x00007f95903ed75d in BlueStore::KVSyncThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957cb33700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 51 (Thread 0x7f957d334700 (LWP 4029961)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f9590393887 in BlueStore::_kv_finalize_thread() ()
#3  0x00007f95903e80cd in BlueStore::KVFinalizeThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957d334700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 50 (Thread 0x7f957db35700 (LWP 4029962)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
---Type <return> to continue, or q <return> to quit---
#1  0x00007f9590363d3c in BlueStore::MempoolThread::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f957db35700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 49 (Thread 0x7f9581bfa700 (LWP 4030490)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9581bfa700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 48 (Thread 0x7f95813f9700 (LWP 4030491)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f95813f9700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 47 (Thread 0x7f9580bf8700 (LWP 4030492)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9580bf8700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 46 (Thread 0x7f95803f7700 (LWP 4030493)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f95803f7700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 45 (Thread 0x7f957fbf6700 (LWP 4030494)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957fbf6700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 44 (Thread 0x7f957f3f5700 (LWP 4030495)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
---Type <return> to continue, or q <return> to quit---
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957f3f5700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 43 (Thread 0x7f957ebf4700 (LWP 4030496)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957ebf4700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 42 (Thread 0x7f957e3f3700 (LWP 4030497)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957e3f3700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 41 (Thread 0x7f957bb31700 (LWP 4030498)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957bb31700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 40 (Thread 0x7f957b330700 (LWP 4030499)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957b330700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 39 (Thread 0x7f957ab2f700 (LWP 4030500)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957ab2f700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 38 (Thread 0x7f957a32e700 (LWP 4030501)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957a32e700) at
pthread_create.c:312
---Type <return> to continue, or q <return> to quit---
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 37 (Thread 0x7f9579b2d700 (LWP 4030502)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9579b2d700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 36 (Thread 0x7f957932c700 (LWP 4030503)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957932c700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 35 (Thread 0x7f9578b2b700 (LWP 4030504)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9578b2b700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 34 (Thread 0x7f957832a700 (LWP 4030505)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f957832a700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 33 (Thread 0x7f9577b29700 (LWP 4030506)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9577b29700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 32 (Thread 0x7f9577328700 (LWP 4030507)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9577328700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

---Type <return> to continue, or q <return> to quit---
Thread 31 (Thread 0x7f9576b27700 (LWP 4030508)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9576b27700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 30 (Thread 0x7f9576326700 (LWP 4030509)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9576326700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 29 (Thread 0x7f9575b25700 (LWP 4030510)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9575b25700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 28 (Thread 0x7f9575324700 (LWP 4030511)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9575324700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 27 (Thread 0x7f9574b23700 (LWP 4030512)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9574b23700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 26 (Thread 0x7f9574322700 (LWP 4030513)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
---Type <return> to continue, or q <return> to quit---
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9574322700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 25 (Thread 0x7f9573b21700 (LWP 4030514)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9573b21700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 24 (Thread 0x7f9573320700 (LWP 4030515)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9573320700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 23 (Thread 0x7f9572b1f700 (LWP 4030516)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9572b1f700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 22 (Thread 0x7f957231e700 (LWP 4030517)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957231e700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 21 (Thread 0x7f9571b1d700 (LWP 4030518)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9571b1d700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111
---Type <return> to continue, or q <return> to quit---

Thread 20 (Thread 0x7f957131c700 (LWP 4030519)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957131c700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 19 (Thread 0x7f9570b1b700 (LWP 4030520)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9570b1b700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 18 (Thread 0x7f957031a700 (LWP 4030521)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957031a700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 17 (Thread 0x7f956fb19700 (LWP 4030522)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f956fb19700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 16 (Thread 0x7f956f318700 (LWP 4030523)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f956f318700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 15 (Thread 0x7f956eb17700 (LWP 4030524)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
---Type <return> to continue, or q <return> to quit---
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f956eb17700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 14 (Thread 0x7f956e316700 (LWP 4030525)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956e316700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 13 (Thread 0x7f956db15700 (LWP 4030526)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956db15700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 12 (Thread 0x7f956d314700 (LWP 4030527)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ff827aa in OSD::heartbeat_entry() ()
#2  0x00007f958fff405d in OSD::T_Heartbeat::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956d314700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 11 (Thread 0x7f956cb13700 (LWP 4030528)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f956cb13700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 10 (Thread 0x7f956c312700 (LWP 4030529)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f956c312700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 9 (Thread 0x7f956bb11700 (LWP 4030530)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
---Type <return> to continue, or q <return> to quit---
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956bb11700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 8 (Thread 0x7f956b310700 (LWP 4030531)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956b310700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 7 (Thread 0x7f956ab0f700 (LWP 4030532)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956ab0f700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 6 (Thread 0x7f956a30e700 (LWP 4030533)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956a30e700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 5 (Thread 0x7f9569b0d700 (LWP 4030534)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958ffd19ae in Cond::Wait(Mutex&) ()
#2  0x00007f958ff61ff0 in OSDService::agent_entry() ()
#3  0x00007f958ffd914d in OSDService::AgentThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9569b0d700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 4 (Thread 0x7f956930c700 (LWP 4030535)):
#0  0x00007f958d09412d in poll () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95904b2438 in SignalHandler::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f956930c700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 3 (Thread 0x7f9568b0b700 (LWP 4066412)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f9590911723 in
rocksdb::ThreadPoolImpl::Impl::BGThread(unsigned long) ()
#3  0x00007f9590911aad in
rocksdb::ThreadPoolImpl::Impl::BGThreadWrapper(void*) ()
---Type <return> to continue, or q <return> to quit---
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f9568b0b700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 2 (Thread 0x7f956830a700 (LWP 4136716)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f9590911723 in
rocksdb::ThreadPoolImpl::Impl::BGThread(unsigned long) ()
#3  0x00007f9590911aad in
rocksdb::ThreadPoolImpl::Impl::BGThreadWrapper(void*) ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f956830a700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 1 (Thread 0x7f958fa8ed00 (LWP 4029594)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f959057faa3 in AsyncMessenger::wait() ()
#2  0x00007f958fec0014 in main ()
(gdb)
(gdb)
(gdb)
(gdb)
(gdb) thread apply all bt

Thread 67 (Thread 0x7f958bd09700 (LWP 4029606)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904fc24b in ceph::logging::Log::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f958bd09700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 66 (Thread 0x7f958b2fc700 (LWP 4029613)):
#0  0x00007f958d0a1b13 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95907056d4 in
EpollDriver::event_wait(std::vector<FiredFileEvent,
std::allocator<FiredFileEvent> >&, timeval*) ()
#2  0x00007f9590583077 in EventCenter::process_events(int,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> >*)
()
#3  0x00007f9590585dee in ?? ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f958b2fc700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 65 (Thread 0x7f958aafb700 (LWP 4029614)):
#0  0x00007f958d0a1b13 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95907056d4 in
EpollDriver::event_wait(std::vector<FiredFileEvent,
std::allocator<FiredFileEvent> >&, timeval*) ()
#2  0x00007f9590583077 in EventCenter::process_events(int,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> >*)
()
#3  0x00007f9590585dee in ?? ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f958aafb700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 64 (Thread 0x7f958a2fa700 (LWP 4029615)):
#0  0x00007f958d0a1b13 in epoll_wait () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95907056d4 in
EpollDriver::event_wait(std::vector<FiredFileEvent,
std::allocator<FiredFileEvent> >&, timeval*) ()
#2  0x00007f9590583077 in EventCenter::process_events(int,
std::chrono::duration<unsigned long, std::ratio<1l, 1000000000l> >*)
()
#3  0x00007f9590585dee in ?? ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f958a2fa700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 63 (Thread 0x7f9589380700 (LWP 4029617)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95905e5446 in CephContextServiceThread::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f9589380700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 62 (Thread 0x7f9588b7f700 (LWP 4029618)):
#0  0x00007f958d09412d in poll () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95904d6c23 in AdminSocket::entry() ()
---Type <return> to continue, or q <return> to quit---
#2  0x00007f958dfb1182 in start_thread (arg=0x7f9588b7f700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 61 (Thread 0x7f9587b49700 (LWP 4029715)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95900047f3 in
ceph::timer_detail::timer<ceph::time_detail::mono_clock>::timer_thread()
()
#2  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9587b49700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 60 (Thread 0x7f9587348700 (LWP 4029717)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9587348700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 59 (Thread 0x7f9586b47700 (LWP 4029718)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9586b47700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 58 (Thread 0x7f9586346700 (LWP 4029719)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9586346700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 57 (Thread 0x7f9585b45700 (LWP 4029720)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9585b45700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 56 (Thread 0x7f9585344700 (LWP 4029721)):
#0  0x00007f958f01958a in ?? () from /lib/x86_64-linux-gnu/libaio.so.1
#1  0x00007f95904aa6a7 in aio_queue_t::get_next_completed(int, aio_t**, int) ()
#2  0x00007f9590495989 in KernelDevice::_aio_thread() ()
#3  0x00007f959049a3bd in KernelDevice::AioCompletionThread::entry() ()
---Type <return> to continue, or q <return> to quit---
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9585344700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 55 (Thread 0x7f9584b43700 (LWP 4029723)):
#0  0x00007f958f01958a in ?? () from /lib/x86_64-linux-gnu/libaio.so.1
#1  0x00007f95904aa6a7 in aio_queue_t::get_next_completed(int, aio_t**, int) ()
#2  0x00007f9590495989 in KernelDevice::_aio_thread() ()
#3  0x00007f959049a3bd in KernelDevice::AioCompletionThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9584b43700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 54 (Thread 0x7f9584342700 (LWP 4029724)):
#0  0x00007f958f01958a in ?? () from /lib/x86_64-linux-gnu/libaio.so.1
#1  0x00007f95904aa6a7 in aio_queue_t::get_next_completed(int, aio_t**, int) ()
#2  0x00007f9590495989 in KernelDevice::_aio_thread() ()
#3  0x00007f959049a3bd in KernelDevice::AioCompletionThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9584342700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 53 (Thread 0x7f957c332700 (LWP 4029959)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f957c332700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 52 (Thread 0x7f957cb33700 (LWP 4029960)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f95903a7b25 in BlueStore::_kv_sync_thread() ()
#3  0x00007f95903ed75d in BlueStore::KVSyncThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957cb33700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 51 (Thread 0x7f957d334700 (LWP 4029961)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f9590393887 in BlueStore::_kv_finalize_thread() ()
#3  0x00007f95903e80cd in BlueStore::KVFinalizeThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957d334700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 50 (Thread 0x7f957db35700 (LWP 4029962)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
---Type <return> to continue, or q <return> to quit---
#1  0x00007f9590363d3c in BlueStore::MempoolThread::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f957db35700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 49 (Thread 0x7f9581bfa700 (LWP 4030490)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9581bfa700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 48 (Thread 0x7f95813f9700 (LWP 4030491)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f95813f9700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 47 (Thread 0x7f9580bf8700 (LWP 4030492)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9580bf8700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 46 (Thread 0x7f95803f7700 (LWP 4030493)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f95803f7700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 45 (Thread 0x7f957fbf6700 (LWP 4030494)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957fbf6700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 44 (Thread 0x7f957f3f5700 (LWP 4030495)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
---Type <return> to continue, or q <return> to quit---
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957f3f5700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 43 (Thread 0x7f957ebf4700 (LWP 4030496)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957ebf4700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 42 (Thread 0x7f957e3f3700 (LWP 4030497)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957e3f3700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 41 (Thread 0x7f957bb31700 (LWP 4030498)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957bb31700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 40 (Thread 0x7f957b330700 (LWP 4030499)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957b330700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 39 (Thread 0x7f957ab2f700 (LWP 4030500)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957ab2f700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 38 (Thread 0x7f957a32e700 (LWP 4030501)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957a32e700) at
pthread_create.c:312
---Type <return> to continue, or q <return> to quit---
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 37 (Thread 0x7f9579b2d700 (LWP 4030502)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590753418 in DispatchQueue::entry() ()
#2  0x00007f959057321d in DispatchQueue::DispatchThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9579b2d700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 36 (Thread 0x7f957932c700 (LWP 4030503)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f9590755f0f in DispatchQueue::run_local_delivery() ()
#2  0x00007f959057323d in DispatchQueue::LocalDeliveryThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f957932c700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 35 (Thread 0x7f9578b2b700 (LWP 4030504)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9578b2b700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 34 (Thread 0x7f957832a700 (LWP 4030505)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f957832a700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 33 (Thread 0x7f9577b29700 (LWP 4030506)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9577b29700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 32 (Thread 0x7f9577328700 (LWP 4030507)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9577328700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

---Type <return> to continue, or q <return> to quit---
Thread 31 (Thread 0x7f9576b27700 (LWP 4030508)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f9576b27700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 30 (Thread 0x7f9576326700 (LWP 4030509)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9576326700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 29 (Thread 0x7f9575b25700 (LWP 4030510)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9575b25700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 28 (Thread 0x7f9575324700 (LWP 4030511)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9575324700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 27 (Thread 0x7f9574b23700 (LWP 4030512)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9574b23700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 26 (Thread 0x7f9574322700 (LWP 4030513)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
---Type <return> to continue, or q <return> to quit---
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9574322700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 25 (Thread 0x7f9573b21700 (LWP 4030514)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9573b21700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 24 (Thread 0x7f9573320700 (LWP 4030515)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9573320700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 23 (Thread 0x7f9572b1f700 (LWP 4030516)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9572b1f700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 22 (Thread 0x7f957231e700 (LWP 4030517)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957231e700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 21 (Thread 0x7f9571b1d700 (LWP 4030518)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9571b1d700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111
---Type <return> to continue, or q <return> to quit---

Thread 20 (Thread 0x7f957131c700 (LWP 4030519)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957131c700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 19 (Thread 0x7f9570b1b700 (LWP 4030520)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9570b1b700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 18 (Thread 0x7f957031a700 (LWP 4030521)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f957031a700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 17 (Thread 0x7f956fb19700 (LWP 4030522)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f956fb19700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 16 (Thread 0x7f956f318700 (LWP 4030523)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f956f318700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 15 (Thread 0x7f956eb17700 (LWP 4030524)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
---Type <return> to continue, or q <return> to quit---
#1  0x00007f958ffb9798 in OSD::ShardedOpWQ::_process(unsigned int,
ceph::heartbeat_handle_d*) ()
#2  0x00007f95904f330f in
ShardedThreadPool::shardedthreadpool_worker(unsigned int) ()
#3  0x00007f95904f5260 in ShardedThreadPool::WorkThreadSharded::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f956eb17700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 14 (Thread 0x7f956e316700 (LWP 4030525)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956e316700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 13 (Thread 0x7f956db15700 (LWP 4030526)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904f3ffb in ThreadPool::worker(ThreadPool::WorkThread*) ()
#2  0x00007f95904f5280 in ThreadPool::WorkThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956db15700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 12 (Thread 0x7f956d314700 (LWP 4030527)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f958ff827aa in OSD::heartbeat_entry() ()
#2  0x00007f958fff405d in OSD::T_Heartbeat::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956d314700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 11 (Thread 0x7f956cb13700 (LWP 4030528)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f956cb13700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 10 (Thread 0x7f956c312700 (LWP 4030529)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904ebae1 in Finisher::finisher_thread_entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f956c312700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 9 (Thread 0x7f956bb11700 (LWP 4030530)):
#0  pthread_cond_timedwait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_timedwait.S:238
#1  0x00007f95904e95de in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
---Type <return> to continue, or q <return> to quit---
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956bb11700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 8 (Thread 0x7f956b310700 (LWP 4030531)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956b310700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 7 (Thread 0x7f956ab0f700 (LWP 4030532)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956ab0f700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 6 (Thread 0x7f956a30e700 (LWP 4030533)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f95904e9357 in SafeTimer::timer_thread() ()
#2  0x00007f95904ea8ed in SafeTimerThread::entry() ()
#3  0x00007f958dfb1182 in start_thread (arg=0x7f956a30e700) at
pthread_create.c:312
#4  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 5 (Thread 0x7f9569b0d700 (LWP 4030534)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958ffd19ae in Cond::Wait(Mutex&) ()
#2  0x00007f958ff61ff0 in OSDService::agent_entry() ()
#3  0x00007f958ffd914d in OSDService::AgentThread::entry() ()
#4  0x00007f958dfb1182 in start_thread (arg=0x7f9569b0d700) at
pthread_create.c:312
#5  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 4 (Thread 0x7f956930c700 (LWP 4030535)):
#0  0x00007f958d09412d in poll () at ../sysdeps/unix/syscall-template.S:81
#1  0x00007f95904b2438 in SignalHandler::entry() ()
#2  0x00007f958dfb1182 in start_thread (arg=0x7f956930c700) at
pthread_create.c:312
#3  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 3 (Thread 0x7f9568b0b700 (LWP 4066412)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f9590911723 in
rocksdb::ThreadPoolImpl::Impl::BGThread(unsigned long) ()
#3  0x00007f9590911aad in
rocksdb::ThreadPoolImpl::Impl::BGThreadWrapper(void*) ()
---Type <return> to continue, or q <return> to quit---
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f9568b0b700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 2 (Thread 0x7f956830a700 (LWP 4136716)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f958d9364bc in
std::condition_variable::wait(std::unique_lock<std::mutex>&) () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f9590911723 in
rocksdb::ThreadPoolImpl::Impl::BGThread(unsigned long) ()
#3  0x00007f9590911aad in
rocksdb::ThreadPoolImpl::Impl::BGThreadWrapper(void*) ()
#4  0x00007f958d939a40 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#5  0x00007f958dfb1182 in start_thread (arg=0x7f956830a700) at
pthread_create.c:312
#6  0x00007f958d0a147d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Thread 1 (Thread 0x7f958fa8ed00 (LWP 4029594)):
#0  pthread_cond_wait@@GLIBC_2.3.2 () at
../nptl/sysdeps/unix/sysv/linux/x86_64/pthread_cond_wait.S:185
#1  0x00007f959057faa3 in AsyncMessenger::wait() ()
#2  0x00007f958fec0014 in main ()

2017-09-09 1:11 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
> On Fri, Sep 8, 2017 at 8:59 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
>> CPU and Disk are fairly idle.
>> I didnt use gdbprof but enable debug log seems it is not hanging. Also
>> "gdb thread apply all bt" shows nothing intresting , all threads are
>> waiting on condition for job.
>
>
> Which cond are they waiting on? Sounds like the backfill is being
> deliberately throttled but it's not immediately obvious what is doing
> it.
