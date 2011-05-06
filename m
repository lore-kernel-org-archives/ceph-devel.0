From: "Dyweni - Qemu-Devel" <8SScqsnYX8tr@dyweni.com>
Subject: Re: Qemu + RBD = ceph::buffer::end_of_buffer
Date: Fri, 6 May 2011 15:24:39 -0500 (CDT)
Message-ID: <da32a6a0a2cf4b75f26eb409dbe53a53.squirrel@localhost>
References: <346055bf24b9f7eabcfafa1cc53a4f66.squirrel@localhost>
	<fb4546550b96ff2f54c7a2f5e795131d.squirrel@localhost>
	<4DC45149.8020101@dreamhost.com>
	<984ed3487d4f68b72f4b0720d3caf27e.squirrel@localhost>
	<Pine.LNX.4.64.1105061303270.1445@cobra.newdream.net>
	<e9667a76329fbf406791fd3d79aa6244.squirrel@localhost>
	<Pine.LNX.4.64.1105061311500.1445@cobra.newdream.net>
	<04a5fc1fcc55ce2fd9d913ca2ae449ed.squirrel@localhost>
	<Pine.LNX.4.64.1105061321230.9905@cobra.newdream.net>
Reply-To: 8SScqsnYX8tr@dyweni.com
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <Pine.LNX.4.64.1105061321230.9905@cobra.newdream.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Sage Weil <sage@newdream.net>
Cc: Dyweni - Qemu-Devel <8sscqsnyx8tr@dyweni.com>, ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>, qemu-devel@nongnu.org
List-Id: ceph-devel.vger.kernel.org

Hi Sage/Lists!


Yes!  The entire Ceph cluster (1 Mon, 1 MSD, 3 OSD) are 32bit linux.

The machine running Qemu is 64bit linux.


Thanks,
Dyweni



> On Fri, 6 May 2011, Dyweni - Qemu-Devel wrote:
>> Hi Sage/Lists!
>>
>>
>> (gdb) f 8
>> #8  0x00007f170174198a in decode (v=3D@0x7f16fd8b190c, p=3D...) at
>> include/encoding.h:80
>> 80      WRITE_INTTYPE_ENCODER(uint32_t, le32)
>> (gdb) p n
>> No symbol "n" in current context.
>> (gdb) p s
>> No symbol "s" in current context.
>>
>>
>> (gdb) f 9
>> #9  0x00007f1701741ade in decode (s=3D..., p=3D...) at
>> include/encoding.h:189
>> 189       decode(len, p);
>> (gdb) p n
>> No symbol "n" in current context.
>> (gdb) p s
>> $3 =3D (ceph::bufferlist &) @0x7f16f40d6060: {_buffers =3D
>> {<std::_List_base<ceph::buffer::ptr, std::allocator<ceph::buffer::ptr>
>> >>
>> =3D {
>>       _M_impl =3D {<std::allocator<std::_List_node<ceph::buffer::ptr> =
>> =3D
>> {<__gnu_cxx::new_allocator<std::_List_node<ceph::buffer::ptr> >> =3D
>> {<No data fields>}, <No data fields>}, _M_node =3D {_M_next =3D
>> 0x7f16f40d6060, _M_prev =3D 0x7f16f40d6060}}}, <No data fields>}, _len
>> =3D 0, append_buffer =3D {_raw =3D 0x0, _off =3D 0, _len =3D 0}, last_=
p =3D {
>>     bl =3D 0x7f16f40d6060, ls =3D 0x7f16f40d6060, off =3D 0, p =3D {_M=
_node =3D
>> 0x7f16f40d6060}, p_off =3D 0}}
>>
>>
>> Sorry, I don't have access to IRC from where I am at.
>
> No worries.
>
> Are you OSDs, by chance, running on 32bit machines?  This looks like a
> word size encoding thing.
>
> sage
>
>
>>
>> Thanks,
>> Dyweni
>>
>>
>>
>>
>> > f 9  (or 8?)
>> > p n
>> > p s
>> >
>> > (BTW this might be faster over irc, #ceph on irc.oftc.net)
>> >
>> > Thanks!
>> > sage
>> >
>> >
>> > On Fri, 6 May 2011, Dyweni - Qemu-Devel wrote:
>> >
>> >> Hi Sage/Lists!
>> >>
>> >>
>> >> (gdb) print c->bl._len
>> >> $1 =3D 20
>> >>
>> >>
>> >> And in case this is helpful:
>> >>
>> >> (gdb) print *c
>> >> $2 =3D {lock =3D {name =3D 0x7f1701430f8d "AioCompletionImpl lock",=
 id =3D
>> -1,
>> >> recursive =3D false, lockdep =3D true, backtrace =3D false, _m =3D =
{__data =3D
>> >> {__lock =3D 1, __count =3D 0,
>> >>         __owner =3D 25800, __nusers =3D 1, __kind =3D 2, __spins =3D=
 0,
>> __list =3D
>> >> {__prev =3D 0x0, __next =3D 0x0}},
>> >>       __size =3D
>> >> "\001\000\000\000\000\000\000\000\310d\000\000\001\000\000\000\002"=
,
>> >> '\000' <repeats 22 times>, __align =3D 1}, nlock =3D 1}, cond =3D {
>> >>     _vptr.Cond =3D 0x7f1701952bd0, _c =3D {__data =3D {__lock =3D 0=
, __futex
>> =3D
>> >> 0,
>> >> __total_seq =3D 0, __wakeup_seq =3D 0, __woken_seq =3D 0, __mutex =3D=
 0x0,
>> >> __nwaiters =3D 0,
>> >>         __broadcast_seq =3D 0}, __size =3D '\000' <repeats 47 times=
>,
>> >> __align
>> >> =3D 0}}, ref =3D 1, rval =3D 0, released =3D true, ack =3D true, sa=
fe =3D
>> >> false, objver =3D {version =3D 0,
>> >>     epoch =3D 0, __pad =3D 0}, callback_complete =3D 0x7f170173de33
>> >> <librbd::rados_aio_sparse_read_cb(rados_completion_t, void*)>,
>> >>   callback_safe =3D 0x7f170173d8bd
>> <librbd::rados_cb(rados_completion_t,
>> >> void*)>, callback_arg =3D 0x7f16f40d6010, bl =3D {
>> >>     _buffers =3D {<std::_List_base<ceph::buffer::ptr,
>> >> std::allocator<ceph::buffer::ptr> >> =3D {
>> >>         _M_impl =3D {<std::allocator<std::_List_node<ceph::buffer::=
ptr>
>> >>
>> >> =3D
>> >> {<__gnu_cxx::new_allocator<std::_List_node<ceph::buffer::ptr> >> =3D
>> >> {<No data fields>}, <No data fields>}, _M_node =3D {_M_next =3D
>> >> 0x1350530, _M_prev =3D 0x1350530}}}, <No data fields>}, _len =3D 20=
,
>> >> append_buffer =3D {_raw =3D 0x0, _off =3D 0, _len =3D 0}, last_p =3D=
 {
>> >>       bl =3D 0x7f16f40d6170, ls =3D 0x7f16f40d6170, off =3D 0, p =3D=
 {_M_node
>> =3D
>> >> 0x7f16f40d6170}, p_off =3D 0}}, pbl =3D 0x0, buf =3D 0x0, maxlen =3D=
 0}
>> >>
>> >>
>> >>
>> >> Thanks,
>> >> Dyweni
>> >>
>> >>
>> >>
>> >>
>> >> > On Fri, 6 May 2011, Dyweni - Qemu-Devel wrote:
>> >> >> Hi Josh/Lists!
>> >> >>
>> >> >> 463             ::decode(*data_bl, iter);
>> >> >> (gdb) print r
>> >> >> $1 =3D 0
>> >> >> (gdb) print data_bl
>> >> >> $2 =3D (ceph::bufferlist *) 0x7f16f40d6060
>> >> >> (gdb) print data_bl->_len
>> >> >> $3 =3D 0
>> >> >
>> >> > What about c->bl._len?
>> >> >
>> >> > sage
>> >> >
>> >> >
>> >> >> (gdb) print iter->off
>> >> >> $4 =3D 20
>> >> >>
>> >> >>
>> >> >> Thanks,
>> >> >> Dyweni
>> >> >>
>> >> >>
>> >> >>
>> >> >> > CCing the ceph list.
>> >> >> >
>> >> >> > On 05/06/2011 12:23 PM, Dyweni - Qemu-Devel wrote:
>> >> >> >> Hi List!
>> >> >> >>
>> >> >> >> I upgraded Ceph to the latest development version
>> >> >> >> 	Commit: 0edbc75a5fe8c3028faf85546f3264d28653ea3f
>> >> >> >> 	Pulled from: git://ceph.newdream.net/ceph.git
>> >> >> >>
>> >> >> >> I recompiled the latest GIT version of QEMU-KVM (with Josh
>> >> Durgin's
>> >> >> >> patches) against the latest git version of Ceph.
>> >> >> >>
>> >> >> >> However, this error is still occurring:
>> >> >> >>
>> >> >> >> terminate called after throwing an instance of
>> >> >> >> 'ceph::buffer::end_of_buffer'
>> >> >> >>    what():  buffer::end_of_buffer
>> >> >> >> Aborted (core dumped)
>> >> >> >>
>> >> >> >>
>> >> >> >>
>> >> >> >> Here's another backtrace from GDB:
>> >> >> >>
>> >> >> >> #0  0x00007f16ff829495 in raise (sig=3D<value optimized out>)=
 at
>> >> >> >> ../nptl/sysdeps/unix/sysv/linux/raise.c:64
>> >> >> >> #1  0x00007f16ff82a81f in abort () at abort.c:92
>> >> >> >> #2  0x00007f16fed74a25 in
>> __gnu_cxx::__verbose_terminate_handler
>> >> ()
>> >> >> at
>> >> >> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/lib=
supc++/vterminate.cc:93
>> >> >> >> #3  0x00007f16fed71c64 in __cxxabiv1::__terminate
>> >> >> >> (handler=3D0x7f16fed74817
>> >> >> >> <__gnu_cxx::__verbose_terminate_handler()>)
>> >> >> >>      at
>> >> >> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/lib=
supc++/eh_terminate.cc:38
>> >> >> >> #4  0x00007f16fed71c8c in std::terminate () at
>> >> >> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/lib=
supc++/eh_terminate.cc:48
>> >> >> >> #5  0x00007f16fed71ea4 in __cxxabiv1::__cxa_throw
>> (obj=3D0x1346470,
>> >> >> >> tinfo=3D0x7f1701952ce0, dest=3D0x7f17017403d4
>> >> >> >> <ceph::buffer::end_of_buffer::~end_of_buffer()>)
>> >> >> >>      at
>> >> >> >> /usr/src/debug/sys-devel/gcc-4.4.5/gcc-4.4.5/libstdc++-v3/lib=
supc++/eh_throw.cc:83
>> >> >> >> #6  0x00007f1701740a7b in ceph::buffer::list::iterator::copy
>> >> >> >> (this=3D0x7f16fd8b1930, len=3D4, dest=3D0x7f16fd8b18dc "") at
>> >> >> >> include/buffer.h:379
>> >> >> >> #7  0x00007f1701743328 in decode_raw<__le32>
>> (t=3D@0x7f16fd8b18dc,
>> >> >> p=3D...)
>> >> >> >> at
>> >> >> >> include/encoding.h:35
>> >> >> >> #8  0x00007f170174198a in decode (v=3D@0x7f16fd8b190c, p=3D..=
.) at
>> >> >> >> include/encoding.h:80
>> >> >> >> #9  0x00007f1701741ade in decode (s=3D..., p=3D...) at
>> >> >> >> include/encoding.h:189
>> >> >> >> #10 0x00007f17012e8369 in
>> >> >> >> librados::RadosClient::C_aio_sparse_read_Ack::finish
>> >> >> >> (this=3D0x7f16f40d6200,
>> >> >> >> r=3D0) at librados.cc:463
>> >> >> >> #11 0x00007f170132bb5a in Objecter::handle_osd_op_reply
>> >> >> (this=3D0x13423e0,
>> >> >> >> m=3D0x1346520) at osdc/Objecter.cc:794
>> >> >> >> #12 0x00007f17012d1444 in librados::RadosClient::_dispatch
>> >> >> >> (this=3D0x133f810, m=3D0x1346520) at librados.cc:751
>> >> >> >> #13 0x00007f17012d1244 in librados::RadosClient::ms_dispatch
>> >> >> >> (this=3D0x133f810, m=3D0x1346520) at librados.cc:717
>> >> >> >> #14 0x00007f170131b57b in Messenger::ms_deliver_dispatch
>> >> >> >> (this=3D0x1341910,
>> >> >> >> m=3D0x1346520) at msg/Messenger.h:98
>> >> >> >> #15 0x00007f17013090d3 in SimpleMessenger::dispatch_entry
>> >> >> >> (this=3D0x1341910)
>> >> >> >> at msg/SimpleMessenger.cc:352
>> >> >> >> #16 0x00007f17012e296e in
>> SimpleMessenger::DispatchThread::entry
>> >> >> >> (this=3D0x1341da0) at msg/SimpleMessenger.h:533
>> >> >> >> #17 0x00007f170131a39b in Thread::_entry_func (arg=3D0x1341da=
0)
>> at
>> >> >> >> common/Thread.h:41
>> >> >> >> #18 0x00007f1701f6dac4 in start_thread (arg=3D<value optimize=
d
>> out>)
>> >> at
>> >> >> >> pthread_create.c:297
>> >> >> >> #19 0x00007f16ff8c838d in clone () at
>> >> >> >> ../sysdeps/unix/sysv/linux/x86_64/clone.S:115
>> >> >> >
>> >> >> > I haven't seen that error before, but it's probably a bug in t=
he
>> >> OSD
>> >> >> > where it doesn't set an error code. If you've still got the co=
re
>> >> file,
>> >> >> > could you go to frame 10 and send us the values of r, bl._len,
>> and
>> >> >> > iter.off?
>> >> >> >
>> >> >> > Thanks,
>> >> >> > Josh
>> >> >> >
>> >> >>
>> >> >>
>> >> >>
>> >> >>
>> >> >
>> >>
>> >>
>> >>
>> >>
>> >
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
