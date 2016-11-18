From: Marov Aleksey <Marov.A@raidix.com>
Subject: HA: ceph issue
Date: Fri, 18 Nov 2016 09:23:08 +0000
Message-ID: <FEC85B105C5F644CA51BDB90657EEA98284250E8@ddsm-mbx01.digdes.com>
References: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com>
 <alpine.DEB.2.11.1611171448450.15311@piezo.us.to>,<CACJqLybjnFedWh+TdN4W6u2+VKWBsJAtVi0A8VjbJ2mGX8aZxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digdes.com ([85.114.5.13]:61384 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbcKRJXV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 18 Nov 2016 04:23:21 -0500
In-Reply-To: <CACJqLybjnFedWh+TdN4W6u2+VKWBsJAtVi0A8VjbJ2mGX8aZxA@mail.gmail.com>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I use ceph with rdma/async messenger. I have done next steps
1. ulimit -c unlimited core
2. fio -v : 2.1.13. Run  fio rbd.fio Where rbd.fio  config is :
[global]
ioengine=rbd
clientname=admin
pool=rbd
rbdname=test_img1
invalidate=0    # mandatory
rw=randwrite
bs=4k
runtime=10m
time_based

[rbd_iodepth32]
iodepth=32
numjobs=1

3.  Got this fio crash
/mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/log/SubsystemMap.h: In function 'bool ceph::logging::SubsystemMap::should_gather(unsigned int, int)' thread 7fffd3fff700 time 2016-11-18 11:51:44.411997
/mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/log/SubsystemMap.h: 62: FAILED assert(sub < m_subsys.size())
 ceph version 11.0.2-1554-g19ca7fd (19ca7fd92bb8813dcabcc57518932b3dbb553d4b)
 1: (()+0x15ccd5) [0x7fffe6d9ccd5]
 2: (()+0x75582) [0x7fffe6cb5582]
 3: (()+0x3b7b07) [0x7fffe6ff7b07]
 4: (()+0x215c36) [0x7fffe6e55c36]
 5: (()+0x201b51) [0x7fffe6e41b51]
 6: (()+0x1f93f4) [0x7fffe6e393f4]
 7: (()+0x1e7035) [0x7fffe6e27035]
 8: (()+0x1e733a) [0x7fffe6e2733a]
 9: (librados::RadosClient::connect()+0x96) [0x7fffe6d0bbd6]
 10: (rados_connect()+0x20) [0x7fffe6cbf2d0]
 11: /usr/local/bin/fio() [0x45b579]
 12: (td_io_init()+0x1b) [0x40d70b]
 13: /usr/local/bin/fio() [0x449eb3]
 14: (()+0x7dc5) [0x7fffe5ac9dc5]
 15: (clone()+0x6d) [0x7fffe55f2ced]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

4. run gdb on core 
gdb $(which fio) core.3860
>>thread apply all bt
>>run
And got this bt:
..
Thread 5 (Thread 0x7f1f54491880 (LWP 3860)):
#0  0x00007f1f41a84efd in nanosleep () from /lib64/libc.so.6
#1  0x00007f1f41ab5b34 in usleep () from /lib64/libc.so.6
#2  0x000000000044c26f in do_usleep (usecs=10000) at backend.c:1727
#3  run_threads () at backend.c:1965
#4  0x000000000044c7ed in fio_backend () at backend.c:2068
#5  0x00007f1f419e8b15 in __libc_start_main () from /lib64/libc.so.6
#6  0x000000000040b8ad in _start ()

Thread 4 (Thread 0x7f1f19ffb700 (LWP 3882)):
#0  0x00007f1f41f986d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00007f1f4326b54b in ceph::logging::Log::entry (this=0x7f1f0802b4d0) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/log/Log.cc:451
#2  0x00007f1f41f94dc5 in start_thread () from /lib64/libpthread.so.0
#3  0x00007f1f41abdced in clone () from /lib64/libc.so.6

Thread 3 (Thread 0x7f1f037fe700 (LWP 3883)):
#0  0x00007f1f41f98a82 in pthread_cond_timedwait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x00007f1f43395dca in WaitUntil (when=..., mutex=..., this=0x7f1f0807a460) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/common/Cond.h:72
#2  WaitInterval (interval=..., mutex=..., cct=<optimized out>, this=0x7f1f0807a460) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/common/Cond.h:81
#3  CephContextServiceThread::entry (this=0x7f1f0807a3e0) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/common/ceph_context.cc:149
#4  0x00007f1f41f94dc5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f1f41abdced in clone () from /lib64/libc.so.6

Thread 2 (Thread 0x7f1f34db5700 (LWP 3861)):
#0  0x00007f1f41a84efd in nanosleep () from /lib64/libc.so.6
#1  0x00007f1f41ab5b34 in usleep () from /lib64/libc.so.6
#2  0x0000000000448500 in disk_thread_main (data=<optimized out>) at backend.c:1992
#3  0x00007f1f41f94dc5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007f1f41abdced in clone () from /lib64/libc.so.6

Thread 1 (Thread 0x7f1f345b4700 (LWP 3881)):
#0  0x00007f1f419fc5f7 in raise () from /lib64/libc.so.6
#1  0x00007f1f419fdce8 in abort () from /lib64/libc.so.6
#2  0x00007f1f43267eb7 in ceph::__ceph_assert_fail (assertion=assertion@entry=0x7f1f4351d090 "sub < m_subsys.size()", 
    file=file@entry=0x7f1f4351cd48 "/mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/log/SubsystemMap.h", line=line@entry=62, 
    func=func@entry=0x7f1f4355f800 <_ZZN4ceph7logging12SubsystemMap13should_gatherEjiE19__PRETTY_FUNCTION__> "bool ceph::logging::SubsystemMap::should_gather(unsigned int, int)")
    at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/common/assert.cc:78
#3  0x00007f1f43180582 in ceph::logging::SubsystemMap::should_gather (level=20, sub=27, this=<optimized out>) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/log/SubsystemMap.h:62
#4  0x00007f1f434c2b07 in should_gather (level=20, sub=27, this=<optimized out>) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/async/rdma/Infiniband.cc:317
#5  Infiniband::create_comp_channel (this=0xd43430) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/async/rdma/Infiniband.cc:310
#6  0x00007f1f43320c36 in RDMADispatcher (s=0x7f1f0807c2a8, i=<optimized out>, c=0x7f1f08026f60, this=0x7f1f08102bb0) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/async/rdma/RDMAStack.h:90
#7  RDMAStack::RDMAStack (this=0x7f1f0807c2a8, cct=0x7f1f08026f60, t=...) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/async/rdma/RDMAStack.cc:66
#8  0x00007f1f4330cb51 in construct<RDMAStack, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__p=0x7f1f0807c2a8, this=<optimized out>)
    at /usr/include/c++/4.8.2/ext/new_allocator.h:120
#9  _S_construct<RDMAStack, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__p=0x7f1f0807c2a8, __a=...) at /usr/include/c++/4.8.2/bits/alloc_traits.h:254
#10 construct<RDMAStack, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__p=0x7f1f0807c2a8, __a=...) at /usr/include/c++/4.8.2/bits/alloc_traits.h:393
#11 _Sp_counted_ptr_inplace<CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__a=..., this=0x7f1f0807c290) at /usr/include/c++/4.8.2/bits/shared_ptr_base.h:399
#12 construct<std::_Sp_counted_ptr_inplace<RDMAStack, std::allocator<RDMAStack>, (__gnu_cxx::_Lock_policy)2>, std::allocator<RDMAStack> const, CephContext*&, std::basic_string<char, std::char_traits<char>, std::al
locator<char> > const&> (__p=<optimized out>, this=<synthetic pointer>) at /usr/include/c++/4.8.2/ext/new_allocator.h:120
#13 _S_construct<std::_Sp_counted_ptr_inplace<RDMAStack, std::allocator<RDMAStack>, (__gnu_cxx::_Lock_policy)2>, std::allocator<RDMAStack> const, CephContext*&, std::basic_string<char, std::char_traits<char>, std:
:allocator<char> > const&> (__p=<optimized out>, __a=<synthetic pointer>) at /usr/include/c++/4.8.2/bits/alloc_traits.h:254
#14 construct<std::_Sp_counted_ptr_inplace<RDMAStack, std::allocator<RDMAStack>, (__gnu_cxx::_Lock_policy)2>, std::allocator<RDMAStack> const, CephContext*&, std::basic_string<char, std::char_traits<char>, std::al
locator<char> > const&> (__p=<optimized out>, __a=<synthetic pointer>) at /usr/include/c++/4.8.2/bits/alloc_traits.h:393
---Type <return> to continue, or q <return> to quit--- 
#15 __shared_count<RDMAStack, std::allocator<RDMAStack>, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__a=..., this=<optimized out>)
    at /usr/include/c++/4.8.2/bits/shared_ptr_base.h:502
#16 __shared_ptr<std::allocator<RDMAStack>, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__a=..., __tag=..., this=<optimized out>)
    at /usr/include/c++/4.8.2/bits/shared_ptr_base.h:957
#17 shared_ptr<std::allocator<RDMAStack>, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__a=..., __tag=..., this=<optimized out>)
    at /usr/include/c++/4.8.2/bits/shared_ptr.h:316
#18 allocate_shared<RDMAStack, std::allocator<RDMAStack>, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> (__a=...) at /usr/include/c++/4.8.2/bits/shared_ptr.h:598
#19 make_shared<RDMAStack, CephContext*&, std::basic_string<char, std::char_traits<char>, std::allocator<char> > const&> () at /usr/include/c++/4.8.2/bits/shared_ptr.h:614
#20 NetworkStack::create (c=c@entry=0x7f1f08026f60, t="rdma") at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/async/Stack.cc:66
#21 0x00007f1f433043f4 in StackSingleton (c=0x7f1f08026f60, this=0x7f1f0807abd0) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/async/AsyncMessenger.cc:244
#22 lookup_or_create_singleton_object<StackSingleton> (name="AsyncMessenger::NetworkStack", p=<synthetic pointer>, this=0x7f1f08026f60)
    at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/common/ceph_context.h:134
#23 AsyncMessenger::AsyncMessenger (this=0x7f1f0807afd0, cct=0x7f1f08026f60, name=..., mname=..., _nonce=7528509425877766185)
    at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/async/AsyncMessenger.cc:278
#24 0x00007f1f432f2035 in Messenger::create (cct=cct@entry=0x7f1f08026f60, type="async", name=..., lname="radosclient", nonce=nonce@entry=7528509425877766185, cflags=cflags@entry=0)
    at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/Messenger.cc:40

#25 0x00007f1f432f233a in Messenger::create_client_messenger (cct=0x7f1f08026f60, lname="radosclient") at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/msg/Messenger.cc:20
#26 0x00007f1f431d6bd6 in librados::RadosClient::connect (this=this@entry=0x7f1f0802ed00) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/librados/RadosClient.cc:245
#27 0x00007f1f4318a2d0 in rados_connect (cluster=0x7f1f0802ed00) at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-1554-g19ca7fd/src/librados/librados.cc:2771
#28 0x000000000045b579 in _fio_rbd_connect (td=<optimized out>) at engines/rbd.c:113
#29 fio_rbd_init (td=<optimized out>) at engines/rbd.c:337
#30 0x000000000040d70b in td_io_init (td=td@entry=0x7f1f34db6000) at ioengines.c:369
#31 0x0000000000449eb3 in thread_main (data=0x7f1f34db6000) at backend.c:1433
#32 0x00007f1f41f94dc5 in start_thread () from /lib64/libpthread.so.0
#33 0x00007f1f41abdced in clone () from /lib64/libc.so.6


Hope it'll help. If you need core dump and fio binary I can send it. May be this problem relates to old fio version? (though I dont think so)

Best regards 
Alex
________________________________________

hi Marov,

Other person also met this problem when using rdma, but it's ok to me.
so plz give more infos to figure it out

On Thu, Nov 17, 2016 at 10:49 PM, Sage Weil <sweil@redhat.com> wrote:
> [adding ceph-devel]
>
> On Thu, 17 Nov 2016, Marov Aleksey wrote:
>> Hello Sage
>>
>> My name is Alex. I need some help with resolving issue with ceph. I have
>> been testing ceph with rdma messenger and I got an error
>>
>> src/log/SubsystemMap.h: 62: FAILED assert(sub < m_subsys.size())
>>
>> I have no idea what it means. I noticed that you was the last one who
>> committed in SubsystemMap.h so I think you have some understanding of this
>> condition in assert
>>
>> bool should_gather(unsigned sub, int level) {
>>   assert(sub < m_subsys.size());
>>   return level <= m_subsys[sub].gather_level ||
>>     level <= m_subsys[sub].log_level;
>> }
>>
>> This error occurs only when I use fio benchmark to test rbd. When I use "rbd
>> bench-write ..."  it is ok. But fio is much mire flexible . In any case I
>> think it is not good to get any assert.
>>
>> Can you explain this for me please, or give a hint where to investigate my
>> trouble.
>
> Can you generate a core file, and then use gdb to capture the output of
> 'thread apply all bt'?
>
> Thanks-
> asge
