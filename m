From: "Dyweni - Qemu-Devel" <8SScqsnYX8tr@dyweni.com>
Subject: Re: Qemu + RBD = ceph::buffer::end_of_buffer
Date: Fri, 6 May 2011 14:58:48 -0500 (CDT)
Message-ID: <984ed3487d4f68b72f4b0720d3caf27e.squirrel@localhost>
References: <346055bf24b9f7eabcfafa1cc53a4f66.squirrel@localhost>
	<fb4546550b96ff2f54c7a2f5e795131d.squirrel@localhost>
	<4DC45149.8020101@dreamhost.com>
Reply-To: 8SScqsnYX8tr@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <4DC45149.8020101@dreamhost.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: 8sscqsnyx8tr@dyweni.com, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

Hi Josh/Lists!

463             ::decode(*data_bl, iter);
(gdb) print r
$1 =3D 0
(gdb) print data_bl
$2 =3D (ceph::bufferlist *) 0x7f16f40d6060
(gdb) print data_bl->_len
$3 =3D 0
(gdb) print iter->off
$4 =3D 20


Thanks,
Dyweni



> CCing the ceph list.
>
> On 05/06/2011 12:23 PM, Dyweni - Qemu-Devel wrote:
>> Hi List!
>>
>> I upgraded Ceph to the latest development version
>> 	Commit: 0edbc75a5fe8c3028faf85546f3264d28653ea3f
>> 	Pulled from: git://ceph.newdream.net/ceph.git
>>
>> I recompiled the latest GIT version of QEMU-KVM (with Josh Durgin's
>> patches) against the latest git version of Ceph.
>>
>> However, this error is still occurring:
>>
>> terminate called after throwing an instance of
>> 'ceph::buffer::end_of_buffer'
>>    what():  buffer::end_of_buffer
>> Aborted (core dumped)
>>
>>
>>
>> Here's another backtrace from GDB:
>>
>> #0  0x00007f16ff829495 in raise (sig=3D<value optimized out>) at
>> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>> #1  0x00007f16ff82a81f in abort () at abort.c:92
>> #2  0x00007f16fed74a25 in __gnu_cxx::__verbose_terminate_handler () at
>> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/vt=
erminate.cc:93
>> #3  0x00007f16fed71c64 in __cxxabiv1::__terminate
>> (handler=3D0x7f16fed74817
>> <__gnu_cxx::__verbose_terminate_handler()>)
>>      at
>> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh=
_terminate.cc:38
>> #4  0x00007f16fed71c8c in std::terminate () at
>> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh=
_terminate.cc:48
>> #5  0x00007f16fed71ea4 in __cxxabiv1::__cxa_throw (obj=3D0x1346470,
>> tinfo=3D0x7f1701952ce0, dest=3D0x7f17017403d4
>> <ceph::buffer::end_of_buffer::~end_of_buffer()>)
>>      at
>> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/libsupc++/eh=
_throw.cc:83
>> #6  0x00007f1701740a7b in ceph::buffer::list::iterator::copy
>> (this=3D0x7f16fd8b1930, len=3D4, dest=3D0x7f16fd8b18dc "") at
>> include/buffer.h:379
>> #7  0x00007f1701743328 in decode_raw<__le32>  (t=3D@0x7f16fd8b18dc, p=3D=
...)
>> at
>> include/encoding.h:35
>> #8  0x00007f170174198a in decode (v=3D@0x7f16fd8b190c, p=3D...) at
>> include/encoding.h:80
>> #9  0x00007f1701741ade in decode (s=3D..., p=3D...) at
>> include/encoding.h:189
>> #10 0x00007f17012e8369 in
>> librados::RadosClient::C_aio_sparse_read_Ack::finish
>> (this=3D0x7f16f40d6200,
>> r=3D0) at librados.cc:463
>> #11 0x00007f170132bb5a in Objecter::handle_osd_op_reply (this=3D0x1342=
3e0,
>> m=3D0x1346520) at osdc/Objecter.cc:794
>> #12 0x00007f17012d1444 in librados::RadosClient::_dispatch
>> (this=3D0x133f810, m=3D0x1346520) at librados.cc:751
>> #13 0x00007f17012d1244 in librados::RadosClient::ms_dispatch
>> (this=3D0x133f810, m=3D0x1346520) at librados.cc:717
>> #14 0x00007f170131b57b in Messenger::ms_deliver_dispatch
>> (this=3D0x1341910,
>> m=3D0x1346520) at msg/Messenger.h:98
>> #15 0x00007f17013090d3 in SimpleMessenger::dispatch_entry
>> (this=3D0x1341910)
>> at msg/SimpleMessenger.cc:352
>> #16 0x00007f17012e296e in SimpleMessenger::DispatchThread::entry
>> (this=3D0x1341da0) at msg/SimpleMessenger.h:533
>> #17 0x00007f170131a39b in Thread::_entry_func (arg=3D0x1341da0) at
>> common/Thread.h:41
>> #18 0x00007f1701f6dac4 in start_thread (arg=3D<value optimized out>) a=
t
>> pthread_create.c:297
>> #19 0x00007f16ff8c838d in clone () at
>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
>
> I haven't seen that error before, but it's probably a bug in the OSD
> where it doesn't set an error code. If you've still got the core file,
> could you go to frame 10 and send us the values of r, bl._len, and
> iter.off?
>
> Thanks,
> Josh
>
