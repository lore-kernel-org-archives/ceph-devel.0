From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [Qemu-devel] Qemu + RBD = ceph::buffer::end_of_buffer
Date: Fri, 06 May 2011 12:51:37 -0700
Message-ID: <4DC45149.8020101@dreamhost.com>
References: <346055bf24b9f7eabcfafa1cc53a4f66.squirrel@localhost> <fb4546550b96ff2f54c7a2f5e795131d.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39048 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab1EFTvi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 15:51:38 -0400
In-Reply-To: <fb4546550b96ff2f54c7a2f5e795131d.squirrel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 8SScqsnYX8tr@dyweni.com
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

CCing the ceph list.

On 05/06/2011 12:23 PM, Dyweni - Qemu-Devel wrote:
> Hi List!
>
> I upgraded Ceph to the latest development version
> 	Commit: 0edbc75a5fe8c3028faf85546f3264d28653ea3f
> 	Pulled from: git://ceph.newdream.net/ceph.git
>
> I recompiled the latest GIT version of QEMU-KVM (with Josh Durgin's
> patches) against the latest git version of Ceph.
>
> However, this error is still occurring:
>
> terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
>    what():  buffer::end_of_buffer
> Aborted (core dumped)
>
>
>
> Here's another backtrace from GDB:
>
> #0  0x00007f16ff829495 in raise (sig=<value optimized out>) at
> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
> #1  0x00007f16ff82a81f in abort () at abort.c:92
> #2  0x00007f16fed74a25 in __gnu_cxx::__verbose_terminate_handler () at
> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/vterminate.cc:93
> #3  0x00007f16fed71c64 in __cxxabiv1::__terminate (handler=0x7f16fed74817
> <__gnu_cxx::__verbose_terminate_handler()>)
>      at
> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh_terminate.cc:38
> #4  0x00007f16fed71c8c in std::terminate () at
> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh_terminate.cc:48
> #5  0x00007f16fed71ea4 in __cxxabiv1::__cxa_throw (obj=0x1346470,
> tinfo=0x7f1701952ce0, dest=0x7f17017403d4
> <ceph::buffer::end_of_buffer::~end_of_buffer()>)
>      at
> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh_throw.cc:83
> #6  0x00007f1701740a7b in ceph::buffer::list::iterator::copy
> (this=0x7f16fd8b1930, len=4, dest=0x7f16fd8b18dc "") at
> include/buffer.h:379
> #7  0x00007f1701743328 in decode_raw<__le32>  (t=@0x7f16fd8b18dc, p=...) at
> include/encoding.h:35
> #8  0x00007f170174198a in decode (v=@0x7f16fd8b190c, p=...) at
> include/encoding.h:80
> #9  0x00007f1701741ade in decode (s=..., p=...) at include/encoding.h:189
> #10 0x00007f17012e8369 in
> librados::RadosClient::C_aio_sparse_read_Ack::finish (this=0x7f16f40d6200,
> r=0) at librados.cc:463
> #11 0x00007f170132bb5a in Objecter::handle_osd_op_reply (this=0x13423e0,
> m=0x1346520) at osdc/Objecter.cc:794
> #12 0x00007f17012d1444 in librados::RadosClient::_dispatch
> (this=0x133f810, m=0x1346520) at librados.cc:751
> #13 0x00007f17012d1244 in librados::RadosClient::ms_dispatch
> (this=0x133f810, m=0x1346520) at librados.cc:717
> #14 0x00007f170131b57b in Messenger::ms_deliver_dispatch (this=0x1341910,
> m=0x1346520) at msg/Messenger.h:98
> #15 0x00007f17013090d3 in SimpleMessenger::dispatch_entry (this=0x1341910)
> at msg/SimpleMessenger.cc:352
> #16 0x00007f17012e296e in SimpleMessenger::DispatchThread::entry
> (this=0x1341da0) at msg/SimpleMessenger.h:533
> #17 0x00007f170131a39b in Thread::_entry_func (arg=0x1341da0) at
> common/Thread.h:41
> #18 0x00007f1701f6dac4 in start_thread (arg=<value optimized out>) at
> pthread_create.c:297
> #19 0x00007f16ff8c838d in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:115

I haven't seen that error before, but it's probably a bug in the OSD 
where it doesn't set an error code. If you've still got the core file, 
could you go to frame 10 and send us the values of r, bl._len, and iter.off?

Thanks,
Josh
