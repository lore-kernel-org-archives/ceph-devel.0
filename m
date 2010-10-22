From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: common/Mutex.h:102: FAILED assert(nlock > 0)
Date: Fri, 22 Oct 2010 12:40:45 -0700
Message-ID: <AANLkTikL=9eXGTGyMzs2b71kQfaEieayp-KFNUrLy2k2@mail.gmail.com>
References: <1287773810.6806.74.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54718 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756985Ab0JVTkq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Oct 2010 15:40:46 -0400
Received: by gxk23 with SMTP id 23so728937gxk.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Oct 2010 12:40:45 -0700 (PDT)
In-Reply-To: <1287773810.6806.74.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If you pull the newest unstable you'll find this fixed, it was a
short-lived error in the tree. :)
-Greg

On Fri, Oct 22, 2010 at 11:56 AM, Jim Schutt <jaschut@sandia.gov> wrote=
:
> Hi,
>
> The unstable branch is giving me lots of these asserts when
> I try to start up a file system with 10 servers, 16 cosd/server:
>
> # tail -30 /var/log/ceph/osd.113.log
> 2010-10-22 12:46:41.372489 4733b940 -- 172.17.40.28:6803/10781 <=3D=3D=
 osd128 172.17.40.29:6801/6905 1 =3D=3D=3D=3D osd_ping(e0 as_of 4 ACK) =
v1 =3D=3D=3D=3D 61+0+0 (2649909510 0 0) 0x226bc30
> 2010-10-22 12:46:41.372507 4733b940 osd113 4 =A0peer osd128 172.17.40=
=2E29:6801/6905 requesting heartbeats
> common/Mutex.h: In function 'void Mutex::Unlock()':
> common/Mutex.h:102: FAILED assert(nlock > 0)
> =A0ceph version 0.23~rc (commit:55fcbc649c42f029ca63a1f36acc5244beacf=
705)
> =A01: (SimpleMessenger::Pipe::accept()+0x130e) [0x474a2e]
> =A02: (SimpleMessenger::Pipe::reader()+0x1f5) [0x476b15]
> =A03: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x46562d]
> =A04: (Thread::_entry_func(void*)+0x7) [0x480607]
> =A05: /lib64/libpthread.so.0 [0x7fda5bce973d]
> =A06: (clone()+0x6d) [0x7fda5af7dd1d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to interpret this.
> *** Caught signal (ABRT) ***
> =A0ceph version 0.23~rc (commit:55fcbc649c42f029ca63a1f36acc5244beacf=
705)
> =A01: (sigabrt_handler(int)+0x4a) [0x614cfa]
> =A02: /lib64/libc.so.6 [0x7fda5aeda2d0]
> =A03: (gsignal()+0x35) [0x7fda5aeda265]
> =A04: (abort()+0x110) [0x7fda5aedbd10]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x114) [0x7fda5b750cb=
4]
> =A06: /usr/lib64/libstdc++.so.6 [0x7fda5b74edb6]
> =A07: /usr/lib64/libstdc++.so.6 [0x7fda5b74ede3]
> =A08: /usr/lib64/libstdc++.so.6 [0x7fda5b74eeca]
> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char c=
onst*)+0x214) [0x601a34]
> =A010: (Mutex::Unlock()+0x5b) [0x4655fb]
> =A011: (SimpleMessenger::Pipe::accept()+0x130e) [0x474a2e]
> =A012: (SimpleMessenger::Pipe::reader()+0x1f5) [0x476b15]
> =A013: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x46562d]
> =A014: (Thread::_entry_func(void*)+0x7) [0x480607]
> =A015: /lib64/libpthread.so.0 [0x7fda5bce973d]
> =A016: (clone()+0x6d) [0x7fda5af7dd1d]
>
>
> # gdb /usr/bin/cosd
> Reading symbols from /usr/bin/cosd...done.
> (gdb) l *0x474a2e
> 0x474a2e is in SimpleMessenger::Pipe::accept() (msg/SimpleMessenger.c=
c:897).
> 892 =A0 =A0 =A0 return 0; =A0 // success.
> 893
> 894 =A0 =A0 =A0fail_unlocked:
> 895 =A0 =A0 =A0 if (existing)
> 896 =A0 =A0 =A0 =A0 existing->pipe_lock.Unlock();
> 897 =A0 =A0 =A0 pipe_lock.Lock();
> 898 =A0 =A0 =A0 bool queued =3D is_queued();
> 899 =A0 =A0 =A0 if (queued)
> 900 =A0 =A0 =A0 =A0 state =3D STATE_CONNECTING;
> 901 =A0 =A0 =A0 else
> (gdb) q
>
>
> FWIW, it looks to me like a double unlock via a failed reply.
>
> -- Jim
>
>
>
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
