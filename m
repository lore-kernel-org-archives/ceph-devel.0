From: Simon Tian <aixt2006@gmail.com>
Subject: Re: operate one file in multi clients with libceph
Date: Fri, 20 May 2011 16:56:13 +0800
Message-ID: <BANLkTi=e4bSvPUK_uKB5NCMEPyJFg+4bhA@mail.gmail.com>
References: <BANLkTi=wd0+u774vRNDJZoXW_EoE9OP67Q@mail.gmail.com>
	<BANLkTinaHaWSpm81LeOHSSpkoqjDyqB5Nw@mail.gmail.com>
	<Pine.LNX.4.64.1105180858360.1988@cobra.newdream.net>
	<BANLkTin+D66OuXUbiRkDBNiLx--8eu2hkw@mail.gmail.com>
	<Pine.LNX.4.64.1105191011180.9218@cobra.newdream.net>
	<Pine.LNX.4.64.1105191020100.9218@cobra.newdream.net>
	<Pine.LNX.4.64.1105191445150.9218@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61097 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934991Ab1ETI4P convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 May 2011 04:56:15 -0400
Received: by wya21 with SMTP id 21so2556697wya.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 May 2011 01:56:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1105191445150.9218@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

OK,  I'll test the branch and give the result these days.

Thanks very much!

Simon

2011/5/20 Sage Weil <sage@newdream.net>:
> On Thu, 19 May 2011, Sage Weil wrote:
>> On Thu, 19 May 2011, Sage Weil wrote:
>> > On Thu, 19 May 2011, Simon Tian wrote:
>> > > Hi Sage,
>> > >
>> > > =C2=A0 =C2=A0 I've test this patch.
>> > > With 8 times test, only 1 (the first time) got a thread assert f=
ail.As
>> > > back trace 1 showed:
>> >
>> > Do you have a simple reproducer for this?
>>
>> Nevermind, I'm easily triggering this with two cfuse mounts.
>
> Hi Simon,
>
> I just pushed a series of fixes to this code to the master branch tha=
t
> fixes both of these crashes in my testing. =C2=A0Can you try it out?
>
> Thanks!
> sage
>
>
>
>>
>> sage
>>
>>
>> >
>> > sage
>> >
>> >
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =C2=A0back trace 1 =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > (gdb) bt
>> > > #0 =C2=A00x000000367fa30265 in raise () from /lib64/libc.so.6
>> > > #1 =C2=A00x000000367fa31d10 in abort () from /lib64/libc.so.6
>> > > #2 =C2=A00x0000003682ebec44 in __gnu_cxx::__verbose_terminate_ha=
ndler() ()
>> > > from /usr/lib64/libstdc++.so.6
>> > > #3 =C2=A00x0000003682ebcdb6 in ?? () from /usr/lib64/libstdc++.s=
o.6
>> > > #4 =C2=A00x0000003682ebcde3 in std::terminate() () from /usr/lib=
64/libstdc++.so.6
>> > > #5 =C2=A00x0000003682ebceca in __cxa_throw () from /usr/lib64/li=
bstdc++.so.6
>> > > #6 =C2=A00x00007ffff7c51a54 in ceph::__ceph_assert_fail
>> > > (assertion=3D0x7ffff7ce31f1 "in->cap_refs[(32 << 8)] =3D=3D 1",
>> > > =C2=A0 =C2=A0 file=3D0x7ffff7ce1431 "client/Client.cc", line=3D2=
190,
>> > > func=3D0x7ffff7ce5fc0 "void Client::_flush(Inode*, Context*)")
>> > > =C2=A0 =C2=A0 at common/assert.cc:86
>> > > #7 =C2=A00x00007ffff7b39bb0 in Client::_flush (this=3D0x629090, =
in=3D0x630f50,
>> > > onfinish=3D0x7fffe8000b60) at client/Client.cc:2190
>> > > #8 =C2=A00x00007ffff7b52426 in Client::handle_cap_grant (this=3D=
0x629090,
>> > > in=3D0x630f50, mds=3D0, cap=3D0x62ee50, m=3D0x631fc0)
>> > > =C2=A0 =C2=A0 at client/Client.cc:2930
>> > > #9 =C2=A00x00007ffff7b52d2a in Client::handle_caps (this=3D0x629=
090,
>> > > m=3D0x631fc0) at client/Client.cc:2711
>> > > #10 0x00007ffff7b560a0 in Client::ms_dispatch (this=3D0x629090,
>> > > m=3D0x631fc0) at client/Client.cc:1444
>> > > #11 0x00007ffff7bcaff9 in Messenger::ms_deliver_dispatch
>> > > (this=3D0x628350, m=3D0x631fc0) at msg/Messenger.h:98
>> > > #12 0x00007ffff7bb2607 in SimpleMessenger::dispatch_entry
>> > > (this=3D0x628350) at msg/SimpleMessenger.cc:352
>> > > #13 0x00007ffff7b22641 in SimpleMessenger::DispatchThread::entry
>> > > (this=3D0x6287d8) at msg/SimpleMessenger.h:533
>> > > #14 0x00007ffff7b5aa04 in Thread::_entry_func (arg=3D0x6287d8) a=
t
>> > > ./common/Thread.h:41
>> > > #15 0x00000036802064a7 in start_thread () from /lib64/libpthread=
=2Eso.0
>> > > #16 0x000000367fad3c2d in clone () from /lib64/libc.so.6
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > In addition, when writing data for a long time, the write thread=
 will
>> > > hang on a pthread_cond_wait, as back trace 2 showed:
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =C2=A0back trace 2 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > Thread 10 (Thread 0x43f87940 (LWP 19986)):
>> > > #0 =C2=A00x000000312be0ab99 in pthread_cond_wait@@GLIBC_2.3.2 ()=
 from
>> > > /lib64/libpthread.so.0
>> > > #1 =C2=A00x00007f147a8e763b in Cond::Wait (this=3D0x43f86b00,
>> > > mutex=3D@0x66d790) at ./common/Cond.h:46
>> > > #2 =C2=A00x00007f147a86630d in Client::wait_on_list (this=3D0x66=
d430,
>> > > ls=3D@0x674df0) at client/Client.cc:2140
>> > > #3 =C2=A00x00007f147a8771ff in Client::get_caps (this=3D0x66d430=
,
>> > > in=3D0x6749d0, need=3D4096, want=3D8192, got=3D0x43f86e8c, endof=
f=3D235470848)
>> > > =C2=A0 =C2=A0 at client/Client.cc:1827
>> > > #4 =C2=A00x00007f147a886003 in Client::_write (this=3D0x66d430, =
f=3D0x671510,
>> > > offset=3D235470336, size=3D512,
>> > > =C2=A0 =C2=A0 buf=3D0x6452b0 '=C3=BF=C3=BF' <repeats 33 times>, =
".001", '=C3=BF=C3=BF' <repeats 165
>> > > times>...) at client/Client.cc:5055
>> > > #5 =C2=A00x00007f147a886d73 in Client::write (this=3D0x66d430, f=
d=3D10,
>> > > =C2=A0 =C2=A0 buf=3D0x6452b0 '=C3=BF=C3=BF' <repeats 33 times>, =
".001", '=C3=BF=C3=BF' <repeats 165
>> > > times>..., size=3D512, offset=3D235470336) at client/Client.cc:5=
007
>> > > #6 =C2=A00x00007f147a85822d in ceph_write (fd=3D10, buf=3D0x6452=
b0 '=C3=BF=C3=BF' <repeats
>> > > 33 times>, ".001", '=C3=BF=C3=BF' <repeats 165 times>..., size=3D=
512,
>> > > =C2=A0 =C2=A0 offset=3D235470336) at libceph.cc:322
>> > > #7 =C2=A00x000000000042fa27 in TdcCephImpl::AsyncWrite (this=3D0=
x647c30,
>> > > offset=3D235470336, length=3D512,
>> > > =C2=A0 =C2=A0 buf=3D0x6452b0 '=C3=BF=C3=BF' <repeats 33 times>, =
".001", '=C3=BF=C3=BF' <repeats 165
>> > > times>..., queue=3D@0x644b60, io=3D0x6456a0)
>> > > =C2=A0 =C2=A0 at /opt/tsk/tdc-tapdisk/td-connector2.0/common/tdc=
_ceph_impl.cpp:191
>> > > #8 =C2=A00x000000000042ffc5 in TdcCephImpl::AsyncProcess (this=3D=
0x647c30,
>> > > io=3D0x6456a0, queue=3D@0x644b60, netfd=3D5)
>> > > =C2=A0 =C2=A0 at /opt/tsk/tdc-tapdisk/td-connector2.0/common/tdc=
_ceph_impl.cpp:268
>> > > #9 =C2=A00x00000000004192be in SubmitRequest_Intra (arg=3D0x644b=
00) at
>> > > /opt/tsk/tdc-tapdisk/td-connector2.0/td_connector_server.cpp:390
>> > > #10 0x000000312be064a7 in start_thread () from /lib64/libpthread=
=2Eso.0
>> > > #11 0x000000312b6d3c2d in clone () from /lib64/libc.so.6
>> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >
>> > > Seem not very safe with the patch.
>> > >
>> > > So I applied this patch:
>> > > diff --git a/src/client/Client.cc b/src/client/Client.cc
>> > > index 7f7fb08..bf0997a 100644
>> > > --- a/src/client/Client.cc
>> > > +++ b/src/client/Client.cc
>> > > @@ -4934,7 +4934,6 @@ public:
>> > >
>> > > =C2=A0void Client::sync_write_commit(Inode *in)
>> > > =C2=A0{
>> > > - =C2=A0client_lock.Lock();
>> > > + int r =3D client_lock.Lock();
>> > > =C2=A0 assert(unsafe_sync_write > 0);
>> > > =C2=A0 unsafe_sync_write--;
>> > >
>> > > @@ -4947,8 +4946,6 @@ void Client::sync_write_commit(Inode *in)
>> > > =C2=A0 }
>> > >
>> > > =C2=A0 put_inode(in);
>> > > + if (r)
>> > > =C2=A0 client_lock.Unlock();
>> > > =C2=A0}
>> > >
>> > > =C2=A0int Client::write(int fd, const char *buf, loff_t size, lo=
ff_t offset)
>> > >
>> > >
>> > > After some test, back trace 1 didn't appear, but back trace 2 st=
ill appear.
>> > > Hmm,, not safe also.
>> > >
>> > > Thx!
>> > > Simon
>> > >
>> > >
>> > >
>> > > 2011/5/19 Sage Weil <sage@newdream.net>:
>> > > > Hi Simon,
>> > > >
>> > > > On Wed, 18 May 2011, Simon Tian wrote:
>> > > >
>> > > >> Hi,
>> > > >>
>> > > >> =C2=A0 =C2=A0 Could any one give me an answer?
>> > > >>
>> > > >> =C2=A0 =C2=A0My application need to open one file with two cl=
ients in different
>> > > >> hosts. One for write/read and one for read only. The client c=
ould be
>> > > >> developed based on libceph or librbd.
>> > > >> =C2=A0 =C2=A0I tried librbd, exception appear too.
>> > > >
>> > > > I opened a bug for this, http://tracker.newdream.net/issues/10=
97.
>> > > >
>> > > > Can you try the patch below? =C2=A0I this may just be somethin=
g missed in a
>> > > > locking rewrite way back when in a rare code path:
>> > > >
>> > > > Thanks!
>> > > > sage
>> > > >
>> > > >
>> > > >
>> > > > diff --git a/src/client/Client.cc b/src/client/Client.cc
>> > > > index 7f7fb08..bf0997a 100644
>> > > > --- a/src/client/Client.cc
>> > > > +++ b/src/client/Client.cc
>> > > > @@ -4934,7 +4934,6 @@ public:
>> > > >
>> > > > =C2=A0void Client::sync_write_commit(Inode *in)
>> > > > =C2=A0{
>> > > > - =C2=A0client_lock.Lock();
>> > > > =C2=A0 assert(unsafe_sync_write > 0);
>> > > > =C2=A0 unsafe_sync_write--;
>> > > >
>> > > > @@ -4947,8 +4946,6 @@ void Client::sync_write_commit(Inode *in=
)
>> > > > =C2=A0 }
>> > > >
>> > > > =C2=A0 put_inode(in);
>> > > > -
>> > > > - =C2=A0client_lock.Unlock();
>> > > > =C2=A0}
>> > > >
>> > > > =C2=A0int Client::write(int fd, const char *buf, loff_t size, =
loff_t offset)
>> > > >
>> > > >
>> > > --
>> > > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>> > > the body of a message to majordomo@vger.kernel.org
>> > > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-in=
fo.html
>> > >
>> > >
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
