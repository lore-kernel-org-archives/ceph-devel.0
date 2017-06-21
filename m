From: zengran zhang <z13121369189@gmail.com>
Subject: [ceph-mgr] Signal Raised in tcmalloc
Date: Wed, 21 Jun 2017 14:07:21 +0800
Message-ID: <CALi+v1_3uLU2T5TPN_qusFF-BVukp6uyQke7a9iFBU8=AKkHPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33242 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbdFUGHc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 02:07:32 -0400
Received: by mail-io0-f171.google.com with SMTP id t87so4586752ioe.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 23:07:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tchaikov@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi, Kefu:

   we found a mgr instance hang, and attach it with gdb. we can see a
signal raised(#8) in or after
`DaemonPerfCounters::update(MMgrReport*)` , so its because the
tcmalloc heap corrupt. can you help to disgnose the problem? ceph
version is 12.0.2. thanks so much.

#0  0x00007f2245fc8026 in SpinLock::SlowLock() () from /usr/lib/libtcmalloc.so.4
#1  0x00007f2245fb907a in
tcmalloc::CentralFreeList::RemoveRange(void**, void**, int) () from
/usr/lib/libtcmalloc.so.4
#2  0x00007f2245fbbfaa in
tcmalloc::ThreadCache::FetchFromCentralCache(unsigned long, unsigned
long) () from /usr/lib/libtcmalloc.so.4
#3  0x00007f2245fce368 in tc_newarray () from /usr/lib/libtcmalloc.so.4
#4  0x000055840e8f670d in ?? ()
#5  0x000055840e8f6a9c in pretty_version_to_str[abi:cxx11]() ()
#6  0x000055840e7122b6 in ceph::BackTrace::print(std::ostream&) const ()
#7  0x000055840e6f8a27 in ?? ()
#8  <signal handler called>
#9  0x00007f2245fb8c33 in
tcmalloc::CentralFreeList::FetchFromOneSpans(int, void**, void**) ()
from /usr/lib/libtcmalloc.so.4
#10 0x00007f2245fb8f0a in
tcmalloc::CentralFreeList::FetchFromOneSpansSafe(int, void**, void**)
() from /usr/lib/libtcmalloc.so.4
#11 0x00007f2245fb8fbf in
tcmalloc::CentralFreeList::RemoveRange(void**, void**, int) () from
/usr/lib/libtcmalloc.so.4
#12 0x00007f2245fbbfaa in
tcmalloc::ThreadCache::FetchFromCentralCache(unsigned long, unsigned
long) () from /usr/lib/libtcmalloc.so.4
#13 0x00007f2245fce368 in tc_newarray () from /usr/lib/libtcmalloc.so.4
#14 0x000055840e67036d in ?? ()
#15 0x000055840e671e46 in DaemonPerfCounters::update(MMgrReport*) ()
#16 0x000055840e6770e4 in DaemonServer::handle_report(MMgrReport*) ()
#17 0x000055840e67cb70 in DaemonServer::ms_dispatch(Message*) ()
#18 0x000055840e970f6a in DispatchQueue::entry() ()
#19 0x000055840e809d7d in DispatchQueue::DispatchThread::entry() ()
#20 0x00007f22453d96ba in start_thread (arg=0x7f223b6dc700) at
pthread_create.c:333
#21 0x00007f224444582d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109
