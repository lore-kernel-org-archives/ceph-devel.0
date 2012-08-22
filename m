From: Andrey Korolyov <andrey@xdel.ru>
Subject: OSD crash
Date: Thu, 23 Aug 2012 00:31:24 +0400
Message-ID: <CABYiri_Fi4uMSqLnoFLp4_2kQ8FSXv=jjSSQiER=DwCOG0hqkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55800 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506Ab2HVUbs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 16:31:48 -0400
Received: by wgbdr13 with SMTP id dr13so10179wgb.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 13:31:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

today during heavy test a pair of osds and one mon died, resulting to
hard lockup of some kvm processes - they went unresponsible and was
killed leaving zombie processes ([kvm] <defunct>). Entire cluster
contain sixteen osd on eight nodes and three mons, on first and last
node and on vm outside cluster.

osd bt:
#0  0x00007fc37d490be3 in
tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
unsigned long, int) () from /usr/lib/libtcmalloc.so.4
(gdb) bt
#0  0x00007fc37d490be3 in
tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
unsigned long, int) () from /usr/lib/libtcmalloc.so.4
#1  0x00007fc37d490eb4 in tcmalloc::ThreadCache::Scavenge() () from
/usr/lib/libtcmalloc.so.4
#2  0x00007fc37d4a2287 in tc_delete () from /usr/lib/libtcmalloc.so.4
#3  0x00000000008b1224 in _M_dispose (__a=..., this=0x6266d80) at
/usr/include/c++/4.7/bits/basic_string.h:246
#4  ~basic_string (this=0x7fc3736639d0, __in_chrg=<optimized out>) at
/usr/include/c++/4.7/bits/basic_string.h:536
#5  ~basic_stringbuf (this=0x7fc373663988, __in_chrg=<optimized out>)
at /usr/include/c++/4.7/sstream:60
#6  ~basic_ostringstream (this=0x7fc373663980, __in_chrg=<optimized
out>, __vtt_parm=<optimized out>) at /usr/include/c++/4.7/sstream:439
#7  pretty_version_to_str () at common/version.cc:40
#8  0x0000000000791630 in ceph::BackTrace::print (this=0x7fc373663d10,
out=...) at common/BackTrace.cc:19
#9  0x000000000078f450 in handle_fatal_signal (signum=11) at
global/signal_handler.cc:91
#10 <signal handler called>
#11 0x00007fc37d490be3 in
tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
unsigned long, int) () from /usr/lib/libtcmalloc.so.4
#12 0x00007fc37d490eb4 in tcmalloc::ThreadCache::Scavenge() () from
/usr/lib/libtcmalloc.so.4
#13 0x00007fc37d49eb97 in tc_free () from /usr/lib/libtcmalloc.so.4
#14 0x00007fc37d1c6670 in __gnu_cxx::__verbose_terminate_handler() ()
from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#15 0x00007fc37d1c4796 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#16 0x00007fc37d1c47c3 in std::terminate() () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#17 0x00007fc37d1c49ee in __cxa_throw () from
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#18 0x0000000000844e11 in ceph::__ceph_assert_fail (assertion=0x90c01c
"0 == \"unexpected error\"", file=<optimized out>, line=3007,
    func=0x90ef80 "unsigned int
FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int)")
at common/assert.cc:77
#19 0x000000000073148f in FileStore::_do_transaction
(this=this@entry=0x2cde000, t=..., op_seq=op_seq@entry=429545,
trans_num=trans_num@entry=0) at os/FileStore.cc:3007
#20 0x000000000073484e in FileStore::do_transactions (this=0x2cde000,
tls=..., op_seq=429545) at os/FileStore.cc:2436
#21 0x000000000070c680 in FileStore::_do_op (this=0x2cde000,
osr=<optimized out>) at os/FileStore.cc:2259
#22 0x000000000083ce01 in ThreadPool::worker (this=0x2cde828) at
common/WorkQueue.cc:54
#23 0x00000000006823ed in ThreadPool::WorkThread::entry
(this=<optimized out>) at ./common/WorkQueue.h:126
#24 0x00007fc37e3eee9a in start_thread () from
/lib/x86_64-linux-gnu/libpthread.so.0
#25 0x00007fc37c9864cd in clone () from /lib/x86_64-linux-gnu/libc.so.6
#26 0x0000000000000000 in ?? ()

mon bt was exactly the same as in http://tracker.newdream.net/issues/2762
