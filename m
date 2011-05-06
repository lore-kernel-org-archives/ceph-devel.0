From: "Dyweni - Qemu-Devel" <8SScqsnYX8tr@dyweni.com>
Subject: Re: [Qemu-devel] Qemu + RBD = ceph::buffer::end_of_buffer
Date: Fri, 6 May 2011 15:07:25 -0500 (CDT)
Message-ID: <e9667a76329fbf406791fd3d79aa6244.squirrel@localhost>
References: <346055bf24b9f7eabcfafa1cc53a4f66.squirrel@localhost>
    <fb4546550b96ff2f54c7a2f5e795131d.squirrel@localhost>
    <4DC45149.8020101@dreamhost.com>
    <984ed3487d4f68b72f4b0720d3caf27e.squirrel@localhost>
    <Pine.LNX.4.64.1105061303270.1445@cobra.newdream.net>
Reply-To: 8SScqsnYX8tr@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:57273 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab1EFUHZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2011 16:07:25 -0400
In-Reply-To: <Pine.LNX.4.64.1105061303270.1445@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dyweni - Qemu-Devel <8sscqsnyx8tr@dyweni.com>, Josh Durgin <josh.durgin@dreamhost.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org

Hi Sage/Lists!


(gdb) print c->bl._len
$1 = 20


And in case this is helpful:

(gdb) print *c
$2 = {lock = {name = 0x7f1701430f8d "AioCompletionImpl lock", id = -1,
recursive = false, lockdep = true, backtrace = false, _m = {__data =
{__lock = 1, __count = 0,
        __owner = 25800, __nusers = 1, __kind = 2, __spins = 0, __list =
{__prev = 0x0, __next = 0x0}},
      __size =
"\001\000\000\000\000\000\000\000\310d\000\000\001\000\000\000\002",
'\000' <repeats 22 times>, __align = 1}, nlock = 1}, cond = {
    _vptr.Cond = 0x7f1701952bd0, _c = {__data = {__lock = 0, __futex = 0,
__total_seq = 0, __wakeup_seq = 0, __woken_seq = 0, __mutex = 0x0,
__nwaiters = 0,
        __broadcast_seq = 0}, __size = '\000' <repeats 47 times>, __align
= 0}}, ref = 1, rval = 0, released = true, ack = true, safe =
false, objver = {version = 0,
    epoch = 0, __pad = 0}, callback_complete = 0x7f170173de33
<librbd::rados_aio_sparse_read_cb(rados_completion_t, void*)>,
  callback_safe = 0x7f170173d8bd <librbd::rados_cb(rados_completion_t,
void*)>, callback_arg = 0x7f16f40d6010, bl = {
    _buffers = {<std::_List_base<ceph::buffer::ptr,
std::allocator<ceph::buffer::ptr> >> = {
        _M_impl = {<std::allocator<std::_List_node<ceph::buffer::ptr> >> =
{<__gnu_cxx::new_allocator<std::_List_node<ceph::buffer::ptr> >> =
{<No data fields>}, <No data fields>}, _M_node = {_M_next =
0x1350530, _M_prev = 0x1350530}}}, <No data fields>}, _len = 20,
append_buffer = {_raw = 0x0, _off = 0, _len = 0}, last_p = {
      bl = 0x7f16f40d6170, ls = 0x7f16f40d6170, off = 0, p = {_M_node =
0x7f16f40d6170}, p_off = 0}}, pbl = 0x0, buf = 0x0, maxlen = 0}



Thanks,
Dyweni




> On Fri, 6 May 2011, Dyweni - Qemu-Devel wrote:
>> Hi Josh/Lists!
>>
>> 463             ::decode(*data_bl, iter);
>> (gdb) print r
>> $1 = 0
>> (gdb) print data_bl
>> $2 = (ceph::bufferlist *) 0x7f16f40d6060
>> (gdb) print data_bl->_len
>> $3 = 0
>
> What about c->bl._len?
>
> sage
>
>
>> (gdb) print iter->off
>> $4 = 20
>>
>>
>> Thanks,
>> Dyweni
>>
>>
>>
>> > CCing the ceph list.
>> >
>> > On 05/06/2011 12:23 PM, Dyweni - Qemu-Devel wrote:
>> >> Hi List!
>> >>
>> >> I upgraded Ceph to the latest development version
>> >> 	Commit: 0edbc75a5fe8c3028faf85546f3264d28653ea3f
>> >> 	Pulled from: git://ceph.newdream.net/ceph.git
>> >>
>> >> I recompiled the latest GIT version of QEMU-KVM (with Josh Durgin's
>> >> patches) against the latest git version of Ceph.
>> >>
>> >> However, this error is still occurring:
>> >>
>> >> terminate called after throwing an instance of
>> >> 'ceph::buffer::end_of_buffer'
>> >>    what():  buffer::end_of_buffer
>> >> Aborted (core dumped)
>> >>
>> >>
>> >>
>> >> Here's another backtrace from GDB:
>> >>
>> >> #0  0x00007f16ff829495 in raise (sig=<value optimized out>) at
>> >> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>> >> #1  0x00007f16ff82a81f in abort () at abort.c:92
>> >> #2  0x00007f16fed74a25 in __gnu_cxx::__verbose_terminate_handler ()
>> at
>> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/vterminate.cc:93
>> >> #3  0x00007f16fed71c64 in __cxxabiv1::__terminate
>> >> (handler=0x7f16fed74817
>> >> <__gnu_cxx::__verbose_terminate_handler()>)
>> >>      at
>> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh_terminate.cc:38
>> >> #4  0x00007f16fed71c8c in std::terminate () at
>> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh_terminate.cc:48
>> >> #5  0x00007f16fed71ea4 in __cxxabiv1::__cxa_throw (obj=0x1346470,
>> >> tinfo=0x7f1701952ce0, dest=0x7f17017403d4
>> >> <ceph::buffer::end_of_buffer::~end_of_buffer()>)
>> >>      at
>> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh_throw.cc:83
>> >> #6  0x00007f1701740a7b in ceph::buffer::list::iterator::copy
>> >> (this=0x7f16fd8b1930, len=4, dest=0x7f16fd8b18dc "") at
>> >> include/buffer.h:379
>> >> #7  0x00007f1701743328 in decode_raw<__le32>  (t=@0x7f16fd8b18dc,
>> p=...)
>> >> at
>> >> include/encoding.h:35
>> >> #8  0x00007f170174198a in decode (v=@0x7f16fd8b190c, p=...) at
>> >> include/encoding.h:80
>> >> #9  0x00007f1701741ade in decode (s=..., p=...) at
>> >> include/encoding.h:189
>> >> #10 0x00007f17012e8369 in
>> >> librados::RadosClient::C_aio_sparse_read_Ack::finish
>> >> (this=0x7f16f40d6200,
>> >> r=0) at librados.cc:463
>> >> #11 0x00007f170132bb5a in Objecter::handle_osd_op_reply
>> (this=0x13423e0,
>> >> m=0x1346520) at osdc/Objecter.cc:794
>> >> #12 0x00007f17012d1444 in librados::RadosClient::_dispatch
>> >> (this=0x133f810, m=0x1346520) at librados.cc:751
>> >> #13 0x00007f17012d1244 in librados::RadosClient::ms_dispatch
>> >> (this=0x133f810, m=0x1346520) at librados.cc:717
>> >> #14 0x00007f170131b57b in Messenger::ms_deliver_dispatch
>> >> (this=0x1341910,
>> >> m=0x1346520) at msg/Messenger.h:98
>> >> #15 0x00007f17013090d3 in SimpleMessenger::dispatch_entry
>> >> (this=0x1341910)
>> >> at msg/SimpleMessenger.cc:352
>> >> #16 0x00007f17012e296e in SimpleMessenger::DispatchThread::entry
>> >> (this=0x1341da0) at msg/SimpleMessenger.h:533
>> >> #17 0x00007f170131a39b in Thread::_entry_func (arg=0x1341da0) at
>> >> common/Thread.h:41
>> >> #18 0x00007f1701f6dac4 in start_thread (arg=<value optimized out>) at
>> >> pthread_create.c:297
>> >> #19 0x00007f16ff8c838d in clone () at
>> >> ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
>> >
>> > I haven't seen that error before, but it's probably a bug in the OSD
>> > where it doesn't set an error code. If you've still got the core file,
>> > could you go to frame 10 and send us the values of r, bl._len, and
>> > iter.off?
>> >
>> > Thanks,
>> > Josh
>> >
>>
>>
>>
>>
>


