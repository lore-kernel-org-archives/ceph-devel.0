From: Simon Tian <aixt2006@gmail.com>
Subject: Re: operate one file in multi clients with libceph
Date: Wed, 18 May 2011 22:40:06 +0800
Message-ID: <BANLkTinaHaWSpm81LeOHSSpkoqjDyqB5Nw@mail.gmail.com>
References: <BANLkTi=wd0+u774vRNDJZoXW_EoE9OP67Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50545 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab1EROkH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 10:40:07 -0400
Received: by wwa36 with SMTP id 36so1793486wwa.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2011 07:40:06 -0700 (PDT)
In-Reply-To: <BANLkTi=wd0+u774vRNDJZoXW_EoE9OP67Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

    Could any one give me an answer?

   My application need to open one file with two clients in different
hosts. One for write/read and one for read only. The client could be
developed based on libceph or librbd.
   I tried librbd, exception appear too.


Thx very much! Really need your help...

Simon



2011/5/17 Simon Tian <aixt2006@gmail.com>:
> Hi folks,
>
> =C2=A0 =C2=A0 =C2=A0 When I write and read a file in client A, open w=
ith
> ceph_open(test_path, O_RDWR|O_CREAT,0 ), and read the same file in
> client B, with ceph_open(test_path, O_RDONLY, 0). =C2=A0Client A and =
B are
> running on different host.
> =C2=A0 =C2=A0 =C2=A0 After a while, client A will throw a exception. =
This exception
> appear every time.
>
> =C2=A0 =C2=A0 =C2=A0 The back trace in ceph is:
>
> (gdb) bt
> #0 =C2=A00x000000367fa30265 in raise () from /lib64/libc.so.6
> #1 =C2=A00x000000367fa31d10 in abort () from /lib64/libc.so.6
> #2 =C2=A00x0000003682ebec44 in __gnu_cxx::__verbose_terminate_handler=
() ()
> from /usr/lib64/libstdc++.so.6
> #3 =C2=A00x0000003682ebcdb6 in ?? () from /usr/lib64/libstdc++.so.6
> #4 =C2=A00x0000003682ebcde3 in std::terminate() () from /usr/lib64/li=
bstdc++.so.6
> #5 =C2=A00x0000003682ebceca in __cxa_throw () from /usr/lib64/libstdc=
++.so.6
> #6 =C2=A00x00007ffff7c51a78 in ceph::__ceph_assert_fail
> (assertion=3D0x7ffff7ce0a1c "r =3D=3D 0", file=3D0x7ffff7ce0a02
> "common/Mutex.h", line=3D118,
> =C2=A0 =C2=A0func=3D0x7ffff7ce0ca0 "void Mutex::Lock(bool)") at commo=
n/assert.cc:86
> #7 =C2=A00x00007ffff7b1ee1c in Mutex::Lock (this=3D0x6293f0,
> no_lockdep=3Dfalse) at common/Mutex.h:118
> #8 =C2=A00x00007ffff7b395f4 in Client::sync_write_commit (this=3D0x62=
9090,
> in=3D0x7ffff0001b50) at client/Client.cc:4979
> #9 =C2=A00x00007ffff7baf304 in C_Client_SyncCommit::finish
> (this=3D0x7ffff3206300) at client/Client.cc:4973
> #10 0x00007ffff7c951d5 in Objecter::handle_osd_op_reply
> (this=3D0x62b420, m=3D0x632190) at osdc/Objecter.cc:806
> #11 0x00007ffff7b56038 in Client::ms_dispatch (this=3D0x629090,
> m=3D0x632190) at client/Client.cc:1414
> #12 0x00007ffff7bcb01d in Messenger::ms_deliver_dispatch
> (this=3D0x628350, m=3D0x632190) at msg/Messenger.h:98
> #13 0x00007ffff7bb262b in SimpleMessenger::dispatch_entry
> (this=3D0x628350) at msg/SimpleMessenger.cc:352
> #14 0x00007ffff7b22641 in SimpleMessenger::DispatchThread::entry
> (this=3D0x6287d8) at msg/SimpleMessenger.h:533
> #15 0x00007ffff7b5aa28 in Thread::_entry_func (arg=3D0x6287d8) at
> ./common/Thread.h:41
> #16 0x00000036802064a7 in start_thread () from /lib64/libpthread.so.0
> #17 0x000000367fad3c2d in clone () from /lib64/libc.so.6
>
> So is there any way to avoid this?
>
>
> Thx!
> Simon
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
