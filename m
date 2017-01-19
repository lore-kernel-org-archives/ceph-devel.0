From: Padmanabh Ratnakar <padmanabh.ratnakar@snapdeal.com>
Subject: Suicide timeout during peering after network glitch on Hammer 0.94.7
Date: Thu, 19 Jan 2017 17:16:41 +0530
Message-ID: <CAC+4SSiCckjmSz-3EQaJZ3GXNA4c_tygnq5tkZD-Bm5gt0_zSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178]:35837 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752192AbdASLqm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jan 2017 06:46:42 -0500
Received: by mail-yb0-f178.google.com with SMTP id l23so14453299ybj.2
        for <ceph-devel@vger.kernel.org>; Thu, 19 Jan 2017 03:46:42 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Nagendra Tomar <nagendra.tomar@snapdeal.com>

Hi,
          We recently hit below suicide timeout on many OSDs on our
ceph cluster.

common/HeartbeatMap.cc: 79: FAILED assert(0 == "hit suicide timeout")
 ceph version 0.94.7 (d56bdf93ced6b80b07397d57e3fa68fe68304432)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x8b) [0xbb1fab]
 2: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
const*, long)+0x2a9) [0xaebbc9]
 3: (ceph::HeartbeatMap::is_healthy()+0xd6) [0xaec456]
 4: (ceph::HeartbeatMap::check_touch_file()+0x17) [0xaecb37]
 5: (CephContextServiceThread::entry()+0x154) [0xbc2074]
 6: (()+0x8182) [0x7f1dbb9f2182]
 7: (clone()+0x6d) [0x7f1db9f5d47d]


Thread which caused suicide looks to be -

Thread 102 (Thread 0x7f6995cad700 (LWP 605414)):
#0  __lll_lock_wait () at
../nptl/sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:135
#1  0x00007f69b69d3657 in _L_lock_909 () from
/lib/x86_64-linux-gnu/libpthread.so.0
#2  0x00007f69b69d3480 in __GI___pthread_mutex_lock (mutex=0x4324880)
at ../nptl/pthread_mutex_lock.c:79
#3  0x0000000000b610fb in Mutex::Lock (this=this@entry=0x4324870,
no_lockdep=no_lockdep@entry=false) at common/Mutex.cc:96
#4  0x00000000006a20fa in Locker (m=..., this=<synthetic pointer>) at
./common/Mutex.h:115
#5  OSDService::try_get_map (this=this@entry=0x43236c8,
epoch=epoch@entry=26494) at osd/OSD.cc:1171
#6  0x00000000006a84ff in OSD::advance_pg (this=this@entry=0x4322000,
osd_epoch=26579, pg=pg@entry=0xec7a000, handle=...,
    rctx=rctx@entry=0x7f6995cac960,
new_pgs=new_pgs@entry=0x7f6995cac930) at osd/OSD.cc:6616
#7  0x00000000006a8cdc in OSD::process_peering_events (this=0x4322000,
pgs=..., handle=...) at osd/OSD.cc:8564
#8  0x0000000000701998 in OSD::PeeringWQ::_process (this=<optimized
out>, pgs=..., handle=...) at osd/OSD.h:1615
#9  0x0000000000ba2a0e in ThreadPool::worker (this=0x43224b0,
wt=0x49ed410) at common/WorkQueue.cc:128
#10 0x0000000000ba3ab0 in ThreadPool::WorkThread::entry
(this=<optimized out>) at common/WorkQueue.h:397
#11 0x00007f69b69d1182 in start_thread (arg=0x7f6995cad700) at
pthread_create.c:312
#12 0x00007f69b4f3c47d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111


There are 8 more threads waiting for same Mutex with similar stack trace.
(osd_tp Threadpool is of size 8 threads).
From gdb, in advance_pg function, variables next_epoch = 26494 and
osd_epoch=26579 on all 8 threads.


Thread which has taken this Mutex has stack trace -

#0  0x00007f69b6c19875 in tc_free () from /usr/lib/libtcmalloc.so.4
#1  0x0000000000c27e70 in ~raw_posix_aligned (this=0x4b7d5080,
__in_chrg=<optimized out>) at common/buffer.cc:262
#2  ceph::buffer::raw_posix_aligned::~raw_posix_aligned
(this=0x4b7d5080, __in_chrg=<optimized out>) at common/buffer.cc:265
#3  0x0000000000c213be in ceph::buffer::ptr::release
(this=this@entry=0x53d34050) at common/buffer.cc:724
#4  0x0000000000661fa7 in ~ptr (this=0x53d34050, __in_chrg=<optimized
out>) at ./include/buffer.h:184
#5  destroy (this=<optimized out>, __p=0x53d34050) at
/usr/include/c++/4.8/ext/new_allocator.h:133
#6  std::_List_base<ceph::buffer::ptr,
std::allocator<ceph::buffer::ptr> >::_M_clear (this=0x2dfd8548)
    at /usr/include/c++/4.8/bits/list.tcc:77
#7  0x000000000070042e in ~pair (this=0x2dfd8540, __in_chrg=<optimized
out>) at /usr/include/c++/4.8/bits/stl_pair.h:96
#8  destroy (this=<optimized out>, __p=0x2dfd8540) at
/usr/include/c++/4.8/ext/new_allocator.h:133
#9  _M_erase (this=0x4324a78, __position=...) at
/usr/include/c++/4.8/bits/stl_list.h:1575
#10 pop_back (this=0x4324a78) at /usr/include/c++/4.8/bits/stl_list.h:1042
#11 trim_cache (this=0x43249e8) at ./common/simple_cache.hpp:35
#12 _add (value=..., key=<optimized out>, this=0x43249e8) at
./common/simple_cache.hpp:42
#13 SimpleLRU<unsigned int, ceph::buffer::list>::clear_pinned
(this=this@entry=0x43249e8, e=e@entry=26579) at
./common/simple_cache.hpp:59
#14 0x0000000000695169 in OSDService::clear_map_bl_cache_pins
(this=0x43236c8, e=26579) at osd/OSD.cc:1147
#15 0x00000000006c2a29 in Context::complete (this=0x38db7c00,
r=<optimized out>) at ./include/Context.h:65
#16 0x0000000000adbbd8 in Finisher::finisher_thread_entry
(this=0x4206b00) at common/Finisher.cc:59
#17 0x00007f69b69d1182 in start_thread (arg=0x7f69a5e34700) at
pthread_create.c:312
#18 0x00007f69b4f3c47d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:111

Either the above routine took too long(150s) and suicide timeout was
hit on other thread.
150s looks to be too long for this thread to be stuck in this cache
update operation.
Something else may also be happening.

In system data collected from ceph machines, we see high load
average(10k) during this time on all machines.
We have 20 node cluster, with each node having 22 disks. (440 osds).

Multiple OSDs have same core dump.
Ubuntu upstart restarted the OSDs and they are working fine.
Any hints to root cause this and avoid this issue during peering will
be helpful.
Let me know if you require any other information.

Thanks,
Padmanabh
