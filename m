From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: operate one file in multi clients with libceph
Date: Wed, 18 May 2011 08:26:36 -0700
Message-ID: <BANLkTikZYc59u1R35fJErCE_vA0+EDGSeQ@mail.gmail.com>
References: <BANLkTi=wd0+u774vRNDJZoXW_EoE9OP67Q@mail.gmail.com>
	<BANLkTinaHaWSpm81LeOHSSpkoqjDyqB5Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39903 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab1ERP0h convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2011 11:26:37 -0400
Received: by vxi39 with SMTP id 39so1177724vxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2011 08:26:36 -0700 (PDT)
In-Reply-To: <BANLkTinaHaWSpm81LeOHSSpkoqjDyqB5Nw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, May 18, 2011 at 7:40 AM, Simon Tian <aixt2006@gmail.com> wrote:
> Hi,
>
> =A0 =A0Could any one give me an answer?
>
> =A0 My application need to open one file with two clients in differen=
t
> hosts. One for write/read and one for read only. The client could be
> developed based on libceph or librbd.
> =A0 I tried librbd, exception appear too.

The libceph API is not yet very well tested.
Can you simply mount the filesystem from both hosts using the kernel
client and have your application open/access the single file with the
standard system call interface?


>
>
> Thx very much! Really need your help...
>
> Simon
>
>
>
> 2011/5/17 Simon Tian <aixt2006@gmail.com>:
>> Hi folks,
>>
>> =A0 =A0 =A0 When I write and read a file in client A, open with
>> ceph_open(test_path, O_RDWR|O_CREAT,0 ), and read the same file in
>> client B, with ceph_open(test_path, O_RDONLY, 0). =A0Client A and B =
are
>> running on different host.
>> =A0 =A0 =A0 After a while, client A will throw a exception. This exc=
eption
>> appear every time.
>>
>> =A0 =A0 =A0 The back trace in ceph is:
>>
>> (gdb) bt
>> #0 =A00x000000367fa30265 in raise () from /lib64/libc.so.6
>> #1 =A00x000000367fa31d10 in abort () from /lib64/libc.so.6
>> #2 =A00x0000003682ebec44 in __gnu_cxx::__verbose_terminate_handler()=
 ()
>> from /usr/lib64/libstdc++.so.6
>> #3 =A00x0000003682ebcdb6 in ?? () from /usr/lib64/libstdc++.so.6
>> #4 =A00x0000003682ebcde3 in std::terminate() () from /usr/lib64/libs=
tdc++.so.6
>> #5 =A00x0000003682ebceca in __cxa_throw () from /usr/lib64/libstdc++=
=2Eso.6
>> #6 =A00x00007ffff7c51a78 in ceph::__ceph_assert_fail
>> (assertion=3D0x7ffff7ce0a1c "r =3D=3D 0", file=3D0x7ffff7ce0a02
>> "common/Mutex.h", line=3D118,
>> =A0 =A0func=3D0x7ffff7ce0ca0 "void Mutex::Lock(bool)") at common/ass=
ert.cc:86
>> #7 =A00x00007ffff7b1ee1c in Mutex::Lock (this=3D0x6293f0,
>> no_lockdep=3Dfalse) at common/Mutex.h:118
>> #8 =A00x00007ffff7b395f4 in Client::sync_write_commit (this=3D0x6290=
90,
>> in=3D0x7ffff0001b50) at client/Client.cc:4979
>> #9 =A00x00007ffff7baf304 in C_Client_SyncCommit::finish
>> (this=3D0x7ffff3206300) at client/Client.cc:4973
>> #10 0x00007ffff7c951d5 in Objecter::handle_osd_op_reply
>> (this=3D0x62b420, m=3D0x632190) at osdc/Objecter.cc:806
>> #11 0x00007ffff7b56038 in Client::ms_dispatch (this=3D0x629090,
>> m=3D0x632190) at client/Client.cc:1414
>> #12 0x00007ffff7bcb01d in Messenger::ms_deliver_dispatch
>> (this=3D0x628350, m=3D0x632190) at msg/Messenger.h:98
>> #13 0x00007ffff7bb262b in SimpleMessenger::dispatch_entry
>> (this=3D0x628350) at msg/SimpleMessenger.cc:352
>> #14 0x00007ffff7b22641 in SimpleMessenger::DispatchThread::entry
>> (this=3D0x6287d8) at msg/SimpleMessenger.h:533
>> #15 0x00007ffff7b5aa28 in Thread::_entry_func (arg=3D0x6287d8) at
>> ./common/Thread.h:41
>> #16 0x00000036802064a7 in start_thread () from /lib64/libpthread.so.=
0
>> #17 0x000000367fad3c2d in clone () from /lib64/libc.so.6
>>
>> So is there any way to avoid this?
>>
>>
>> Thx!
>> Simon
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
