From: Brian Chrisman <brchrisman@gmail.com>
Subject: Re: cfuse crash stack trace
Date: Fri, 18 Mar 2011 23:24:11 -0700
Message-ID: <AANLkTin+RWMVV1pcRgLNKAZ8byBkRRFM5vbpmPsYTtv2@mail.gmail.com>
References: <AANLkTimzePYGQfTRHONB7LdSncjXn_EPcuCUjwAFniQm@mail.gmail.com>
	<Pine.LNX.4.64.1103181651180.16804@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53794 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab1CSGYM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Mar 2011 02:24:12 -0400
Received: by vws1 with SMTP id 1so4205815vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2011 23:24:12 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1103181651180.16804@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Cool enough, got the log now... last_ack < tid test failing.
Some transaction not making it through?

I originally intended to build this with -g (rpm), but my build
must've been looking at an incorrect/older version of that package.


[write 1204224~57344] ack =3D 0) v1 =3D=3D=3D=3D 106+0+0 (462844183 0 0=
)
0x7fc19c0aece0 con 0x238ed80
osdc/ObjectCacher.cc: In function 'void
ObjectCacher::bh_write_ack(int, sobject_t, loff_t, uint64_t, tid_t)',
in thread '0x7fc1ced85710'
osdc/ObjectCacher.cc: 673: FAILED assert(ob->last_ack_tid < tid)
 ceph version 0.25.1 (commit:7f4a161e7fd1bb0d0eab3958b427a3c4c585bc05)
 1: (ObjectCacher::bh_write_ack(int, sobject_t, long, unsigned long,
unsigned long)+0x6b0) [0x4ef5a0]
 2: (ObjectCacher::C_WriteAck::finish(int)+0x5a) [0x4fe30a]
 3: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x93c) [0x4d0d6c]
 4: (Client::ms_dispatch(Message*)+0x143) [0x4a4e43]
 5: (SimpleMessenger::dispatch_entry()+0x882) [0x454b32]
 6: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x44d0ac]
 7: (()+0x77e1) [0x7fc1d21b77e1]
 8: (clone()+0x6d) [0x7fc1d10a351d]
 ceph version 0.25.1 (commit:7f4a161e7fd1bb0d0eab3958b427a3c4c585bc05)
 1: (ObjectCacher::bh_write_ack(int, sobject_t, long, unsigned long,
unsigned long)+0x6b0) [0x4ef5a0]
 2: (ObjectCacher::C_WriteAck::finish(int)+0x5a) [0x4fe30a]
 3: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x93c) [0x4d0d6c]
 4: (Client::ms_dispatch(Message*)+0x143) [0x4a4e43]
 5: (SimpleMessenger::dispatch_entry()+0x882) [0x454b32]
 6: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x44d0ac]
 7: (()+0x77e1) [0x7fc1d21b77e1]
 8: (clone()+0x6d) [0x7fc1d10a351d]
*** Caught signal (Aborted) **
 in thread 0x7fc1ced85710
 ceph version 0.25.1 (commit:7f4a161e7fd1bb0d0eab3958b427a3c4c585bc05)
 1: cfuse() [0x553dcc]
 2: (()+0xf4c0) [0x7fc1d21bf4c0]
 3: (gsignal()+0x35) [0x7fc1d0ff49b5]
 4: (abort()+0x175) [0x7fc1d0ff6195]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x7fc1d1899aad]
 6: (()+0xbcc36) [0x7fc1d1897c36]
 7: (()+0xbcc63) [0x7fc1d1897c63]
 8: (()+0xbcd5e) [0x7fc1d1897d5e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x373) [0x5400c3]
 10: (ObjectCacher::bh_write_ack(int, sobject_t, long, unsigned long,
unsigned long)+0x6b0) [0x4ef5a0]
 11: (ObjectCacher::C_WriteAck::finish(int)+0x5a) [0x4fe30a]
 12: (Objecter::handle_osd_op_reply(MOSDOpReply*)+0x93c) [0x4d0d6c]
 13: (Client::ms_dispatch(Message*)+0x143) [0x4a4e43]
 14: (SimpleMessenger::dispatch_entry()+0x882) [0x454b32]
 15: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x44d0ac]
 16: (()+0x77e1) [0x7fc1d21b77e1]
 17: (clone()+0x6d) [0x7fc1d10a351d]




On Fri, Mar 18, 2011 at 4:53 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 18 Mar 2011, Brian Chrisman wrote:
>> I'm doing some testing via cfuse (technically via samba-over-cfuse).
>> I caught the core dump and pulled a stack trace. =A0This is the thre=
ad
>> that seems to be initiating the core dump.
>> I can provide the rest if it'll help identify what's going on.
>
> If this is reproducible, can you pass --log-file /some/path to cfuse =
to
> get the crash dump (assert error, line number, etc.)? =A0Also, you sh=
ould
> probably build with -g to get the debug symbols (I suspect that's why
> you're getting the no symbol table errors). =A0Better yet, if you can
> reproduce this with cfuse --log-file foo --debug-client 20 --debug-ms=
 1
> --debug-objectcacher 20 it'll be easy to squash.
>
> Also which version?
>
> Thanks!
> sage
>
>
>> >
>> My cfuse crashing thread:
>>
>> Thread 1 (Thread 1696):
>> #0 =A00x00007f14ede7d38b in raise () from /lib64/libpthread.so.0
>> No symbol table info available.
>> #1 =A00x0000000000553fe9 in handle_fatal_signal(int) ()
>> No symbol table info available.
>> #2 =A0<signal handler called>
>> No symbol table info available.
>> #3 =A00x00007f14eccb29b5 in raise () from /lib64/libc.so.6
>> No symbol table info available.
>> #4 =A00x00007f14eccb4195 in abort () from /lib64/libc.so.6
>> No symbol table info available.
>> #5 =A00x00007f14ed557aad in __gnu_cxx::__verbose_terminate_handler()=
 ()
>> from /usr/lib64/libstdc++.so.6
>> No symbol table info available.
>> #6 =A00x00007f14ed555c36 in ?? () from /usr/lib64/libstdc++.so.6
>> ---Type <return> to continue, or q <return> to quit---
>> No symbol table info available.
>> #7 =A00x00007f14ed555c63 in std::terminate() () from /usr/lib64/libs=
tdc++.so.6
>> No symbol table info available.
>> #8 =A00x00007f14ed555d5e in __cxa_throw () from /usr/lib64/libstdc++=
=2Eso.6
>> No symbol table info available.
>> #9 =A00x00000000005400c3 in ceph::__ceph_assert_fail(char const*, ch=
ar
>> const*, int, char const*) ()
>> No symbol table info available.
>> #10 0x00000000004ef5a0 in ObjectCacher::bh_write_ack(int, sobject_t,
>> long, unsigned long, unsigned long) ()
>> No symbol table info available.
>> #11 0x00000000004fe30a in ObjectCacher::C_WriteAck::finish(int) ()
>> No symbol table info available.
>> #12 0x00000000004d0d6c in Objecter::handle_osd_op_reply(MOSDOpReply*=
) ()
>> No symbol table info available.
>> #13 0x00000000004a4e43 in Client::ms_dispatch(Message*) ()
>> No symbol table info available.
>> #14 0x0000000000454b32 in SimpleMessenger::dispatch_entry() ()
>> No symbol table info available.
>> #15 0x000000000044d0ac in SimpleMessenger::DispatchThread::entry() (=
)
>> No symbol table info available.
>> #16 0x00007f14ede757e1 in start_thread () from /lib64/libpthread.so.=
0
>> No symbol table info available.
>> #17 0x00007f14ecd6151d in clone () from /lib64/libc.so.6
>> No symbol table info available.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
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
